import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/smplit";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cpf = request.getParameter("cpf");
        String email = request.getParameter("email");
        String nome = request.getParameter("nome");
        String senha = request.getParameter("senha");
        String telefone = request.getParameter("telefone");
        String sexo = request.getParameter("sexo");
        String nascimento = request.getParameter("nascimento");
        

        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO user (cpf, email, nome, senha, telefone, nascimento, sexo) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, cpf);
            stmt.setString(2, email);
            stmt.setString(3, nome);
            stmt.setString(4, senha);
            stmt.setString(5, telefone);
            stmt.setString(6, nascimento);
            stmt.setString(7, sexo);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.getWriter().println("User registered successfully!");
            } else {
                response.getWriter().println("Error occurred during registration.");
            }

            stmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database connection or query error.");
        }
    }
}
