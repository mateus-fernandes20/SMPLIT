import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/GetAudioServlet")
public class GetAudioServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/smplit";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String audioId = request.getParameter("id");

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT file_name, file_data FROM audio_files WHERE id=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, audioId);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String fileName = resultSet.getString("file_name");
                byte[] fileData = resultSet.getBytes("file_data");

                response.setContentType("audio/mpeg");
                response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");

                try (OutputStream out = response.getOutputStream()) {
                    out.write(fileData);
                }
            } else {
                response.getWriter().println("Audio file not found!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
