<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastre-se -SMPLIT</title>
    <style>
        body {
            font-family: 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
            background-color: hsl(0, 0%, 9%);
            color: #fff;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column; /* Adiciona flex-direction: column para empilhar as caixas verticalmente */
            align-items: center; /* Centraliza horizontalmente */
            padding-top: 1%; /* Espa�amento do topo */
        }

        .registration-form {
            width: 100%; /* Largura completa da p�gina */
            max-width: 900px; /* Limita a largura m�xima */
            background-color: #282828;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 30px; /* Aumenta o padding interno */
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            gap: 20px; /* Espa�o entre as linhas */
            margin-bottom: 20px; /* Espa�o entre a caixa de registro e a caixa de beneficios */
        }

        .registration-form h2 {
            color: #fefefe;
            width: 100%; /* Largura total para o t�tulo */
            text-align: center;
            margin-bottom: 20px; /* Aumenta o espa�o abaixo do t�tulo */
        }

        .form-row {
            display: flex;
            gap: 60px; /* Espa�o entre os itens dentro da linha */
            margin-bottom: 20px; /* Espa�o entre as linhas */
            flex-wrap: wrap; /* Permite que os itens quebrem linha se necess�rio */
        }

        .form-group {
            flex: 1 1 calc(50% - 50px); /* Largura dos itens com espa�o entre eles */
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px; /* Aumenta o espa�o abaixo do r�tulo */
            font-weight: bold;
            color: #f4f4f4;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px; /* Aumenta o padding para mais espa�o interno */
            font-size: 16px;
            border: 1px solid #555;
            border-radius: 4px;
            background-color: #333;
            color: #fff;
        }

        .form-group input[type="submit"] {
            background-color: #ffffff;
            color: rgb(0, 0, 0);
            border: none;
            cursor: pointer;
            padding: 15px; /* Aumenta o padding para um bot�o maior */
            font-size: 18px;
            border-radius: 4px;
            width: 50%; /* Largura total da caixa de registro */
            margin-top: 20px;
            margin-left: 25%;
           
        }

        .form-group input[type="submit"]:hover {
            background-color:  #f7a100;
        }

        .form-group input::placeholder {
            color: #aaa;
        }

        /* benef�cios de ter conta na nossa plataforma */
        .benefits-section {
            width: 100%; /* Largura completa da p�gina */
            background-color: #1f1f1f;
            padding: 20px;
            text-align: center;
            box-sizing: border-box;
           
        }

        .benefits-section h3 {
            color: #ff8c00;
            margin-bottom: 40px;
            font-size: 28px;
        }

        .benefits-list {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap; /* Permite que os cart�es quebrem linha se necess�rio */
        }

        .benefit-card {
            background-color: #222;
            padding: 20px;
            border-radius: 20px;
            width: 250px;
            color: white;
            text-align: center;
            line-height: 1.8; /* Aumenta o espa�amento entre linhas de texto */

        }
        img {
            width: 170px; /* Defina o tamanho da imagem conforme necess�rio */
            height: auto;
            margin-right: 50%;
        }

    </style>
</head>
<body>

    <div class="registration-form">
        <div> <img src="/src/main/imagens/logo.PNG" alt="Logo"> </div>
        <h2>Cadastre-se em nossa plataforma:</h2>
        <form action="RegisterServlet" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="cpf">CPF:</label>
                    <input type="text" id="cpf" name="cpf" placeholder="Digite seu CPF" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" placeholder="Digite seu email" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" placeholder="Digite seu nome" required>
                </div>
                <div class="form-group">
                    <label for="senha">Senha:</label>
                    <input type="password" id="senha" name="senha" placeholder="Digite sua senha" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="telefone">Telefone:</label>
                    <input type="text" id="telefone" name="telefone" placeholder="Digite seu telefone" required>
                </div>
                <div class="form-group">
                    <label for="sexo">Sexo/G�nero:</label>
                    <select id="sexo" name="sexo" required>
                        <option value="male">Masculino</option>
                        <option value="female">Feminino</option>
                        <option value="other">Outro</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="nascimento">Data de Nascimento:</label>
                    <input type="date" id="nascimento" name="nascimento" required>
                </div>
            </div>
            <div class="form-group">
                <input type="submit" value="Registrar">
            </div>
        </form>
    </div>

    <!-- Se��o de Benef�cios de ter uma conta -->
    <div class="benefits-section">
        <h3>Com uma conta do SMPLIT voc� pode:</h3>
        <div class="benefits-list">
            <div class="benefit-card">
                <p>Compartilhar seus samples com o mundo</p>
            </div>
            <div class="benefit-card">
                <p>Conhecer o trabalho de outros produtores e artistas</p>
            </div>
            <div class="benefit-card">
                <p>Encontrar sons novos e unicos todos os dias</p>
            </div>
            <div class="benefit-card">
                <p>Usufruir de uma plataforma feita pensando em produtores como voc�</p>
            </div>
        </div>
    </div>

</body>
</html>
