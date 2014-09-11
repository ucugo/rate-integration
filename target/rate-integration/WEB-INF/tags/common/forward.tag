<%@include file="taglibs.tagf" %>
<%@tag description="put the tag description here" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/tld/taglib18.tld" prefix="skip" %>

<%@attribute name="page" required="true" description=""%>

<common:setHeaderValue name="forward_page" value="${page}"/>
<jsp:forward page="${page}"/>
<skip:SkipPage/>