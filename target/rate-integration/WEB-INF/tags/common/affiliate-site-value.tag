<%@include file="taglibs.tagf" %>
<%@tag description="Fecth a value from the my_affiliate_site table for display purposes." body-content="empty" %>
<%@attribute name="affiliateSite" required="true" type="za.co.axon.venus.core.AffiliateSite" %>
<%@attribute name="siteKey1" required="true" type="java.lang.String"  %>
<%@attribute name="siteKey2" required="true" type="java.lang.String"  %>
<%@attribute name="defaultValue" required="false"  type="java.lang.String" %>

<c:if test="${empty defaultValue}">
	<c:set var="defaultValue" value="[NO_DEFAULT_VALUE]"/>
</c:if>
<%
	String value = affiliateSite.getAffiliateSiteValue(siteKey1+"-"+siteKey2,defaultValue);
	boolean showSiteLabelNames = "true".equals(request.getHeader("showSiteLabelNames"));

	if (showSiteLabelNames)
		value = "AffSite[class='" + siteKey1 + "', name='" + siteKey2 + "', defaultValue='" + defaultValue + "', currentValue='" + value + "']";
	out.print(value);
%>
