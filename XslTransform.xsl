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
                    <Titre>
                        <xls:value-of select="info[@nom = 'nom']/@value"/>
                    </Titre>
                    <Resume>
                        <xls:value-of select="info[@nom = 'résumé']/p/t/text()"/>
                    </Resume>
                    <Photo>
                        <xls:value-of select="info[@nom = 'photo']/@value"/>
                    </Photo>
                    <DatePublication>
                        <xls:value-of select="info[@nom = 'date_publication']/@value"/>
                    </DatePublication>
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
                        <xsl:value-of select="info[@nom = 'Préparation']/@value"/>
                    </TempsPreparation>
                    <TempsCuisson>
                        <xsl:value-of select="info[@nom = 'Cuisson']/@value"/>
                    </TempsCuisson>
                    <TempsRepos>
                        <xsl:value-of select="info[@nom = 'Repos']/@value"/>
                    </TempsRepos>
                    <Description>
                        <xsl:value-of select="info[@nom = 'Préparation']/p/text()"/>
                    </Description>
                    <Note>
                        <xsl:value-of select="info[@nom = 'note']/@value"/>
                    </Note>
                    <ListeAuteurs>
                        <xsl:for-each select="info[@nom = 'auteur']">
                            <xsl:variable name="nomAuteur" select="@value"/>
                            <Auteur>
                                <xsl:attribute name="nom">
                                    <xsl:value-of select="//objet[@id = $nomAuteur]/info[@nom = 'nom']/@value"/>
                                </xsl:attribute>
                            </Auteur>
                        </xsl:for-each>
                    </ListeAuteurs>
                </recette>
            </xsl:for-each>
        </recettes>
    </xsl:template>


</xsl:stylesheet>
