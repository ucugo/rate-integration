<%@tag dynamic-attributes="params" body-content="empty" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="all" tagdir="/WEB-INF/tags/all"%>
<%@taglib prefix="common" tagdir="/WEB-INF/tags/common" %>
<%@ taglib prefix="comp" tagdir="/WEB-INF/tags/component" %>
<%@tag import="org.springframework.web.bind.ServletRequestUtils"%>

<%@tag import="za.co.axon.venus.core.SiteLabelUtils"%>
<%@tag import="java.text.MessageFormat"%>
<%@tag import="za.co.axon.venus.core.SiteLabel"%>
<%@tag import="za.co.axon.venus.core.SiteLabel"%>

<%@attribute name="userRegistered" required="true" type="java.lang.Boolean" description="Boolean indicating whether the user is registered" %>
<%@attribute name="picId" required="true" type="java.lang.String" description="The ID of the picture to be liked" %>
<%@attribute name="likerId" required="true" type="java.lang.String" description="The ID of the user who wishes to like the picture" %>
<%@attribute name="hasLiked" required="true" type="java.lang.Boolean" description="Boolean indicating whether the user has liked the pic, this is used for display purposes" %>
<%@attribute name="align" required="false" type="java.lang.String" description="Image alignment type" %>

<c:if test="${userRegistered}">
	<c:choose>
		<c:when test="${not hasLiked}">
			<c:url var="likeLink" value="like_pic.jsp">
				<c:param name="picId" value="${picId}" />
				<c:param name="likerId" value="${likerId }" />
				<c:param name="backUrl"><common:current-url /></c:param>
			</c:url>
			<all:link href="${likeLink}">
				<comp:evrest-site-icon defaultImage="/icons/local/site/like_black.gif" iconId="mypics_like" userManager="${um}" altText="like" alignment="${align}"/>
			</all:link>
		</c:when>
		<c:otherwise>
			<comp:evrest-site-icon defaultImage="/icons/local/site/haslike_black.gif" iconId="mypics_haslike" userManager="${um}" altText="haslike" alignment="${align}"/>
		</c:otherwise>
	</c:choose>
	<common:nbsp/>
</c:if>