package model;

public class Regles {
    private int idTournoi;
    private int ptsVictoire = 3;
    private int ptsNul = 1;
    private int ptsDefaite = 0;
    private int nbTerrains = 1;
    private int dureeMatchMinutes = 90;
    private boolean gestionProlongations = false;

    public Regles() {}

    public Regles(int idTournoi) {
        this.idTournoi = idTournoi;
    }

    // Getters/Setters
    public int getIdTournoi() { return idTournoi; }
    public void setIdTournoi(int idTournoi) { this.idTournoi = idTournoi; }

    public int getPtsVictoire() { return ptsVictoire; }
    public void setPtsVictoire(int ptsVictoire) { this.ptsVictoire = ptsVictoire; }

    public int getPtsNul() { return ptsNul; }
    public void setPtsNul(int ptsNul) { this.ptsNul = ptsNul; }

    public int getPtsDefaite() { return ptsDefaite; }
    public void setPtsDefaite(int ptsDefaite) { this.ptsDefaite = ptsDefaite; }

    public int getNbTerrains() { return nbTerrains; }
    public void setNbTerrains(int nbTerrains) { this.nbTerrains = nbTerrains; }

    public int getDureeMatchMinutes() { return dureeMatchMinutes; }
    public void setDureeMatchMinutes(int dureeMatchMinutes) { this.dureeMatchMinutes = dureeMatchMinutes; }

    public boolean isGestionProlongations() { return gestionProlongations; }
    public void setGestionProlongations(boolean gestionProlongations) { this.gestionProlongations = gestionProlongations; }
}
