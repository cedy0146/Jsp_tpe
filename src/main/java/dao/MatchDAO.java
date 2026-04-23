package dao;

import model.Match;
import model.Equipe;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatchDAO {

    public List<Match> findByTournoi(int idTournoi) throws SQLException {
        List<Match> list = new ArrayList<>();
        String sql = "SELECT m.*, " +
                     "e1.id as e1_id, e1.nom as e1_nom, e1.ville as e1_ville, " +
                     "e2.id as e2_id, e2.nom as e2_nom, e2.ville as e2_ville " +
                     "FROM match_sportif m " +
                     "JOIN equipe e1 ON m.id_equipe1 = e1.id " +
                     "JOIN equipe e2 ON m.id_equipe2 = e2.id " +
                     "WHERE m.id_tournoi = ? ORDER BY m.journee, m.date_match";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTournoi);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    public Match findById(int id) throws SQLException {
        String sql = "SELECT m.*, " +
                     "e1.id as e1_id, e1.nom as e1_nom, e1.ville as e1_ville, " +
                     "e2.id as e2_id, e2.nom as e2_nom, e2.ville as e2_ville " +
                     "FROM match_sportif m " +
                     "JOIN equipe e1 ON m.id_equipe1 = e1.id " +
                     "JOIN equipe e2 ON m.id_equipe2 = e2.id " +
                     "WHERE m.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public void insert(Match m) throws SQLException {
        String sql = "INSERT INTO match_sportif (id_tournoi, id_equipe1, id_equipe2, date_match, journee, statut) " +
                     "VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, m.getIdTournoi());
            ps.setInt(2, m.getEquipe1().getId());
            ps.setInt(3, m.getEquipe2().getId());
            ps.setDate(4, m.getDateMatch() != null ? new java.sql.Date(m.getDateMatch().getTime()) : null);
            ps.setInt(5, m.getJournee());
            ps.setString(6, m.getStatut().name());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) m.setId(keys.getInt(1));
            }
        }
    }

    public void updateScore(int idMatch, int score1, int score2) throws SQLException {
        String sql = "UPDATE match_sportif SET score_equipe1=?, score_equipe2=?, statut='JOUE' WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, score1);
            ps.setInt(2, score2);
            ps.setInt(3, idMatch);
            ps.executeUpdate();
        }
    }

    public void deleteByTournoi(int idTournoi) throws SQLException {
        String sql = "DELETE FROM match_sportif WHERE id_tournoi=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTournoi);
            ps.executeUpdate();
        }
    }

    private Match mapRow(ResultSet rs) throws SQLException {
        Match m = new Match();
        m.setId(rs.getInt("id"));
        m.setIdTournoi(rs.getInt("id_tournoi"));
        m.setJournee(rs.getInt("journee"));
        m.setStatut(Match.Statut.valueOf(rs.getString("statut")));

        int s1 = rs.getInt("score_equipe1");
        if (!rs.wasNull()) m.setScoreEquipe1(s1);
        int s2 = rs.getInt("score_equipe2");
        if (!rs.wasNull()) m.setScoreEquipe2(s2);

        Date d = rs.getDate("date_match");
        if (d != null) m.setDateMatch(new java.util.Date(d.getTime()));

        Equipe e1 = new Equipe(rs.getInt("e1_id"), rs.getString("e1_nom"), rs.getString("e1_ville"));
        Equipe e2 = new Equipe(rs.getInt("e2_id"), rs.getString("e2_nom"), rs.getString("e2_ville"));
        m.setEquipe1(e1);
        m.setEquipe2(e2);
        return m;
    }
}
