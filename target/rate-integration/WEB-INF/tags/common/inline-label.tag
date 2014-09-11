<%@tag dynamic-attributes="params" body-content="empty" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@tag import="org.springframework.web.bind.ServletRequestUtils"%>
<%@tag import="za.co.axon.venus.core.SiteLabelUtils"%>
<%@tag import="java.text.MessageFormat"%>
<%@tag import="za.co.axon.venus.core.SiteLabel"%>

<%@ attribute name="label" required="true" type="java.lang.String" %>
<%@ attribute name="defaultValue" required="false" type="java.lang.String" %>
<%@ variable name-given="value" %>

<%@include file="get-site-label-value.tagf" %>

<%
	if (!StringUtils.isBlank(value)) {
		out.print(value);
	}
%>