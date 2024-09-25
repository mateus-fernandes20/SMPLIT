import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Servlet que processa buscas de arquivos de áudio
@WebServlet("/SearchAudioServlet")
public class SearchAudioServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/smplit";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "your_password_here"; // Substitua pela sua senha


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String genre = request.getParameter("genre");
        String tempo = request.getParameter("tempo");
        String key = request.getParameter("key");

        List<AudioFile> audioFiles = searchAudioFiles(name, genre, tempo, key);

        request.setAttribute("audioFiles", audioFiles);
        request.getRequestDispatcher("/searchResults.jsp").forward(request, response);
    }

    private List<AudioFile> searchAudioFiles(String name, String genre, String tempo, String key) {
        List<AudioFile> audioFiles = new ArrayList<>();
        String sql = "SELECT * FROM audio_files WHERE "
                   + "(file_name LIKE ? OR ? IS NULL) AND "
                   + "(genre LIKE ? OR ? IS NULL) AND "
                   + "(tempo LIKE ? OR ? IS NULL) AND "
                   + "(audio_key LIKE ? OR ? IS NULL)";

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, name != null ? "%" + name + "%" : null);
            statement.setString(2, name);
            statement.setString(3, genre != null ? "%" + genre + "%" : null);
            statement.setString(4, genre);
            statement.setString(5, tempo != null ? "%" + tempo + "%" : null);
            statement.setString(6, tempo);
            statement.setString(7, key != null ? "%" + key + "%" : null);
            statement.setString(8, key);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    AudioFile audioFile = new AudioFile();
                    audioFile.setId(resultSet.getInt("id"));
                    audioFile.setFileName(resultSet.getString("file_name"));
                    audioFile.setTempo(resultSet.getString("tempo"));
                    audioFile.setGenre(resultSet.getString("genre"));
                    audioFile.setDescription(resultSet.getString("description"));
                    audioFiles.add(audioFile);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return audioFiles;
    }
}
