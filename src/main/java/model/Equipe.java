package model;

import java.util.Date;

public class Equipe {

    private int id;
    private String nom;
    private String ville;
    private String logoUrl;
    private Date dateCreation;

    public Equipe() {}

    public Equipe(int id, String nom, String ville) {
        this.id = id;
        this.nom = nom;
        this.ville = ville;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getVille() { return ville; }
    public void setVille(String ville) { this.ville = ville; }

    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }

    public Date getDateCreation() { return dateCreation; }
    public void setDateCreation(Date dateCreation) { this.dateCreation = dateCreation; }

    @Override
    public String toString() {
        return "Equipe{id=" + id + ", nom='" + nom + "', ville='" + ville + "'}";
    }
}
