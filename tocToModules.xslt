<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="UTF-8"/>
  <xsl:variable name="datatypes" as="element(datatypes)">
    <datatypes>
      <datatype page="Resource" name="Base Resource Definitions" noEx="Y" noMap="Y"/>
      <datatype page="DomainResource" name="DomainResource Resource" noEx="Y" noMap="Y"/>
      <datatype page="CanonicalResource" name="Resource CanonicalResource - Content" noEx="Y" noMap="Y" noConv="Y"/>
      <datatype page="MetadataResource" name="Resource MetadataResource - Content" noEx="Y" noMap="Y" noConv="Y"/>
      <datatype page="Datatypes" name="Datatypes" tab="Datatypes" isDt="Y"/>
      <datatype page="Dosage" name="Dosage" tab="Dosage Detail" isDt="Y"/>
      <datatype page="ElementDefinition" name="Element Definition" tab="ElementDefinition Detail" isDt="Y"/>
      <datatype page="MetaDatatypes" name="MetaDatatypes" tab="MetaDatatypes" isDt="Y"/>
      <datatype page="Reference" name="Resource References" tab="References" noEx="Y" noMap="Y" isDt="Y"/>
    </datatypes>
  </xsl:variable>
  <xsl:variable name="special" as="element(special)">
    <special>
      <resource page="Resource" name="Base Resource Definitions"/>
      <resource page="DomainResource" name="DomainResource Resource"/>
    </special>
  </xsl:variable>
	<xsl:variable name="phase1" as="element(pages)">
    <xsl:apply-templates mode="phase1" select="/table"/>
	</xsl:variable>
	<xsl:variable name="phase2" as="element(pages)">
    <pages>
      <xsl:apply-templates mode="phase2" select="$phase1/page[1]"/>
    </pages>
	</xsl:variable>
	<xsl:variable name="phase3" as="element(modules)">
    <modules>
      <xsl:for-each select="$phase2/page">
        <module name="{if (ends-with(@title, 'Module')) then substring-before(@title, ' Module') else @title}">
          <xsl:apply-templates mode="phase3" select="page"/>
        </module>
      </xsl:for-each>
    </modules>
	</xsl:variable>
	<xsl:template match="/">
    <xsl:text>{"resources": {</xsl:text>
    <xsl:variable name="foundationSection" select="substring-before($phase3/module[@name='Foundation']/resource[last()]/@section, '.')"/>
    <xsl:variable name="foundationSubSection" select="number(substring-before(substring-after($phase3/module[@name='Foundation']/resource[last()]/@section, '.'), '.'))"/>
    <xsl:value-of select="concat('&quot;extension-registry&quot;:{&quot;module&quot;:&quot;Foundation&quot;,&quot;section&quot;:&quot;', $foundationSection, '.', $foundationSubSection+1,
        '&quot;},&quot;conversion-registry&quot;:{&quot;module&quot;:&quot;Foundation&quot;,&quot;section&quot;:&quot;', $foundationSection, '.', $foundationSubSection+2,
        '&quot;},&quot;search-params&quot;:{&quot;module&quot;:&quot;Foundation&quot;,&quot;section&quot;:&quot;', $foundationSection, '.', $foundationSubSection+3,
        '&quot;},')"/>
    <xsl:for-each select="$phase3/module/resource">
      <xsl:value-of select="concat('&quot;', @title, '&quot;:{&quot;module&quot;:&quot;', parent::module/@name, '&quot;,&quot;section&quot;:&quot;')"/>
      <xsl:choose>
        <xsl:when test="@inDt='Y'">
          <xsl:variable name="precedingDt" select="count(preceding-sibling::*[@inDt='Y'])"/>
          <xsl:for-each select="parent::module/resource[@title='Datatypes']">
            <xsl:variable name="sectionParts" select="tokenize(@section2, '\.')"/>
            <xsl:variable name="sectionBase" select="string-join($sectionParts[position()!=last()], '.')"/>
            <xsl:variable name="sectionLast" select="$sectionParts[position()=last()]"/>
            <xsl:variable name="section" select="concat($sectionBase, '.', number($sectionLast) + $precedingDt + 1)"/>
            <xsl:value-of select="concat($section, '.1&quot;,&quot;section2&quot;:&quot;', $section, '.2')"/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(@section, '&quot;,&quot;section2&quot;:&quot;', @section2)"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@noEx='Y'">
        <xsl:text>","noEx":"Y</xsl:text>
      </xsl:if>
      <xsl:if test="@noMap='Y'">
        <xsl:text>","noMap":"Y</xsl:text>
      </xsl:if>
      <xsl:if test="@noConv='Y'">
        <xsl:text>","noConv":"Y</xsl:text>
      </xsl:if>
      <xsl:if test="@inDoc='Y'">
        <xsl:text>","inDoc":"Y</xsl:text>
      </xsl:if>
      <xsl:if test="@inDt='Y'">
        <xsl:text>","inDt":"Y</xsl:text>
      </xsl:if>
      <xsl:if test="@inFt='Y'">
        <xsl:text>","inFt":"Y</xsl:text>
      </xsl:if>
      <xsl:if test="@isDt='Y'">
        <xsl:text>","isDt":"Y</xsl:text>
      </xsl:if>
      <xsl:if test="@tab">
        <xsl:text>","tab":"</xsl:text>
        <xsl:value-of select="@tab"/>
      </xsl:if>
      <xsl:text>"}</xsl:text>
      <xsl:if test="position()!=last()">,</xsl:if>
    </xsl:for-each>
    <xsl:text>}}</xsl:text>
	</xsl:template>	
	<xsl:template mode="phase1" match="table">
    <pages>
      <xsl:for-each select="tr/td/a[not(@style) and not(starts-with(@title, 'CodeSystem') or starts-with(@title, 'ValueSet'))]">
        <page num="{substring-before(., ' ')}" title="{substring-after(., ' ')}"/>
      </xsl:for-each>
    </pages>
	</xsl:template>	
	<xsl:template mode="phase2" match="page">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:if test="exists(following-sibling::page[1][starts-with(@num, current()/@num)])">
        <xsl:variable name="matching" as="element(page)">
          <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates mode="match" select="following-sibling::page[1]">
              <xsl:with-param name="match" select="@num"/>
            </xsl:apply-templates>
          </xsl:copy>
        </xsl:variable>
        <xsl:apply-templates mode="phase2" select="$matching/page[1]"/>
      </xsl:if>
    </xsl:copy>
    <xsl:apply-templates mode="phase2" select="following-sibling::page[not(starts-with(@num, current()/@num))][1]"/>
	</xsl:template>
	<xsl:template mode="match" match="page">
    <xsl:param name="match"/>
    <xsl:if test="starts-with(@num, $match)">
      <xsl:copy-of select="."/>
      <xsl:apply-templates mode="match" select="following-sibling::page[1]">
        <xsl:with-param name="match" select="$match"/>
      </xsl:apply-templates>
    </xsl:if>
	</xsl:template>
	<xsl:template mode="phase3" match="page">
	  <xsl:param name="inDoc" select="false()"/>
	  <xsl:param name="inDt" select="false()"/>
	  <xsl:param name="inFt" select="false()"/>
    <xsl:if test="@title='Documentation Index'">
      <xsl:apply-templates mode="phase3" select="page">
        <xsl:with-param name="inDoc" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:if test="@title='Datatypes'">
      <xsl:apply-templates mode="phase3" select="page">
        <xsl:with-param name="inDoc" select="$inDoc"/>
        <xsl:with-param name="inDt" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:if test="@title='FHIR Type Framework'">
      <xsl:apply-templates mode="phase3" select="page">
        <xsl:with-param name="inDoc" select="$inDoc"/>
        <xsl:with-param name="inFt" select="true()"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:if test="(starts-with(@title, 'Resource ') and ends-with(@title, ' - Content')) or exists($datatypes/datatype[@name=current()/@title])">
      <xsl:variable name="num" select="if (page) then page[last()]/@num else concat(@num, '.12')"/>
      <xsl:variable name="nums" select="tokenize($num, '\.')"/>
      <xsl:variable name="prefix" select="string-join($nums[position()&lt;last()], '.')"/>
      <xsl:variable name="newNum" select="concat($prefix, '.', number($nums[last()])+1)"/>
      <xsl:variable name="newNum2" select="concat($prefix, '.', number($nums[last()])+2)"/>
      <resource title="{substring-before(substring-after(@title, 'Resource '), ' - Content')}">
        <!-- If we're already 4 deep in the hierarchy (ToC doesn't go deeper), then presume the last existing section is 12 - which is currently true for the type-framework resources -->
        <xsl:attribute name="section" select="$newNum"/>
        <xsl:attribute name="section2" select="$newNum2"/>
        <xsl:for-each select="$datatypes/datatype[@name=current()/@title]">
          <xsl:attribute name="title" select="@page"/>
          <xsl:copy-of select="@*[not(local-name(.)=('name', 'page'))]"/>
        </xsl:for-each>
        <xsl:if test="$inDoc">
          <xsl:attribute name="inDoc" select="'Y'"/>
        </xsl:if>
        <xsl:if test="$inDt">
          <xsl:attribute name="inDt" select="'Y'"/>
        </xsl:if>
        <xsl:if test="$inFt">
          <xsl:attribute name="inFt" select="'Y'"/>
        </xsl:if>
      </resource>
    </xsl:if>
	</xsl:template>
</xsl:stylesheet>
