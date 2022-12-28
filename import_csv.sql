  SET datestyle = dmy;
  \copy clients FROM '/home/nsalaun/Cours/Projet_BDD/CSV/clients.csv' WITH (FORMAT csv, HEADER true);
  \copy adresse FROM '/home/nsalaun/Cours/Projet_BDD/CSV/adresses.csv' WITH (FORMAT csv, HEADER true);
