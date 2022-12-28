nom_produit <- c("Guerrier", "Tireur", "Psyker", "Commandant", "Général")
factions <- c("Orcs", "Adeptus Mechanicus", "Adepta Sororitas", "Space Marines",
             "T'au", "Necrons")
niveau_detail <- c("Pret au combat", "Détaillé", "Parade")

type_list <- c()
faction_list <- c()
detail_list <- c()
price_list <- c()
etat_list <- c()
delais_list <- c()
stock_list <- c()

for (faction in factions){
  for (type in nom_produit){
    for (detail in niveau_detail){
      prix_sample = 0
      stock = 0
      if (type %in% c("Guerrier", "Tireur", "Psyker")){
        prix_sample = 10
      }
      if (type == "Commandant"){
        prix_sample = 20
      }
      if (type == "Général"){
        prix_sample = 35
      }
      if (detail == "Détaillé"){
        prix_sample = prix_sample * 1.5
        etat_sample <- "En stock"
        delais_sample <- 5
        stock_sample <- sample(1:50, 1)
      }
      if (detail == "Parade"){
        prix_sample = prix_sample * 2
        etat_sample <- "Sur Commande"
        delais_sample <- 15
        stock_sample = 0
      }
      if (detail == "Pret au combat"){
        etat_sample <- "En stock"
        delais_sample <- 5
        stock_sample <- sample(1:50, 1)
      }
      type_list <- c(type_list, type)
      faction_list <- c(faction_list, faction)
      detail_list <- c(detail_list, detail)
      price_list <- c(price_list, prix_sample)
      etat_list <- c(etat_list, etat_sample)
      delais_list <- c(delais_list, delais_sample)
      stock_list <- c(stock_list, stock_sample)
      
    }
  }
}
id_list <- c(1:90)

mat_produit <- cbind(id_list, type_list, faction_list, detail_list, price_list, 
                     etat_list, delais_list, stock_list)
colnames(mat_produit) <- c("id_produit", "nom_produit", "faction_produit",
                           "niveau_detail_produit", "price_produit", "etat_produit",
                           "delais_produit", "quantite_stock_produit")

write.csv(mat_produit, file = "/home/nsalaun/Cours/Projet_BDD/CSV/produits.csv",
          row.names = F, quote = F)
