import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RetrieveAudioListServlet")
public class RetrieveAudioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Map<String, Object>> audioFiles = new ArrayList<>();

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT id, file_name, tempo, genre, description FROM audio_files";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> audioFile = new HashMap<>();
                audioFile.put("id", rs.getInt("id"));
                audioFile.put("fileName", rs.getString("file_name"));
                audioFile.put("tempo", rs.getString("tempo"));
                audioFile.put("genre", rs.getString("genre"));
                audioFile.put("description", rs.getString("description"));
                audioFiles.add(audioFile);
            }

            request.setAttribute("audioFiles", audioFiles);
            RequestDispatcher dispatcher = request.getRequestDispatcher("retrieveAudioFiles.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error retrieving audio files.");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
