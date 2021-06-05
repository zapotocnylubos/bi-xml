<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

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
          <xsl:apply-templates mode="index"/>
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
          <h1>
            <xsl:value-of select="name"/>
          </h1>

          <h2>Introduction</h2>
          <xsl:apply-templates select="introduction"/>

          <h2>Geography</h2>
          <xsl:apply-templates select="geography"/>

          <h2>People</h2>
          <xsl:apply-templates select="people"/>

          <h2>Government</h2>
          <xsl:apply-templates select="government"/>

          <h2>Economy</h2>
          <xsl:apply-templates select="economy"/>

          <h2>Energy</h2>
          <xsl:apply-templates select="energy"/>

          <h2>Communications</h2>
          <xsl:apply-templates select="communications"/>

          <h2>Transportation</h2>
          <xsl:apply-templates select="transportation"/>

          <h2>Military and security</h2>
          <xsl:apply-templates select="military_and_security"/>

          <h2>Transnational issues</h2>
          <xsl:apply-templates select="transnational_issues"/>
        </body>

      </html>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="introduction">
    <p>
      <xsl:value-of select="background"/>
    </p>
  </xsl:template>

  <xsl:template match="location">
    <h3>Location</h3>
    <p>
      <xsl:value-of select="location"/>
    </p>
  </xsl:template>

  <xsl:template match="geographic_coordinates">
    <h4>Coordinates</h4>
    <xsl:for-each select="longitude|latitude">
    <p>
      <xsl:apply-templates select="current()" />
    </p>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="longitude|latitude">
    <xsl:apply-templates select="degrees" />
    <xsl:apply-templates select="minutes" />
    <xsl:apply-templates select="hemisphere" />
  </xsl:template>

  <xsl:template match="degrees">
      <xsl:value-of select="current()"/>°
  </xsl:template>

  <xsl:template match="minutes">
    <xsl:value-of select="current()"/>'
  </xsl:template>

  <xsl:template match="hemisphere">
    (<xsl:value-of select="current()"/>)
  </xsl:template>

</xsl:stylesheet>
