package model;

public class Classement {

    private int id;
    private int idTournoi;
    private Equipe equipe;
    private int points;
    private int matchsJoues;
    private int victoires;
    private int nuls;
    private int defaites;
    private int butsPour;
    private int butsContre;

    public Classement() {}

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdTournoi() { return idTournoi; }
    public void setIdTournoi(int idTournoi) { this.idTournoi = idTournoi; }

    public Equipe getEquipe() { return equipe; }
    public void setEquipe(Equipe equipe) { this.equipe = equipe; }

    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }

    public int getMatchsJoues() { return matchsJoues; }
    public void setMatchsJoues(int matchsJoues) { this.matchsJoues = matchsJoues; }

    public int getVictoires() { return victoires; }
    public void setVictoires(int victoires) { this.victoires = victoires; }

    public int getNuls() { return nuls; }
    public void setNuls(int nuls) { this.nuls = nuls; }

    public int getDefaites() { return defaites; }
    public void setDefaites(int defaites) { this.defaites = defaites; }

    public int getButsPour() { return butsPour; }
    public void setButsPour(int butsPour) { this.butsPour = butsPour; }

    public int getButsContre() { return butsContre; }
    public void setButsContre(int butsContre) { this.butsContre = butsContre; }

    public int getDifferenceButs() {
        return butsPour - butsContre;
    }
}
