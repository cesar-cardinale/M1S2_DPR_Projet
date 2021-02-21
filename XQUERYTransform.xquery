xquery version "1.0" encoding "utf-8";

element Auteurs {
    let $recettes_doc := doc('Recettes.xml')//Recettes
    let $auteurs := $recettes_doc/Auteurs
    for $auteur in $auteurs/Auteur
    order by $auteur/Nom ascending
    let $recettes_call := $auteur/ListeRecettes
    return 
        <Auteur id="{$auteur/@id}"> 
            {$auteur/(* except ListeRecettes)}
            <ListeRecettes>
                {
                    for $recette_call in $recettes_call/Recette, $recette in $recettes_doc/Recette
                    where $recette/@id-recette = $recette_call/@id
                    order by $recette/DatePublication descending
                    return
                        <Recette id="{$recette/@id-recette}">
                        {
                            for $subcat in $recettes_doc/Sous-categories/Sous-categorie[@id eq $recette/@sous-categorie]
                            return 
                                for $cat in $recettes_doc/Categories/Categorie[@id-categorie eq $subcat/@cat]
                                return
                                    <Categorie id="{$cat/@id-categorie}" nom="{$cat/@nom}">
                                        <Sous-categorie id="{$subcat/@id}" nom="{$subcat/@nom}" />
                                    </Categorie>
                         }
                         {$recette/*}
                         </Recette>
                }
            </ListeRecettes>
        </Auteur>
}