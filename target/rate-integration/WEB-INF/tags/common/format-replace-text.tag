
<%@tag import="rnd.util.str.NoOpReplacer"%>
<%@tag import="edu.emory.mathcs.backport.java.util.TreeMap"%>
<%@tag import="java.util.TreeSet"%>
<%@tag import="java.util.SortedSet"%>
<%@tag import="java.util.HashMap"%>
<%@tag import="java.util.Set"%>
<%@tag import="java.text.MessageFormat"%>
<%@ tag dynamic-attributes="attrMap"  %>
<%@ attribute name="text" required="true" type="java.lang.String" %>
<%@ attribute name="replacer" required="false" type="rnd.util.str.StringReplacer" %>
<%
	HashMap map = ((HashMap)(jspContext.getAttribute("attrMap")));

	TreeMap set2 = new TreeMap(map);
	if (replacer == null)
		replacer = NoOpReplacer.getInstance();

%>

<%= MessageFormat.format(replacer.replace(text),set2.values().toArray()) %>
