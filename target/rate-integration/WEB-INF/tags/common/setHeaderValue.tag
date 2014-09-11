<%@include file="taglibs.tagf" %>
<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@attribute name="name" type="java.lang.String" required="true"%>
<%@attribute name="value" type="java.lang.String" required="true"%>
<c:if test="${header.debugShowPageForwards}">
	<%
	response.addHeader(String.valueOf(jspContext.getAttribute("name")), String.valueOf(jspContext.getAttribute("value")));
	%>
</c:if>