<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- convert longitude and latitude data  -->
  <xsl:template match="*[@degrees and @minutes and @hemisphere]">
    <xsl:variable name="degree">&#176;</xsl:variable>
    <xsl:variable name="minute">&#34;</xsl:variable>

    <xsl:variable name="coordinates" select="concat(@degrees, $degree, @minutes, $minute, @hemisphere)"/>

    <xsl:element name="{name()}">
      <xsl:value-of select="$coordinates"/>
    </xsl:element>
  </xsl:template>

  <!-- universally convert units|value -->
  <xsl:template name="value_units">
    <xsl:param name="value"/>
    <xsl:param name="units"/>

    <xsl:value-of select="concat($value, ' ', translate($units, '_', ' '))"/>
  </xsl:template>

  <!-- copy element and all his attributes but @units -->
  <xsl:template name="copy_non_units_attributes">
    <xsl:param name="value"/>

    <xsl:element name="{name()}">
      <xsl:for-each select="@* except @units">
        <xsl:attribute name="{name()}" select="."/>
      </xsl:for-each>

      <xsl:value-of select="$value"/>
    </xsl:element>
  </xsl:template>

  <!-- copy element and all his attributes but @units -->
  <!-- TODO: parametrized except? -->
  <xsl:template name="copy_non_population_attributes">
    <xsl:param name="value"/>

    <xsl:element name="{name()}">
      <xsl:for-each select="@* except @population">
        <xsl:attribute name="{name()}" select="."/>
      </xsl:for-each>

      <xsl:value-of select="$value"/>
    </xsl:element>
  </xsl:template>

  <!-- exchange_rates correct units -->
  <xsl:template match="exchange_rates/annual_values[@units]">
    <xsl:call-template name="copy_non_units_attributes">
      <xsl:with-param name="value">
        <xsl:call-template name="value_units">
          <xsl:with-param name="value" select="."/>
          <xsl:with-param name="units" select="concat('per ', @units)"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- major_urban_areas population correct units -->
  <xsl:template match="major_urban_areas/area[@population]">
    <xsl:call-template name="copy_non_population_attributes">
      <xsl:with-param name="value">
        <xsl:call-template name="value_units">
          <xsl:with-param name="value" select="@population"/>
          <xsl:with-param name="units" select="'people'"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- universally convert anything, that has units attribute -->
  <xsl:template match="
    *[@units]
    except exchange_rates/annual_values
  ">
    <xsl:call-template name="copy_non_units_attributes">
      <xsl:with-param name="value">
        <xsl:call-template name="value_units">
          <xsl:with-param name="value" select="."/>
          <xsl:with-param name="units" select="@units"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
