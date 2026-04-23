package dao;

import model.Regles;
import java.sql.*;
import java.util.Optional;
import java.util.Optional;

public class ReglesDAO {

    public Optional<Regles> findByTournoi(int idTournoi) throws SQLException {
        String sql = "SELECT * FROM regles_tournoi WHERE id_tournoi = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTournoi);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Regles r = new Regles();
                    r.setIdTournoi(rs.getInt("id_tournoi"));
                    r.setPtsVictoire(rs.getInt("pts_victoire"));
                    r.setPtsNul(rs.getInt("pts_nul"));
                    r.setPtsDefaite(rs.getInt("pts_defaite"));
                    r.setNbTerrains(rs.getInt("nb_terrains"));
                    r.setDureeMatchMinutes(rs.getInt("duree_match_minutes"));
                    r.setGestionProlongations(rs.getBoolean("gestion_prolongations"));
                    return Optional.of(r);
                }
            }
        }
        return Optional.empty();
    }

    public void save(Regles r) throws SQLException {
        String sql = "REPLACE INTO regles_tournoi (id_tournoi, pts_victoire, pts_nul, pts_defaite, nb_terrains, duree_match_minutes, gestion_prolongations) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, r.getIdTournoi());
            ps.setInt(2, r.getPtsVictoire());
            ps.setInt(3, r.getPtsNul());
            ps.setInt(4, r.getPtsDefaite());
            ps.setInt(5, r.getNbTerrains());
            ps.setInt(6, r.getDureeMatchMinutes());
            ps.setBoolean(7, r.isGestionProlongations());
            ps.executeUpdate();
        }
    }
}
