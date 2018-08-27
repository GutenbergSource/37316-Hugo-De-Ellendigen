<!DOCTYPE xsl:stylesheet [

    <!ENTITY ndash "&#x2013;">
    <!ENTITY mdash "&#x2014;">
    <!ENTITY euml "&#x00EB;">

]>
<xsl:transform
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="urn:stylesheet-functions"
    exclude-result-prefixes="f xs"
    version="2.0">

<xsl:variable name="volume1" select="f:document('../Deel 1/Processed/Ellendigen1.xml', 'p1')"/>
<xsl:variable name="volume2" select="f:document('../Deel 2/Processed/Ellendigen2.xml', 'p2')"/>
<xsl:variable name="volume3" select="f:document('../Deel 3/Processed/Ellendigen3.xml', 'p3')"/>
<xsl:variable name="volume4" select="f:document('../Deel 4/Processed/Ellendigen4.xml', 'p4')"/>
<xsl:variable name="volume5" select="f:document('../Deel 5/Processed/Ellendigen5.xml', 'p5')"/>


<!-- Import a document, while changing internal IDs and references to them -->
<xsl:function name="f:document">
    <xsl:param name="location" as="xs:string"/>
    <xsl:param name="prefix" as="xs:string"/>

    <xsl:apply-templates select="document($location)" mode="fix-ids">
        <xsl:with-param name="prefix" select="$prefix"/>
    </xsl:apply-templates>
</xsl:function>


<xsl:function name="f:newid">
    <xsl:param name="prefix" as="xs:string"/>
    <xsl:param name="oldid" as="xs:string"/>

    <xsl:choose>
        <xsl:when test="$prefix = 'p1' and ($oldid = 'cover' or $oldid = 'cover-image')">
            <xsl:value-of select="$oldid"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="concat($prefix, $oldid)"/>
        </xsl:otherwise>
     </xsl:choose>
</xsl:function>


<xsl:template match="@id" mode="fix-ids">
    <xsl:param name="prefix" as="xs:string"/>

    <xsl:attribute name="id">
        <xsl:value-of select="f:newid($prefix, .)"/>
    </xsl:attribute>
</xsl:template>


<xsl:template match="@target" mode="fix-ids">
    <xsl:param name="prefix" as="xs:string"/>

    <xsl:attribute name="target">
        <xsl:value-of select="f:newid($prefix, .)"/>
    </xsl:attribute>
</xsl:template>


<xsl:template match="node()|@*" mode="fix-ids">
    <xsl:param name="prefix" as="xs:string"/>

    <xsl:copy>
        <xsl:apply-templates select="node()|@*" mode="fix-ids">
            <xsl:with-param name="prefix" select="$prefix"/>
        </xsl:apply-templates>
    </xsl:copy>
</xsl:template>


<xsl:template match="/">
    <TEI.2 lang="nl-1900">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title>De Ellendigen</title>
                <author key="Hugo, Victor" ref="https://viaf.org/viaf/9847974/">Victor Hugo (1802&ndash;1885)</author>
                <respStmt><resp>Transcription</resp> <name key="Hellingman, Jeroen">Jeroen Hellingman</name></respStmt>
            </titleStmt>
            <publicationStmt>
                <publisher>Project Gutenberg</publisher>
                <pubPlace>Urbana, Illinois, USA.</pubPlace>
                <idno type="epub-id">urn:uuid:2c5e215a-5c59-4558-b48a-a7f4d183f8fb</idno>
                <idno type="PGSrc">37316-Hugo-De-Ellendigen</idno>
                <idno type="PGnum">#####</idno>
                <date>#####</date>

                <xsl:apply-templates select="$volume1//teiHeader/publicationStmt/availability"/>

            </publicationStmt>
            <sourceDesc>
                <bibl>
                <author>Victor Hugo (1802&ndash;1885)</author>
                <title>De Ellendigen</title>
                <date>1892</date>
                </bibl>
            </sourceDesc>
        </fileDesc>

        <xsl:apply-templates select="$volume1//teiHeader/encodingDesc"/>
        <xsl:apply-templates select="$volume1//teiHeader/profileDesc"/>

        <revisionDesc>
            <list type="simple">
                <item>2011-11-27 started.</item>
            </list>
        </revisionDesc>
    </teiHeader>
    <text rend="stylesheet(style/classic.css)">
        <front id="frontmatter">
            <xsl:apply-templates select="$volume1//front"/>
        </front>
        <body>
            <xsl:apply-templates select="$volume1//body/div0"/>
            <xsl:apply-templates select="$volume2//body/div0"/>
            <xsl:apply-templates select="$volume3//body/div0"/>
            <xsl:apply-templates select="$volume4//body/div0"/>
            <xsl:apply-templates select="$volume5//body/div0"/>
        </body>
        <back id="backmatter">
            <divGen id="toc" type="toc"/>
            <divGen type="Colophon"/>
        </back>
    </text>
    </TEI.2>
</xsl:template>


<!-- Drop the volume number from the title page -->
<xsl:template match="docTitle[@id='p1volumetitle']"/>


<xsl:template match="node()|@*">
    <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
</xsl:template>

</xsl:transform>
