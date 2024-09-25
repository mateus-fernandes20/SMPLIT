<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil do Usuário</title>
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

        header img {
            display: block;
            margin: 0 auto;
        }

        header h1 {
            color: #ffffff;
            text-align: center;
            margin-bottom: 20px;
            font-size: 2rem;
        }

        .profile-info {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #444;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }

        .profile-pic {
            width: 120px;
            height: 120px;
            background-color: #c32828;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 50px;
            margin-right: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6);
        }

        .profile-details {
            flex: 1;
        }

        .profile-details h2 {
            margin: 0;
            color: #e0e0e0;
            font-size: 1.5rem;
        }

        .profile-details p {
            margin: 5px 0;
            font-size: 1rem;
        }

        .section-title {
            font-size: 1.0rem;
            margin-bottom: 15px;
            border-bottom: 1px solid #444;
            padding-bottom: 10px;
            color: #ffffff;
        }

        .sample-card {
            display: flex;
            flex-direction: column;
            background-color: #333;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
        }

        .sample-info {
            margin-bottom: 15px;
        }

        .sample-info h3 {
            margin: 0 0 5px 0;
            color: #e0e0e0;
        }

        .sample-info p {
            margin: 5px 0;
            color: #b0b0b0;
        }

        .sample-card audio {
            width: 100%;
            margin-top: 10px;
        }

        .form-group textarea {
            width: 100%;
            height: 80px;
            padding: 10px;
            border: 1px solid #444;
            border-radius: 4px;
            background-color: #333;
            color: #e0e0e0;
        }

        img {
            width: 170px;
            height: auto;
            margin-left: auto;
            display: block;
        }
        /* Add the rest of your CSS styles */
    </style>
</head>
<body>
    <div class="container">
        <header>
            <img src="/src/main/imagens/logo.PNG" alt="Logo"> 
        </header>
        
        <%
            // Database connection details
            String dbURL = "jdbc:mysql://localhost:3306/smplit";
            String dbUser = "root";
            String dbPassword = "root"; // Replace with your MySQL password
            
            // Placeholder variables for user data
            String userName = "";
            String gender = "";
            int age = 0;

            // Fetch the user data from the database
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                String userQuery = "SELECT nome, sexo, nascimento FROM user WHERE cpf = ?";
                PreparedStatement userStmt = conn.prepareStatement(userQuery);
                userStmt.setString(1, "111"); // Replace '1' with the actual user ID (can come from session or query parameters)

                ResultSet userRs = userStmt.executeQuery();

                if (userRs.next()) {
                    userName = userRs.getString("nome");
                    gender = userRs.getString("sexo");

                    // Calculate age from birthdate
                    java.sql.Date birthdate = userRs.getDate("nascimento");
                    java.util.Date currentDate = new java.util.Date();
                    age = currentDate.getYear() - birthdate.getYear();
                }

                // Close the statement
                userStmt.close();
        %>
        
        <div class="profile-info">
            <div class="profile-pic">
                <span><%= userName.charAt(0) %></span> <!-- First letter of the user's name -->
            </div>
            <div class="profile-details">
                <h2><%= userName %></h2>
                <p>Gênero: <%= gender %></p>
                <p>Idade: <%= age %> anos</p>
            </div>
        </div>

        <!-- Seção de lançamentos -->
        <div class="section-title">Lançamentos do Usuário</div>

        <%
                // Fetch user audio samples
                String audioQuery = "SELECT file_name, genre, tempo, audio_key FROM user_audio WHERE cpf = ?";
                PreparedStatement audioStmt = conn.prepareStatement(audioQuery);
                audioStmt.setString(1, "111"); // Use the same user ID

                ResultSet audioRs = audioStmt.executeQuery();

                while (audioRs.next()) {
                    String fileName = audioRs.getString("file_name");
                    String genre = audioRs.getString("genre");
                    String tempo = audioRs.getString("tempo");
                    String audioKey = audioRs.getString("audio_key");
        %>

        <!-- Sample Card -->
        <div class="sample-card">
            <div class="sample-info">
                <h3><%= fileName %></h3>
                <p>Gênero: <%= genre %></p>
                <p>Tempo: <%= tempo %></p>
                <p>Key: <%= audioKey %></p>
            </div>
            <audio controls>
                <source src="RetrieveAudioServlet?fileName=<%= fileName %>" type="audio/mpeg">
                Seu navegador não suporta o elemento de áudio.
            </audio>
        </div>

        <%
                } // End of audio samples loop

                // Close audio result set and statement
                audioRs.close();
                audioStmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("Erro ao acessar os dados do banco de dados: " + e.getMessage());
            }
        %>
        
    </div>
</body>
</html>
