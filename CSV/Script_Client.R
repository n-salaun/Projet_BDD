fichier_nom <- "/home/nsalaun/Cours/Projet_BDD/CSV/Données_brutes/noms2008nat.txt"
fichier_prenom <- "/home/nsalaun/Cours/Projet_BDD/CSV/Données_brutes/prenom.csv"
fichier_phone <- "/home/nsalaun/Cours/Projet_BDD/CSV/Données_brutes/phone_number.csv"

#LOAD les fichiers
data_nom <- read.csv(fichier_nom, header = T, sep = "", check.names = F)
data_prenom <- read.csv(fichier_prenom, header = T)
data_phone <- read.csv(fichier_phone, header = T)

#Cree le vecteur nom
for (i in 2:12){
  data_index <- which(data_nom[,i] > 400)
  data_nom <- data_nom[data_index,]
}
data_nom <- sample(data_nom[,1], size = 100)

#cree le vecteur prenom
data_index <- sample(which(data_prenom[,"sum"] > 30000), size = 100)
data_prenom <- data_prenom[data_index,1]

#cree les adresse mail
domaine <- c("gmail.com", "outlook.fr", "orange.fr", "yahoo.com")
colonne_email <- c()
for (i in 1:100){
  email <- tolower(paste0(data_nom[i], ".", data_prenom[i]))
  suffixe <- sample(domaine, 1)
  email <- paste0(email, "@",suffixe)
  colonne_email <- c(colonne_email, email)
}

#génere anniversaire et date inscription
mois <- c(1:12)
jour <- c(1:28)
annee_naissance <- c(1940:2004)
annee_inscription <- c(2015:2022)
anniversaire <- c()
date_inscription <- c()
for (i in 1:100){
  jour_sample <- toString(sample(jour, 1))
  mois_sample <- toString(sample(mois, 1))
  annee_naissance_sample <- toString(sample(annee_naissance, 1))
  date_anniversaire <- paste0(annee_naissance_sample, "-", paste0(mois_sample, "-", jour_sample))
  anniversaire <- c(anniversaire, date_anniversaire)
  
  jour_sample <- toString(sample(jour, 1))
  mois_sample <- toString(sample(mois, 1))
  annee_inscription_sample <- toString(sample(annee_inscription, 1))
  date_inscription_sample <- paste0(annee_inscription_sample, "-",
                                      paste0(mois_sample, "-",
                                             jour_sample))
  date_inscription <- c(date_inscription, date_inscription_sample)
}

id_client <- c(1:100)

mat_client <- cbind(id_client, data_nom, data_prenom, colonne_email, data_phone,
                    anniversaire, date_inscription)
colnames(mat_client) <- c("id_clients", "nom_clients", "prenom_clients",
                          "email_clients", "telephone_clients",
                          "date_anniversaire_clients", "date_inscription_clients")

write.csv(mat_client, file = "/home/nsalaun/Cours/Projet_BDD/CSV/clients.csv",
          row.names = F, quote = F)















