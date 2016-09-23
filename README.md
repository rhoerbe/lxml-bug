## Purpose

Document a bug where lxml 3.6.0 fails to process a textnode in a xsl:message element when it start
with a newline. xsltproc does not exhibit this behavior.

## Log

create style sheets with xsltproc.  

    xsltproc lib/message.xsl rule04E_complete.sch > rule04E.xsl

1. Calling from xsltproc yields the expected result: 

    xsltproc rule04E.xsl testdata/rule4_test1_idp_missing_key.xml

    ERROR
    Error (04): Each IDPSSODescriptor must contain a signing key as X509Certificate (child element of X509Data) 
        XPATH: /md:EntityDescriptor[1] /md:IDPSSODescriptor[1] 
        validation rule: (md:KeyDescriptor[@use='signing' or not(@use)]/ds:KeyInfo/ds:X509Data/ds:X509Certificate)
    Error (04): Each IDPSSODescriptor must contain a signing key as X509Certificate (child element of X509Data) XPATH: /md:EntityDescriptor[1] /md:IDPSSODescriptor[1] validation rule: (md:KeyDescriptor[@use='signing' or not(@use)]/ds:KeyInfo/ds:X509Data/ds:X509Certificate)


2. Calling from lxml yields "unknown error", but is OK if the newline before the textnode is removed

    perl -pe "chomp if /<axsl:message>/" rule04E.xsl > rule04E_OK.xsl
    python demo.py 
 