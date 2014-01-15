
(function() {
    var comments, hide_comment_panel;
    hide_comment_panel = function(btn) {
        return $(btn).parents('.panel').slideUp();
    };
    comments = $('.comments');
    comments.on('click', 'a.additional_info', function() {
        var btn, holder;
        btn = $(this);
        holder = btn.parents('.panel-body');
        holder.find('div.additional_info').slideToggle();
        return false;
    });
    comments.on('click', 'a.edit', function() {
        var btn, holder;
        btn = $(this);
        holder = btn.parents('.panel-body');
        holder.find('.edit_form, .comment_body, a.edit').toggle();
        return false;
    });
    comments.on('ajax:success', '.to_published, .to_draft, .to_spam, .to_deleted', function() {
        return hide_comment_panel(this);
    });
    comments.on('ajax:success', '.edit_comment', function(request, response, status) {
        var form, holder;
        form = $(this);
        holder = form.parents('.panel-body');
        holder.find('.edit_form, .comment_body, a.edit').toggle();
        return holder.find('.comment_body').replaceWith(response);
    });
})(this);

