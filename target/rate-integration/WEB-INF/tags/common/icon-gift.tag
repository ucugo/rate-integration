<%@include file="taglibs.tagf" %>
<%@ tag body-content="empty"%>
<%@attribute name="read" required="false" type="java.lang.Boolean" %>
<%@attribute name="useSecondary" required="false"  type="java.lang.Boolean" %>
<%@attribute name="bgColourOverride" required="false"  type="java.lang.String" %>

<c:choose>
	<c:when test="${read}">
		<comp:evrest-site-icon defaultImage="/icons/local/gifts/gift_read_transparent.gif" iconId="gift_read" userManager="${um}" altText="gift_read" useSecondary="${useSecondary }" transparent="true" bgColourOverride="${bgColourOverride}"/>
	</c:when>
	<c:otherwise>
		<comp:evrest-site-icon defaultImage="/icons/local/gifts/gift_unread_transparent.gif" iconId="gift_unread" userManager="${um}" altText="gift_unread" useSecondary="${useSecondary }" transparent="true" bgColourOverride="${bgColourOverride}"/>
	</c:otherwise>
</c:choose>
