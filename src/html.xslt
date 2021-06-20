<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <!-- INDEX page -->

  <xsl:template match="/">
    <xsl:apply-templates mode="detail"/>

    <xsl:result-document href="index.html">
      <html lang="en">
        <head>
          <meta charset="utf-8"/>
          <meta name="viewport" content="width=device-width, initial-scale=1"/>
          <meta name="author" content="Lubos Zapotocny"/>

          <title>BI-XML</title>

          <link href="assets/css/bootstrap.min.css" rel="stylesheet"/>
        </head>

        <body>
          <div class="container">
            <h1>
              <xsl:text>Countries</xsl:text>
            </h1>

            <xsl:apply-templates mode="index"/>
          </div>
        </body>
      </html>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="countries" mode="index">
    <ul>
      <xsl:apply-templates mode="index"/>
    </ul>
  </xsl:template>

  <xsl:template match="countries/country" mode="index">
    <li>
      <a href="country/{@id}.html">
        <xsl:value-of select="name"/>
      </a>
    </li>
  </xsl:template>

  <!-- DETAIL pages -->

  <xsl:template match="countries/country" mode="detail">
    <xsl:result-document href="country/{@id}.html">
      <html lang="en">
        <head>
          <meta charset="utf-8"/>
          <meta name="viewport" content="width=device-width, initial-scale=1"/>
          <meta name="author" content="Lubos Zapotocny"/>

          <title>BI-XML |
            <xsl:value-of select="name"/>
          </title>

          <link href="../assets/css/bootstrap.min.css" rel="stylesheet"/>
        </head>

        <body>
          <div class="container">
            <h1>
              <xsl:value-of select="name"/>
            </h1>

            <xsl:apply-templates select="introduction"/>
            <xsl:apply-templates select="geography"/>
            <xsl:apply-templates select="people"/>
            <xsl:apply-templates select="government"/>
            <xsl:apply-templates select="economy"/>
            <xsl:apply-templates select="energy"/>
            <xsl:apply-templates select="communications"/>
            <xsl:apply-templates select="transportation"/>
            <xsl:apply-templates select="military_and_security"/>
            <xsl:apply-templates select="transnational_issues"/>
          </div>
        </body>

      </html>
    </xsl:result-document>
  </xsl:template>

  <!-- Introduction -->

  <xsl:template match="introduction">
    <h2>Introduction</h2>

    <p>
      <xsl:value-of select="background"/>
    </p>
  </xsl:template>

  <!-- Geography -->

  <xsl:template match="geography">
    <h2>Geography</h2>

    <p>
      <xsl:value-of select="location"/>
    </p>

    <xsl:apply-templates select="geographic_coordinates"/>

  </xsl:template>

  <!-- People -->

  <xsl:template match="people">
    <h2>People</h2>

    <xsl:apply-templates select="population"/>
    <xsl:apply-templates select="nationality"/>
  </xsl:template>

  <xsl:template match="people/population">
    <div>
      <span style="font-weight: bold">
        Population:
      </span>
      <xsl:apply-templates select="total"/>
      <xsl:apply-templates select="global_rank"/>
    </div>
  </xsl:template>

  <xsl:template match="people/nationality">
    <div>
      <span style="font-weight: bold">
        Nationality:
      </span>
      <xsl:apply-templates select="adjective"/>
    </div>
  </xsl:template>

  <!-- Government -->

  <xsl:template match="government">
    <h2>Government</h2>

    <xsl:apply-templates select="government_type"/>
  </xsl:template>

  <xsl:template match="government_type">
    <div>
      <span style="font-weight: bold">
        Type:
      </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- Economy -->

  <xsl:template match="economy">
    <h2>Economy</h2>

    <div>
      <xsl:apply-templates select="overview"/>
    </div>
  </xsl:template>

  <!-- Energy -->

  <xsl:template match="energy">
    <h2>Energy</h2>

    <xsl:apply-templates select="electricity"/>
    <xsl:apply-templates select="crude_oil"/>
    <xsl:apply-templates select="natural_gas"/>
  </xsl:template>

  <xsl:template match="energy/electricity">
    <h3>Electricity</h3>

    <xsl:apply-templates select="production"/>
    <xsl:apply-templates select="consumption"/>
  </xsl:template>

  <xsl:template match="energy/crude_oil">
    <h3>Crude oil</h3>

    <xsl:apply-templates select="production"/>
  </xsl:template>

  <xsl:template match="energy/natural_gas">
    <h3>Natural gas</h3>

    <xsl:apply-templates select="production"/>
    <xsl:apply-templates select="consumption"/>
  </xsl:template>

  <!-- Communications -->

  <xsl:template match="communications">
    <h2>Communications</h2>

    <div>
      <xsl:apply-templates select="broadcast_media"/>
    </div>

    <xsl:apply-templates select="internet"/>
  </xsl:template>

  <xsl:template match="communications/internet">
    <h3>Internet</h3>

    <xsl:apply-templates select="country_code"/>
    <xsl:apply-templates select="users"/>
  </xsl:template>

  <xsl:template match="communications/internet/users">
    <div>
      <span style="font-weight: bold">
        Internet users:
      </span>
      <xsl:value-of select="total"/>
      <xsl:apply-templates select="global_rank"/>
    </div>
  </xsl:template>

  <!-- Transportation -->

  <xsl:template match="transportation">
    <h2>Transportation</h2>

    <xsl:apply-templates select="railways"/>
    <xsl:apply-templates select="roadways"/>
  </xsl:template>

  <xsl:template match="transportation/railways">
    <h3>Railways</h3>

    <div>
      <xsl:apply-templates select="total"/>
      <xsl:apply-templates select="global_rank"/>
    </div>
  </xsl:template>

  <xsl:template match="transportation/roadways">
    <h3>Roadways</h3>

    <div>
      <xsl:apply-templates select="total"/>
      <xsl:apply-templates select="global_rank"/>
    </div>
  </xsl:template>

  <!-- Military and security -->

  <xsl:template match="military_and_security">
    <h2>Military and security</h2>

    <h3>Service age and obligation</h3>

    <xsl:apply-templates select="service_age_and_obligation"/>
  </xsl:template>

  <xsl:template match="military_and_security/service_age_and_obligation">
    <div>
      At age of <xsl:value-of select="years_of_age"/>
    </div>
    <div>
      <xsl:value-of select="note"/>
    </div>
  </xsl:template>

  <!-- Transnational Issues -->

  <xsl:template match="transnational_issues">
    <h2>Transnational issues</h2>

    <xsl:apply-templates select="refugees_and_iternally_displaced_persons/stateless_persons"/>
    <xsl:apply-templates select="illicit_drugs"/>
  </xsl:template>

  <xsl:template match="stateless_persons">
    <h3>Stateless persons</h3>

    <div>
      Total: <xsl:value-of select="people"/>
    </div>
  </xsl:template>

  <xsl:template match="illicit_drugs">
    <h3>Illicit drugs</h3>

    <div>
      <xsl:value-of select="note"/>
    </div>
  </xsl:template>

  <!-- Universal -->

  <xsl:template match="cubic_metres">
    <span>
      <xsl:value-of select="."/>
      m3
    </span>
  </xsl:template>
  <xsl:template match="kWh">
    <span>
      <xsl:value-of select="."/>
      kWh
    </span>
  </xsl:template>
  <xsl:template match="bbl_per_day">
    <span>
      <xsl:value-of select="."/>
      bbl/day
    </span>
  </xsl:template>

  <xsl:template match="geographic_coordinates">
    <div>
      <span style="font-weight: bold">
        Coordinates:
      </span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="longitude|latitude">
    <span>
      <xsl:apply-templates/>
    </span>
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
    <span>
      (Global rank: <xsl:value-of select="."/>)
    </span>
  </xsl:template>

  <xsl:template match="production">
    <div>
      Production:
      <xsl:apply-templates select="* except date"/>
    </div>
  </xsl:template>
  <xsl:template match="consumption">
    <div>
      Consumption:
      <xsl:apply-templates select="* except date"/>
    </div>
  </xsl:template>

  <xsl:template match="internet/country_code">
    <div>
      <span style="font-weight: bold">
        Top level domain (TLD):
      </span>
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <xsl:template match="total[length and units]">
    <span>
      Total:
      <xsl:value-of select="length"/>
      <xsl:value-of select="units"/>
    </span>
  </xsl:template>
  <xsl:template match="total[value and units]">
    <span>
      Total:
      <xsl:value-of select="value"/>
      <xsl:value-of select="units"/>
    </span>
  </xsl:template>

</xsl:stylesheet>
