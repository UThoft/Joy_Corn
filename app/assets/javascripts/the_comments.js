
comments_errors_builder = function(errors) {
    var error, error_msgs, _i, _len;
    error_msgs = '';
    for (_i = 0, _len = errors.length; _i < _len; _i++) {
        error = errors[_i];
        error_msgs += "<p><b>" + error + "</b></p>";
    }
    return error_msgs;
};

clear_comment_form = function() {
    $('.error_notifier', '#new_comment, .comments_tree').hide();
    $("input[name='comment[title]']").val('');
    return $("textarea[name='comment[raw_content]']").val('');
};

comments_error_notifier = function(form, text) {
    return form.children('.error_notifier').empty().hide().append(text).show();
};

unixsec = function(t) {
    return Math.round(t.getTime() / 1000);
};

highlight_anchor = function() {
    var hash;
    hash = document.location.hash;
    if (hash.match('#comment_')) {
        return $(hash).addClass('highlighted');
    }
    else {
        return false;
    }
};

(function() {

    var comment_forms, submits, tolerance_time;
    window.tolerance_time_start = unixsec(new Date);
    tolerance_time = $('[data-comments-tolarance-time]').first().data('comments-tolarance-time');
    submits = '#new_comment input[type=submit], .reply_comments_form input[type=submit]';
    $(document).on('click', submits, function(e) {
        var button, delta, error_msgs, form, time_diff;
        button = $(e.target);
        form = button.parents('form').first();
        time_diff = unixsec(new Date) - window.tolerance_time_start;
        if (tolerance_time && (time_diff < tolerance_time)) {
            delta = tolerance_time - time_diff;
            error_msgs = comments_errors_builder(["Please wait " + delta + " secs"]);
            comments_error_notifier(form, error_msgs);
            return false;
        }
        $('.tolerance_time').val(time_diff);
        button.hide();
        return true;
    });
    comment_forms = "#new_comment, .reply_comments_form";
    $(document).on('ajax:error', comment_forms, function(request, response, status) {
        var error_msgs, form;
        form = $(this);
        $('input[type=submit]', form).show();
        error_msgs = comments_errors_builder(["Server Error: " + response.status]);
        return comments_error_notifier(form, error_msgs);
    });
    $(document).on('ajax:success', comment_forms, function(request, response, status) {
        var anchor, error_msgs, form, tree;
        form = $(this);
        $('input[type=submit]', form).show();
        if (typeof response === 'string') {
            anchor = $(response).find('.comment').attr('id');
            clear_comment_form();
            form.hide();
            $('.parent_id').val('');
            $('#new_comment').fadeIn();
            tree = form.parent().siblings('.nested_set');
            if (tree.length === 0) {
                tree = $('ol.comments_tree');
            }
            tree.append(response);
            return document.location.hash = anchor;
        } else {
            error_msgs = comments_errors_builder(response.errors);
            return comments_error_notifier(form, error_msgs);
        }
    });
    $(document).on('click', '#new_root_comment', function() {
        $('.reply_comments_form').hide();
        $('.parent_id').val('');
        $('#new_comment').fadeIn();
        return false;
    });

    $(document).on('click', '.reply_link', function() {
        var comment, comment_id, form, link;
        link = $(this);
        comment = link.parent().parent().parent();
        $(comment_forms).hide();
        form = $('#new_comment').clone().removeAttr('id').addClass('reply_comments_form');
        comment_id = comment.data('comment-id');
        $('.parent_id', form).val(comment_id);
        comment.siblings('.form_holder').html(form);
        $('.error_notifier', form).empty().hide();
        form.fadeIn();
        return false;
    });
})(this);

(function() {
    highlight_anchor();
    return $(window).on('hashchange', function() {
        $('.comment.highlighted').removeClass('highlighted');
        return highlight_anchor();
    });
})(this);

