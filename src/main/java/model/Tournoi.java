package model;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;

public class Tournoi {

    public enum Type { ELIMINATION_DIRECTE, CHAMPIONNAT }
    public enum Statut { EN_ATTENTE, EN_COURS, TERMINE }

    private int id;
    private String nom;
    private Type type;
    private Date dateDebut;
    private Date dateFin;
    private Statut statut;
    private List<Equipe> equipes;

    public Tournoi() {
        this.equipes = new ArrayList<>();
        this.statut = Statut.EN_ATTENTE;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public Type getType() { return type; }
    public void setType(Type type) { this.type = type; }

    public Date getDateDebut() { return dateDebut; }
    public void setDateDebut(Date dateDebut) { this.dateDebut = dateDebut; }

    public Date getDateFin() { return dateFin; }
    public void setDateFin(Date dateFin) { this.dateFin = dateFin; }

    public Statut getStatut() { return statut; }
    public void setStatut(Statut statut) { this.statut = statut; }

    public List<Equipe> getEquipes() { return equipes; }
    public void setEquipes(List<Equipe> equipes) { this.equipes = equipes; }

    public String getTypeLabel() {
        return type == Type.ELIMINATION_DIRECTE ? "Elimination Directe" : "Championnat";
    }

    public String getStatutLabel() {
        switch (statut) {
            case EN_ATTENTE: return "En attente";
            case EN_COURS:   return "En cours";
            case TERMINE:    return "Termine";
            default:         return "";
        }
    }

    // Méthodes booléennes utilisables directement en EL : ${tournoi.championnat}
    public boolean isChampionnat()       { return type == Type.CHAMPIONNAT; }
    public boolean isEliminationDirecte(){ return type == Type.ELIMINATION_DIRECTE; }
    public boolean isEnAttente()         { return statut == Statut.EN_ATTENTE; }
    public boolean isEnCours()           { return statut == Statut.EN_COURS; }
    public boolean isTermine()           { return statut == Statut.TERMINE; }
}
