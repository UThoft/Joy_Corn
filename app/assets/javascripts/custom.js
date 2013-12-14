$(document).ready(
    $(function()
    {
    var $container = $('#post-panel');
    $container.imagesLoaded(function(){
        $container.masonry({
            columnWidth: 10,
            itemSelector: '#post-box',
            gutterWidth: 0
        });
    });
    $container.infinitescroll({
            navSelector  : "#",
            nextSelector : "#",
            itemSelector : "#post-box" ,
            pixelsFromNavToBottom: 300
        },
        function( newElements )
        {
            var $newElems = $( newElements ).css({ opacity: 0 });
            $newElems.imagesLoaded(function()
            {
                $newElems.animate({ opacity: 1 });
                $container.masonry( 'appended', $newElems, true );
            });
        });
    })
);
