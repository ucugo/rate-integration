<%@tag import="org.apache.commons.lang.StringUtils"%>
<%@tag import="za.co.axon.venus.core.SiteLabelUtils"%>
<%@tag body-content="empty"%>
<%@ attribute name="label" required="true" type="java.lang.String" %>
<%@ attribute name="ikey" required="true" type="java.lang.String" %>
<%@ attribute name="defaultValue" required="false" type="java.lang.String" %>
<%
	String value = SiteLabelUtils.getSafeTranslateIKey(request, label, ikey, defaultValue);
	boolean showSiteLabelNames = "true".equals(request.getHeader("showSiteLabelNames"));

	if (showSiteLabelNames){
		value = "SLTranslation[label='" + label + "', ikey='" + ikey + "', defaultValue='" + defaultValue + "', currentValue='" + value + "']";
	}
	if (!StringUtils.isBlank(value)) {
		out.print(value);
	}
%>



