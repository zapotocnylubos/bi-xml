<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <fo:root language="en" font-family="Times New Roman, serif">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="bi-xml" margin="1in">
          <fo:region-body/>
          <fo:region-after extent="6mm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="bi-xml">
        <fo:static-content flow-name="xsl-region-after">
          <fo:block>
            <xsl:text>Page </xsl:text>
            <fo:page-number/>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates/>
          <!--          <xsl:apply-templates select="clanek/zahlavi/autor"/>-->
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="countries">
    <fo:block>
      <fo:block font-size="24pt" font-weight="bold">
        <xsl:text>Countries:</xsl:text>
      </fo:block>

      <xsl:for-each select="country">
        <fo:block>
          <fo:basic-link internal-destination="{@id}">
            <xsl:value-of select="name"/>
          </fo:basic-link>
        </fo:block>
      </xsl:for-each>
    </fo:block>

    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="countries/country">
    <fo:block break-before="page">
      <fo:block id="{@id}">
        <xsl:value-of select="name"/>
      </fo:block>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
