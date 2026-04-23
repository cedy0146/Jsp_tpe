package dao;

import model.Classement;
import model.Equipe;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClassementDAO {
    /**
     * Tiebreakers: 1. Points 2. Diff buts 3. Buts pour 4. Buts contre 5. Confront direct (TODO) 6. Tirage
     */

    public List<Classement> findByTournoi(int idTournoi) throws SQLException {
List<Classement> list = new ArrayList<>();
        String sql = "SELECT 0 as id, COALESCE(c.points,0) points, COALESCE(c.matchs_joues,0) matchs_joues, COALESCE(c.victoires,0) victoires, COALESCE(c.nuls,0) nuls, COALESCE(c.defaites,0) defaites, COALESCE(c.buts_pour,0) buts_pour, COALESCE(c.buts_contre,0) buts_contre, e.id as e_id, e.nom as e_nom, e.ville as e_ville " +
                     "FROM tournoi_equipe te JOIN equipe e ON te.id_equipe = e.id " +
                     "LEFT JOIN classement c ON c.id_tournoi = te.id_tournoi AND c.id_equipe = te.id_equipe " +
                     "WHERE te.id_tournoi = ? " +
                     "ORDER BY points DESC, (buts_pour - buts_contre) DESC, buts_pour DESC, buts_contre ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTournoi);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    public void initClassement(int idTournoi, int idEquipe) throws SQLException {
        String sql = "INSERT IGNORE INTO classement (id_tournoi, id_equipe) VALUES (?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTournoi);
            ps.setInt(2, idEquipe);
            ps.executeUpdate();
        }
    }

    public void updateClassement(int idTournoi, int idEquipe,
                                  int points, int matchsJoues,
                                  int victoires, int nuls, int defaites,
                                  int butsPour, int butsContre) throws SQLException {
        String sql = "UPDATE classement SET points=points+?, matchs_joues=matchs_joues+?, " +
                     "victoires=victoires+?, nuls=nuls+?, defaites=defaites+?, " +
                     "buts_pour=buts_pour+?, buts_contre=buts_contre+? " +
                     "WHERE id_tournoi=? AND id_equipe=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, points);
            ps.setInt(2, matchsJoues);
            ps.setInt(3, victoires);
            ps.setInt(4, nuls);
            ps.setInt(5, defaites);
            ps.setInt(6, butsPour);
            ps.setInt(7, butsContre);
            ps.setInt(8, idTournoi);
            ps.setInt(9, idEquipe);
            ps.executeUpdate();
        }
    }

    public void resetClassement(int idTournoi) throws SQLException {
        String sql = "UPDATE classement SET points=0, matchs_joues=0, victoires=0, " +
                     "nuls=0, defaites=0, buts_pour=0, buts_contre=0 WHERE id_tournoi=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTournoi);
            ps.executeUpdate();
        }
    }

    private Classement mapRow(ResultSet rs) throws SQLException {
        Classement c = new Classement();
        c.setId(rs.getInt("id"));
        c.setIdTournoi(rs.getInt("id_tournoi"));
        c.setPoints(rs.getInt("points"));
        c.setMatchsJoues(rs.getInt("matchs_joues"));
        c.setVictoires(rs.getInt("victoires"));
        c.setNuls(rs.getInt("nuls"));
        c.setDefaites(rs.getInt("defaites"));
        c.setButsPour(rs.getInt("buts_pour"));
        c.setButsContre(rs.getInt("buts_contre"));
        Equipe e = new Equipe(rs.getInt("e_id"), rs.getString("e_nom"), rs.getString("e_ville"));
        c.setEquipe(e);
        return c;
    }
}
