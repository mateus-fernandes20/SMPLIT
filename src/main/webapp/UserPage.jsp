<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seu Perfil - SMPLIT</title>
    <style>
        /* Add your existing styles here */
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

        /* Add the rest of the existing styles */
        /* Styles truncated for brevity */

        .sample-card {
            display: flex;
            flex-direction: column;
            background-color: #333;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
        }

        .sample-info {
            margin-bottom: 15px;
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
            text-align: center;
            display: inline-block;
        }

        .delete-btn:hover {
            background-color: #ff0000;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div><img src="/src/main/imagens/logo.PNG" alt="Logo"> <h1>Bem Vindo Ao Seu Perfil</h1></div>
        </header>
        <div class="profile-info">
            <div class="profile-details">
                <% 
                    // Fetch user information from the session or database
                    String username = (String) session.getAttribute("user");
                    if (username == null) {
                        username = "Visitante";
                    }

                    // Replace this with your actual user data fetching logic
                    String gender = "Masculino";
                    int age = 30; // Example static value
                %>
                <h2><%= username %></h2>
                <p>Gênero: <%= gender %></p>
                <p>Idade: <%= age %> anos</p>
                <button class="edit-btn" onclick="toggleEditForm()">Editar Perfil</button>
                <button class="upload-btn" onclick="toggleUploadSection()">Fazer Upload de Áudio</button>
            </div>
        </div>

        <!-- Existing forms for editing profile and uploading audio -->
        <!-- (No changes made here) -->

        <!-- Seção de lançamentos -->
        <div class="section-title">Seus Lançamentos</div>
        <% 
            // Database connection setup
            String dbURL = "jdbc:mysql://localhost:3306/smplit";
            String dbUser = "root";
            String dbPassword = "root"; // Replace with your MySQL password

            try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                String sql = "SELECT id, file_name, genre, tempo, audio_key FROM audio_files join user on audio_files.cpf = user.cpf";
                PreparedStatement statement = connection.prepareStatement(sql);
                //statement.setString(1, username);
                ResultSet resultSet = statement.executeQuery();

                // Iterate through each user's audio file and display it
                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String fileName = resultSet.getString("file_name");
                    String genre = resultSet.getString("genre");
                    String tempo = resultSet.getString("tempo");
                    String audioKey = resultSet.getString("audio_key");
        %>
                    <div class="sample-card">
                        <div class="sample-info">
                            <h3><%= fileName %></h3>
                            <p>Gênero: <%= genre %></p>
                            <p>Tempo: <%= tempo %></p>
                            <p>Key: <%= audioKey %></p>
                        </div>
                        <audio controls>
                            <source src="RetrieveAudioServlet?id=<%= id %>" type="audio/mpeg">
                            Seu navegador não suporta o elemento de áudio.
                        </audio>
                        <form action="DeleteAudioServlet" method="post">
                            <input type="hidden" name="id" value="<%= id %>">
                            <button class="delete-btn">Excluir</button>
                        </form>
                    </div>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("Database error: " + e.getMessage());
            }
        %>
    </div>
</body>
</html>
