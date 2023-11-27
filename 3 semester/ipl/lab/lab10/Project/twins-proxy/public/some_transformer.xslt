<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <xsl:if test="output/input">
    <div><xsl:value-of select="output/input"/></div>
  </xsl:if>

  <table border="1">
      <tr bgcolor="#9933ff">
        <th>1</th>
        <th>2</th>
      </tr>
      <xsl:for-each select="catalog/cd">
      <tr>
        <td><xsl:value-of select="id"/></td>
        <td><xsl:value-of select="item"/></td>
      </tr>
      </xsl:for-each>
    </table>
</xsl:template>
</xsl:stylesheet>
