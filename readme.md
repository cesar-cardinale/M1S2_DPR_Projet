# Projet DPR S1 M1 Informatique 2021

**Projet réalisé par Benjamin BEN ESTI et César CARDINALE (DRP1).**

* Le fichier XSLTransform.xsl permet de transformer un fichier XML (donnees-recettes.xml) en un fichier XML (Recettes.xml) selon un fichier DTD (Recettes.dtd).

* Le fichier XSL XHTMLTransform.xml permet de transformer un fichier XML (Recettes.xml) respectant un fichier DTD (Recettes.dtd) en pages HTML :
```
Auteurs.html : Fichier permettant le recensement de tous les auteurs avec leurs recettes.
Categories.html :  Fichier permettant le recensement de toutes les catégories.
Ingredients.html :  Fichier permettant le recensement de tous les ingrédients.
Produits.html :  Fichier permettant le recensement de tous les produits.
Recettes.html :  Fichier permettant le recensement de toutes les recettes triées par ordre décroissant de publication.
Recettes-cat.html :  Fichier permettant le recensement de toutes les recettes triées par catégories et sous-catégories.
```

* Le fichier XQUERYTransform.xquery permet de produire un fichier XML (XQUERY.xml) qui liste les auteurs  avec, pour chacun, les recettes qu’il a proposées et les sous-catégories dans lesquelles les recettes apparaissent, triés par ordre alphabétique et ordre de date de publication.

- * Nous avons donc utiliser une méthode XPATH 2.0 afin de pouvoir séléctionner uniquement la sous-catégories qui correspond à la recette, ici le `eq` permet de vérifier l'égalité.
```
/Recettes/Sous-categories/Sous-categorie[@id eq $recette/@sous-categorie]
```