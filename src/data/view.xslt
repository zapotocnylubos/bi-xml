<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template name="to-title">
    <xsl:param name="text"/>

    <xsl:variable name="title" select="
    concat(
      upper-case(substring($text, 1, 1)),
      translate(
        substring($text, 2),
        '_', ' '
      )
    )"/>

    <xsl:attribute name="title" select="$title"/>
  </xsl:template>

  <xsl:template name="section-with-title">
    <xsl:element name="section">
      <xsl:call-template name="to-title">
        <xsl:with-param name="text" select="name()"/>
      </xsl:call-template>

      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="glossary">
    <xsl:element name="glossary">

      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="term">
    <xsl:element name="term">

      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="/country">
    <section id="{@id}" title="{name}">
      <xsl:apply-templates select="* except name"/>
    </section>
  </xsl:template>

  <xsl:template match="
      introduction|
      introduction/background|

      geography|
      geography/location|

      people|
      international_organization_participation|

      economy|
      economy/overview|

      energy|
      energy/electricity|
      energy/crude_oil|
      energy/refined_petroleum_products|
      energy/refined_petroleum_products|

      communications|
      transportation|
      military_and_security|
      transnational_issues
      [parent::country]">
    <xsl:call-template name="section-with-title"/>
  </xsl:template>


  <xsl:template match="*">
    <xsl:element name="{name()}">
      <xsl:apply-templates/>

      <xsl:if test="@units">
        <xsl:text> </xsl:text>
        <xsl:value-of select="@units"/>
      </xsl:if>
      <xsl:if test="@global_rank">
        <xsl:text> (Global rank: </xsl:text>
        <xsl:value-of select="@global_rank"/>
        <xsl:text>)</xsl:text>
      </xsl:if>
      <xsl:if test="@date">
        <xsl:text> [</xsl:text>
        <xsl:value-of select="@date"/>
        <xsl:text>]</xsl:text>
      </xsl:if>
    </xsl:element>
  </xsl:template>

<!--  <xsl:template match="-->
<!--  geographic_coordinates|-->
<!--  area|-->
<!--  land_boundaries-->
<!--">-->
<!--    <glossary>-->

<!--    </glossary>-->
<!--  </xsl:template>-->

<!--  <xsl:template match="*[@units]">-->
<!--    <xsl:call-template name="element-to-title"/>-->
<!--  </xsl:template>-->

</xsl:stylesheet>
