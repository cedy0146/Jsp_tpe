package dao;

import model.Equipe;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EquipeDAO {

    public List<Equipe> findAll() throws SQLException {
        List<Equipe> equipes = new ArrayList<>();
        String sql = "SELECT * FROM equipe ORDER BY nom";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                equipes.add(mapRow(rs));
            }
        }
        return equipes;
    }

    public Equipe findById(int id) throws SQLException {
        String sql = "SELECT * FROM equipe WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public List<Equipe> findByTournoi(int idTournoi) throws SQLException {
        List<Equipe> equipes = new ArrayList<>();
        String sql = "SELECT e.* FROM equipe e " +
                     "JOIN tournoi_equipe te ON e.id = te.id_equipe " +
                     "WHERE te.id_tournoi = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTournoi);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) equipes.add(mapRow(rs));
            }
        }
        return equipes;
    }

    public void insert(Equipe e) throws SQLException {
        String sql = "INSERT INTO equipe (nom, ville, logo_url, date_creation) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, e.getNom());
            ps.setString(2, e.getVille());
            ps.setString(3, e.getLogoUrl());
            ps.setDate(4, e.getDateCreation() != null ? new java.sql.Date(e.getDateCreation().getTime()) : null);
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) e.setId(keys.getInt(1));
            }
        }
    }

    public void update(Equipe e) throws SQLException {
        String sql = "UPDATE equipe SET nom=?, ville=?, logo_url=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, e.getNom());
            ps.setString(2, e.getVille());
            ps.setString(3, e.getLogoUrl());
            ps.setInt(4, e.getId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM equipe WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private Equipe mapRow(ResultSet rs) throws SQLException {
        Equipe e = new Equipe();
        e.setId(rs.getInt("id"));
        e.setNom(rs.getString("nom"));
        e.setVille(rs.getString("ville"));
        e.setLogoUrl(rs.getString("logo_url"));
        Date d = rs.getDate("date_creation");
        if (d != null) e.setDateCreation(new java.util.Date(d.getTime()));
        return e;
    }
}
