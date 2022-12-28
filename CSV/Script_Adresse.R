fichier <- "/home/nsalaun/Cours/Projet_BDD/CSV/Données_brutes/Adresses.csv"

index <- sample(nrow(read.csv(fichier, header = T)), 100)
df <- read.csv(fichier, header = T, sep = ";")[index,]

id_adresse <- c(1:100)
numero_adresse <- df$numero
rue_adresse <- df$nom_voie
ville_adresse <- df$nom_commune
code_postal_adresse <- df$code_postal

mat_adresse <- cbind(id_adresse, numero_adresse, rue_adresse,
                     ville_adresse, code_postal_adresse)

write.csv(mat_adresse, file = "/home/nsalaun/Cours/Projet_BDD/CSV/adresses.csv",
          row.names = F, quote = F)

mat_adresse_client <- cbind(c(1:100), c(1:100))
colnames(mat_adresse_client) <- c("id_clients", "id_adresse")

write.csv(mat_adresse_client, file = "/home/nsalaun/Cours/Projet_BDD/CSV/adresse_clients.csv",
          row.names = F, quote = F)
