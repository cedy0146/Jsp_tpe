-- Supprimer et recréer la base proprement
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

-- Table tournoi_equipe
CREATE TABLE tournoi_equipe (
    id_tournoi INT,
    id_equipe INT,
    PRIMARY KEY (id_tournoi, id_equipe),
    FOREIGN KEY (id_tournoi) REFERENCES tournoi(id) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe)  REFERENCES equipe(id)  ON DELETE CASCADE
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
    FOREIGN KEY (id_tournoi) REFERENCES tournoi(id) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe1) REFERENCES equipe(id),
    FOREIGN KEY (id_equipe2) REFERENCES equipe(id)
);

-- Table classement
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
    UNIQUE KEY unique_classement (id_tournoi, id_equipe),
    FOREIGN KEY (id_tournoi) REFERENCES tournoi(id) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe)  REFERENCES equipe(id)
);

-- Donnees de test
INSERT INTO equipe (nom, ville, date_creation) VALUES
('Lions FC',      'Casablanca', '2010-01-01'),
('Eagles United', 'Rabat',      '2008-06-15'),
('Thunder Boys',  'Marrakech',  '2012-03-20'),
('Red Warriors',  'Fes',        '2005-09-10'),
('Blue Storm',    'Agadir',     '2015-11-05'),
('Golden Stars',  'Tanger',     '2009-04-22');
