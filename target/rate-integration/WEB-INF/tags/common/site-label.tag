<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<%@tag dynamic-attributes="params" %>
<%@ attribute name="label" required="true" type="java.lang.String" %>
<%@ attribute name="defaultValue" required="false" type="java.lang.String" %>
<%@ variable name-given="value" %>

<%@include file="get-site-label-value.tagf" %>

<%
	jspContext.setAttribute("value", value);
	if (!StringUtils.isBlank(value)) {
%>
<jsp:doBody />
<% } %>
