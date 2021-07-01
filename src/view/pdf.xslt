<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:variable name="root-heading-size" select="26"/>
  <xsl:variable name="heading-step-size" select="4"/>

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

<!--  <xsl:template match="/sections/section">-->
<!--&lt;!&ndash;    <fo:block break-before="page"/>&ndash;&gt;-->

<!--    <xsl:apply-templates select="."/>-->
<!--  </xsl:template>-->

  <xsl:template match="section">
    <xsl:variable name="level" select="count(ancestor::section)"/>
    <xsl:variable name="heading-size" select="$root-heading-size - ($level * $heading-step-size)"/>



    <fo:block>
      <fo:block id="{@id}" font-size="{$heading-size}pt" font-weight="bold">
        <xsl:value-of select="@title"/>
      </fo:block>
    </fo:block>

    <xsl:apply-templates/>
  </xsl:template>

<!--  <xsl:template match="section">-->
<!--    <fo:block break-before="page">-->
<!--      <fo:block id="{@id}">-->
<!--        <xsl:value-of select="@title"/>-->
<!--      </fo:block>-->
<!--    </fo:block>-->
<!--    <xsl:apply-templates/>-->
<!--  </xsl:template>-->

  <xsl:template match="paragraph">
    <fo:block>
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <xsl:template match="glossary">
    <fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="glossary/term">
    <fo:block>
      <fo:inline font-weight="bold">
        <xsl:value-of select="@name"/>
      </fo:inline>
      :
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
