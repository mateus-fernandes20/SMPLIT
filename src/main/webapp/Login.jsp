<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SMPLIT - Login</title>
    <style>
        body {
            font-family: 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #434343;
            color: rgb(73, 73, 73);
        }

        img {
            width: 170px;
            height: auto;
            margin-right: 25px;
            margin-left: 35px;
            margin-top: -200px;
        }

        .hero-section {
            position: relative;
            background-color: #161616;
            background-size: cover;
            background-position: center;
            height: 730px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-box {
            background-color: rgba(0, 0, 0, 0.996);
            padding: 105px 120px;
            border-radius: 70px;
            text-align: center;
        }

        .login-box h2 {
            margin-bottom: 50px;
            font-size: 45px;
            color: #fcfcfc;
        }

        .login-box input {
            padding: 15px;
            margin-bottom: 15px;
            width: 100%;
            border: none;
            border-radius: 10px;
        }

        .login-box button {
            margin-top: 10px;
            padding: 15px 80px;
            border: none;
            border-radius: 10px;
            background-color: #fefefe;
            color: rgb(0, 0, 0);
            cursor: pointer;
            font-size: 16px;
        }

        .login-box button:hover {
            background-color: #f7a100;
        }

        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <div class="hero-section">
        <div class="login-box">
            <img src="/src/main/imagens/logo.PNG" alt="Logo">
            <h2>FAÇA LOGIN</h2>
			<form action="LoginServlet" method="post">
                <input type=email name="email" placeholder="Email" required>
                <input type="password" name="senha" placeholder="Senha" required>
                <button type="submit">Entrar</button>
            </form>

            <!-- Exibe a mensagem de erro, caso exista -->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <div class="error-message"><%= errorMessage %></div>
            <% } %>

            <p style="margin-top: 20px;">Novo por aqui? <a href="register.jsp" style="color: #ff8c00;">Crie uma conta</a></p>
        </div>
    </div>

</body>
</html>
