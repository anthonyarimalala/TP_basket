CREATE TABLE equipe(
    id_equipe VARCHAR(20) PRIMARY KEY,
    nom VARCHAR(255),
    localisation VARCHAR(255)
);

CREATE TABLE maatch(
    id_maatch VARCHAR(20) PRIMARY KEY,
    date_maatch TIMESTAMP,
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
    id_maatch VARCHAR(20) REFERENCES maatch(id_maatch),
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

INSERT INTO maatch (id_maatch, date_maatch, equipe_local, equipe_visiteur) VALUES
    ('GM1', '2023-01-01 20:00:00', 'LAL', 'BOS'),
    ('GM2', '2023-01-15 19:30:00', 'GSW', 'LAL'),
    ('GM3', '2023-02-02 21:00:00', 'BOS', 'GSW');

INSERT INTO statistic (id_maatch, id_joueur, three_point, r_three_point, two_point, r_two_point, lancer_franc, r_lancer_franc, rebond, passe_decisive) VALUES
    ('GM1', 1, 3, 4, 2, 10, 7, 10, 12, 8),
    ('GM1', 2, 2, 5, 8, 10, 5, 10, 9, 5),
    ('GM2', 3, 4, 5, 7, 10, 6, 10, 8, 4),
    ('GM2', 4, 5, 7, 9, 14, 8, 10, 7, 6),
    ('GM3', 1, 3, 3, 11, 15, 7, 10, 10, 7),
    ('GM3', 3, 2, 2, 6, 6, 4, 1, 5, 3);



CREATE VIEW v_statistic AS
SELECT
    CONCAT(j.nom, ' ', j.prenom) AS joueur,
    (SELECT id_equipe FROM joueur WHERE id_joueur=st1.id_joueur) AS equipe,
    (SELECT COUNT(s2.id_statistic) FROM statistic s2 WHERE s2.id_joueur=st1.id_joueur) AS mj,
    (CAST(SUM(CASE WHEN st1.id_joueur = st1.id_joueur THEN three_point*3+two_point*2+lancer_franc ELSE 0 END) AS FLOAT)/(SELECT COUNT(s2.id_statistic) FROM statistic s2 WHERE s2.id_joueur=st1.id_joueur)) AS ppm,
    (SELECT CAST(SUM(s2.rebond) AS FLOAT) FROM statistic s2 WHERE s2.id_joueur=st1.id_joueur)/(SELECT COUNT(s2.id_statistic) FROM statistic s2 WHERE s2.id_joueur=st1.id_joueur) AS rpm,
    (SELECT CAST(SUM(s2.passe_decisive) AS FLOAT) FROM statistic s2 WHERE s2.id_joueur=st1.id_joueur)/(SELECT COUNT(s2.id_statistic) FROM statistic s2 WHERE s2.id_joueur=st1.id_joueur) AS pdpm,
    (SELECT CAST(SUM(s2.three_point+s2.two_point) AS FLOAT)/CAST(SUM(s2.r_three_point+s2.r_two_point) AS FLOAT) FROM statistic s2 WHERE s2.id_joueur=st1.id_joueur)*100 AS fg,
    (SELECT CAST(SUM(s2.three_point) AS FLOAT)/CAST(SUM(s2.r_three_point) AS FLOAT) FROM statistic s2 WHERE s2.id_joueur=st1.id_joueur)*100 AS three_p,
    (SELECT CAST(SUM(s2.lancer_franc) AS FLOAT)/CAST(SUM(s2.r_lancer_franc) AS FLOAT) FROM statistic s2 WHERE s2.id_joueur=st1.id_joueur)*100 AS lf
FROM statistic st1
    JOIN joueur j ON st1.id_joueur=j.id_joueur
GROUP BY st1.id_joueur, j.nom, j.prenom;

