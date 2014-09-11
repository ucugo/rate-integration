<%@include file="taglibs.tagf" %>

<%@tag  description="Will return the default banner/icon or the campaign's ones. What about backgrounds" dynamic-attributes="attrMap" %>
<%@attribute name="subscriptionControl" required="true" type="rnd.domain.subscription.SubscriptionControl" %>
<%@attribute name="defaultBanner" required="true" type="java.lang.String" %>
<%@attribute name="defaultIcon" required="true" type="java.lang.String" %>
<%@variable name-given="banner" variable-class="java.lang.String" scope="NESTED" %>
<%@variable name-given="icon" variable-class="java.lang.String"  scope="NESTED" %>
<%@variable name-given="smsBannerId" variable-class="java.lang.String" scope="NESTED" %>
<%@variable name-given="smsBanner" variable-class="java.lang.String" scope="NESTED" %>
<%@variable name-given="join" variable-class="java.lang.String" scope="NESTED" %>
<%@variable name-given="profilePicBanner" variable-class="java.lang.String" scope="NESTED" %>

<c:set var="path" value="${request.contextPath}"/>

<c:set var="banner" value="${defaultBanner}"/>
<c:set var="icon" value="${defaultIcon}"/>
<c:set var="smsBannerId" value="${subscriptionControl.subscriptionProduct.smsBanner}"/>
<c:if test="${banner eq 'default' || empty banner}"><c:set var="banner" value=""/></c:if>
<c:if test="${icon eq 'default' || empty icon}"><c:set var="icon" value=""/></c:if>
<c:if test="${smsBanner eq 'default' || empty smsBanner }"><c:set var="smsBanner" value=""/></c:if>

<c:set var="join" value=""/>
<c:set var="profilePicBanner" value=""/>

<c:if test="${!empty subscriptionControl.subscriptionProductCampaign}">
	<c:if test="${subscriptionControl.subscriptionProductCampaign.banner ne 'default'}">
		<c:set var="banner" value="${subscriptionControl.subscriptionProductCampaign.banner}"/>
	</c:if>
	<c:if test="${subscriptionControl.subscriptionProductCampaign.icon ne 'default'}">
		<c:set var="icon" value="${subscriptionControl.subscriptionProductCampaign.icon}"/>
	</c:if>
	<c:if test="${subscriptionControl.subscriptionProductCampaign.smsBanner ne 'default'}">
		<c:set var="smsBanner" value="${subscriptionControl.subscriptionProductCampaign.smsBanner}"/>
	</c:if>
	<c:if test="${subscriptionControl.subscriptionProductCampaign.joinImage ne 'default'}">
		<c:set var="join" value="${subscriptionControl.subscriptionProductCampaign.joinImage}"/>
	</c:if>
	<c:set var="profilePicBanner" value="${subscriptionControl.subscriptionProductCampaign.profilePicBanner}"/>
</c:if>
<jsp:doBody/>
