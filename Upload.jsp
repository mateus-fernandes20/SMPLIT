<!DOCTYPE html>
<html>
<form action="UploadAudioServlet" method="post" enctype="multipart/form-data">
    <input type="file" id="audioFiles" name="audioFiles" accept="audio/*" multiple onchange="generateFields()" required>
    <br><br>
    <div id="formContainer"></div>
    <input type="submit" value="Upload">
</form>

<script>
function generateFields() {
    var fileInput = document.getElementById("audioFiles");
    var files = fileInput.files;
    var formContainer = document.getElementById("formContainer");

    // Clear previous inputs
    formContainer.innerHTML = "";

    // Check if files are selected
    if (files.length === 0) {
        formContainer.innerHTML = "<p>No files selected.</p>";
        return;
    }

    // Iterate over the selected files
    Array.from(files).forEach((file, index) => {
        let fileDiv = document.createElement("div");
        fileDiv.className = "file-entry";

        // Use simple concatenation instead of template literals
        fileDiv.innerHTML = 
            '<h4>File ' + (index + 1) + ': ' + file.name + '</h4>' +
            '<label for="tempo' + index + '">Tempo:</label>' +
            '<input type="text" id="tempo' + index + '" name="tempo' + index + '" required>' +
            '<br>' +
            '<label for="genre' + index + '">Genre:</label>' +
            '<input type="text" id="genre' + index + '" name="genre' + index + '" required>' +
            '<br>' +
            '<label for="description' + index + '">Description:</label>' +
            '<textarea id="description' + index + '" name="description' + index + '" rows="2" cols="50" required></textarea>' +
            '<br><br>';

        // Append the fileDiv to the form container
        formContainer.appendChild(fileDiv);
    });
}
</script>
</body>
</html>
