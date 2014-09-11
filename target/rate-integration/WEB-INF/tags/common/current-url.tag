<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@tag import="za.co.axon.venus.core.SiteLabelUtils"%>
<%@tag import="java.text.MessageFormat"%>
<%@tag import="za.co.axon.venus.core.SiteLabel"%>
<%@tag import="org.apache.commons.lang.StringUtils"%>
<%@tag import="rnd.util.UrlBuilder"%>
<%
	UrlBuilder builder = new UrlBuilder(request);
	String url = response.encodeURL(builder.toString());
	out.append(url);
%>
