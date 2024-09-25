<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Perfil</title>
    <style>
        body {
    background-color: #121212;
    color: #e0e0e0;
    font-family: 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
}

/* Container */
.container {
    max-width: 900px;
    margin: 20px auto;
    padding: 20px;
    background-color: #1e1e1e;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.8);
}

/* Header Styles */
header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 20px;
}

header img {
    height: 60px; /* Adjust logo size */
}

/* Profile Info */
.profile-info {
    margin-bottom: 20px;
}

.profile-details {
    margin-bottom: 30px;
}

/* Edit Form Styles */
.edit-form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.edit-form label {
    font-weight: bold;
    margin-bottom: 5px;
}

.edit-form input[type="text"],
.edit-form input[type="email"],
.edit-form input[type="password"],
.edit-form select {
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #444;
    background-color: #2a2a2a;
    color: #e0e0e0;
    font-size: 16px;
}

.edit-form input[type="text"]:focus,
.edit-form input[type="email"]:focus,
.edit-form input[type="password"]:focus,
.edit-form select:focus {
    border-color: #ff5252; /* Highlight border on focus */
}

/* Buttons */
.btn {
    padding: 10px 20px;
    background-color: #ff52522c;
    border: none;
    color: #e0e0e0;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
    text-align: center;
}

.btn:hover {
    background-color: #ff0000;
}

/* Form Submission */
.submit-btn {
    background-color: #4CAF50; /* Green */
}

.submit-btn:hover {
    background-color: #45a049;
}

/* Section Titles */
.section-title {
    font-size: 24px;
    margin-top: 30px;
    margin-bottom: 15px;
    border-bottom: 2px solid #444;
    padding-bottom: 10px;
}

    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Editar Perfil</h1>
        </header>
        <form action="UpdateProfileServlet" method="post">
            <div class="form-group">
                <label for="name">Nome:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="dob">Data de Nascimento:</label>
                <input type="date" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf" required>
            </div>
            <div class="form-group">
                <label for="email">E-mail:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Telefone:</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <button type="submit" class="save-btn">Salvar Alterações</button>
            </div>
        </form>
    </div>
</body>
</html>
