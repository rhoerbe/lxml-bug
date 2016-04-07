<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xalan" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata" md:dummy-for-xmlns="" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" ds:dummy-for-xmlns="" xmlns:rpi="urn:oasis:names:tc:SAML:metadata:rpi" rpi:dummy-for-xmlns="" xmlns:mdui="urn:oasis:names:tc:SAML:metadata:ui" mdui:dummy-for-xmlns="" xmlns:alg="urn:oasis:names:tc:SAML:metadata:algsupport" alg:dummy-for-xmlns="" xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion" saml:dummy-for-xmlns="" xmlns:idpdisc="urn:oasis:names:tc:SAML:profiles:SSO:idp-discovery-protocol" idpdisc:dummy-for-xmlns="" xmlns:mdattr="urn:oasis:names:tc:SAML:metadata:attribute" mdattr:dummy-for-xmlns="" xmlns:init="urn:oasis:names:tc:SAML:profiles:SSO:request-init" init:dummy-for-xmlns="" version="1.0">
<!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<axsl:param name="archiveDirParameter"/>
<axsl:param name="archiveNameParameter"/>
<axsl:param name="fileNameParameter"/>
<axsl:param name="fileDirParameter"/>

<!--PHASES-->


<!--PROLOG-->
<axsl:output method="text"/>
<axsl:template name="xpathgetter">
<axsl:variable select="name()" name="name"/>
<axsl:apply-templates mode="xpathgetter" select="parent::*"/>/<axsl:value-of select="$name"/>[<axsl:value-of select="count(preceding-sibling::*[name() = $name]) + 1"/>]
   </axsl:template>
<axsl:template mode="xpathgetter" match="*">
<axsl:call-template name="xpathgetter"/>
</axsl:template>

