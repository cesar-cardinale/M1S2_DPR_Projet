<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>

    <xsl:template name="liste-des-recettes" match="/Recettes">
        <xsl:for-each select="Recette">
            <xsl:call-template name="recette" />
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="recette" match="/Recette">
        <div class="recipe">
            <h2><xsl:value-of select="Titre"/></h2>
            <div class="rate"><xsl:value-of select="Note"/></div>
            <div class="date"><xsl:value-of select="DatePublication"/></div>
            <div class="resume"><xsl:value-of select="Resume"/></div>
            <div class="img">
                <xsl:element name="img">
                    <xsl:attribute name="src">
                        <xsl:value-of select="Photo"/>
                    </xsl:attribute>
                </xsl:element>
            </div>
            <ul class="ingredients">
                <xsl:for-each select="ListeIngredients/Ingredient">
                    <li class="ingredient"><xsl:value-of select="@quantite"/> <xsl:value-of select="@nom"/></li>
                </xsl:for-each>
            </ul>
            <div class="time">
                <xsl:if test="TempsPreparation &gt; 0"><div>Temps de préparation : <xsl:value-of select="TempsPreparation" /></div></xsl:if>
                <xsl:if test="TempsCuisson &gt; 0"><div>Temps de cuisson : <xsl:value-of select="TempsCuisson" /></div></xsl:if>
                <xsl:if test="TempsRepos &gt; 0"><div>Temps de repos : <xsl:value-of select="TempsRepos" /></div></xsl:if>
            </div>
            <div><xsl:value-of select="Description" /></div>
        </div>
    </xsl:template>
</xsl:stylesheet>