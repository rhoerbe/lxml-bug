import lxml.etree as etree

def process(xsl):
    with open(xsl) as fd:
        transform = etree.XSLT(etree.XML(''.join(fd.readlines())))
    with open('testdata.xml') as fd:
        md_dom = etree.parse(fd)
    unused_result = (transform(md_dom))   # the expected result is in the error log!
    print(str(transform.error_log).
          replace('<string>:0:0:ERROR:XSLT:ERR_OK:', ''))

print('NOK: process with newline after xsl:message results in "unknown error" and missing log output')
process('rule04E.xsl')
print('\n\nOK: process without newline after xsl:message results expected error message in log output')
process('rule04E_OK.xsl')