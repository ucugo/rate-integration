<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@tag description="Fetches an array of obelix values." %>
<%@tag dynamic-attributes="params" %>
<%@ attribute name="label" required="true" type="java.lang.String" %>
<%@ attribute name="defaultValue" required="false" type="java.util.List" %>
<%@ variable name-given="valueList" variable-class="java.util.List" %>

<%@include file="get-site-label-values.tagf" %>

<%
	jspContext.setAttribute("valueList", valueList);
	if (valueList != null && valueList.size() >= 1) {
%>
<jsp:doBody />
<% } %>
