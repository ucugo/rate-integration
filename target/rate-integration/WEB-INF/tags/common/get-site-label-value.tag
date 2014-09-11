<%@tag body-content="empty" %>
<%@include file="taglibs.tagf" %>
<%@include file="get-site-label-value.tagf" %>
<c:set var="value" value="<%=value %>" />
<c:if test="${escapeXML}">
	<c:set var="value" value="${fn:escapeXml(value)}" />
</c:if>


