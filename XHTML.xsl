<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>
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
    <h2><xsl:value-of select="Titre"/></h2>
    <p><xsl:value-of select="DatePublication"/></p>
    <p><xsl:value-of select="Resume"/></p>
    <xsl:element name="img">
        <xsl:attribute name="src">
            <xsl:value-of select="Photo"/>
        </xsl:attribute>
    </xsl:element>
    <xsl:call-template name="ingredients" />
</xsl:template>

    <xsl:template name="ingredients" match="/Ingredients">
        <ul>
            <xsl:for-each select="Ingredient">
                <li><xsl:value-of select="@nom"/> - <xsl:value-of select="@quantite"/></li>
            </xsl:for-each>
        </ul>
    </xsl:template>
</xsl:stylesheet>