<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="firstAd" required="false"%>
<%@ attribute name="secondAd" required="false"%>

<jsp:useBean id="directAdvert" class="com.test.TestDirectAdvert"/>
<jsp:setProperty property="request" name="directAdvert" value="${pageContext.request}"/>
<jsp:setProperty property="nads" name="directAdvert" value="2"/><!-- Sets the number of ads to return -->
<jsp:setProperty property="adFormat" name="directAdvert" value="xml"/><!-- Supports xml -->
<c:set var="adNum" value="firstAd"/>
<c:set var="adNum2" value="secondAd"/>


<c:catch var="radbar_application_error">
	<c:if test="${not empty directAdvert and firstAd eq adNum}">
		<c:forEach var="adList" begin="0" end="0" items="${directAdvert.advert}">
		
			<img src="${adList.csc}"/><!--Client Side counting url for pixel tracking  -->
		
			<c:if test="${adList.type eq 'Text'}">
				<a href='<c:url value='${adList.curl}'/>'><!-- Click URL -->
					<c:out value="${adList.text}"/>
				</a>
			</c:if>
		
			<c:if test="${adList.type eq 'Banner'}">
				<a href='<c:url value='${adList.curl}'/>'><!-- Click url -->
					<img src='<c:url value="${adList.img}"/>' align="middle">
				</a>
			</c:if>
	
		</c:forEach>
	</c:if>
	
	<c:if test="${not empty directAdvert and secondAd eq adNum2}">
		<c:forEach var="adList" begin="1" end="1" items="${directAdvert.advert}">
		
			<img src="${adList.csc}"/><!--Client Side counting url for pixel tracking  -->
		
			<c:if test="${adList.type eq 'Text'}">
				<a href='<c:url value='${adList.curl}'/>'><!-- Click URL -->
					<c:out value="${adList.text}"/>
				</a>
			</c:if>
		
			<c:if test="${adList.type eq 'Banner'}">
				<a href='<c:url value='${adList.curl}'/>'><!-- Click url -->
					<img src='<c:url value="${adList.img}"/>' align="middle">
				</a>
			</c:if>
	
		</c:forEach>
	</c:if>
	</c:catch>
<c:if test="${not empty radbar_application_error}"><!-- ${pollen8ApiUrl} :: ${radbar_application_error} --></c:if>
