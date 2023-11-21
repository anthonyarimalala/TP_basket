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
    two_point INTEGER,
    lancer_franc INTEGER,
    rebond INTEGER,
    passe_decisive INTEGER
);