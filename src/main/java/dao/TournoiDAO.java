package dao;

import model.Tournoi;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TournoiDAO {

    public List<Tournoi> findAll() throws SQLException {
        List<Tournoi> list = new ArrayList<>();
        String sql = "SELECT * FROM tournoi ORDER BY date_debut DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public Tournoi findById(int id) throws SQLException {
        String sql = "SELECT * FROM tournoi WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public void insert(Tournoi t) throws SQLException {
        String sql = "INSERT INTO tournoi (nom, type, date_debut, date_fin, statut) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, t.getNom());
            ps.setString(2, t.getType().name());
            ps.setDate(3, t.getDateDebut() != null ? new java.sql.Date(t.getDateDebut().getTime()) : null);
            ps.setDate(4, t.getDateFin() != null ? new java.sql.Date(t.getDateFin().getTime()) : null);
            ps.setString(5, t.getStatut().name());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) t.setId(keys.getInt(1));
            }
        }
    }

    public void update(Tournoi t) throws SQLException {
        String sql = "UPDATE tournoi SET nom=?, type=?, date_debut=?, date_fin=?, statut=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, t.getNom());
            ps.setString(2, t.getType().name());
            ps.setDate(3, t.getDateDebut() != null ? new java.sql.Date(t.getDateDebut().getTime()) : null);
            ps.setDate(4, t.getDateFin() != null ? new java.sql.Date(t.getDateFin().getTime()) : null);
            ps.setString(5, t.getStatut().name());
            ps.setInt(6, t.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM tournoi WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public void addEquipe(int idTournoi, int idEquipe) throws SQLException {
        String sql = "INSERT IGNORE INTO tournoi_equipe (id_tournoi, id_equipe) VALUES (?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTournoi);
            ps.setInt(2, idEquipe);
            ps.executeUpdate();
        }
    }

    public void removeEquipe(int idTournoi, int idEquipe) throws SQLException {
        String sql = "DELETE FROM tournoi_equipe WHERE id_tournoi=? AND id_equipe=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTournoi);
            ps.setInt(2, idEquipe);
            ps.executeUpdate();
        }
    }

    private Tournoi mapRow(ResultSet rs) throws SQLException {
        Tournoi t = new Tournoi();
        t.setId(rs.getInt("id"));
        t.setNom(rs.getString("nom"));
        t.setType(Tournoi.Type.valueOf(rs.getString("type")));
        t.setStatut(Tournoi.Statut.valueOf(rs.getString("statut")));
        Date dd = rs.getDate("date_debut");
        if (dd != null) t.setDateDebut(new java.util.Date(dd.getTime()));
        Date df = rs.getDate("date_fin");
        if (df != null) t.setDateFin(new java.util.Date(df.getTime()));
        return t;
    }
}
