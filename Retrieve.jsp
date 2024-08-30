<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Audio Files</title>
    <style>
		/* Reset some default browser styles */
		body, h2, ul, li, p, a, audio {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		}
		
		/* Body style */
		body {
		    font-family: Arial, sans-serif;
		    background-color: #f4f4f4;
		    color: #333;
		    padding: 20px;
		}
		
		/* Page title */
		h2 {
		    color: #2c3e50;
		    font-size: 28px;
		    margin-bottom: 20px;
		    text-align: center;
		}
		
		/* Audio files list */
		ul {
		    list-style: none;
		    padding: 0;
		}
		
		/* Each file entry */
		li {
		    background: #ffffff;
		    border: 1px solid #ddd;
		    border-radius: 8px;
		    margin-bottom: 20px;
		    padding: 15px;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}
		
		/* File name */
		li p {
		    font-size: 18px;
		    font-weight: bold;
		    margin-bottom: 10px;
		    color: #34495e;
		}
		
		/* Tempo, genre, and description labels */
		li p strong {
		    display: inline-block;
		    width: 100px;
		    padding-right: 20px;
		    color: #7f8c8d;
		}
		
		/* Audio player */
		li audio {
		    width: 100%;
		    margin-top: 10px;
		}
		
		/* Download button */
		li a {
		    display: inline-block;
		    padding: 10px 20px;
		    margin-top: 10px;
		    color: #fff;
		    background-color: #3498db;
		    border-radius: 4px;
		    text-decoration: none;
		    text-align: center;
		}
		
		li a:hover {
		    background-color: #2980b9;
		}
		
		/* Mobile responsiveness */
		@media (max-width: 768px) {
		    li {
		        padding: 10px;
		    }
		
		    li p {
		        font-size: 16px;
		    }
		
		    li a {
		        padding: 8px 16px;
		        font-size: 14px;
		    }
		}
    </style>
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
                String sql = "SELECT id, file_name, tempo, genre, description, audio_key FROM audio_files";
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String fileName = resultSet.getString("file_name");
                    String tempo = resultSet.getString("tempo");
                    String genre = resultSet.getString("genre");
                    String description = resultSet.getString("description");
                    String audioKey = resultSet.getString("audio_key");

        %>
                    <li>
                        <p><strong>File Name:</strong> <%= fileName %></p>
                        <p><strong>Tempo:</strong> <%= tempo %></p>
                        <p><strong>Genre:</strong> <%= genre %></p>
                        <p><strong>Description:</strong> <%= description %></p>
                        <p><strong>Key:</strong> <%= audioKey %></p>
                        <audio controls>
                            <source src="RetrieveAudioServlet?id=<%= id %>" type="audio/mpeg">
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