<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template mode="schematron-select-full-path" match="*">
<axsl:apply-templates mode="schematron-get-full-path" select="."/>
</axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template mode="schematron-get-full-path" match="*">
<axsl:apply-templates mode="schematron-get-full-path" select="parent::*"/>
<axsl:text>/</axsl:text>
<axsl:choose>
<axsl:when test="namespace-uri()=''">
<axsl:value-of select="name()"/>
<axsl:variable select="1+    count(preceding-sibling::*[name()=name(current())])" name="p_1"/>
<axsl:if test="$p_1&gt;1 or following-sibling::*[name()=name(current())]">[<axsl:value-of select="$p_1"/>]</axsl:if>
</axsl:when>
<axsl:otherwise>
<axsl:text>*[local-name()='</axsl:text>
<axsl:value-of select="local-name()"/>
<axsl:text>' and namespace-uri()='</axsl:text>
<axsl:value-of select="namespace-uri()"/>
<axsl:text>']</axsl:text>
<axsl:variable select="1+   count(preceding-sibling::*[local-name()=local-name(current())])" name="p_2"/>
<axsl:if test="$p_2&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<axsl:value-of select="$p_2"/>]</axsl:if>
</axsl:otherwise>
</axsl:choose>
</axsl:template>
<axsl:template mode="schematron-get-full-path" match="@*">
<axsl:text>/</axsl:text>
<axsl:choose>
<axsl:when test="namespace-uri()=''">@<axsl:value-of select="name()"/>
</axsl:when>
<axsl:otherwise>
<axsl:text>@*[local-name()='</axsl:text>
<axsl:value-of select="local-name()"/>
<axsl:text>' and namespace-uri()='</axsl:text>
<axsl:value-of select="namespace-uri()"/>
<axsl:text>']</axsl:text>
</axsl:otherwise>
</axsl:choose>
</axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<axsl:template mode="schematron-get-full-path-2" match="node() | @*">
<axsl:for-each select="ancestor-or-self::*">
<axsl:text>/</axsl:text>
<axsl:value-of select="name(.)"/>
<axsl:if test="preceding-sibling::*[name(.)=name(current())]">
<axsl:text>[</axsl:text>
<axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
<axsl:text>]</axsl:text>
</axsl:if>
</axsl:for-each>
<axsl:if test="not(self::*)">
<axsl:text/>/@<axsl:value-of select="name(.)"/>
</axsl:if>
</axsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<axsl:template mode="generate-id-from-path" match="/"/>
<axsl:template mode="generate-id-from-path" match="text()">
<axsl:apply-templates mode="generate-id-from-path" select="parent::*"/>
<axsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/>
</axsl:template>
<axsl:template mode="generate-id-from-path" match="comment()">
<axsl:apply-templates mode="generate-id-from-path" select="parent::*"/>
<axsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/>
</axsl:template>
<axsl:template mode="generate-id-from-path" match="processing-instruction()">
<axsl:apply-templates mode="generate-id-from-path" select="parent::*"/>
<axsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/>
</axsl:template>
<axsl:template mode="generate-id-from-path" match="@*">
<axsl:apply-templates mode="generate-id-from-path" select="parent::*"/>
<axsl:value-of select="concat('.@', name())"/>
</axsl:template>
<axsl:template priority="-0.5" mode="generate-id-from-path" match="*">
<axsl:apply-templates mode="generate-id-from-path" select="parent::*"/>
<axsl:text>.</axsl:text>
<axsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/>
</axsl:template>
<!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<axsl:template mode="schematron-get-full-path-3" match="node() | @*">
<axsl:for-each select="ancestor-or-self::*">
<axsl:text>/</axsl:text>
<axsl:value-of select="name(.)"/>
<axsl:if test="parent::*">
<axsl:text>[</axsl:text>
<axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/>
<axsl:text>]</axsl:text>
</axsl:if>
</axsl:for-each>
<axsl:if test="not(self::*)">
<axsl:text/>/@<axsl:value-of select="name(.)"/>
</axsl:if>
</axsl:template>

<!--MODE: GENERATE-ID-2 -->
<axsl:template mode="generate-id-2" match="/">U</axsl:template>
<axsl:template priority="2" mode="generate-id-2" match="*">
<axsl:text>U</axsl:text>
<axsl:number count="*" level="multiple"/>
</axsl:template>
<axsl:template mode="generate-id-2" match="node()">
<axsl:text>U.</axsl:text>
<axsl:number count="*" level="multiple"/>
<axsl:text>n</axsl:text>
<axsl:number count="node()"/>
</axsl:template>
<axsl:template mode="generate-id-2" match="@*">
<axsl:text>U.</axsl:text>
<axsl:number count="*" level="multiple"/>
<axsl:text>_</axsl:text>
<axsl:value-of select="string-length(local-name(.))"/>
<axsl:text>_</axsl:text>
<axsl:value-of select="translate(name(),':','.')"/>
</axsl:template>
<!--Strip characters-->
<axsl:template priority="-1" match="text()"/>

<!--SCHEMA METADATA-->
<axsl:template match="/">
<axsl:apply-templates mode="M10" select="/"/>
</axsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN Rule04-->


	<!--RULE -->
<axsl:template mode="M10" priority="1001" match="//md:IDPSSODescriptor">

		<!--ASSERT -->
<axsl:choose>
<axsl:when test="md:KeyDescriptor[@use='signing' or not(@use)]/ds:KeyInfo/ds:X509Data/ds:X509Certificate"/>
<axsl:otherwise>
<axsl:message>
    Error (04): Each IDPSSODescriptor must contain a signing key as X509Certificate (child element of X509Data)
             XPATH: <axsl:call-template name="xpathgetter"/> validation rule: (md:KeyDescriptor[@use='signing' or not(@use)]/ds:KeyInfo/ds:X509Data/ds:X509Certificate)</axsl:message>
</axsl:otherwise>
</axsl:choose>
<axsl:apply-templates mode="M10" select="*|comment()|processing-instruction()"/>
</axsl:template>

	<!--RULE -->
<axsl:template mode="M10" priority="1000" match="//md:SPSSODescriptor">

		<!--ASSERT -->
<axsl:choose>
<axsl:when test="descendant::ds:X509Data/ds:X509Certificate"/>
<axsl:otherwise>
<axsl:message>
    Error (04): Each SPSSODescriptor must contain a signing key as X509Certificate (child element of X509Data)
             XPATH: <axsl:call-template name="xpathgetter"/> validation rule: (descendant::ds:X509Data/ds:X509Certificate)</axsl:message>
</axsl:otherwise>
</axsl:choose>
<axsl:apply-templates mode="M10" select="*|comment()|processing-instruction()"/>
</axsl:template>
<axsl:template mode="M10" priority="-1" match="text()"/>
<axsl:template mode="M10" priority="-2" match="@*|node()">
<axsl:apply-templates mode="M10" select="*|comment()|processing-instruction()"/>
</axsl:template>
</axsl:stylesheet>
