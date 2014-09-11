<%@include file="taglibs.tagf" %>
<%@ tag body-content="empty"%>
<%@ tag import="za.co.axon.venus.utils.PaginatedList"%>

<%@attribute name="firstPage" required="false" type="java.lang.String" %>
<%@attribute name="previousPage" required="false" type="java.lang.String" %>
<%@attribute name="nextPage" required="false" type="java.lang.String" %>
<%@attribute name="lastPage" required="false" type="java.lang.String" %>
<%@attribute name="curPageNum" required="true" type="java.lang.Integer"%>
<%@attribute name="lastPageNum" required="true" type="java.lang.Integer"%>

<c:if test="${lastPageNum > 1}">
	<c:if test="${display.width ge 320}">
		<c:set var="hd_size" value="_hd" />
	</c:if>

	<c:set var="gotoPrevText"><comp:evrest-site-icon defaultImage="/icons/local/site/rollbar_prev_black.gif" iconId="rollbar_prev${hd_size}" userManager="${um}" altText="<"/></c:set>
	<c:set var="gotoNextText"><comp:evrest-site-icon defaultImage="/icons/local/site/rollbar_next_black.gif" iconId="rollbar_next${hd_size}" userManager="${um}" altText=">"/></c:set>


	<c:set var="noJump" value="${empty firstPage && empty lastPage}" />

	<c:if test="${!noJump}">
		<c:set var="gotoFirstText"><comp:evrest-site-icon defaultImage="/icons/local/site/rollbar_first_black.gif" iconId="rollbar_first${hd_size}" userManager="${um}" altText="<<"/></c:set>
		<c:set var="gotoLastText"><comp:evrest-site-icon defaultImage="/icons/local/site/rollbar_last_black.gif" iconId="rollbar_last${hd_size}" userManager="${um}" altText=">>"/></c:set>
	</c:if>

	<c:if test="${!noJump && !empty firstPage}">
		<all:link href="${firstPage}">
			${gotoFirstText}
		</all:link>
	</c:if>
	<common:nbsp/>
	<c:if test="${!empty previousPage}">
		<all:link href="${previousPage}">
			${gotoPrevText}
		</all:link>
		<common:nbsp/>
	</c:if>
	<all:bold>
		<common:inline-label label="gen_evrest_roll_bar_page" defaultValue="Page"/>
		<common:nbsp />
		${curPageNum}
		<common:inline-label label="gen_evrest_roll_bar_seperator" defaultValue="/"/>
		${lastPageNum }
		<common:nbsp/>
	</all:bold>
	<c:if test="${!empty nextPage}">
		<all:link href="${nextPage}">
			${gotoNextText}
		</all:link>
		<common:nbsp/>
	</c:if>
	<c:if test="${!noJump && !empty lastPage}">
		<all:link href="${lastPage}">
			${gotoLastText}
		</all:link>
	</c:if>
	<all:br/>
</c:if>