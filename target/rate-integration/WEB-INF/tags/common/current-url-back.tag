
<%@tag import="java.net.URLEncoder"%><%@include file="taglibs.tagf" %>

<%@tag description="Get the current page link." %>
<%@attribute name="defaultBackUrl" required="false" type="java.lang.String" %>
<%@attribute name="loopbackUrl" required="false" type="java.lang.String" %>

<%@ variable name-given="currentUrl" scope="NESTED" variable-class="java.lang.String" %>
<%@ variable name-given="currentUrlAsBack" scope="NESTED" variable-class="java.lang.String" %>

<c:if test="${empty defaultBackUrl}">
	<c:set var="defaultBackUrl" value="index.jsp?override=yes"/>
</c:if>
<c:if test="${empty loopbackUrl}">
	<c:set var="loopbackUrl" value=""/>
</c:if>





<%
    String m_s_back = (String)request.getAttribute("m_s_back");
    String m_s_pback = (String)request.getAttribute("m_s_pback");
    String m_s_requestpage = (String)request.getAttribute("m_s_requestpage");

	// Override
	String s_override = request.getParameter("o");
	if (s_override == null) { s_override = "";}
	if ( m_s_back.equals("") || m_s_back == null ) {
		m_s_back =  defaultBackUrl;
	}
	String s_inc_pback_back_default = m_s_back;
	String s_inc_pback_pback_default = "";

	try
	{
		if (request.getAttribute("m_s_query_chopped") != null) {
		   String query = request.getAttribute("m_s_query_chopped").toString();
		   if ( query.equals("") ) {
			   s_inc_pback_pback_default = m_s_requestpage;
		   }
		   else {
			   s_inc_pback_pback_default = m_s_requestpage +"?"+URLEncoder.encode(query);
		   }
		   // Implemneting a loopback
		   // Used to override the back setting in specific cases like info and chat
		   // Note when you use this teh theory is as follows
		   // 1. The back parameter passed onto the loopback page actually contains the m_s_back not the usual m_s_pback
		   //    this allows the loopback pageto hold teh original passback page and pass onto the next page
		   if (loopbackUrl.length() > 0 && s_override.length() == 0) {
			   m_s_back = loopbackUrl+"?back="+m_s_back;
		   }
		}

	}
	catch (Exception e)
	{
	}


 //   Function: inc_pback
 //   "wap2/inc/inc_pback.jsp"          Calculates the passback parameters
 //             String s_inc_pback_back_default = "index.jsp?code="+code+"&override=yes";
 //             String s_inc_pback_pback_default = "profile.jsp?"+URLEncoder.encode(request.getQueryString());



	if ( m_s_back.equals("") || m_s_back == null ) {
	  m_s_back =  s_inc_pback_back_default;
	}
	// This is the backurl that will be passed onto other pages
	m_s_pback = s_inc_pback_pback_default;
%>


<c:set var="s_inc_loopback_or"  value="<%=s_override%>"  scope="request"/>
<c:url var="currentUrl" value="<%=m_s_back%>" />
<c:set var="currentUrlAsBack" value="<%=m_s_pback%>" />
<jsp:doBody/>

