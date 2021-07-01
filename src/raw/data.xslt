<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <!-- identity transformation for all other elements -->

  <xsl:template match="*">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>
      <xsl:call-template name="attr-note"/>

      <xsl:apply-templates select="node() except date except global_rank except note"/>
    </xsl:element>
  </xsl:template>

  <!-- root element -->

  <xsl:template match="/country">
    <country id="{@id}">
      <xsl:apply-templates/>
    </country>
  </xsl:template>

  <!-- most generic cases -->

  <xsl:template match="*[value and units]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-units"/>

      <xsl:value-of select="value"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[length and units]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-units"/>

      <xsl:value-of select="length"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[total[not(*)]]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-global-rank"/>
      <xsl:call-template name="attr-date"/>

      <xsl:value-of select="total"/>
    </xsl:element>
  </xsl:template>

  <!--  <xsl:template match="*[length and units and not(type)]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-units"/>-->

  <!--      <xsl:value-of select="length"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[type and length]">-->
  <!--    <xsl:element name="type">-->
  <!--      <xsl:call-template name="attr-units"/>-->

  <!--      <xsl:attribute name="name" select="type"/>-->

  <!--      <xsl:value-of select="length"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--    <xsl:template match="total[not(units) and not(value) and not(length)]">-->
  <!--      <xsl:element name="total">-->
  <!--        <xsl:call-template name="attr-date"/>-->

  <!--        <xsl:value-of select="."/>-->
  <!--      </xsl:element>-->
  <!--    </xsl:template>-->

  <!--  <xsl:template match="total[length]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-units"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->
  <!--      <xsl:call-template name="attr-date"/>-->

  <!--      <xsl:value-of select="length"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--    <xsl:template match="*[total]">-->
  <!--      <xsl:element name="{name()}">-->
  <!--        <xsl:call-template name="attr-percent-of-population"/>-->
  <!--        <xsl:call-template name="attr-global-rank"/>-->
  <!--        <xsl:call-template name="attr-date"/>-->

  <!--        <xsl:value-of select="."/>-->
  <!--      </xsl:element>-->
  <!--    </xsl:template>-->


  <xsl:template match="*[name and percent]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-note"/>

      <xsl:attribute name="name" select="name"/>
      <xsl:attribute name="units" select="'%'"/>

      <xsl:value-of select="percent"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[not(name) and percent]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-global-rank"/>
      <xsl:call-template name="attr-date"/>

      <xsl:value-of select="percent"/>
    </xsl:element>
  </xsl:template>

  <!-- elements to units attributes -->

  <xsl:template match="*[bbl]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-global-rank"/>
      <xsl:call-template name="attr-date"/>

      <xsl:attribute name="units" select="'bbl'"/>
      <xsl:value-of select="bbl"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[bbl_per_day]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-global-rank"/>
      <xsl:call-template name="attr-date"/>

      <xsl:attribute name="units" select="'bbl per day'"/>
      <xsl:value-of select="bbl_per_day"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[cubic_metres]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-global-rank"/>
      <xsl:call-template name="attr-date"/>

      <xsl:attribute name="units" select="'cubic metres'"/>
      <xsl:value-of select="cubic_metres"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[megatonnes]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-global-rank"/>
      <xsl:call-template name="attr-date"/>

      <xsl:attribute name="units" select="'megatonnes'"/>
      <xsl:value-of select="megatonnes"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[kW]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'kW'"/>
      <xsl:value-of select="kW"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[kWh]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'kWh'"/>
      <xsl:value-of select="kWh"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[USD]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'$'"/>
      <xsl:value-of select="USD"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[migrants_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'migrants per 1000 population'"/>
      <xsl:value-of select="migrants_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[deaths_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'deaths per 1000 population'"/>
      <xsl:value-of select="deaths_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[births_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'births per 1000 population'"/>
      <xsl:value-of select="births_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[deaths_per_100k_live_births]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'deaths per 100k live births'"/>
      <xsl:value-of select="deaths_per_100k_live_births"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[children_born_per_woman]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'children born per woman'"/>
      <xsl:value-of select="children_born_per_woman"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[physicians_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'physicians per 1000 population'"/>
      <xsl:value-of select="physicians_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[beds_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'beds per 1000 population'"/>
      <xsl:value-of select="beds_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[percent_of_adults]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'% of adults'"/>
      <xsl:value-of select="percent_of_adults"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[percent_of_gdp]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:attribute name="units" select="'% of gdp'"/>
      <xsl:value-of select="percent_of_gdp"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[years_of_age]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>
      <xsl:call-template name="attr-note"/>
      <xsl:attribute name="units" select="'years of age'"/>

      <xsl:value-of select="years_of_age"/>
    </xsl:element>
  </xsl:template>

  <!-- arbitrary element values to direct values with attributes -->

  <xsl:template match="*[growth_rate]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:value-of select="growth_rate"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[place]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-population"/>
      <xsl:call-template name="attr-is-capital"/>

      <xsl:value-of select="place"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[age]">
    <xsl:element name="{name()}">
      <xsl:value-of select="age"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[total_subscriptions]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-global-rank"/>
      <xsl:call-template name="attr-date"/>

      <xsl:value-of select="total_subscriptions"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[start and end]">
    <xsl:element name="{name()}">
      <xsl:attribute name="start" select="start"/>
      <xsl:attribute name="end" select="end"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[parent::refugees_and_iternally_displaced_persons and child::people]">
    <xsl:element name="{name()}">
      <xsl:call-template name="attr-date"/>
      <xsl:call-template name="attr-global-rank"/>

      <xsl:value-of select="people"/>
    </xsl:element>
  </xsl:template>

  <!-- merge horrible structure into logical piece -->

  <xsl:template match="*[international_organization_participation]">
    <international_organization_participation>
      <xsl:for-each select="international_organization_participation">
        <organization>
          <xsl:value-of select="organization"/>
        </organization>
      </xsl:for-each>
    </international_organization_participation>
  </xsl:template>

  <xsl:template match="*[degrees and minutes and hemisphere]">
    <xsl:element name="{name()}">
      <xsl:attribute name="degrees" select="degrees"/>
      <xsl:attribute name="minutes" select="minutes"/>
      <xsl:attribute name="hemisphere" select="hemisphere"/>
    </xsl:element>
  </xsl:template>


  <!-- helper templates -->

  <xsl:template name="attr-date">
    <xsl:if test="date">
      <xsl:attribute name="date" select="date"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="attr-note">
    <xsl:if test="note">
      <xsl:attribute name="note" select="note"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="attr-global-rank">
    <xsl:if test="global_rank">
      <xsl:attribute name="global_rank" select="global_rank"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="attr-percent-of-population">
    <xsl:if test="percent_of_population">
      <xsl:attribute name="percent_of_population" select="percent_of_population"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="attr-units">
    <xsl:if test="units">
      <xsl:attribute name="units" select="translate(normalize-space(units), '_', ' ')"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="attr-population">
    <xsl:if test="population">
      <xsl:attribute name="population" select="population"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="attr-is-capital">
    <xsl:if test="is_capital">
      <xsl:attribute name="is_capital" select="is_capital"/>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
