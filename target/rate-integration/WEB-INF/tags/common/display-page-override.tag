<%@tag import="java.net.URL"%>
<%@include file="taglibs.tagf" %>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="cache" %>

<%@tag description="Will either render template page or std one" body-content="empty" %>
<%@attribute name="pagename" required="true" type="java.lang.String"  %>

<c:set var="newPageName" value="/${requestScope.m_s_displaypath}/${requestScope.m_s_template}/${pagename}_${m_s_displaytype}${requestScope.m_s_template}.jsp" scope="page" />
<c:set var="fallbackPage" value="/${requestScope.m_s_displaypath}/std/${pagename}_xstd.jsp" scope="page"/>
<c:set var="showNewPage">
	<cache:cache key="${newPageName}" duration="300" scope="application">
		<cache:addgroups groups="dispatch"/>
		<%
			String filePath = (String)jspContext.getAttribute("newPageName");
			URL fileURL = ((PageContext) jspContext).getServletContext().getResource(filePath);
			out.print(fileURL != null);
		%>
	</cache:cache>
</c:set>
<c:if test="${showNewPage}">
	<jsp:include page="${newPageName}" flush="true"/>
</c:if>
<c:if test="${!showNewPage}">
    <jsp:include page="${fallbackPage}" flush="true"/>
</c:if>