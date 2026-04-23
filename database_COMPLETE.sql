-- =====================================================
-- BASE DE DONNÉES COMPLÈTE TOURNOISPORT
-- =====================================================

-- Supprimer et recréer proprement
DROP DATABASE IF EXISTS tournois_db;
CREATE DATABASE tournois_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tournois_db;

-- Table equipe
CREATE TABLE equipe (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    ville VARCHAR(100),
    logo_url VARCHAR(255),
    date_creation DATE
);

-- Table tournoi
CREATE TABLE tournoi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    type ENUM('ELIMINATION_DIRECTE', 'CHAMPIONNAT') NOT NULL,
    date_debut DATE,
    date_fin DATE,
    statut ENUM('EN_ATTENTE', 'EN_COURS', 'TERMINE') DEFAULT 'EN_ATTENTE'
);

-- Table tournoi_equipe (liaison N-N)
CREATE TABLE tournoi_equipe (
    id_tournoi INT,
    id_equipe INT,
    PRIMARY KEY (id_tournoi, id_equipe),
    FOREIGN KEY (id_tournoi) REFERENCES tournoi(id) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe) REFERENCES equipe(id) ON DELETE CASCADE
);

-- Table match_sportif
CREATE TABLE match_sportif (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_tournoi INT NOT NULL,
    id_equipe1 INT NOT NULL,
    id_equipe2 INT NOT NULL,
    score_equipe1 INT DEFAULT NULL,
    score_equipe2 INT DEFAULT NULL,
    date_match DATE,
    journee INT DEFAULT 1,
    statut ENUM('PROGRAMME', 'JOUE') DEFAULT 'PROGRAMME',
    resultat VARCHAR(20), -- \"2-1\" format
    FOREIGN KEY (id_tournoi) REFERENCES tournoi(id) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe1) REFERENCES equipe(id),
    FOREIGN KEY (id_equipe2) REFERENCES equipe(id)
);

-- Table classement (pour championnats)
CREATE TABLE classement (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_tournoi INT NOT NULL,
    id_equipe INT NOT NULL,
    points INT DEFAULT 0,
    matchs_joues INT DEFAULT 0,
    victoires INT DEFAULT 0,
    nuls INT DEFAULT 0,
    defaites INT DEFAULT 0,
    buts_pour INT DEFAULT 0,
    buts_contre INT DEFAULT 0,
    difference_buts INT DEFAULT 0,
    UNIQUE KEY unique_classement (id_tournoi, id_equipe),
    FOREIGN KEY (id_tournoi) REFERENCES tournoi(id) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe) REFERENCES equipe(id)
);

-- Table regles configurables
CREATE TABLE regles_tournoi (
    id_tournoi INT PRIMARY KEY,
    pts_victoire INT DEFAULT 3,
    pts_nul INT DEFAULT 1,
    pts_defaite INT DEFAULT 0,
    nb_terrains INT DEFAULT 1,
duree_match_minutes INT DEFAULT 90,
gestion_prolongations BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_tournoi) REFERENCES tournoi(id) ON DELETE CASCADE
);

-- Table terrains
CREATE TABLE terrain (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    capacite INT DEFAULT 100,
    type VARCHAR(20) DEFAULT 'herbe'
);

-- Liaison match-terrain
CREATE TABLE match_terrain (
    id_match INT,
    id_terrain INT,
    PRIMARY KEY (id_match, id_terrain),
    FOREIGN KEY (id_match) REFERENCES match_sportif(id) ON DELETE CASCADE,
    FOREIGN KEY (id_terrain) REFERENCES terrain(id)
);

-- Indexes performance
CREATE INDEX idx_tournoi_equipe_tournoi ON tournoi_equipe(id_tournoi);
CREATE INDEX idx_match_tournoi ON match_sportif(id_tournoi);
CREATE INDEX idx_classement_tournoi ON classement(id_tournoi);
CREATE INDEX idx_regles_tournoi ON regles_tournoi(id_tournoi);

-- =====================================================
-- DONNÉES DE TEST COMPLÈTES
-- =====================================================

-- Équipes
INSERT INTO equipe (nom, ville, logo_url, date_creation) VALUES
('Lions FC', 'Casablanca', '/logos/lions.png', '2010-01-01'),
('Eagles United', 'Rabat', '/logos/eagles.png', '2008-06-15'),
('Thunder Boys', 'Marrakech', '/logos/thunder.png', '2012-03-20'),
('Red Warriors', 'Fes', '/logos/red.png', '2005-09-10'),
('Blue Storm', 'Agadir', '/logos/blue.png', '2015-11-05'),
('Golden Stars', 'Tanger', '/logos/golden.png', '2009-04-22'),
('Black Panthers', 'Kenitra', NULL, '2011-07-12'),
('White Sharks', 'Sale', NULL, '2014-02-28');

-- Terrains
INSERT INTO terrain (nom, capacite, type) VALUES
('Terrain A Principal', 500, 'herbe'),
('Terrain B Annexe', 300, 'herbe'),
('Terrain C Synthétique', 200, 'synthetique'),
('Stade Municipal', 1000, 'herbe');

-- Tournoi Championnat test
INSERT INTO tournoi (nom, type, date_debut, date_fin, statut) VALUES
('Championnat National 2024', 'CHAMPIONNAT', '2024-04-01', '2024-06-30', 'EN_COURS'),
('Coupe du Trône', 'ELIMINATION_DIRECTE', '2024-03-01', '2024-05-15', 'EN_COURS');

-- Règles pour tournois
INSERT INTO regles_tournoi (id_tournoi, pts_victoire, pts_nul, nb_terrains) VALUES
(1, 3, 1, 2),
(2, 3, 0, 1);

-- Inscriptions équipes championnat
INSERT INTO tournoi_equipe (id_tournoi, id_equipe) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6);


-- FIN - Base prête !
-- Exécutez : mysql -u root -p < database_COMPLETE.sql

