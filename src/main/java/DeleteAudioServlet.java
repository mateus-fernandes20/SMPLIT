import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteAudioServlet")
public class DeleteAudioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/smplit";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int audioId = Integer.parseInt(request.getParameter("id"));

        Connection conn = null;
        PreparedStatement pstmt = null;
		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		

            String sql = "DELETE FROM audio_files WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, audioId);

            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
                response.sendRedirect("profile.jsp?delete=success");
            } else {
                response.sendRedirect("profile.jsp?delete=failure");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?delete=error");
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
