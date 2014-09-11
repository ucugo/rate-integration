<%@include file="taglibs.tagf" %>
<%@ tag description="Will display the body if the values are not equal"%>
<%@ attribute name="value" required="true" type="java.lang.String" %>
<%@ attribute name="compareTo" required="true" type="java.lang.String" %>
<%@ attribute name="comparison" required="true" type="java.lang.Boolean" %>

<c:set var="show">
	<c:choose>
		<c:when test="${comparison}">
			${value eq compareTo}
		</c:when>
		<c:otherwise>
			${value ne compareTo}
		</c:otherwise>
	</c:choose>
</c:set>

<c:if test="${show}">
	<jsp:doBody/>
</c:if>