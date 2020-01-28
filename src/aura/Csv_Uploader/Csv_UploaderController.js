/**
 * Created by gamedevmadeeasy on 1/27/20.
 */

({
    handleUploadFinished: function (cmp, event) {
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");
        console.log(cmp.value);
        console.log("Files uploaded : " + uploadedFiles.length);
        alert("Files uploaded : " + uploadedFiles.length);
    }
});
