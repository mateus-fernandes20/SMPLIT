import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Collection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadAudioServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/smplit";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root"; // Replace with your MySQL password

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Collection<Part> fileParts = request.getParts(); // Retrieves all files
        boolean uploadSuccess = true;

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            for (Part filePart : fileParts) {
                if (filePart.getName().equals("audioFiles") && filePart.getSize() > 0) {
                    String fileName = extractFileName(filePart);
                    InputStream fileInputStream = filePart.getInputStream();

                    String sql = "INSERT INTO audio_files (file_name, file_data) VALUES (?, ?)";
                    PreparedStatement statement = connection.prepareStatement(sql);
                    statement.setString(1, fileName);
                    statement.setBlob(2, fileInputStream);

                    int rowsInserted = statement.executeUpdate();
                    if (rowsInserted <= 0) {
                        uploadSuccess = false;
                        response.getWriter().println("Failed to upload file: " + fileName);
                    }
                }
            }

            if (uploadSuccess) {
                response.getWriter().println("All files uploaded successfully!");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1).replace("\\", "/");
            }
        }
        return "";
    }
}
