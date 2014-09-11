<%--
Back button process tag. Processes the current page into the back button object.
--%>

<%@include file="taglibs.tagf" %>
<%@tag import="rnd.ui.web.BackController"%>

<%@ attribute name="process" required="true" type="java.lang.Boolean" description="Whether or not to perform the processing action"%>
<%@ attribute name="display" required="true" type="java.lang.Boolean" description="Whether or not to perform the display action"%>
<%@ attribute name="override" required="true" type="java.lang.Boolean" description="Use override if you would like the back button to update with the latest parameters of a URL instead storing another instance of the URL e.g. in online.jsp we want to remember last visited page"%>
<%@ attribute name="processPostParams" required="true" type="java.lang.Boolean" description="Use processParams if you would like the back button to remember POST params as well" %>
<%@ attribute name="manualOverride" required="false" type="java.lang.String" description="e.g. manualOverride=index.jsp. Use manualOverride if you need to hardcode a value to go back to. Will disregard other logic. Not recommended." %>
<%@ attribute name="forceStackPop" required="false" type="java.lang.Boolean" description="Forces a stack pop. Used by pages that post to other pages e.g. gift shop" %>
<%@ attribute name="styleClass" required="false" type="java.lang.String" %>
<%@ attribute name="indexOverride" required="false" type="java.lang.String" description="Overrides the index page. By default reg users would go to menu and unreg users would go to rate." %>

<%
	//processing
	if(process){

		//back button
		BackController back=(BackController)session.getAttribute("back");
		if(back==null || back.isEmpty()){
			back=new BackController();
		}

		if(!StringUtils.isEmpty(indexOverride)){
			back.setIndexPage(indexOverride);
		}

		back.wentBack(request);

		if(manualOverride!=null){
			back.manualOverride(manualOverride);
		}
		else if(override){
			back.setUri(request, true, false);
		}
		else if(processPostParams){
			back.setUri(request, false, true);
		}
		else{
			back.setUri(request);
		}

		session.setAttribute("back",back);
	}
%>

<%--Display--%>

<%@tag import="org.apache.commons.lang.StringUtils"%><c:url value="${back.uri}" var="uri_back" scope="request"/>
<c:url value="index.jsp?view=menu" var="url_home" scope="request"/>
<c:if test="${display=='true'}">
	<common:renderDisplay>
		<jsp:attribute name="pml">
			<all:block>
				<all:link href="${uri_back}" accesskey="#"><common:inline-label label="gen_backbutton" defaultValue="Back" /></all:link>
			</all:block>
		</jsp:attribute>
		<jsp:attribute name="xwall">
			<all:block>
				<all:link href="${uri_back}" accesskey="#"><common:inline-label label="gen_backbutton" defaultValue="Back" /></all:link>
				| <all:link href="${url_home}"><common:inline-label label="gen_menu" defaultValue="Menu" /></all:link>
			</all:block>
		</jsp:attribute>
		<jsp:attribute name="mxit">
			<all:block>
				<all:link href="${uri_back}" accesskey="#"><common:inline-label label="gen_backbutton" defaultValue="Back" /></all:link>
				| <all:link href="${url_home}"><common:inline-label label="gen_menu" defaultValue="Menu" /></all:link>
			</all:block>
		</jsp:attribute>
		<jsp:attribute name="xhtml">
			<c:if test="${empty styleClass}">
				<c:set var="styleClass" value="leftbutton"/>
			</c:if>
			<all:div styleClass="${styleClass}">
				<all:link href="${uri_back}">
					<common:affiliate-site-image affiliate_name="icon_path" href="/button_hd/back_{0}.png" imgWidth="52" height="52" alignment="middle" color="${requestScope.affiliate_bckgrnd}" affiliateSite="${affsite}"/>
				</all:link>
				<all:br/>
				<all:link href="${uri_back}"><common:inline-label label="gen_backbutton" defaultValue="Back" /></all:link>
			</all:div>
		</jsp:attribute>
	</common:renderDisplay>
</c:if>

<%
	if(process){
		//Store in session
		BackController back=(BackController)session.getAttribute("back");

		if(forceStackPop==null?false:forceStackPop==true){
			back.forceStackPop();
		}

		session.setAttribute("back",back);
	}
%>