<%@include file="taglibs.tagf" %>

<%@attribute name="listToFormat" required="true" type="java.util.List" description="The list of objects to format into normal display."%>
<%@attribute name="defaultLinkUrl" required="true" type="java.lang.String" description="The default page to link to if the link item does not link somewhere." %>

<c:set var="linkStarted" value="false" />
<c:set var="boldStarted" value="false" />
<%@attribute name="disableLinks" required="false" type="java.lang.Boolean" description="Set this as true and it will not show hyperlinks" %>


<c:forEach begin="0" end="${fn:length(listToFormat)}" step="1" var="curItem">
	<c:choose>
		<c:when test="${listToFormat[curItem] == 'LINE'}">
			<all:br />
		</c:when>
		<c:when test="${(listToFormat[curItem] == 'LINK') || (fn:substringBefore(listToFormat[curItem], ':') == 'LINK')}">
			<c:set var="linkStarted" value="true" />
			<c:set var="linkAnchor" value="${fn:substringAfter(listToFormat[curItem], ':')}" />
			<c:if test="${empty linkAnchor}">
				<c:set var="linkAnchor" value="${defaultLinkUrl}" />
			</c:if>
		</c:when>
		<c:when test="${linkStarted && empty linkText}">
			<c:set var="linkText" value="${listToFormat[curItem]}" />
		</c:when>
		<c:when test="${listToFormat[curItem] == 'UNLINK'}">
			<c:set var="linkStarted" value="false" />

			<c:if test="${!empty linkAnchor && !empty linkText}">
				<c:if test="${!disableLinks}">
					<all:link href="${linkAnchor}">${linkText}</all:link>
				</c:if>
				<c:if test="${disableLinks}">
					${linkText}
				</c:if>
			</c:if>

			<c:set var="linkAnchor" value="" />
			<c:set var="linkText" value="" />
		</c:when>
		<c:when test="${listToFormat[curItem] == 'BOLD'}">
			<c:set var="boldStarted" value="true"/>
		</c:when>
		<c:when test="${boldStarted && empty boldText}">
			<c:set var="boldText" value="${listToFormat[curItem]}" />
		</c:when>
		<c:when test="${listToFormat[curItem] == 'UNBOLD'}">
			<c:set var="boldStarted" value="false"/>

			<c:if test="${!empty boldText}">
				<all:bold>${boldText}</all:bold>
			</c:if>

			<c:set var="boldText" value="" />
		</c:when>
		<c:otherwise>
			${listToFormat[curItem]}
		</c:otherwise>
	</c:choose>
</c:forEach>


