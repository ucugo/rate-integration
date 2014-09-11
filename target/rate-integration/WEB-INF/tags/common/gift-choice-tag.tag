<%@include file="taglibs.tagf" %>
<%@ attribute name="um_other" required="true" type="java.lang.Object" %>
<%@ attribute name="picType" required="true" type="java.lang.String" %>

<%@ variable name-given="gift" %>

<jsp:useBean id="giftHelper" type="rnd.ui.web.helpers.GiftHelper" scope="application"/>

<c:choose>
	<c:when test="${picType eq 'icon'}">
		<c:set var="lTag" value="[!$"/>
		<c:set var="rTag" value="$!]"/>
	</c:when>
	<c:when test="${picType eq 'gift'}">
		<c:set var="lTag" value="[!@"/>
		<c:set var="rTag" value="@!]"/>
	</c:when>
	<c:otherwise>
		<c:set var="lTag" value="&lt;&lt;&lt;"/>
		<c:set var="rTag" value="&gt;&gt;&gt;"/>
	</c:otherwise>
</c:choose>

<c:set var="gift">
	<c:choose>
		<c:when test="${um_other.gender eq 'male'}">${giftHelper.maleGift.codes[0]}</c:when>
		<c:otherwise>${giftHelper.femaleGift.codes[0]}</c:otherwise>
	</c:choose>
</c:set>
<jsp:doBody/>

