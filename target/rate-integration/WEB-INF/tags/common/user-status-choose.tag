<%@include file="taglibs.tagf" %>
<%@attribute name="canChat" fragment="true" %>
<%@attribute name="noChat" fragment="true" %>
<%@attribute name="notLoggedOn" fragment="true" %>
<%@attribute name="needResubscribe" fragment="true" %>
<%@attribute name="notRegistered" fragment="true" %>
<%@attribute name="pendingSubscription" fragment="true" %>
<%@tag import="java.util.ArrayList"%>

<c:choose>

	<%-- Not logged on --%>
	<c:when test="${ !userStatus.loggedIn && userStatus.registered && userStatus.subscribed }">
		<jsp:invoke fragment="noChat"/>
		<jsp:invoke fragment="notLoggedOn"/>
	</c:when>

	<%-- Pending subscription --%>
	<c:when test="${!userStatus.allowedAccessForPendingBill}">
		<jsp:invoke fragment="pendingSubscription"/>
	</c:when>

	<%-- Unsubscribed, needs to re-subscribe --%>
	<c:when test="${userStatus.unsubscribed}">
		<jsp:invoke fragment="noChat"/>
		<jsp:invoke fragment="needResubscribe"/>
	</c:when>

	<%-- Non registered user --%>
	<c:when test="${!userStatus.registered}">
		<jsp:invoke fragment="noChat"/>
		<jsp:invoke fragment="notRegistered"/>
	</c:when>

	<c:otherwise>
		<jsp:invoke fragment="canChat"/>
	</c:otherwise>

</c:choose>