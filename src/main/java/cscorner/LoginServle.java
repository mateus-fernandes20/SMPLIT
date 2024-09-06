package cscorner;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServle
 */

public class LoginServle extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try 
		{
			PrintWriter out=response.getWriter();
			response.setContentType("text/html");
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smplit","root","root");
			
			String n=request.getParameter("txtEmail");
			String p=request.getParameter("txtPwd");
			PreparedStatement ps=con.prepareStatement("select email from user where email=? and senha=?");
			//PreparedStatement ps=con.prepareStatement("INSERT into user VALUES('222', 'slaaa@gmail', 'meunodasme', 'minhasenhasda', '1234567ss890', '2012-02-01', 'M')");
			ps.setString(1, n);
			ps.setString(2, p);
			ResultSet rs=ps.executeQuery();
			//ps.executeUpdate();
			
			if(rs.next())
			{
				RequestDispatcher rd = request.getRequestDispatcher("welcome.jsp");
				rd.forward(request, response);
			}
			else
			{
				out.println("<font color=red size=18> Login Failed!!<br>");
				out.println("<a href=Login.jsp> Try Again </a>");
			}
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		};
	}
}
