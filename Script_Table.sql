DROP TABLE IF EXISTS demande_retour CASCADE;
DROP TABLE IF EXISTS ligne_commande CASCADE;
DROP TABLE IF EXISTS commande CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS retour_effectif CASCADE;
DROP TABLE IF EXISTS produit CASCADE;
DROP TABLE IF EXISTS changement_prix CASCADE;
DROP TABLE IF EXISTS status CASCADE;
DROP TABLE IF EXISTS adresse CASCADE;
DROP TABLE IF EXISTS commande_retour CASCADE;
DROP TABLE IF EXISTS appartient CASCADE;
DROP TABLE IF EXISTS client_review CASCADE;
DROP TABLE IF EXISTS clients_order CASCADE;
DROP TABLE IF EXISTS retour_valide CASCADE;
DROP TABLE IF EXISTS review_comande_ligne CASCADE;
DROP TABLE IF EXISTS achat CASCADE;
DROP TABLE IF EXISTS changement_produit CASCADE;
DROP TABLE IF EXISTS est_annulee CASCADE;
DROP TABLE IF EXISTS est_livree CASCADE;
DROP TABLE IF EXISTS en_livraison CASCADE;
DROP TABLE IF EXISTS en_preparation CASCADE;
DROP TABLE IF EXISTS en_attente CASCADE;
DROP TABLE IF EXISTS adresse_clients CASCADE;
DROP TABLE IF EXISTS adresse_commande CASCADE;

CREATE TABLE produit (id_produit INTEGER PRIMARY KEY,
nom_produit varchar(20),
faction_produit varchar(20),
niveau_detail_produit varchar(20),
price_produit FLOAT,
etat_produit VARCHAR(20),
delais_produit INTEGER,
quantite_stock_produit INTEGER);

CREATE TABLE changement_prix (id_changement_prix INTEGER PRIMARY KEY);

CREATE TABLE changement_produit (id_changement_prix INTEGER REFERENCES changement_prix,
id_produit INTEGER REFERENCES produit,
date_changement_produit DATE,
ancien_prix FLOAT,
nouveau_prix FLOAT,
PRIMARY KEY (id_changement_prix, id_produit));

CREATE TABLE clients (id_clients INTEGER PRIMARY KEY,
nom_clients VARCHAR(20),
prenom_clients VARCHAR(20),
email_clients VARCHAR(100),
telephone_clients VARCHAR(20),
date_anniversaire_clients DATE,
date_inscription_clients DATE);

CREATE TABLE adresse (id_adresse INTEGER PRIMARY KEY,
numero_adresse INTEGER,
rue_adresse VARCHAR(100),
ville_adresse VARCHAR(50),
code_postal_adresse INTEGER);

CREATE TABLE adresse_clients (id_clients INTEGER REFERENCES clients,
id_adresse INTEGER REFERENCES adresse,
PRIMARY KEY (id_clients, id_adresse));

CREATE TABLE commande (id_commande INTEGER PRIMARY KEY,
order_date_commande DATE,
order_total_commande FLOAT);

CREATE TABLE clients_order (id_clients INTEGER REFERENCES clients,
id_commande INTEGER REFERENCES commande,
PRIMARY KEY (id_clients, id_commande));

CREATE TABLE adresse_commande (id_adresse INTEGER REFERENCES adresse,
id_commande INTEGER REFERENCES commande,
PRIMARY KEY (id_adresse, id_commande));

CREATE TABLE review (id_review INTEGER PRIMARY KEY,
note_review INTEGER,
commentaire_review TEXT);

CREATE TABLE client_review (id_review INTEGER REFERENCES review,
id_clients INTEGER REFERENCES clients,
PRIMARY KEY (id_review, id_clients));

CREATE TABLE ligne_commande (id_commande_ligne INTEGER PRIMARY KEY,
quantite_ligne_commande INTEGER,
price_ligne_commande FLOAT,
payee_ligne_commande BOOL);

CREATE TABLE review_comande_ligne (id_commande_ligne INTEGER REFERENCES ligne_commande,
id_review INTEGER REFERENCES review,
PRIMARY KEY (id_commande_ligne, id_review));

CREATE TABLE appartient (id_commande_ligne INTEGER REFERENCES ligne_commande,
id_commande INTEGER REFERENCES commande,
PRIMARY KEY (id_commande_ligne, id_commande));

CREATE TABLE achat (id_commande_ligne INTEGER REFERENCES ligne_commande,
id_produit INTEGER REFERENCES produit,
PRIMARY KEY (id_commande_ligne, id_produit));

CREATE TABLE status (id_status INTEGER PRIMARY KEY,
nom_status VARCHAR(20));

CREATE TABLE est_annulee (id_commande_ligne INTEGER REFERENCES ligne_commande,
id_status INTEGER REFERENCES status,
PRIMARY KEY (id_commande_ligne, id_status));

CREATE TABLE est_livree (id_commande_ligne INTEGER REFERENCES ligne_commande,
id_status INTEGER REFERENCES status,
date_expedition DATE,
date_livraison DATE,
PRIMARY KEY (id_commande_ligne, id_status));

CREATE TABLE en_livraison (id_commande_ligne INTEGER REFERENCES ligne_commande,
id_status INTEGER REFERENCES status,
date_expedition DATE,
PRIMARY KEY (id_commande_ligne, id_status));

CREATE TABLE en_preparation (id_commande_ligne INTEGER REFERENCES ligne_commande,
id_status INTEGER REFERENCES status,
date_expedition_prevue DATE,
PRIMARY KEY (id_commande_ligne, id_status));

CREATE TABLE en_attente (id_commande_ligne INTEGER REFERENCES ligne_commande,
id_status INTEGER REFERENCES status,
date_reapprovisionnement DATE,
date_expedition_prevue DATE,
PRIMARY KEY (id_commande_ligne, id_status));

CREATE TABLE demande_retour (id_demande_retour INTEGER PRIMARY KEY,
date_demande DATE);

CREATE TABLE commande_retour (id_commande_ligne INTEGER REFERENCES ligne_commande,
id_demande_retour INTEGER REFERENCES demande_retour,
PRIMARY KEY (id_commande_ligne, id_demande_retour));

CREATE TABLE retour_effectif (id_retour_effectif INTEGER PRIMARY KEY,
remboursement_retour_effectif BOOL,
raison_retour_effectif TEXT);

CREATE TABLE retour_valide (id_demande_retour INTEGER REFERENCES demande_retour,
id_retour_effectif INTEGER REFERENCES retour_effectif,
PRIMARY KEY (id_demande_retour, id_retour_effectif));

SET datestyle = dmy;
\copy clients FROM './CSV/clients.csv' WITH (FORMAT csv, HEADER true);
\copy adresse FROM './CSV/adresses.csv' WITH (FORMAT csv, HEADER true);
\copy adresse_clients FROM './CSV/adresse_clients.csv' WITH (FORMAT csv, HEADER true);
\copy produit FROM './CSV/produits.csv' WITH (FORMAT csv, HEADER true);
