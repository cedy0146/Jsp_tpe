package model;

import java.util.Date;

public class Match {

    public enum Statut { PROGRAMME, JOUE }

    private int id;
    private int idTournoi;
    private Equipe equipe1;
    private Equipe equipe2;
    private Integer scoreEquipe1;
    private Integer scoreEquipe2;
    private Date dateMatch;
    private int journee;
    private Statut statut;

    public Match() {
        this.statut = Statut.PROGRAMME;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdTournoi() { return idTournoi; }
    public void setIdTournoi(int idTournoi) { this.idTournoi = idTournoi; }

    public Equipe getEquipe1() { return equipe1; }
    public void setEquipe1(Equipe equipe1) { this.equipe1 = equipe1; }

    public Equipe getEquipe2() { return equipe2; }
    public void setEquipe2(Equipe equipe2) { this.equipe2 = equipe2; }

    public Integer getScoreEquipe1() { return scoreEquipe1; }
    public void setScoreEquipe1(Integer scoreEquipe1) { this.scoreEquipe1 = scoreEquipe1; }

    public Integer getScoreEquipe2() { return scoreEquipe2; }
    public void setScoreEquipe2(Integer scoreEquipe2) { this.scoreEquipe2 = scoreEquipe2; }

    public Date getDateMatch() { return dateMatch; }
    public void setDateMatch(Date dateMatch) { this.dateMatch = dateMatch; }

    public int getJournee() { return journee; }
    public void setJournee(int journee) { this.journee = journee; }

    public Statut getStatut() { return statut; }
    public void setStatut(Statut statut) { this.statut = statut; }

    public boolean isJoue() { return statut == Statut.JOUE; }

    public String getResultat() {
        if (!isJoue()) return "- vs -";
        return scoreEquipe1 + " - " + scoreEquipe2;
    }
}
