<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smplit</title>
</head>
<body>
<div align=center>
<h1>User Login</h1>
</div>
<form action=LoginServle method=post>

<table>
<tr><td>Enter Email:</td><td><input type=text name=txtEmail></td></tr>
<tr><td>Enter Password:</td><td><input type=password name=txtPwd></td></tr>
<tr><td><input type=submit value=Login></td><td><input type=reset></td></tr>
</table>
</form>
</body>
</html>