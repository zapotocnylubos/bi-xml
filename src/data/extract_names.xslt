<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- universally convert anything, that has name and no children -->
  <xsl:template match="*[@name and not(*) and not(text())]">
    <xsl:element name="{name()}">

      <!-- copy all remaining attributes -->
      <xsl:for-each select="@* except @name">
        <xsl:attribute name="{name()}" select="."/>
      </xsl:for-each>

      <xsl:value-of select="@name"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
