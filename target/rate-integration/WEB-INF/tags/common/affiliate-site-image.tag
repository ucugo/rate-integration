<%@include file="taglibs.tagf" %>

<%@attribute name="affiliateSite" required="true" type="za.co.axon.venus.core.AffiliateSite" %>
<%@attribute name="affiliate_name" required="true" type="java.lang.String" %>
<%@attribute name="color" required="true" type="java.lang.String" %>
<%@attribute name="href" required="true"  type="java.lang.String" %>
<%@attribute name="altText" required="false"  type="java.lang.String" %>
<%@attribute name="genUrl" required="false" type="java.lang.Boolean" %>
<%@attribute name="defaultAffiliateIconPath" required="false" type="java.lang.String" %>

<%@attribute name="alignment" required="false" type="java.lang.String" description="left, right or middle" %>
<%@attribute name="imgWidth" required="false" type="java.lang.String" description="cant use 'width' name due to it being a request object declared in header.jsp"%>
<%@attribute name="height" required="false" type="java.lang.String" %>
<%@attribute name="style" required="false" type="java.lang.String" %>
<%@attribute name="hspace" required="false" type="java.lang.String" %>
<%@attribute name="id" required="false" type="java.lang.String" %>
<%@attribute name="vspace" required="false" type="java.lang.String" %>

<c:set var="iconBasePath">
	<c:if test="${not fn:startsWith(defaultAffiliateIconPath,'/')}"><c:set var="defaultAffiliateIconPath" value="/${defaultAffiliateIconPath}"/></c:if>
	<common:affiliate-site-value siteKey1="url" siteKey2="${affiliate_name}" affiliateSite="${affiliateSite}" defaultValue="${defaultAffiliateIconPath}"/>
</c:set>
<c:set var="iconPath">
	<c:if test="${not fn:startsWith(href,'/')}"><c:set var="href" value="/${href}"/></c:if>
	<common:format-replace-text param0="${color}" text="${iconBasePath}${href}" />
</c:set>
<c:if test="${empty altText}">
	<c:set var="altText" value="${href}"/>
</c:if>
<c:choose>
	<c:when test="${genUrl}">
		${iconPath}
	</c:when>
	<c:otherwise>
		<all:image href="${iconPath}" alt="${altText}" alignment="${alignment}" imgWidth="${imgWidth}" height="${height}" style="${style}" hspace="${hspace}" id="${id}" vspace="${vspace}"/>
	</c:otherwise>
</c:choose>
