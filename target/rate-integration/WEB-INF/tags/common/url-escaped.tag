<%@include file="taglibs.tagf" %>

<%@tag %>
<%@attribute name="url" required="true" type="java.lang.String" %>
<%@ variable name-given="valueUrl" %>

<c:set var="valueUrl" value="${fn:replace(url, 'amp;', '')}" />
<c:set var="valueUrl" value="${fn:replace(valueUrl, '&', '&amp;')}" />
<c:url var="valueUrl" value="${valueUrl}"/>	
<jsp:doBody/>