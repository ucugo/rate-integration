<%@ tag language="java" pageEncoding="UTF-8" description="Tag for direct advert integration" import="advert.direct.DirectAdvert,java.util.HashMap"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@attribute name="directAdvertTag" required="true" description="Displays Direct Advert"%>

<%
DirectAdvert advert = new DirectAdvert();
try{
	HashMap<String,String> map = advert.getAdvert("xml", request);
	request.setAttribute("directAdvert", map);
}catch(Exception e){
	
}

%>
<c:catch var="radbar_application_error">
<c:if test="${not empty directAdvertTag}">
		<img src="${directAdvert.csc}"/><!--Client Side counting url for pixel tracking  -->
		
		<c:if test="${directAdvert.type eq 'Text'}">
			<a href='<c:url value='${directAdvert.curl}'/>'><!-- Click URL -->
				<c:out value="${directAdvert.text}"/>
			</a>
		</c:if>
		
		<c:if test="${directAdvert.type eq 'Banner'}">
			<a href='<c:url value='${directAdvert.curl}'/>'><!-- Click url -->
				<img src='<c:url value="${directAdvert.img}"/>' align="middle">
			</a>
		</c:if>
	</c:if>
</c:catch>
<c:if test="${not empty radbar_application_error}"><!-- ${pollen8ApiUrl} :: ${radbar_application_error} --></c:if>



