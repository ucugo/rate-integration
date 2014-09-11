<%@ attribute name="text" required="true" type="java.lang.String" %>
<%@ attribute name="replacer" required="false" type="rnd.util.str.StringReplacer" %>
<%= replacer.replace(text) %>
