<%@include file="taglibs.tagf" %>

<%@attribute name="picId" type="java.lang.String" required="true"%>
<%@attribute name="linkTextSingular" type="java.lang.String" required="false"%>
<%@attribute name="linkTextPlural" type="java.lang.String" required="false"%>
<%@attribute name="likeCount" type="java.lang.Integer" required="true"%>

<c:choose>
	<c:when test="${likeCount <= 0}">
		<c:choose>
			<c:when test="${empty linkTextPlural }">
				(0)
			</c:when>
			<c:otherwise>
				${likeCount}
				<common:nbsp/>
				${linkTextPlural}
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:when test="${likeCount eq 1 }">
		<common:nbsp/>
		<c:url var="likePage" value="view_likes.jsp?picId=${picId}" />
		<c:choose>
			<c:when test="${empty linkTextSingular}">
				<all:link href="${likePage}">
					(${likeCount})
				</all:link>
			</c:when>
			<c:otherwise>
				${likeCount}
				<common:nbsp/>
				<all:link href="${likePage}">
					${linkTextSingular}
				</all:link>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<common:nbsp/>
		<c:url var="likePage" value="view_likes.jsp?picId=${picId}" />
		<c:choose>
			<c:when test="${empty linkTextPlural}">
				<all:link href="${likePage}">
					(${likeCount})
				</all:link>
			</c:when>
			<c:otherwise>
				${likeCount}
				<common:nbsp/>
				<all:link href="${likePage}">
					${linkTextPlural}
				</all:link>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>