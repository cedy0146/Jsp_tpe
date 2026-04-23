-- Updates DB pour Améliorations Projet TournoiSport
-- À exécuter après database_FINAL.sql
USE tournois_db;

-- Table règles configurables par tournoi
CREATE TABLE IF NOT EXISTS regles_tournoi (
    id_tournoi INT PRIMARY KEY,
    pts_victoire INT DEFAULT 3,
    pts_nul INT DEFAULT 1,
    pts_defaite INT DEFAULT 0,
    nb_terrains INT DEFAULT 1,
    duree_match_minutes INT DEFAULT 90,
    gestion_prolongations BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_tournoi) REFERENCES tournoi(id) ON DELETE CASCADE
);

-- Table terrains (ex: A1, A2...)
CREATE TABLE IF NOT EXISTS terrain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    capacite INT DEFAULT 100
);

-- Table affectation terrain à match (optionnel)
CREATE TABLE IF NOT EXISTS match_terrain (
    id_match INT,
    id_terrain INT,
    PRIMARY KEY (id_match, id_terrain),
    FOREIGN KEY (id_match) REFERENCES match_sportif(id) ON DELETE CASCADE,
    FOREIGN KEY (id_terrain) REFERENCES terrain(id)
);

-- Données test terrains
INSERT IGNORE INTO terrain (nom, capacite) VALUES
('Terrain A', 500), ('Terrain B', 300), ('Terrain C', 200);

-- Update ClassementDAO gèrera tiebreakers avancés via APP (confrontation directe calculée)

-- Indexes perf
CREATE INDEX idx_classement_tournoi ON classement(id_tournoi);
CREATE INDEX idx_match_tournoi ON match_sportif(id_tournoi);

-- FIN Updates

