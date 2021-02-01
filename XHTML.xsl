<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <link href="style.css" rel="stylesheet" type="text/css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
            </head>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>

    <xsl:template name="liste-des-recettes" match="/Recettes">
        <div class="container">
            <h1>Toutes nos recettes</h1>
            <xsl:for-each select="Recette">
                <xsl:call-template name="recette" />
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template name="recette" match="/Recette">
        <div class="row justify-content-center receipt">
            <div class="col-6">
                <div class="img">
                    <xsl:attribute name="style">
                        background-image: url('<xsl:value-of select="Photo"/>')
                    </xsl:attribute>
                    <h2><xsl:value-of select="Titre"/></h2>
                </div>
                <div class="row data">
                    <div class="col-6">Pour <xsl:value-of select="NbPersonnes"/> personne<xsl:if test="NbPersonnes &gt; 1">s</xsl:if></div>
                    <xsl:if test="Note &gt; 0"><div class="col-6"><xsl:value-of select="Note"/> ★</div></xsl:if>
                </div>
                <xsl:if test="string-length(Resume)>0"><div class="resume"><xsl:value-of select="Resume"/></div></xsl:if>
                <div class="ingredients">
                    <span>Ingrédients :</span>
                    <ul>
                        <xsl:for-each select="ListeIngredients/Ingredient">
                            <li class="ingredient"><xsl:value-of select="@quantite"/> <xsl:value-of select="@nom"/></li>
                        </xsl:for-each>
                    </ul>
                </div>
                <div class="time">
                    <xsl:if test="TempsPreparation &gt; 0"><div>Temps de préparation : <xsl:value-of select="TempsPreparation" /></div></xsl:if>
                    <xsl:if test="TempsCuisson &gt; 0"><div>Temps de cuisson : <xsl:value-of select="TempsCuisson" /></div></xsl:if>
                    <xsl:if test="TempsRepos &gt; 0"><div>Temps de repos : <xsl:value-of select="TempsRepos" /></div></xsl:if>
                </div>
                <div class="steps"><xsl:value-of select="Description" /></div>
                <div class="date">
                    Publié le <xsl:value-of select="DatePublication"/>
                    <xsl:if test="string-length(ListeAuteurs/Auteur/@nom)>0">
                        par
                        <xsl:for-each select="ListeAuteurs/Auteur">
                            <a>
                                <xsl:attribute name="href">/auteur/<xsl:value-of select="@id"/></xsl:attribute>
                                <xsl:value-of select="@nom" />
                            </a>
                        </xsl:for-each>
                    </xsl:if>
                </div>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>