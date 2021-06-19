<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <fo:root language="en" font-size="12pt" font-family="Times New Roman, serif">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="bi-xml"
                               page-width="210mm" page-height="297mm"
                               margin-top="2cm" margin-bottom="1cm"
                               margin-left="2cm" margin-right="2cm">
          <fo:region-body margin-bottom="2cm"/>
          <fo:region-after extent="1cm"/>
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
        <fo:block font-size="20pt">
          <fo:basic-link internal-destination="{@id}">
            <xsl:value-of select="name"/>
          </fo:basic-link>
        </fo:block>
      </xsl:for-each>
    </fo:block>

    <xsl:apply-templates/>
  </xsl:template>


  <xsl:template name="h1">
    <xsl:param name="content"/>
    <fo:block margin-top="2mm" font-size="20pt" font-weight="bold">
      <xsl:copy-of select="$content"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="h2">
    <xsl:param name="content"/>
    <fo:block margin-top="2mm" font-size="16pt" font-weight="bold">
      <xsl:copy-of select="$content"/>
    </fo:block>
  </xsl:template>

  <xsl:template name="h3">
    <xsl:param name="content"/>
    <fo:block margin-top="2mm" font-size="14pt" font-weight="bold">
      <xsl:copy-of select="$content"/>
    </fo:block>
  </xsl:template>


  <xsl:template match="countries/country">
    <fo:block break-before="page">
      <fo:block id="{@id}">
        <xsl:call-template name="h1">
          <xsl:with-param name="content">
            <xsl:value-of select="name"/>
          </xsl:with-param>
        </xsl:call-template>
      </fo:block>
    </fo:block>
    <xsl:apply-templates select="introduction"/>
    <xsl:apply-templates select="geography"/>
    <xsl:apply-templates select="people"/>
    <xsl:apply-templates select="government"/>
    <xsl:apply-templates select="economy"/>
    <xsl:apply-templates select="energy"/>
    <xsl:apply-templates select="communications"/>
  </xsl:template>

  <!-- Introduction -->

  <xsl:template match="introduction">
    <xsl:call-template name="h2">
      <xsl:with-param name="content">
        <xsl:text>Introduction</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <fo:block>
      <xsl:value-of select="background"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="introduction/location">
    <fo:block font-weight="bold">
      Location
    </fo:block>
    <fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Geography -->

  <xsl:template match="geography">
    <xsl:call-template name="h2">
      <xsl:with-param name="content">
        <xsl:text>Geography</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <fo:block>
      <xsl:value-of select="location"/>
    </fo:block>

    <xsl:apply-templates select="geographic_coordinates"/>
  </xsl:template>

  <!-- People -->

  <xsl:template match="people">
    <xsl:call-template name="h2">
      <xsl:with-param name="content">
        <xsl:text>People</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:apply-templates select="population"/>
    <xsl:apply-templates select="nationality"/>
  </xsl:template>

  <xsl:template match="people/population">
    <fo:block>
      <fo:inline font-weight="bold">
        Population:
      </fo:inline>
      <xsl:apply-templates select="total"/>
      <xsl:apply-templates select="global_rank"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="people/nationality">
    <fo:block>
      <fo:inline font-weight="bold">
        Nationality:
      </fo:inline>
      <xsl:apply-templates select="adjective"/>
    </fo:block>
  </xsl:template>

  <!-- Government -->

  <xsl:template match="government">
    <xsl:call-template name="h2">
      <xsl:with-param name="content">
        <xsl:text>Government</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates select="government_type"/>
  </xsl:template>

  <xsl:template match="government_type">
    <fo:block>
      <fo:inline font-weight="bold">
        Type:
      </fo:inline>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Economy -->

  <xsl:template match="economy">
    <xsl:call-template name="h2">
      <xsl:with-param name="content">
        <xsl:text>Economy</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <fo:block>
      <xsl:apply-templates select="overview"/>
    </fo:block>
  </xsl:template>

  <!-- Energy -->

  <xsl:template match="energy">
    <xsl:call-template name="h2">
      <xsl:with-param name="content">
        <xsl:text>Energy</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:apply-templates select="electricity"/>
    <xsl:apply-templates select="crude_oil"/>
    <xsl:apply-templates select="natural_gas"/>
  </xsl:template>

  <xsl:template match="energy/electricity">
    <xsl:call-template name="h3">
      <xsl:with-param name="content">
        <xsl:text>Electricity</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:apply-templates select="production"/>
    <xsl:apply-templates select="consumption"/>
  </xsl:template>

  <xsl:template match="energy/crude_oil">
    <xsl:call-template name="h3">
      <xsl:with-param name="content">
        <xsl:text>Crude oil</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:apply-templates select="production"/>
  </xsl:template>

  <xsl:template match="energy/natural_gas">
    <xsl:call-template name="h3">
      <xsl:with-param name="content">
        <xsl:text>Natural gas</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:apply-templates select="production"/>
    <xsl:apply-templates select="consumption"/>
  </xsl:template>

  <!-- Communications -->

  <xsl:template match="communications">
    <xsl:call-template name="h2">
      <xsl:with-param name="content">
        <xsl:text>Communications</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <fo:block>
      <xsl:apply-templates select="broadcast_media"/>
    </fo:block>

    <xsl:apply-templates select="internet"/>
    <!--    <xsl:apply-templates select="natural_gas"/>-->
  </xsl:template>

  <xsl:template match="communications/internet">
    <xsl:call-template name="h3">
      <xsl:with-param name="content">
        <xsl:text>Internet</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:apply-templates select="country_code"/>
    <xsl:apply-templates select="users"/>
  </xsl:template>

  <xsl:template match="communications/internet/users">
    <fo:block>
      <fo:inline font-weight="bold">
        Internet users:
      </fo:inline>
      <xsl:value-of select="total"/>
      <xsl:apply-templates select="global_rank"/>
    </fo:block>
  </xsl:template>


  <!-- Universal -->

  <xsl:template match="cubic_metres">
    <fo:inline>
      <xsl:value-of select="."/>
      m3
    </fo:inline>
  </xsl:template>
  <xsl:template match="kWh">
    <fo:inline>
      <xsl:value-of select="."/> kWh
    </fo:inline>
  </xsl:template>
  <xsl:template match="bbl_per_day">
    <fo:inline>
      <xsl:value-of select="."/> bbl/day
    </fo:inline>
  </xsl:template>

  <xsl:template match="geographic_coordinates">
    <fo:block>
      <fo:inline font-weight="bold">
        Coordinates:
      </fo:inline>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="longitude|latitude">
    <fo:inline>
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>
  <xsl:template match="degrees">
    <xsl:value-of select="."/>°
  </xsl:template>
  <xsl:template match="minutes">
    <xsl:value-of select="."/>'
  </xsl:template>
  <xsl:template match="hemisphere">
    (<xsl:value-of select="."/>)
  </xsl:template>

  <xsl:template match="global_rank">
    <fo:inline>
      (Global rank: <xsl:value-of select="."/>)
    </fo:inline>
  </xsl:template>

  <xsl:template match="production">
    <fo:block>
      Production:
      <xsl:apply-templates select="* except date"/>
    </fo:block>
  </xsl:template>
  <xsl:template match="consumption">
    <fo:block>
      Consumption:
      <xsl:apply-templates select="* except date"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="internet/country_code">
    <fo:block>
      <fo:inline font-weight="bold">
        Top level domain (TLD):
      </fo:inline>
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
