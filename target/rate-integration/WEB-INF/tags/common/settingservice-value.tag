<%@include file="taglibs.tagf" %>
<%@tag description="Fetch setting from settings tables." body-content="empty" %>
<%@attribute name="lookupKey" required="true" type="java.lang.String"  %>
<%@attribute name="defaultValue" required="false"  type="java.lang.String" %>
<%@attribute name="userManager" required="true" type="za.co.axon.venus.core.UserManager" %>
<%@attribute name="affiliateForSite" required="true" type="za.co.axon.venus.core.Affiliate" %>

<jsp:useBean id="settingService" class="rnd.application.setup.SettingService" scope="application"/>

<%
	String value = settingService.getValue(userManager.getUserService(), affiliateForSite, lookupKey, defaultValue);
	boolean showSiteLabelNames = "true".equals(request.getHeader("showSettings"));

	if (showSiteLabelNames)
		value = "SettingService[value='" + value + "', lookupKey='" + lookupKey + "', defaultValue='" + defaultValue + "', userService='" + userManager.getUserService() + "', affiliate='" + affiliateForSite.getAffiliate() + "']";

	out.print(value);
%>
