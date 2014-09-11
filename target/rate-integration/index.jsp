<%@page import="org.springframework.web.servlet.tags.form.TextareaTag"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="java.io.StringReader"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%-- <%@page import="rnd.domain.billing.module.dto.SubscriptionState"%> --%>
<%@page import="net.sf.json.JSONObject"%>
<%-- <%@page import="rnd.util.RequestExtractorUtils"%> --%>
<%-- <%@ include file="taglibs.jspf" %> --%>
<%-- <%@page import="za.co.axon.venus.core.UserManager"%> --%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.concurrent.Semaphore"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.slf4j.Logger"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<%-- <jsp:useBean id="um" class="za.co.axon.venus.core.UserManager" scope="session"/>
<jsp:useBean id="affsite" class="za.co.axon.venus.core.AffiliateSite" scope="request"/>
 --%>
<%-- We should rather use the rnd.ui.radbar.Pollen8 class --%>
<c:catch var="radbar_application_error">
	<c:set var="pollen8ResponseFmt" scope="request" value="xml"/>
	<%!	private static final Logger logger = LoggerFactory.getLogger("jsp.pollen8");
		private static final int CONNECTION_TIMEOUT = 1000;
		private static final int READ_TIMEOUT = 1000;
		private static final int CONCURRENT_CALLS = 50;
		private static final Semaphore SEMAPHORE = new Semaphore(CONCURRENT_CALLS);
		private static final String VERSION = "s2s_1";
		private static final String UTF_8 = "UTF-8";
		private static final String baseUrl = "http://test.mobiclicksdirect.com/impag/ads";
		private static final String HEADER_PREFIX = "header_";
		private static final String PROFILE_PREFIX = "profile_";
		private static final List<String> IGNORE_HEADER_LIST = Arrays.asList(new String[]{"accept", "accept-charset", "cookie", "x-wap-profile", "x-wap-profile-diff"});

		public String getAdvertSafe(HttpServletRequest request, String code/* , UserManager userManager */) {
			return getAdvertSafe(request, code, /* userManager, */ null);
		}

		public String getAdvertSafe(HttpServletRequest request, String code, /* UserManager userManager, */ String format) {
			try {
				return getAdvert(request, code, /* userManager, */ format);
			} catch (IOException e) {
				//Log Exception
				return "";
			}
		}

		public String getAdvert(HttpServletRequest request, String code/* , UserManager userManager */) throws IOException {
			return getAdvert(request, code, /* userManager, */ null);
		}

		public String getAdvert(HttpServletRequest request, String code,/*  UserManager userManager, */ String format) throws IOException {
			String separator = "?";
			StringBuilder urlBuilder = new StringBuilder(baseUrl);
			//===================
			//Add preset params to url
			separator = append(urlBuilder, separator, "fmt", format);
			separator = append(urlBuilder, separator, "site-id", code);
			separator = append(urlBuilder, separator, "ua", request.getHeader("User-Agent"));
			separator = append(urlBuilder, separator, "ip", request.getRemoteAddr());
			separator = append(urlBuilder, separator, "ver", VERSION);
			
			

			ArrayList<String> headerNames = Collections.list(request.getHeaderNames());
			for (String headerName : headerNames) {
				if (!IGNORE_HEADER_LIST.contains(headerName.toLowerCase())) {
					ArrayList<String> headerValues = Collections.list(request.getHeaders(headerName));
					separator = append(urlBuilder, separator, HEADER_PREFIX + headerName.toLowerCase(), headerValues.toString());
				}
			}
			//===============================================================================================
			boolean allowed = SEMAPHORE.tryAcquire();
			if (!allowed) {
				throw new IOException("Too many concurrent requests to pollen8 server");
			}
			BufferedReader reader = null;
			try {
				URL url = new URL(urlBuilder.toString());
				HttpURLConnection httpUrlConnection = (HttpURLConnection) url.openConnection();
				httpUrlConnection.setConnectTimeout(CONNECTION_TIMEOUT);
				httpUrlConnection.setReadTimeout(READ_TIMEOUT);
				httpUrlConnection.setRequestMethod("GET");
				httpUrlConnection.connect();
				reader = new BufferedReader(new InputStreamReader(httpUrlConnection.getInputStream(), UTF_8));
				String tmp;
				StringBuilder responseText = new StringBuilder();
				while ((tmp = reader.readLine()) != null) {
					responseText.append(tmp);
				}
				return responseText.toString();
			} finally {
				SEMAPHORE.release();
				if (reader != null) {
					reader.close();
				}
			}
		}

		private String append(StringBuilder urlBuilder, String separator, String key, String value) throws IOException {
			if (value == null) {
				return separator;
			}
			urlBuilder.append(separator).append(key).append("=").append(URLEncoder.encode(value, UTF_8));
			return "&";
		}

		
		
		public static HashMap<String, String> convertDirectAdvertAsXMLToHashMap(Document document){
			final String ParentTagName="ad";
			
			final String ImgHrefTagName="img";
			final String AdTypeTagName="type";
			final String TextAdTagName="text";
			final String CURLTagName="curl";
			final String CSCTagName="csc";
			
			HashMap<String, String> advertMap = new HashMap<String, String>();
			
			NodeList nodeList = document.getElementsByTagName(ParentTagName);
			
			for(int index=0; index < nodeList.getLength(); index++){
				
				 Element element = (Element)nodeList.item(index);
				 Node adTypeNode = element.getElementsByTagName(AdTypeTagName).item(0);
				 advertMap.put(AdTypeTagName, adTypeNode.getTextContent());
				 

				
				 if(adTypeNode.getTextContent().equals("Banner")){
					 Node imageNode = element.getElementsByTagName(ImgHrefTagName).item(0);
					 advertMap.put(ImgHrefTagName, imageNode.getTextContent());
				 }
				 if(adTypeNode.getTextContent().equals("Text")){
					 Node textAdNode = element.getElementsByTagName(TextAdTagName).item(0);
					 advertMap.put(TextAdTagName, textAdNode.getTextContent());
				 }
				 Node curlNode = element.getElementsByTagName(CURLTagName).item(0);
				 advertMap.put(CURLTagName, curlNode.getTextContent());
				 
				 Node cscNode = element.getElementsByTagName(CSCTagName).item(0);
				 advertMap.put(CSCTagName, cscNode.getTextContent());
				
			}
			return advertMap;
		}
	%>
	<%
		long startTime = System.currentTimeMillis();
		try {
			
			String format = ((String) pageContext.findAttribute("pollen8ResponseFmt")).trim();
			
			request.removeAttribute("directAdvert");
			//Todo: Remove hardcoded user code from below parameter
			String responseText = getAdvert(request, "0122000b-3280-a701-4846-3b458c00005d", /* um, */ format);
			if (StringUtils.isNotEmpty(responseText)) {
				 if(StringUtils.equals(format, "xml")){
					DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
					Document document = builder.parse(new ByteArrayInputStream(responseText.getBytes(UTF_8)));
					request.setAttribute("directAdvert", convertDirectAdvertAsXMLToHashMap(document));
				}
				else {
					request.setAttribute("directAdvert", responseText);
				}
			}
			logger.debug("Request for Pollen8 code took [{}] ms", System.currentTimeMillis() - startTime);
		} catch (Exception e) {
			logger.warn("Error requesting Pollen8 code, took [" + (System.currentTimeMillis() - startTime) + "]ms. {}", e.getMessage());
			throw e;
		}
	%>
	<%-- ==================================================================================================== --%>
	
	<c:if test="${not empty directAdvert}">
		<img alt="" src="${directAdvert.csc}"/>
		<c:if test="${directAdvert.type eq 'Text'}">
			<a href='<c:url value='${directAdvert.curl}'/>'>
				<c:out value="${directAdvert.text}"/>
			</a>
		</c:if>
		<c:if test="${directAdvert.type eq 'Banner'}">
			<a href='<c:url value='${directAdvert.curl}'/>'>
				<img alt='' src='<c:url value="${directAdvert.img}"/>' align="middle">
			</a>
		</c:if>
	</c:if>
</c:catch>
	

<c:if test="${not empty radbar_application_error}"><!-- ${pollen8ApiUrl} :: ${radbar_application_error} --></c:if>


