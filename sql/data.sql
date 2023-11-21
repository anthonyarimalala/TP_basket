CREATE TABLE equipe(
    id_equipe VARCHAR(20) PRIMARY KEY,
    nom VARCHAR(255),
    localisation VARCHAR(255)
);

CREATE TABLE match(
    id_match VARCHAR(20) PRIMARY KEY,
    date_match TIMESTAMP,
    equipe_local VARCHAR(20) REFERENCES equipe(id_equipe),
    equipe_visiteur VARCHAR(20) REFERENCES equipe(id_equipe)
);

CREATE TABLE joueur(
    id_joueur SERIAL PRIMARY KEY,
    id_equipe VARCHAR(20) REFERENCES equipe(id_equipe),
    nom VARCHAR(255),
    prenom VARCHAR(255),
    numero INTEGER
);

CREATE TABLE statistic(
    id_statistic SERIAL PRIMARY KEY,
    id_match VARCHAR(20) REFERENCES match(id_match),
    id_joueur INTEGER REFERENCES joueur(id_joueur),
    three_point INTEGER,
    r_three_point INTEGER,
    two_point INTEGER,
    r_two_point INTEGER,
    lancer_franc INTEGER,
    r_lancer_franc INTEGER,
    rebond INTEGER,
    passe_decisive INTEGER
);

INSERT INTO equipe (id_equipe, nom, localisation) VALUES
    ('LAL', 'Los Angeles Lakers', 'Los Angeles, CA'),
    ('BOS', 'Boston Celtics', 'Boston, MA'),
    ('GSW', 'Golden State Warriors', 'San Francisco, CA');

INSERT INTO joueur (id_equipe, nom, prenom, numero) VALUES
    ('LAL', 'James', 'LeBron', 23),
    ('LAL', 'Davis', 'Anthony', 3),
    ('BOS', 'Tatum', 'Jayson', 0),
    ('GSW', 'Curry', 'Stephen', 30);

INSERT INTO match (id_match, date_match, equipe_local, equipe_visiteur) VALUES
    ('GM1', '2023-01-01 20:00:00', 'LAL', 'BOS'),
    ('GM2', '2023-01-15 19:30:00', 'GSW', 'LAL'),
    ('GM3', '2023-02-02 21:00:00', 'BOS', 'GSW');

INSERT INTO statistic (id_match, id_joueur, three_point, r_three_point, two_point, r_two_point, lancer_franc, r_lancer_franc, rebond, passe_decisive) VALUES
    ('GM1', 1, 3, 1, 10, 5, 7, 3, 12, 8),
    ('GM1', 2, 2, 1, 8, 4, 5, 2, 9, 5),
    ('GM2', 3, 4, 2, 7, 3, 6, 2, 8, 4),
    ('GM2', 4, 5, 3, 9, 4, 8, 4, 7, 6),
    ('GM3', 1, 3, 1, 11, 6, 7, 3, 10, 7),
    ('GM3', 3, 2, 1, 6, 3, 4, 1, 5, 3);
