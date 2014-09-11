<%@ include file="taglibs.tagf" %>
<%@ tag body-content="empty" description="For the message interrupt system" %>
<jsp:useBean id="interruptService" class="rnd.application.interrupt.InterruptService" scope="application"/>

<%@tag import="org.apache.commons.collections.Predicate"%>

<c:choose>
	<c:when test="${not empty currentInterrupt}">
		<!-- Already fetched -->
	</c:when>
	<c:when test="${not empty interrupt_predicate}">
		<c:set var="currentInterrupt" scope="request" value='<%= interruptService.getInterrupt(request, (Predicate) request.getAttribute("interrupt_predicate"))%>'/>
	</c:when>
	<c:when test="${block_all_interrupts}">
		<c:set var="currentInterrupt" scope="request" value=""/>
	</c:when>
	<c:otherwise>
		<c:set var="currentInterrupt" scope="request" value="<%= interruptService.getInterrupt(request)%>"/>
	</c:otherwise>
</c:choose>
<c:if test="${not empty currentInterrupt}">
	<jsp:include page="/inc/interrupt_${m_s_template}/${currentInterrupt['class'].simpleName}.jsp"/>
</c:if>