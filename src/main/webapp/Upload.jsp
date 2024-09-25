<!DOCTYPE html>
<html>
<body>
<style>
	body {
	    background-color: #121212;
	    color: #e0e0e0;
	    font-family: 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
	    margin: 0;
	    padding: 0;
	}
	
	.container {
	    max-width: 900px;
	    margin: 20px auto;
	    padding: 20px;
	    background-color: #1e1e1e;
	    border-radius: 12px;
	    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.8);
	}
	
	header h1 {
	    color: #ffffff;
	    text-align: center;
	    margin-bottom: 20px;
	    font-size: 2rem;
	}
	
	.upload-section {
	    background-color: #2c2c2c;
	    padding: 20px;
	    border-radius: 8px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6);
	    margin-bottom: 20px;
	}
	
	.upload-section h2 {
	    color: #e0e0e0;
	    margin-top: 0;
	}
	
	.form-group {
	    margin-bottom: 15px;
	}
	
	.form-group label {
	    display: block;
	    font-weight: bold;
	    margin-bottom: 5px;
	}
	
	.form-group input,
	.form-group select {
	    width: 100%;
	    padding: 10px;
	    border: 1px solid #444;
	    border-radius: 4px;
	    background-color: #333;
	    color: #e0e0e0;
	}
	
	.form-group input::placeholder {
	    color: #888;
	}
	
	.save-btn,
	.upload-btn {
	    padding: 10px 20px;
	    background-color: #ff52522c;
	    border: none;
	    color: #e0e0e0;
	    font-size: 16px;
	    border-radius: 4px;
	    cursor: pointer;
	    transition: background-color 0.3s;
	}
	
	.save-btn:hover,
	.upload-btn:hover {
	    background-color: #ff0000;
	}
	
	.sample-card {
	    display: flex;
	    flex-direction: column;
	    background-color: #333;
	    padding: 15px;
	    border-radius: 8px;
	    margin-bottom: 15px;
	    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
	}
	
	.sample-card h3 {
	    margin: 0 0 5px 0;
	    color: #e0e0e0;
	}
	
	.sample-card audio {
	    width: 100%;
	    margin: 10px 0;
	}
	
	.delete-btn {
	    padding: 10px 20px;
	    background-color: #ff52522c;
	    border: none;
	    color: #e0e0e0;
	    font-size: 16px;
	    border-radius: 4px;
	    cursor: pointer;
	    transition: background-color 0.3s;
	    margin-right: 10px;
	}
	
	.delete-btn:hover {
	    background-color: #ff0000;
	}
	
	.section-title {
	    font-size: 1.2rem;
	    margin-bottom: 15px;
	    border-bottom: 1px solid #444;
	    padding-bottom: 10px;
	    color: #ffffff;
	}
	</style>

<form action="UploadAudioServlet" method="post" enctype="multipart/form-data">
	<input type="text" id="cpf" name="cpf" placeholder="Digite seu CPF" required>
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

    formContainer.innerHTML = "";

    if (files.length === 0) {
        formContainer.innerHTML = "<p>No files selected.</p>";
        return;
    }

    Array.from(files).forEach((file, index) => {
        let fileDiv = document.createElement("div");
        fileDiv.className = "file-entry";

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
            '<br>' +
            '<label for="key' + index + '">Key:</label>' +
            '<select id="key' + index + '" name="key' + index + '" required>' +
                '<option value="ATONAL">ATONAL</option>' +
                '<option value="C">C</option>' +
                '<option value="C#">C#</option>' +
                '<option value="D">D</option>' +
                '<option value="D#">D#</option>' +
                '<option value="E">E</option>' +
                '<option value="F">F</option>' +
                '<option value="F#">F#</option>' +
                '<option value="G">G</option>' +
                '<option value="G#">G#</option>' +
                '<option value="A">A</option>' +
                '<option value="A#">A#</option>' +
                '<option value="B">B</option>' +
            '</select>' +
            '<br><br>';

        formContainer.appendChild(fileDiv);
    });
}
</script>
</body>
</html>
