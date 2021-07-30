<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>
  <!--  <xsl:strip-space elements="*"/>-->

  <!-- reusable templates -->

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

  <!-- sections -->

  <xsl:template match="/country">
    <section id="{@id}" title="{name}">
      <xsl:apply-templates select="* except name"/>
    </section>
  </xsl:template>

  <!--  <xsl:template match="-->
  <!--      introduction|-->
  <!--      introduction/background|-->

  <!--      geography|-->
  <!--      geography/location|-->

  <!--      people|-->
  <!--      international_organization_participation|-->

  <!--      economy|-->
  <!--      economy/overview|-->

  <!--      energy|-->
  <!--      energy/electricity|-->
  <!--      energy/crude_oil|-->
  <!--      energy/refined_petroleum_products|-->
  <!--      energy/refined_petroleum_products|-->

  <!--      communications|-->
  <!--      transportation|-->
  <!--      military_and_security|-->
  <!--      transnational_issues-->
  <!--      [parent::country]">-->
  <!--    <xsl:call-template name="section-with-title"/>-->
  <!--  </xsl:template>-->


  <!-- Glossaries -->

  <xsl:template name="glossary">
    <xsl:param name="title" select="translate(name(), '_', ' ')"/>

    <glossary title="{$title}">
      <xsl:for-each select="*">
        <xsl:call-template name="glossary-term"/>
      </xsl:for-each>
    </glossary>
  </xsl:template>

  <xsl:template name="glossary-term">
    <xsl:param name="name">
      <xsl:choose>
        <xsl:when test="@with">
          <xsl:value-of select="@with"/>
        </xsl:when>
        <xsl:when test="@type">
          <xsl:value-of select="@type"/>
        </xsl:when>
        <xsl:when test="@name">
          <xsl:value-of select="@name"/>
        </xsl:when>
        <xsl:when test="@date">
          <xsl:value-of select="@date"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="name()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>

    <term name="{translate($name, '_', ' ')}">
      <xsl:apply-templates select="."/>
    </term>
  </xsl:template>

  <xsl:template match="
      geographic_coordinates|

      geography/area|
      geography/border_countries|
      geography/elevation|
      geography/land_use/*|
      geography/natural_hazards|

      people/ethnic_groups|
      people/languages|
      people/religions|
      people/dependency_ratios|
      people/median_age|
      people/urbanization|
      people/major_urban_areas|
      people/infant_mortality_rate|
      people/life_expectancy_at_birth|
      people/drinking_water_source/*|
      people/sanitation_facility_access/*|
      people/hiv_aids|
      people/literacy|
      people/school_life_expectancy|
      people/youth_unemployment|

      government/country_name|
      government/citizenship|
      government/executive_branch|
      government/legislative_branch|
      government/judicial_branch|
      government/diplomatic_representation/*|
      government/national_symbols/*|
      government/national_anthem|
      government/national_holidays|

      economy/gdp/*|
      economy/gross_national_saving|
      economy/industrial_production_growth_rate|
      economy/labor_force/total_size|
      economy/labor_force/by_occupation/*|
      economy/labor_force/total_size|
      economy/unemployment_rate|
      economy/household_income_by_percentage_share|
      economy/budget|
      economy/exports/total_value|
      economy/exports/partners|
      economy/imports/total_value|
      economy/imports/partners|
      economy/reserves_of_foreign_exchange_and_gold|
      economy/external_debt|
      economy/exchange_rates|

      energy/electricity/access|
      energy/electricity/source|
      energy/crude_oil|
      energy/refined_petroleum_products|
      energy/natural_gas|

      communications/telephones|
      communications/internet|

      transportation/pipelines|
      transportation/railways|
      transportation/roadways|

      military_and_security/expenditures|

      transnational_issues/refugees_and_iternally_displaced_persons/refugees


">
    <xsl:call-template name="glossary"/>
  </xsl:template>


  <!-- Lists -->

  <!--  <xsl:template match="">-->
  <!--    <xsl:call-template name="list"/>-->
  <!--  </xsl:template>-->

  <xsl:template match="*[@units]">
    <xsl:variable name="extra">
      <!--  TODO: dont use @name - change source data? e.g. elevation/lowest_point    -->
      <xsl:choose>
        <xsl:when test="@name and not(@note) and not(@date)">
          <xsl:value-of select="concat('(', @name, ')')"/>
        </xsl:when>
        <xsl:when test="not(@name) and @note and not(@date)">
          <xsl:value-of select="concat('(', @note, ')')"/>
        </xsl:when>
        <xsl:when test="not(@name) and not(@note) and @date">
          <xsl:value-of select="concat('[', @date, ']')"/>
        </xsl:when>

        <xsl:when test="@name and @note and not(@date)">
          <xsl:value-of select="concat('(', @name, ') ', ' [', @note, ']')"/>
        </xsl:when>
        <xsl:when test="@name and not(@note) and @date">
          <xsl:value-of select="concat('(', @name, ') ', ' [', @date, ']')"/>
        </xsl:when>
        <xsl:when test="not(@name) and @note and @date">
          <xsl:value-of select="concat('(', @note, ') ', ' [', @date, ']')"/>
        </xsl:when>

        <xsl:when test="@name and @note and @date">
          <xsl:value-of select="concat('(', @name, ') ', ' (', @note, ') ', ' [', @date, ']')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$extra = ''">
        <xsl:value-of select="concat(., ' ', translate(@units, '_', ' '))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(., ' ', translate(@units, '_', ' '), ' ', translate($extra, '_', ' '))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[@population]">
    <xsl:value-of select="concat(@population, ' people')"/>
  </xsl:template>

  <!--  <xsl:template match="geography/border_countries/*[@units]">-->
  <!--    <xsl:value-of select="concat(., ' ', @units)"/>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template name="glossary">-->
  <!--    <xsl:variable name="title">-->
  <!--        <xsl:value-of select="name()"/>-->
  <!--    </xsl:variable>-->

  <!--    <xsl:variable name="sanitized-title">-->
  <!--      <xsl:value-of select="translate($title, '_', ' ')"/>-->
  <!--    </xsl:variable>-->

  <!--    <glossary title="{$sanitized-title}">-->
  <!--      <xsl:for-each select="*">-->
  <!--        <xsl:call-template name="term"/>-->
  <!--      </xsl:for-each>-->
  <!--    </glossary>-->
  <!--  </xsl:template>-->

<!--  <xsl:template name="term">-->
<!--    <xsl:variable name="name">-->

<!--    </xsl:variable>-->

<!--    <xsl:variable name="sanitized-name">-->
<!--      <xsl:value-of select="translate($name, '_', ' ')"/>-->
<!--    </xsl:variable>-->

<!--    <term name="{$sanitized-name}">-->
<!--      <xsl:apply-templates select="."/>-->
<!--    </term>-->
<!--  </xsl:template>-->

<!--  <xsl:template match="geography/elevation">-->
<!--    <glossary title="elevation">-->
<!--      <xsl:for-each select="*">-->
<!--        <xsl:call-template name="term"/>-->
<!--      </xsl:for-each>-->
<!--    </glossary>-->
<!--  </xsl:template>-->


  <!-- Data-view formatting -->

  <xsl:template match="*[@degrees and @minutes and @hemisphere]">
    <xsl:variable name="degree">&#176;</xsl:variable>
    <xsl:variable name="minute">&#34;</xsl:variable>

    <xsl:value-of select="concat(@degrees, $degree, @minutes, $minute, @hemisphere)"/>
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
