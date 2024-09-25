<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SMPLIT - Inicio</title>
    <style>
        body, h2, ul, li, p, a, audio {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #0c090d;
            color: #ffffff;
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        .header {
            color: #2c3e50;
            font-size: 28px;
            margin-top: 20px;
            text-align: left;
        }

        .search-bar {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
        }

        .search-bar input[type="text"], .search-bar select {
            padding: 10px;
            margin-right: 10px;
            width: 200px;
        }

        .search-bar button {
            padding: 10px;
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
        }

        .search-bar button:hover {
            background-color: #2980b9;
        }

        .music-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
            gap: 20px;
        }

        .music-card {
            background-color: #fff8f0;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: left;
            color: #34495e;
        }

        .music-card p {
            margin: 5px 0;
        }

        .music-card p strong {
            display: inline-block;
            width: 100px;
            padding-right: 20px;
            color: #7f8c8d;
        }

        .music-card audio {
            width: 100%;
            margin-top: 10px;
            outline: none;
        }

        .music-card a {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 10px;
            color: #fff;
            background-color: #3498db;
            border-radius: 4px;
            text-decoration: none;
            text-align: center;
        }

        .music-card a:hover {
            background-color: #2980b9;
        }

        @media (max-width: 768px) {
            .music-card {
                padding: 10px;
            }

            .music-card p {
                font-size: 16px;
            }

            .music-card a {
                padding: 8px 16px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <!-- Search Bar -->
    <form class="search-bar" method="get" action="home.jsp">
        <input type="text" name="searchName" placeholder="Nome do Áudio" value="<%= request.getParameter("searchName") %>">
        <input type="text" name="searchGenre" placeholder="Gênero" value="<%= request.getParameter("searchGenre") %>">
        <input type="text" name="searchTempo" placeholder="Tempo" value="<%= request.getParameter("searchTempo") %>">
        <input type="text" name="searchKey" placeholder="Chave" value="<%= request.getParameter("searchKey") %>">
        <button type="submit">Buscar</button>
    </form>

    <!-- Music Section -->
    <div class="music-section">
        <%
            String searchName = request.getParameter("searchName");
            String searchGenre = request.getParameter("searchGenre");
            String searchTempo = request.getParameter("searchTempo");
            String searchKey = request.getParameter("searchKey");

            String dbURL = "jdbc:mysql://localhost:3306/smplit";
            String dbUser = "root";
            String dbPassword = "root";

            try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                String sql = "SELECT id, file_name, tempo, genre, description, audio_key FROM audio_files WHERE 1=1";

                if (searchName != null && !searchName.isEmpty()) {
                    sql += " AND file_name LIKE ?";
                }
                if (searchGenre != null && !searchGenre.isEmpty()) {
                    sql += " AND genre LIKE ?";
                }
                if (searchTempo != null && !searchTempo.isEmpty()) {
                    sql += " AND tempo LIKE ?";
                }
                if (searchKey != null && !searchKey.isEmpty()) {
                    sql += " AND audio_key LIKE ?";
                }

                PreparedStatement statement = connection.prepareStatement(sql);

                int paramIndex = 1;

                if (searchName != null && !searchName.isEmpty()) {
                    statement.setString(paramIndex++, "%" + searchName + "%");
                }
                if (searchGenre != null && !searchGenre.isEmpty()) {
                    statement.setString(paramIndex++, "%" + searchGenre + "%");
                }
                if (searchTempo != null && !searchTempo.isEmpty()) {
                    statement.setString(paramIndex++, "%" + searchTempo + "%");
                }
                if (searchKey != null && !searchKey.isEmpty()) {
                    statement.setString(paramIndex++, "%" + searchKey + "%");
                }

                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String fileName = resultSet.getString("file_name");
                    String tempo = resultSet.getString("tempo");
                    String genre = resultSet.getString("genre");
                    String description = resultSet.getString("description");
                    String audioKey = resultSet.getString("audio_key");
        %>
                    <div class="music-card">
                        <p><strong>File Name:</strong> <%= fileName %></p>
                        <p><strong>Tempo:</strong> <%= tempo %></p>
                        <p><strong>Genre:</strong> <%= genre %></p>
                        <p><strong>Description:</strong> <%= description %></p>
                        <p><strong>Key:</strong> <%= audioKey %></p>
                        <audio controls>
                            <source src="RetrieveAudioServlet?id=<%= id %>" type="audio/mpeg">
                            Your browser does not support the audio element.
                        </audio>
                        <a href="DownloadAudioServlet?id=<%= id %>" download="<%= fileName %>">Download</a>
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
