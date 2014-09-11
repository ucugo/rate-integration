<%@ include file="taglibs.tagf" %>
<%@ attribute name="pml" fragment="true"  %>
<%@ attribute name="xhtml" fragment="true" %>
<%@ attribute name="xwall" fragment="true" %>
<%@ attribute name="mxit" fragment="true" %>
<%@ attribute name="jqm" fragment="true" %>

<c:choose>
	<c:when test="${requestScope.m_s_template=='pml'}">
		<jsp:invoke fragment="pml"/>
	</c:when>
	<c:when test="${requestScope.m_s_template=='xhtml'}">
		<jsp:invoke fragment="xhtml"/>
	</c:when>
	<c:when test="${requestScope.m_s_template=='mxit'}">
		<jsp:invoke fragment="mxit"/>
	</c:when>
	<c:when test="${requestScope.m_s_template=='std'}">
		<jsp:invoke fragment="xwall"/>
	</c:when>
	<c:when test="${requestScope.m_s_template=='jqm'}">
		<jsp:invoke fragment="jqm"/>
	</c:when>
	<c:otherwise></c:otherwise>
</c:choose>
