# coding: UTF-8
# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderCommentsTreeHelper
  module Render 
    class << self
      attr_accessor :h, :options
      include StaticPagesHelper::IpHelper

      # Main Helpers
      def controller
        @options[:controller]
      end

      def t str
        controller.t str
      end

      # Render Helpers
      def visible_draft?
        controller.try(:comments_view_token) == @comment.view_token
      end

      def moderator?
        controller.try(:current_user).try(:comments_moderator?, @comment)
      end

      # Render Methods
      def render_node(h, options)
        @h, @options = h, options
        @comment     = options[:node]

        @max_reply_depth = options[:max_reply_depth] || TheComments.config.max_reply_depth

        if @comment.draft?
          draft_comment
        else @comment.published?
          published_comment
        end
      end

      def draft_comment
        if visible_draft? || moderator?
          published_comment
        else
          "<li class='draft'>
            <div class='comment draft' id='comment_#{@comment.anchor}'>
              #{ t('the_comments.waiting_for_moderation') }
              #{ h.link_to '#', '#comment_' + @comment.anchor }
            </div>
            #{ children }
          </li>"
        end
      end

      def published_comment
        "<li>
          <div id='comment_#{@comment.anchor}' class='comment #{@comment.state}' data-comment-id='#{@comment.to_param}'>
            <div>
              #{ avatar }
              #{ userbar }
              <div class='cbody'>#{ @comment.content }</div>
              #{ reply }
            </div>
          </div>

          <div class='form_holder'></div>
          #{ children }
        </li>"
      end

      def avatar
        "<div class='userpic'>
          <img src='#{ @comment.avatar_url }' alt='userpic' />
          #{ controls }
        </div>"
      end

      def userbar
        anchor = h.link_to('#', '#comment_' + @comment.anchor)
        comment_user = @comment.title
        # Use cookie to check if it's guest or user.
        if comment_user.to_s.include?('guest') && comment_user.to_s.include?('example.com')
          user_ip = ip_to_int(@comment.ip)
          user_location = IpCity.where("ip_start >= ?", user_ip).order(ip_start: :asc).limit(1)
          title = user_location.blank? ? 'Jcorner from Mars' : 'Jcorner from ' + user_location.first.location.to_s
        else
          title = comment_user.blank? ? t('the_comments.guest_name') : comment_user
          user_ip = 0
        end
        comment_time = @comment.updated_at.to_formatted_s(:long)
        "<div class='userbar'>
          #{ title } #{ anchor }
          <br>
          #{ ip_masker(@comment.ip) unless user_ip == 0}
          <br>
          <span class='comment-time'>#{ comment_time }</span>
        </div>"
      end

      def moderator_controls
        if moderator?
          h.link_to(t('the_comments.edit'), h.edit_comment_url(@comment), class: :edit)
        end
      end

      def reply
        if @comment.depth < (@max_reply_depth - 1)
          "<p class='reply'><a href='#' class='reply_link'>#{ t('the_comments.reply') }</a>"
        end
      end

      def controls
        "<div class='controls'>#{ moderator_controls }</div>"
      end

      def children
        "<ol class='nested_set'>#{ options[:children] }</ol>"
      end
    end
  end
end