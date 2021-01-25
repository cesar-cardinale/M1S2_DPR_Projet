<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xls="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    <xsl:template match="/">
        <recettes>
            <xsl:for-each select="//objet[@type = 'recette']">
                <recette>
                    <xsl:attribute name="nom">
                        <xls:value-of select="@id"/>
                    </xsl:attribute>
                    <xsl:attribute name="difficulte">
                        <xls:value-of select="info[@nom = 'difficulté']/@value"/>
                    </xsl:attribute>
                    <Titre><xls:value-of select="info[@nom = 'nom']/@value"/></Titre>
                    <Resume><xls:value-of select="info[@nom = 'résumé']/p"/></Resume>
                    <Photo><xls:value-of select="info[@nom = 'photo']/@value"/></Photo>
                    <DatePublication><xls:value-of select="info[@nom = 'date_publication']/@value"/></DatePublication>
                    <ListeIngredients>
                        <xsl:for-each select="info[@nom = 'ingrédient']">
                            <xsl:variable name="idIngr" select="@value"/>
                            <Ingredient>
                                <xsl:attribute name="nom">
                                    <xls:value-of select="//objet[@id = $idIngr]/info[@nom = 'nom']/@value"/>
                                </xsl:attribute>
                            </Ingredient>
                        </xsl:for-each>
                    </ListeIngredients>
                    <NbPersonnes><xls:value-of select="info[@nom = 'nbre_personnes']/@value"/></NbPersonnes>
                    <TempsPreparation>
                        <xsl:attribute name="unite"></xsl:attribute>
                    </TempsPreparation>
                    <TempsCuisson>
                        <xsl:attribute name="unite"></xsl:attribute>
                    </TempsCuisson>
                    <TempsRepos>
                        <xsl:attribute name="unite"></xsl:attribute>
                    </TempsRepos>
                </recette>
            </xsl:for-each>
        </recettes>
    </xsl:template>


</xsl:stylesheet>
