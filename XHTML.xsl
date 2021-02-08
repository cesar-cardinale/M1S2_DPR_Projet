<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <link href="style.css" rel="stylesheet" type="text/css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous" />
                <script src="https://cdn.jsdelivr.net/npm/masonry-layout@4.2.2/dist/masonry.pkgd.min.js" integrity="sha384-GNFwBvfVxBkLMJpYMOABq3c+d3KnQxudP/mGPkzpZSTYykLBNsZEnG2D9G/X/+7D" crossorigin="anonymous" />
                <meta name="viewport" content="width=device-width, initial-scale=1" />
            </head>
            <body>
                <div class="container">
                    <xsl:call-template name="menu" />
                    <xsl:apply-templates />
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="liste-recettes" match="/Recettes">
        <div class="row receipt" id="recettes">
            <h1 class="text-center">Toutes nos recettes</h1>
            <xsl:for-each select="Recette">
                <div class="row justify-content-center">
                    <xsl:call-template name="recette" />
                </div>
            </xsl:for-each>
        </div>
        <xsl:call-template name="categories" />
        <xsl:call-template name="ingredients" />
        <xsl:call-template name="auteurs" />
    </xsl:template>

    <xsl:template name="recette" match="/Recette">
        <div class="col-10 mb-3">
            <xsl:attribute name="id">rece_<xsl:value-of select="@id-recette"/></xsl:attribute>
            <div class="img">
                <xsl:attribute name="style">background-image: url('<xsl:value-of select="Photo"/>')</xsl:attribute>
                <h2><xsl:value-of select="Titre"/></h2>
            </div>
            <div class="row data">
                <div class="col-6">Pour <xsl:value-of select="NbPersonnes"/> personne<xsl:if test="NbPersonnes &gt; 1">s</xsl:if></div>
                <xsl:if test="number(Note) > 0"><div class="col-6"><xsl:value-of select="Note"/> ★</div></xsl:if>
            </div>
            <xsl:if test="string-length(Resume)>0"><div class="resume"><xsl:value-of select="Resume"/></div></xsl:if>
            <div class="ingredients">
                <span>Ingrédients :</span>
                <ul>
                    <xsl:for-each select="ListeIngredients/Ingredient">
                        <xsl:variable name="id-ingredient" select="@id"/>
                        <li class="ingredient"><xsl:value-of select="@quantite"/> <xsl:value-of select="concat(' ',/Recettes/Ingredients/Ingredient[@id-ingredient = $id-ingredient]/Nom)"/></li>
                    </xsl:for-each>
                </ul>
            </div>
            <div class="time">
                <xsl:if test="number(translate(TempsPreparation, 'min', '')) > 0"><div>Temps de préparation : <xsl:value-of select="TempsPreparation" /></div></xsl:if>
                <xsl:if test="number(translate(TempsCuisson, 'min', '')) > 0"><div>Temps de cuisson : <xsl:value-of select="TempsCuisson" /></div></xsl:if>
                <xsl:if test="number(translate(TempsRepos, 'min', '')) > 0"><div>Temps de repos : <xsl:value-of select="TempsRepos" /></div></xsl:if>
            </div>
            <div class="steps">
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="Description"/>
                </xsl:call-template>
                <xsl:value-of select="Description" />
            </div>
            <div class="date">
                Publié le <xsl:value-of select="DatePublication"/>
                <xsl:if test="ListeAuteurs/Auteur">
                    par
                    <xsl:for-each select="ListeAuteurs/Auteur">
                        <xsl:variable name="id-auteur" select="@idref"/>
                        <a>
                            <xsl:attribute name="href">#aute_<xsl:value-of select="$id-auteur"/></xsl:attribute>
                            <xsl:value-of select="/Recettes/Auteurs/Auteur[@id = $id-auteur]/Nom"></xsl:value-of>
                        </a>
                    </xsl:for-each>
                </xsl:if>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="menu">
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <div class="collapse navbar-collapse">
                    <div class="navbar-nav me-auto mb-2 mb-lg-0">
                        <a class="navbar-brand" href="#">DPR Recettes</a>
                        <a class="nav-link" href="#recettes">Toutes les recettes</a>
                        <a class="nav-link" href="#categories">Les catégories</a>
                        <a class="nav-link" href="#products">Les produits</a>
                        <a class="nav-link" href="#ingredients">Les ingrédients</a>
                        <a class="nav-link" href="#authors">Les auteurs</a>
                    </div>
                </div>
            </div>
        </nav>
    </xsl:template>

    <xsl:template name="categories" match="/Recettes/Categories">
        <div class="row justify-content-center categories" id="categories">
            <!--
            <xsl:attribute name="data-masonry">
                {"percentPosition": true }
            </xsl:attribute>
            -->
            <h1 class="text-center">Toutes les catégories</h1>
            <xsl:for-each select="/Recettes/Categories/Categorie">
                <xsl:variable name="id-category" select="@id-categorie"/>
                <div class="col-sm-10 mb-3">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title">
                                <a>
                                    <xsl:attribute name="href">#cate_<xsl:value-of select="$id-category"/></xsl:attribute>
                                    <xsl:value-of select="@nom" />
                                </a>
                            </h4>
                            <div><xsl:value-of select="Descriptif" /></div>
                            <ul class="list-group">
                                <xsl:for-each select="/Recettes/Sous-categories/Sous-categorie">
                                    <xsl:if test="$id-category = @cat" >
                                        <li class="list-group-item">
                                            <a>
                                                <xsl:attribute name="href">#cate_<xsl:value-of select="@id"/></xsl:attribute>
                                                <h5><xsl:value-of select="@nom" /></h5>
                                            </a>
                                            <div><xsl:value-of select="Descriptif" /></div>
                                        </li>
                                    </xsl:if>
                                </xsl:for-each>
                            </ul>
                        </div>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template name="ingredients" match="/Recettes/Ingredients">
        <div class="row justify-content-center ingredients" id="ingredients">
            <h1 class="text-center">Tous les ingrédients</h1>
            <xsl:for-each select="/Recettes/Ingredients/Ingredient">
                <xsl:call-template name="ingredient" />
            </xsl:for-each>
        </div>
    </xsl:template>
    <xsl:template name="ingredient" match="/Recettes/Ingredients/Ingredient">
        <div class="col-10 mb-3">
            <xsl:attribute name="id">ingr_<xsl:value-of select="@id-ingredient"/></xsl:attribute>
            <h4><xsl:value-of select="Nom" /></h4>
            <div><xsl:value-of select="ApportNutritif" /></div>
            <div><xsl:value-of select="ApportÉnergétique" /></div>
            <xsl:if test="string-length(Saison) > 0">
                <div>Saison : <xsl:value-of select="Saison" /></div>
            </xsl:if>
        </div>
    </xsl:template>
    <xsl:template name="auteurs" match="/Recettes/Auteurs">
        <div class="row justify-content-center authors" id="authors">
            <h1 class="text-center">Tous les auteurs</h1>
            <xsl:for-each select="/Recettes/Auteurs/Auteur">
                <xsl:call-template name="auteur" />
            </xsl:for-each>
        </div>
    </xsl:template>
    <xsl:template name="auteur" match="/Recettes/Auteurs/Auteur">
        <div class="col-sm-10 mb-3">
            <div class="card">
                <xsl:attribute name="id">auth_<xsl:value-of select="@id"/></xsl:attribute>
                <div class="card-body">
                    <h4 class="card-title"><xsl:value-of select="Nom" /></h4>
                    <div><xsl:value-of select="Age" /></div>
                    <div><xsl:value-of select="Pays" /></div>
                    <div><xsl:value-of select="Biographie" /></div>
                    <ul class="list-group">
                        <xsl:for-each select="ListeRecettes/Recette">
                            <xsl:variable name="id-recette" select="@id"/>
                            <xsl:for-each select="/Recettes/Recette">
                                <xsl:if test="$id-recette = @id-recette" >
                                    <li class="list-group-item">
                                        <a>
                                            <xsl:attribute name="href">#rece_<xsl:value-of select="@id-recette"/></xsl:attribute>
                                            <h6><xsl:value-of select="Titre" /></h6>
                                        </a>
                                    </li>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>
                    </ul>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="tokenize">
        <xsl:param name="text"/>
        <xsl:param name="delimiter" select="'\r'"/>
        <xsl:choose>
            <xsl:when test="contains($text, $delimiter)">
                <xsl:value-of select="substring-before($text, $delimiter)"/>
                <br/>
                <!-- recursive call -->
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>