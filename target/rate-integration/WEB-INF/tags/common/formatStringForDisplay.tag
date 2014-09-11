<%@include file="taglibs.tagf" %>

<%@attribute name="stringToFormat" required="true" type="java.lang.String" description="The string to format into normal display"%>
<%@attribute name="defaultLinkUrl" required="true" type="java.lang.String" description="The default page to link to if the link item does not link somewhere." %>
<%@attribute name="disableLinks" required="false" type="java.lang.Boolean" description="Set this as true and it will not show hyperlinks" %>

<format:convertStringToFormatList stringToFormat="${stringToFormat}" var="listToFormat" />
<common:formatFormatList listToFormat="${listToFormat}" defaultLinkUrl="${defaultLinkUrl}" disableLinks="${disableLinks}"/>

