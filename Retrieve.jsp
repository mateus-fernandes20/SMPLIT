<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Audio Files</title>
</head>
<body>
    <h2>Audio Files</h2>
    <ul>
        <%
            // Connect to the database
            String dbURL = "jdbc:mysql://localhost:3306/smplit";
            String dbUser = "root";
            String dbPassword = "root"; // Replace with your MySQL password

            try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
                String sql = "SELECT id, file_name, tempo, genre, description FROM audio_files";
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String fileName = resultSet.getString("file_name");
                    String tempo = resultSet.getString("tempo");
                    String genre = resultSet.getString("genre");
                    String description = resultSet.getString("description");

        %>
                    <li>
                        <p><strong>File Name:</strong> <%= fileName %></p>
                        <p><strong>Tempo:</strong> <%= tempo %></p>
                        <p><strong>Genre:</strong> <%= genre %></p>
                        <p><strong>Description:</strong> <%= description %></p>
                        <audio controls>
                            <source src="RetrieveAudioServlet?id=<%= id %>" type="audio/*">
                            Your browser does not support the audio element.
                        </audio>
                        <br>
                        <a href="DownloadAudioServlet?id=<%= id %>" download="<%= fileName %>">Download</a>
                    </li>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("Database error: " + e.getMessage());
            }
        %>
    </ul>
</body>
</html>
