<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xls="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    <xsl:template match="/">
        <Recettes>
            <xsl:for-each select="//objet[@type = 'recette']">
                <Recette>
                    <xsl:attribute name="id-recette">
                        <xls:value-of select="@id"/>
                    </xsl:attribute>
                    <xsl:attribute name="difficulte">
                        <xls:value-of select="translate(info[@nom = 'difficulté']/@value,' ','-')"/>
                    </xsl:attribute>
                    <xsl:attribute name="sous-categorie">
                        <xls:value-of select="info[@nom = 'sous-catégorie']/@value"/>
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
                            <Ingredient>
                                <xsl:variable name="idIngr" select="@value"/>
                                <xsl:attribute name="id">
                                    <xls:value-of select="$idIngr"/>
                                </xsl:attribute>
                                <xsl:attribute name="quantite">
                                    <xls:value-of select="@quantite"/>
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
                        <xsl:value-of select="info[@nom = 'Préparation']/child::*"/>
                    </Description>
                    <Note>
                        <xsl:value-of select="info[@nom = 'note']/@value"/>
                    </Note>
                    <ListeAuteurs>
                        <xsl:for-each select="info[@nom = 'auteur']">
                            <Auteur>
                                <xsl:attribute name="idref">
                                    <xsl:value-of select="@value" />
                                </xsl:attribute>
                            </Auteur>
                        </xsl:for-each>
                    </ListeAuteurs>
                </Recette>
            </xsl:for-each>
            <Categories>
                <xls:for-each select="//objet[@type = 'catégorie']">
                    <Categorie>
                        <xsl:attribute name="id-categorie">
                            <xls:value-of select="@id"/>
                        </xsl:attribute>
                        <xsl:attribute name="nom">
                            <xls:value-of select="info[@nom = 'nom']/@value"/>
                        </xsl:attribute>
                        <Descriptif>
                            <xsl:value-of select="info[@nom = 'descriptif']/child::*"/>
                        </Descriptif>
                    </Categorie>
                </xls:for-each>
            </Categories>
            <Sous-categories>
                <xls:for-each select="//objet[@type = 'sous-catégorie']">
                    <Sous-categorie>
                        <xls:attribute name="id">
                            <xls:value-of select="@id"/>
                        </xls:attribute>
                        <xls:attribute name="cat">
                            <xls:value-of select="info[@nom = 'catégorie']/@value"/>
                        </xls:attribute>
                        <xsl:attribute name="nom">
                            <xls:value-of select="info[@nom = 'nom']/@value"/>
                        </xsl:attribute>
                        <Descriptif>
                            <xsl:value-of select="info[@nom = 'descriptif']/child::*"/>
                        </Descriptif>
                    </Sous-categorie>
                </xls:for-each>
            </Sous-categories>
            <Auteurs>
                <xsl:for-each select="//objet[@type = 'auteur']">
                    <Auteur>
                        <xsl:attribute name="id">
                            <xls:value-of select="@id"/>
                        </xsl:attribute>
                        <Nom><xsl:if test="info[@nom = 'nom']"><xsl:value-of select="info[@nom = 'nom']/@value" /></xsl:if>  <xsl:if test="info[@nom = 'prenom']"><xsl:value-of select="info[@nom = 'prenom']/@value" /></xsl:if></Nom>
                        <Age><xsl:value-of select="info[@nom = 'age']" /></Age>
                        <Pays><xsl:value-of select="info[@nom = 'pays']" /></Pays>
                        <xsl:if test="info[@nom = 'biographie']"><Biographie><xsl:value-of select="info[@nom = 'biographie']/@value" /></Biographie></xsl:if>
                        <xsl:if test="info[@nom = 'recette']">
                            <ListeRecettes>
                                <xsl:for-each select="info[@nom = 'recette']">
                                    <Recette>
                                        <xsl:attribute name="id">
                                            <xls:value-of select="@value"/>
                                        </xsl:attribute>
                                    </Recette>
                                </xsl:for-each>
                            </ListeRecettes>
                        </xsl:if>
                    </Auteur>
                </xsl:for-each>
            </Auteurs>
            <Ingredients>
                <xsl:for-each select="//objet[@type = 'ingrédient']">
                    <Ingredient>
                        <xsl:attribute name="id-ingredient">
                            <xls:value-of select="@id"/>
                        </xsl:attribute>
                        <xsl:attribute name="id-produit">
                            <xls:value-of select="info[@nom = 'produit']/@value"/>
                        </xsl:attribute>
                        <Nom>
                            <xls:value-of select="info[@nom = 'nom']/@value"/>
                        </Nom>
                        <ApportNutritif>
                            <xls:value-of select="info[@nom = 'Apport nutritif']/@value"/>
                        </ApportNutritif>
                        <ApportÉnergétique>
                            <xls:value-of select="info[@nom = 'Apport énergétique']/@value"/>
                        </ApportÉnergétique>
                        <Descriptif>
                            <xls:value-of select="info[@nom = 'descriptif']/@value"/>
                        </Descriptif>
                        <xsl:if test="info[@nom = 'saison']">
                            <Saison>
                                <xls:value-of select="info[@nom = 'saison']/@value"/>
                            </Saison>
                        </xsl:if>
                    </Ingredient>
                </xsl:for-each>
            </Ingredients>
            <Produits>
                <xls:for-each select="//objet[@type ='produit']">
                    <Produit>
                    <xls:attribute name="id-produit">
                        <xls:value-of select="@id"/>
                    </xls:attribute>
                    <xls:attribute name="nom">
                        <xls:value-of select="info[@nom='nom']/@value"/>
                    </xls:attribute>
                    <xls:for-each select="info[@type='ingrédient']">
                        <Ingredient>
                            <xls:attribute name="id">
                                <xls:value-of select="@value"/>
                            </xls:attribute>
                        </Ingredient>
                    </xls:for-each>
                    </Produit>
                </xls:for-each>
            </Produits>
        </Recettes>
    </xsl:template>

</xsl:stylesheet>
