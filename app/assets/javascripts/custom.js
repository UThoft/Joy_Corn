$(function(){

    var $container = $('#post-panel');

    $container.imagesLoaded(function(){
        $container.masonry({
            itemSelector: '.post',
//            isAnimated: true
            isAnimated: !Modernizr.csstransitions,
//            isRTL: true
            columnWidth: 10
        });
    });

//    $('.infinite-scroll').jscroll({
//        loadingHtml: '<img src="loading.gif" alt="Loading" /> Loading...',
//        padding: 20,
//        nextSelector: 'a.jscroll-next:last',
//        contentSelector: 'li'
//    });

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
