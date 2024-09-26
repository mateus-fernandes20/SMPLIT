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

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/smplit";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String nascimento = request.getParameter("nascimento");
        String cpf = request.getParameter("cpf");
        String email = request.getParameter("email");
        String phone = request.getParameter("telefone");

        PreparedStatement pstmt = null;
        Connection conn = null;
		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "UPDATE users SET nome = ?, nascimento = ?, email = ?, phone = ? WHERE cpf = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, nascimento);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, cpf);

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("profile.jsp?update=success");
            } else {
                response.sendRedirect("editProfile.jsp?update=failure");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editProfile.jsp?update=error");
        } finally {
            // Close resources
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
