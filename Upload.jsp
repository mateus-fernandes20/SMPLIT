<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Audio</title>
</head>
<body>
    <h2>Upload Audio File</h2>
    <form action="UploadAudioServlet" method="post" enctype="multipart/form-data">
        <input type="file" name="audioFiles" accept="audio/*" multiple />
        <br /><br />
        <input type="submit" value="Upload" />
    </form>
</body>
</html>
