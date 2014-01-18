$(document).ready(function(){

    var $container = $('#post-panel');

    $container.imagesLoaded(function(){
        $container.masonry({
            itemSelector: '.post',
//            isAnimated: true
            isAnimated: !Modernizr.csstransitions
//            isRTL: true
//            columnWidth: 250
//            gutterWidth: 17
        });
    });

    $container.infinitescroll({
//            debug        : true,
            navSelector  : '.page-nav',    // selector for the paged navigation
            nextSelector : '.page-nav a',  // selector for the NEXT link (to page 2)
            itemSelector : '.post',     // selector for all items you'll retrieve
            pixelsFromNavToBottom : 0,  // set to 0, or it will load earlier than expected.
//            behavior: 'local',
//            animate: true,
//            binder: $(''),
            loading: {
                finishedMsg: 'No more posts.'
//                img: 'http://i.imgur.com/6RMhx.gif'
            }
        },
        // trigger Masonry as a callback
        function( newElements ) {
            // enable the freezeframe as a call back
            // hide new items while they are loading
            var $newElems = $( newElements ).css({ opacity: 0 });
            // ensure that images load before adding to masonry layout
            $newElems.imagesLoaded(function(){
                // show elems now they're ready
                $newElems.animate({ opacity: 1 });
                $container.masonry( 'appended', $newElems, true );
            });
        }
    );


});

$(document).ready(function() {
    if (document.getElementById('notification-notice').getAttribute('data-notice-text').length != 0) {
        $('p#notification-notice').fadeOut(4000);
    }
    if (document.getElementById('notification-alert').getAttribute('data-notice-text').length != 0) {
        $('p#notification-alert').fadeOut(4000);
    }
});

(function(){
    window.BroswerTZone = window.BroswerTZone || {};
    BroswerTZone.setCookie = function(){
        var d = new Date();
        d.setTime(d.getTime() + (356 * 24 * 60 * 60 * 1000));
        var expires = "expires="+d.toUTCString();
        document.cookie="browser.timezone=" + jstz.determine().name() + ";" + expires + "; path=/";
    };
    $(document).ready(function() {
        BroswerTZone.setCookie();
    });
})(jQuery);
