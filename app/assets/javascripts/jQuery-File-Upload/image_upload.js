//= require jquery
//= require jQuery-File-Upload/jquery.iframe-transport
//= require jQuery-File-Upload/jquery.ui.widget
//= require jQuery-File-Upload/jquery.fileupload
//= require jQuery-File-Upload/image_upload

$(function() {
    var file_upload_selector = $('#file_upload');
    file_upload_selector.fileupload({
        url: file_upload_selector.attr('action'),
        type: 'POST',
        forceIframeTransport: true,    // VERY IMPORTANT.  you will get 405 Method Not Allowed if you don't add this.
        autoUpload: true,
//        dataType: 'xml', // This is really important as s3 gives us back the url of the file in a XML document
        add: function (event, data) {
            $.ajax({
                url: "/signed_urls",
                type: 'GET',
                dataType: 'json',
                data: {doc: {title: data.files[0].name}},
                async: false,
                success: function(data) {
                    // after we created our document in rails, it is going to send back JSON of they key,
                    // policy, and signature.  We will put these into our form before it gets submitted to amazon.
                    file_upload_selector.find('input[name=AWSAccessKeyId]').val(data.AWSAccessKeyId);
                    file_upload_selector.find('input[name=key]').val(data.key);
                    file_upload_selector.find('input[name=policy]').val(data.policy);
                    file_upload_selector.find('input[name=signature]').val(data.signature);
                }

            });

            data.submit();
        },
        send: function(e, data) {
            // show a loading spinner because now the form will be submitted to amazon,
            // and the file will be directly uploaded there, via an iframe in the background.
            $('.fileupload-content').fadeIn();
//            $('#loading').show();
        },
        progress: function(e, data){
            // This is what makes everything really cool, thanks to that callback
            // you can now update the progress bar based on the upload progress
            var percent = Math.round((e.loaded / e.total) * 100);
            $('.fileupload-progress').css('width', percent + '%');
        },
        fail: function(e, data) {
            console.log('fail');
            console.log(data);
        },
        success: function(data) {
            // Here we get the file url on s3 in an xml doc
            var url = $(data).find('Location').text();

            $('#real_file_url').attr(url); // Update the real input in the other form
        },
        done: function (event, data) {
            // here you can perform an ajax call to get your documents to display on the screen.
//            $('#your_documents').load("/documents?for_item=1234");


            // hide the loading spinner that we turned on earlier.
//            $('#loading').hide();
            $('.fileupload-content').fadeOut(300, function() {
                $('.file-upload').css('width', 0)
            })
        }
    });
});