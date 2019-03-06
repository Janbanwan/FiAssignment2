<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" >
<xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
<xsl:template match="/">
	
	<xsl:variable name="delimiter">;</xsl:variable>
	
	<xsl:variable name="InvoiceTypeCode" select="//InvoiceDetails/InvoiceTypeCode"></xsl:variable>
	<xsl:variable name="AmountCurrencyIdentifier" select="//InvoiceDetails/InvoiceTotalVatExcludedAmount/@AmountCurrencyIdentifier"></xsl:variable>
	<xsl:variable name="BuyerPartyIdentifier" select="//BuyerPartyDetails/BuyerPartyIdentifier"></xsl:variable>
	<xsl:variable name="DeliveryOrganisationName" select="//DeliveryPartyDetails/DeliveryOrganisationName"></xsl:variable>
	<xsl:variable name="PaymentOverDueFinePercent" select="//InvoiceDetails/PaymentTermsDetails/PaymentOverDueFineDetails/PaymentOverDueFinePercent"></xsl:variable>
	<xsl:variable name="InvoiceDate" select="//InvoiceDetails/InvoiceDate"></xsl:variable>
	<xsl:variable name="FormattedInvoiceDate" select="concat(substring($InvoiceDate,7),'.',substring($InvoiceDate,5,2),'.',substring($InvoiceDate,1,4))"></xsl:variable>
	<xsl:variable name="InvoiceFreeText" select="//InvoiceDetails/InvoiceFreeText"></xsl:variable>
	
	<xsl:variable name="BuyerPostalAddressDetails" select="//BuyerPartyDetails/BuyerPostalAddressDetails"></xsl:variable>
	<xsl:variable name="BuyerPostalAddress" select="concat(//BuyerPartyDetails/BuyerOrganisationName,'\',
																$BuyerPostalAddressDetails/BuyerStreetName,'\',
																$BuyerPostalAddressDetails/BuyerTownName,'\',
																$BuyerPostalAddressDetails/BuyerPostCodeIdentifier,'\',
																$BuyerPostalAddressDetails/CountryCode)"></xsl:variable>
														
	<xsl:variable name="DeliveryPostalAddressDetails" select="//DeliveryPartyDetails/DeliveryPostalAddressDetails"></xsl:variable>
	<xsl:variable name="DeliveryPostalAddress" select="concat(//DeliveryPartyDetails/DeliveryOrganisationName,'\',
																$DeliveryPostalAddressDetails/DeliveryStreetName,'\',
																$DeliveryPostalAddressDetails/DeliveryTownName,'\',
																$DeliveryPostalAddressDetails/DeliveryPostCodeIdentifier,'\',
																$DeliveryPostalAddressDetails/CountryCode)"></xsl:variable>
																
																
	<xsl:value-of select="concat($InvoiceTypeCode,$delimiter,$AmountCurrencyIdentifier,$delimiter,$delimiter,$delimiter,
								 $BuyerPartyIdentifier,$delimiter,$delimiter,
								 $DeliveryOrganisationName,$delimiter,$delimiter,$delimiter,$delimiter,$delimiter,
								 $PaymentOverDueFinePercent,$delimiter,
								 $FormattedInvoiceDate,$delimiter,$delimiter,$delimiter,$delimiter,
								 $BuyerPostalAddress,$delimiter,
								 $DeliveryPostalAddress,$delimiter,
								 $InvoiceFreeText)"/>

	
	<xsl:for-each select="//InvoiceRow">
		<xsl:variable name="QuantityUnitCode" select="OrderedQuantity/@QuantityUnitCode"></xsl:variable>
		<xsl:text>&#xA;</xsl:text>
		<xsl:value-of select="concat($delimiter,ArticleName,$delimiter,ArticleIdentifier,$delimiter,OrderedQuantity,$delimiter,$QuantityUnitCode,$delimiter,UnitPriceAmount,$delimiter,$delimiter,RowVatRatePercent)"/>
	</xsl:for-each>
	
</xsl:template>
</xsl:stylesheet>