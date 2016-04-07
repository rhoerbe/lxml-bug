## Purpose

Document a bug where lxml 3.6.0 behaves differently to xsltproc

## Log

create style sheets with 3 methods: (1) xsltproc (2) jxerces and (3) format xsltproc output with oxygen

    xsltproc lib/message.xsl rule04E_complete.sch > rule04E_xsltproc.xsl
    java -jar xalan-j_2_7_2/xalan.jar -OUT rule04E_jxerces.xsl -IN rule04E_complete.sch -XSL lib/message.xsl

result is OK when called from xsltproc (the ERROR message is correct!):

    xsltproc rule04E_xsltproc.xsl testdata/rule4_test1_idp_missing_key.xml

    ERROR
    Error (04): Each IDPSSODescriptor must contain a signing key as X509Certificate (child element of X509Data) 
        XPATH: /md:EntityDescriptor[1] /md:IDPSSODescriptor[1] 
        validation rule: (md:KeyDescriptor[@use='signing' or not(@use)]/ds:KeyInfo/ds:X509Data/ds:X509Certificate)
    Error (04): Each IDPSSODescriptor must contain a signing key as X509Certificate (child element of X509Data) XPATH: /md:EntityDescriptor[1] /md:IDPSSODescriptor[1] validation rule: (md:KeyDescriptor[@use='signing' or not(@use)]/ds:KeyInfo/ds:X509Data/ds:X509Certificate)


result is weongwhen called from lxml, using either style sheet (1) or (2): it prints "OK" instead of ERROR

    python src/validate.py testdata/rule4_test1_idp_missing_key.xml rule04E_xsltproc.xsl 

result is OK when called from lxml, using style sheet (3)

    python src/validate.py testdata/rule4_test1_idp_missing_key.xml rule04E_oxygen.xsl 
 