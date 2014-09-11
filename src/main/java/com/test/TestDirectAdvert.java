package com.test;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.Semaphore;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.lang.NotImplementedException;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
@Component
public class TestDirectAdvert {
	
	private static final Logger logger = LoggerFactory.getLogger("jsp.pollen8");
	private static final String Site_Id = "0122000b-3280-a701-4846-3b458c00005d";
	private static final int CONNECTION_TIMEOUT = 1000;
	private static final int READ_TIMEOUT = 1000;
	private static final int CONCURRENT_CALLS = 50;
	private static final Semaphore SEMAPHORE = new Semaphore(CONCURRENT_CALLS);
	private static final String VERSION = "s2s_1";
	private static final String UTF_8 = "UTF-8";
	private static final String baseUrl = "http://test.mobiclicksdirect.com/impag/ads";
	private static final String HEADER_PREFIX = "header_";
	
	private HttpServletRequest request;
	private String nads;
	private String adFormat;
	
	private static final List<String> IGNORE_HEADER_LIST = Arrays.asList(new String[]{"accept", "accept-charset", "cookie", "x-wap-profile", "x-wap-profile-diff"});
	
	public TestDirectAdvert(){}
	public List<HashMap<String, String>> getAdvert()throws Exception{
		long startTime = System.currentTimeMillis();


		try {

			String responseText = getAdvert(this.request, Site_Id, this.adFormat);

			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			Document document = builder.parse(new ByteArrayInputStream(responseText.getBytes(UTF_8)));


			if (StringUtils.isNotEmpty(responseText)) {
				if(StringUtils.equals(this.adFormat, "xml")){

					return convertDirectAdvertAsXMLToHashMap(document);
				}else{
					throw new NotImplementedException("Ad response format ["+this.adFormat+"] for is not supported");
				}
				
			}
			logger.debug("Request for Pollen8 code took [{}] ms", System.currentTimeMillis() - startTime);
		} catch (Exception e) {
			logger.warn("Error requesting Pollen8 code, took [" + (System.currentTimeMillis() - startTime) + "]ms. {}", e.getMessage());
			throw e;
		}
		throw new RuntimeException();
	}
	

	
	
	private String getAdvert(HttpServletRequest request, String code, String format) throws IOException {
		String separator = "?";
		StringBuilder urlBuilder = new StringBuilder(baseUrl);
		//===================
		//Add preset params to url
		separator = append(urlBuilder, separator, "fmt", format);
		separator = append(urlBuilder, separator, "site-id", code);
		separator = append(urlBuilder, separator, "ua", request.getHeader("User-Agent"));
		separator = append(urlBuilder, separator, "ip", request.getRemoteAddr());
		separator = append(urlBuilder, separator, "ver", VERSION);
		separator = append(urlBuilder, separator, "nads", ""+this.nads);



		ArrayList<String> headerNames = Collections.list(request.getHeaderNames());
		for (String headerName : headerNames) {
			if (!IGNORE_HEADER_LIST.contains(headerName.toLowerCase())) {
				ArrayList<String> headerValues = Collections.list(request.getHeaders(headerName));
				separator = append(urlBuilder, separator, HEADER_PREFIX + headerName.toLowerCase(), headerValues.toString());
			}
		}
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

	
	
	private static List<HashMap<String, String>> convertDirectAdvertAsXMLToHashMap(Document document){
		final String ParentTagName="ad";
		
		final String ImgHrefTagName="img";
		final String AdTypeTagName="type";
		final String TextAdTagName="text";
		final String CURLTagName="curl";
		final String CSCTagName="csc";
		
		NodeList nodeList = document.getElementsByTagName(ParentTagName);
		
		List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		
		for(int index=0; index < nodeList.getLength(); index++){
			HashMap<String, String> advertMap = new HashMap<String, String>();
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
			 
			 list.add(advertMap);
			
		}
		return list;
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public void setNads(String nads) {
		this.nads = nads;
	}
	public String getNads() {
		return nads;
	}
	public String getAdFormat() {
		return adFormat;
	}
	public void setAdFormat(String adFormat) {
		this.adFormat = adFormat;
	}


}
