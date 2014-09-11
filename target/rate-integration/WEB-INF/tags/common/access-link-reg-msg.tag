<%--
    Document   : access-link-reg-msg
    Created on : 09 Apr 2014, 3:32:14 PM
    Author     : Gavin Boshoff
--%>

<%@tag description="A convenience tag to handle the display message for users who need to login/subscribe/register" pageEncoding="UTF-8"%>
<%@include file="taglibs.tagf" %>

<%@attribute name="userManager" required="true" type="za.co.axon.venus.core.UserManager"%>

<c:choose>
	<c:when test="${!userStatusManager.registered}">
		<common:inline-label label="registerToChat" defaultValue="registerToChatDefault" />
	</c:when>
	<c:when test="${!userStatusManager.subscribed}">
		<common:inline-label label="subscribeToChat" defaultValue="subscribeToChatDefault" />
	</c:when>
	<c:otherwise>
		<common:inline-label label="loginToChat" defaultValue="loginToChatDefault" />
	</c:otherwise>
</c:choose>