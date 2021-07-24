<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/country">
    <country id="{@id}">
      <xsl:apply-templates/>
    </country>
  </xsl:template>

  <!-- Introduction -->

  <xsl:template match="introduction">
    <introduction>
      <xsl:apply-templates select="background"/>
    </introduction>
  </xsl:template>

  <xsl:template match="introduction/background">
    <background>
      <xsl:apply-templates/>
    </background>
  </xsl:template>

  <!-- Geography -->

  <xsl:template match="geography">
    <geography>
      <xsl:apply-templates select="location"/>
      <xsl:apply-templates select="geographic_coordinates"/>
      <xsl:apply-templates select="area"/>
      <xsl:apply-templates select="land_boundaries"/>
      <xsl:apply-templates select="coastline"/>
      <xsl:apply-templates select="climate"/>
      <xsl:apply-templates select="terrain"/>
      <xsl:apply-templates select="elevation"/>
      <xsl:apply-templates select="natural_resources"/>
      <xsl:apply-templates select="land_use"/>
      <xsl:apply-templates select="irrigated_land"/>
      <xsl:apply-templates select="population_distribution"/>
      <natural_hazards>
        <xsl:apply-templates select="natural_hazards"/>
      </natural_hazards>
      <xsl:apply-templates select="environment"/>
    </geography>
  </xsl:template>

  <xsl:template match="*[border_countries]">
    <border_countries>
      <xsl:apply-templates select="border_countries"/>
    </border_countries>
  </xsl:template>

  <xsl:template match="border_countries">
    <border with="{country}" units="{border_length/units}">
      <xsl:value-of select="border_length/value"/>
    </border>
  </xsl:template>

  <xsl:template match="*[name and elevation[value and units]]">
    <xsl:element name="{name()}">
      <xsl:attribute name="name" select="name"/>
      <xsl:attribute name="units" select="elevation/units"/>
      <xsl:value-of select="elevation/value"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="natural_hazards">
    <hazard type="{type}">
      <xsl:value-of select="description"/>
    </hazard>
  </xsl:template>

  <xsl:template match="environment">
    <environment>
      <issues>
        <xsl:apply-templates select="current_issues"/>
      </issues>
      <international_agreements>
        <party_to>
          <xsl:apply-templates select="international_agreements/party_to"/>
        </party_to>
        <signed_but_not_ratified>
          <xsl:apply-templates select="international_agreements/signed_but_not_ratified"/>
        </signed_but_not_ratified>
      </international_agreements>
    </environment>
  </xsl:template>

  <xsl:template match="party_to | signed_but_not_ratified">
    <agreement>
      <xsl:value-of select="."/>
    </agreement>
  </xsl:template>

  <!-- People  -->

  <xsl:template match="nationality">
    <nationality noun="{noun}">
      <xsl:value-of select="adjective"/>
    </nationality>
  </xsl:template>

  <xsl:template match="ethnicity">
    <group units="%" name="{name}">
      <xsl:value-of select="percent"/>
    </group>
  </xsl:template>

  <xsl:template match="language">
    <language units="%" name="{name}">
      <xsl:value-of select="percent"/>
    </language>
  </xsl:template>

  <xsl:template match="religion">
    <religion units="%" name="{name}">
      <xsl:value-of select="percent"/>
    </religion>
  </xsl:template>

  <xsl:template match="dependency_ratios/ratios">
    <xsl:for-each select="*">
      <!-- TODO: humanifiy name  -->
      <ratio units="%" name="{name()}">
        <xsl:value-of select="value"/>
      </ratio>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="growth_rate">
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="*[births_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'births per 1000 population'"/>
      <xsl:value-of select="births_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[deaths_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'deaths per 1000 population'"/>
      <xsl:value-of select="deaths_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[migrants_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'migrants per 1000 population'"/>
      <xsl:value-of select="migrants_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="urbanization">
    <urbanization>
      <xsl:apply-templates select="urban_population"/>
      <xsl:apply-templates select="rate_of_urbanization"/>
    </urbanization>
  </xsl:template>

  <xsl:template match="major_urban_areas">
    <major_urban_areas>
      <xsl:apply-templates select="places"/>
    </major_urban_areas>
  </xsl:template>

  <xsl:template match="major_urban_areas/places">
    <area name="{place}" population="{population}"/>
  </xsl:template>

  <xsl:template match="*[age]">
    <xsl:element name="{name()}">
      <xsl:value-of select="age"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[deaths_per_100k_live_births]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'deaths per 100k live population'"/>
      <xsl:value-of select="deaths_per_100k_live_births"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[children_born_per_woman]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'children born per woman'"/>
      <xsl:value-of select="children_born_per_woman"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[physicians_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'physicians per 1000 population'"/>
      <xsl:value-of select="physicians_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[beds_per_1000_population]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'beds per 1000 population'"/>
      <xsl:value-of select="beds_per_1000_population"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[percent_of_adults]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'% of adults'"/>
      <xsl:value-of select="percent_of_adults"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[percent_of_gdp]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'% of gdp'"/>
      <xsl:value-of select="percent_of_gdp"/>
    </xsl:element>
  </xsl:template>

  <!-- government -->

  <xsl:template match="government">
    <government>
      <xsl:apply-templates select="*
                                 except national_holidays
                                 except international_law_organization_participation
                                 except international_organization_participation"/>

      <national_holidays>
        <xsl:apply-templates select="national_holidays"/>
      </national_holidays>

      <international_law_organization_participation>
        <xsl:apply-templates select="international_law_organization_participation"/>
      </international_law_organization_participation>

      <international_organization_participation>
        <xsl:apply-templates select="international_organization_participation"/>
      </international_organization_participation>
    </government>
  </xsl:template>

  <xsl:template match="*[timezone and note]">
    <xsl:element name="{name()}">
      <xsl:attribute name="timezones" select="timezone"/>
      <xsl:value-of select="note"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="independence">
    <xsl:element name="independence">
      <xsl:if test="note">
        <xsl:attribute name="note" select="note"/>
      </xsl:if>

      <xsl:value-of select="date"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="national_holidays">
    <holiday name="{name}">
      <xsl:value-of select="day"/>
    </holiday>
  </xsl:template>

  <xsl:template match="international_law_organization_participation">
    <participation>
      <xsl:value-of select="."/>
    </participation>
  </xsl:template>

  <xsl:template match="political_parties_and_leaders/parties">
    <party name="{name}" leader="{leaders}"/>
  </xsl:template>

  <xsl:template match="international_organization_participation">
    <organization name="{organization}"/>
  </xsl:template>

  <xsl:template match="national_symbol">
    <national_symbols>
      <symbols>
        <xsl:apply-templates select="symbols"/>
      </symbols>
      <colors>
        <xsl:apply-templates select="colors"/>
      </colors>
    </national_symbols>
  </xsl:template>

  <xsl:template match="national_symbol/symbols">
    <symbol name="{symbol}"/>
  </xsl:template>

  <xsl:template match="national_symbol/colors">
    <color name="{color}"/>
  </xsl:template>

  <!-- economy -->

  <xsl:template match="official_exchange_rate/* except official_exchange_rate/date">
    <rate units="{name()}">
      <xsl:value-of select="."/>
    </rate>
  </xsl:template>

  <xsl:template match="composition">
    <end_uses>
      <xsl:apply-templates select="by_end_use/end_uses/*"/>
    </end_uses>
    <sectors_of_origin>
      <xsl:apply-templates select="by_sector_of_origin/sectors/*"/>
    </sectors_of_origin>
  </xsl:template>

  <xsl:template match="products[count(*)=0]">
    <product>
      <xsl:value-of select="."/>
    </product>
  </xsl:template>

  <xsl:template match="industries[count(*)=0]">
    <industry>
      <xsl:value-of select="."/>
    </industry>
  </xsl:template>

  <xsl:template match="by_commodity">
    <commodity>
      <xsl:value-of select="."/>
    </commodity>
  </xsl:template>

  <xsl:template match="partners/by_country">
    <partner name="{name}" units="%">
      <xsl:value-of select="percent"/>
    </partner>
  </xsl:template>

  <!-- energy -->

  <xsl:template match="*[kWh]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'kWh'"/>
      <xsl:value-of select="kWh"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[kW]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'kW'"/>
      <xsl:value-of select="kW"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="by_source">
    <source>
      <xsl:apply-templates/>
    </source>
  </xsl:template>

  <xsl:template match="by_source/*[percent]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'%'"/>
      <xsl:value-of select="percent"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[bbl_per_day]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'bbl per day'"/>
      <xsl:value-of select="bbl_per_day"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[bbl]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'bbl'"/>
      <xsl:value-of select="bbl"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[cubic_metres]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'cubic metres'"/>
      <xsl:value-of select="cubic_metres"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[megatonnes]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="'megatonnes'"/>
      <xsl:value-of select="megatonnes"/>
    </xsl:element>
  </xsl:template>

  <!-- communications -->

  <xsl:template match="*[total_subscriptions]">
    <xsl:element name="{name()}">
      <xsl:value-of select="total_subscriptions"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="pipelines/*[type and length and units]">
    <pipeline name="{type}" units="{units}">
      <xsl:value-of select="length"/>
    </pipeline>
  </xsl:template>

  <xsl:template match="railways/total">
    <total units="{units}">
      <xsl:value-of select="length"/>
    </total>
  </xsl:template>

  <xsl:template match="railways/*[length and units] except railways/total">
    <pipeline name="{name()}" units="{units}">
      <xsl:value-of select="length"/>
    </pipeline>
  </xsl:template>

  <xsl:template match="ports_and_terminals">
    <xsl:if test="river_ports">
      <river_ports>
        <xsl:apply-templates select="river_ports"/>
      </river_ports>
    </xsl:if>

    <xsl:if test="major_seaports">
      <major_seaports>
        <xsl:apply-templates select="major_seaports"/>
      </major_seaports>
    </xsl:if>

    <xsl:if test="container_ports">
      <container_ports>
        <xsl:apply-templates select="container_ports"/>
      </container_ports>
    </xsl:if>

    <xsl:if test="oil_terminals">
      <oil_terminals>
        <xsl:apply-templates select="oil_terminals"/>
      </oil_terminals>
    </xsl:if>

    <xsl:if test="liquid_natural_gas_terminals_import">
      <liquid_natural_gas_terminals_import>
        <xsl:apply-templates select="liquid_natural_gas_terminals_import"/>
      </liquid_natural_gas_terminals_import>
    </xsl:if>

    <xsl:if test="liquid_natural_gas_terminals_export">
      <liquid_natural_gas_terminals_export>
        <xsl:apply-templates select="liquid_natural_gas_terminals_export"/>
      </liquid_natural_gas_terminals_export>
    </xsl:if>
  </xsl:template>

  <xsl:template match="river_ports">
    <river_port>
      <xsl:value-of select="."/>
    </river_port>
  </xsl:template>

  <xsl:template match="major_seaports">
    <seaport>
      <xsl:value-of select="."/>
    </seaport>
  </xsl:template>

  <xsl:template match="container_ports">
    <container_port>
      <xsl:value-of select="place"/>
    </container_port>
  </xsl:template>

  <xsl:template match="oil_terminals">
    <oil_terminal>
      <xsl:value-of select="."/>
    </oil_terminal>
  </xsl:template>

  <xsl:template match="liquid_natural_gas_terminals_import">
    <liquid_natural_gas_terminal>
      <xsl:value-of select="."/>
    </liquid_natural_gas_terminal>
  </xsl:template>

  <xsl:template match="liquid_natural_gas_terminals_export">
    <liquid_natural_gas_terminal>
      <xsl:value-of select="."/>
    </liquid_natural_gas_terminal>
  </xsl:template>

  <xsl:template match="service_age_and_obligation[note]">
    <service_age_and_obligation>
      <xsl:value-of select="note"/>
    </service_age_and_obligation>
  </xsl:template>

  <xsl:template match="stateless_persons[people] | internally_displaced_persons[people]">
    <xsl:element name="{name()}">
      <xsl:value-of select="people"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="refugees/by_country">
    <country_of_origin name="{country_of_origin}">
      <xsl:value-of select="people"/>
    </country_of_origin>
  </xsl:template>

  <!-- Re-usable rules -->

  <xsl:template match="*[degrees and minutes and hemisphere]">
    <xsl:element name="{name()}">
      <xsl:attribute name="degrees" select="degrees"/>
      <xsl:attribute name="minutes" select="minutes"/>
      <xsl:attribute name="hemisphere" select="hemisphere"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[value and units]">
    <xsl:element name="{name()}">
      <xsl:attribute name="units" select="units"/>

      <xsl:if test="name">
        <xsl:attribute name="name" select="name"/>
      </xsl:if>

      <xsl:if test="date">
        <xsl:attribute name="date" select="date"/>
      </xsl:if>

      <xsl:if test="note">
        <xsl:attribute name="note" select="note"/>
      </xsl:if>

      <xsl:value-of select="value"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[total[count(child::element()) = 0]]">
    <xsl:element name="{name()}">
      <xsl:value-of select="total"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[start and end]">
    <xsl:element name="{name()}">
      <xsl:attribute name="start" select="start"/>
      <xsl:attribute name="end" select="end"/>
    </xsl:element>
  </xsl:template>

  <!--  <xsl:template match="*[percent]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:attribute name="units" select="'%'"/>-->
  <!--      <xsl:value-of select="percent"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <xsl:template match="global_rank"/>
  <xsl:template match="date"/>

  <!--  &lt;!&ndash; most generic cases &ndash;&gt;-->

  <!--  <xsl:template match="*[value and units]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-units"/>-->

  <!--      <xsl:value-of select="value"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->


  <!--  <xsl:template match="*[total[not(*)]]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->
  <!--      <xsl:call-template name="attr-date"/>-->

  <!--      <xsl:value-of select="total"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  &lt;!&ndash;  <xsl:template match="*[length and units and not(type)]">&ndash;&gt;-->
  <!--  &lt;!&ndash;    <xsl:element name="{name()}">&ndash;&gt;-->
  <!--  &lt;!&ndash;      <xsl:call-template name="attr-date"/>&ndash;&gt;-->
  <!--  &lt;!&ndash;      <xsl:call-template name="attr-units"/>&ndash;&gt;-->

  <!--  &lt;!&ndash;      <xsl:value-of select="length"/>&ndash;&gt;-->
  <!--  &lt;!&ndash;    </xsl:element>&ndash;&gt;-->
  <!--  &lt;!&ndash;  </xsl:template>&ndash;&gt;-->

  <!--  &lt;!&ndash;  <xsl:template match="*[type and length]">&ndash;&gt;-->
  <!--  &lt;!&ndash;    <xsl:element name="type">&ndash;&gt;-->
  <!--  &lt;!&ndash;      <xsl:call-template name="attr-units"/>&ndash;&gt;-->

  <!--  &lt;!&ndash;      <xsl:attribute name="name" select="type"/>&ndash;&gt;-->

  <!--  &lt;!&ndash;      <xsl:value-of select="length"/>&ndash;&gt;-->
  <!--  &lt;!&ndash;    </xsl:element>&ndash;&gt;-->
  <!--  &lt;!&ndash;  </xsl:template>&ndash;&gt;-->

  <!--  &lt;!&ndash;    <xsl:template match="total[not(units) and not(value) and not(length)]">&ndash;&gt;-->
  <!--  &lt;!&ndash;      <xsl:element name="total">&ndash;&gt;-->
  <!--  &lt;!&ndash;        <xsl:call-template name="attr-date"/>&ndash;&gt;-->

  <!--  &lt;!&ndash;        <xsl:value-of select="."/>&ndash;&gt;-->
  <!--  &lt;!&ndash;      </xsl:element>&ndash;&gt;-->
  <!--  &lt;!&ndash;    </xsl:template>&ndash;&gt;-->

  <!--  &lt;!&ndash;  <xsl:template match="total[length]">&ndash;&gt;-->
  <!--  &lt;!&ndash;    <xsl:element name="{name()}">&ndash;&gt;-->
  <!--  &lt;!&ndash;      <xsl:call-template name="attr-units"/>&ndash;&gt;-->
  <!--  &lt;!&ndash;      <xsl:call-template name="attr-global-rank"/>&ndash;&gt;-->
  <!--  &lt;!&ndash;      <xsl:call-template name="attr-date"/>&ndash;&gt;-->

  <!--  &lt;!&ndash;      <xsl:value-of select="length"/>&ndash;&gt;-->
  <!--  &lt;!&ndash;    </xsl:element>&ndash;&gt;-->
  <!--  &lt;!&ndash;  </xsl:template>&ndash;&gt;-->

  <!--  &lt;!&ndash;    <xsl:template match="*[total]">&ndash;&gt;-->
  <!--  &lt;!&ndash;      <xsl:element name="{name()}">&ndash;&gt;-->
  <!--  &lt;!&ndash;        <xsl:call-template name="attr-percent-of-population"/>&ndash;&gt;-->
  <!--  &lt;!&ndash;        <xsl:call-template name="attr-global-rank"/>&ndash;&gt;-->
  <!--  &lt;!&ndash;        <xsl:call-template name="attr-date"/>&ndash;&gt;-->

  <!--  &lt;!&ndash;        <xsl:value-of select="."/>&ndash;&gt;-->
  <!--  &lt;!&ndash;      </xsl:element>&ndash;&gt;-->
  <!--  &lt;!&ndash;    </xsl:template>&ndash;&gt;-->


  <!--  <xsl:template match="*[name and percent]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-note"/>-->

  <!--      <xsl:attribute name="name" select="name"/>-->
  <!--      <xsl:attribute name="units" select="'%'"/>-->

  <!--      <xsl:value-of select="percent"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[not(name) and percent]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->
  <!--      <xsl:call-template name="attr-date"/>-->

  <!--      <xsl:value-of select="percent"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  &lt;!&ndash; elements to units attributes &ndash;&gt;-->


  <!--  <xsl:template match="*[kW]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'kW'"/>-->
  <!--      <xsl:value-of select="kW"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[kWh]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'kWh'"/>-->
  <!--      <xsl:value-of select="kWh"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[USD]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'$'"/>-->
  <!--      <xsl:value-of select="USD"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[migrants_per_1000_population]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'migrants per 1000 population'"/>-->
  <!--      <xsl:value-of select="migrants_per_1000_population"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[deaths_per_1000_population]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'deaths per 1000 population'"/>-->
  <!--      <xsl:value-of select="deaths_per_1000_population"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[births_per_1000_population]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'births per 1000 population'"/>-->
  <!--      <xsl:value-of select="births_per_1000_population"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[deaths_per_100k_live_births]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'deaths per 100k live births'"/>-->
  <!--      <xsl:value-of select="deaths_per_100k_live_births"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[children_born_per_woman]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'children born per woman'"/>-->
  <!--      <xsl:value-of select="children_born_per_woman"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[physicians_per_1000_population]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'physicians per 1000 population'"/>-->
  <!--      <xsl:value-of select="physicians_per_1000_population"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[beds_per_1000_population]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'beds per 1000 population'"/>-->
  <!--      <xsl:value-of select="beds_per_1000_population"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[percent_of_adults]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'% of adults'"/>-->
  <!--      <xsl:value-of select="percent_of_adults"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[percent_of_gdp]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:attribute name="units" select="'% of gdp'"/>-->
  <!--      <xsl:value-of select="percent_of_gdp"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[years_of_age]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->
  <!--      <xsl:call-template name="attr-note"/>-->
  <!--      <xsl:attribute name="units" select="'years of age'"/>-->

  <!--      <xsl:value-of select="years_of_age"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  &lt;!&ndash; arbitrary element values to direct values with attributes &ndash;&gt;-->

  <!--  <xsl:template match="*[growth_rate]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:value-of select="growth_rate"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[place]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-population"/>-->
  <!--      <xsl:call-template name="attr-is-capital"/>-->

  <!--      <xsl:value-of select="place"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[age]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:value-of select="age"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[total_subscriptions]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->
  <!--      <xsl:call-template name="attr-date"/>-->

  <!--      <xsl:value-of select="total_subscriptions"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->


  <!--  <xsl:template match="*[parent::refugees_and_iternally_displaced_persons and child::people]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:call-template name="attr-date"/>-->
  <!--      <xsl:call-template name="attr-global-rank"/>-->

  <!--      <xsl:value-of select="people"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->

  <!--  &lt;!&ndash; merge horrible structure into logical piece &ndash;&gt;-->

  <!--  <xsl:template match="*[international_organization_participation]">-->
  <!--    <international_organization_participation>-->
  <!--      <xsl:for-each select="international_organization_participation">-->
  <!--        <organization>-->
  <!--          <xsl:value-of select="organization"/>-->
  <!--        </organization>-->
  <!--      </xsl:for-each>-->
  <!--    </international_organization_participation>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template match="*[degrees and minutes and hemisphere]">-->
  <!--    <xsl:element name="{name()}">-->
  <!--      <xsl:attribute name="degrees" select="degrees"/>-->
  <!--      <xsl:attribute name="minutes" select="minutes"/>-->
  <!--      <xsl:attribute name="hemisphere" select="hemisphere"/>-->
  <!--    </xsl:element>-->
  <!--  </xsl:template>-->


  <!--  &lt;!&ndash; helper templates &ndash;&gt;-->

  <!--  <xsl:template name="attr-date">-->
  <!--    <xsl:if test="date">-->
  <!--      <xsl:attribute name="date" select="date"/>-->
  <!--    </xsl:if>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template name="attr-note">-->
  <!--    <xsl:if test="note">-->
  <!--      <xsl:attribute name="note" select="note"/>-->
  <!--    </xsl:if>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template name="attr-global-rank">-->
  <!--    <xsl:if test="global_rank">-->
  <!--      <xsl:attribute name="global_rank" select="global_rank"/>-->
  <!--    </xsl:if>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template name="attr-percent-of-population">-->
  <!--    <xsl:if test="percent_of_population">-->
  <!--      <xsl:attribute name="percent_of_population" select="percent_of_population"/>-->
  <!--    </xsl:if>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template name="attr-units">-->
  <!--    <xsl:if test="units">-->
  <!--      <xsl:attribute name="units" select="translate(normalize-space(units), '_', ' ')"/>-->
  <!--    </xsl:if>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template name="attr-population">-->
  <!--    <xsl:if test="population">-->
  <!--      <xsl:attribute name="population" select="population"/>-->
  <!--    </xsl:if>-->
  <!--  </xsl:template>-->

  <!--  <xsl:template name="attr-is-capital">-->
  <!--    <xsl:if test="is_capital">-->
  <!--      <xsl:attribute name="is_capital" select="is_capital"/>-->
  <!--    </xsl:if>-->
  <!--  </xsl:template>-->

</xsl:stylesheet>
