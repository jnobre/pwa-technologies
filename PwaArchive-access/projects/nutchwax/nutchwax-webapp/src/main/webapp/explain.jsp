<%@ page 
  contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" 

  import="javax.servlet.*"
  import="javax.servlet.http.*"
  import="java.io.*"
  import="java.util.*"
  import="org.apache.hadoop.conf.*"
  import="org.apache.nutch.searcher.*"
  import="org.archive.access.nutch.NutchwaxConfiguration"
  import="org.apache.lucene.search.PwaFunctionsWritable"
%>
<%
  Configuration nutchConf = NutchwaxConfiguration.getConfiguration(application);
  NutchBean bean = NutchBean.get(application, nutchConf);
  // set the character encoding to use when interpreting request values 
  request.setCharacterEncoding("UTF-8");
  bean.LOG.info("explain request from " + request.getRemoteAddr());
  Hit hit = new Hit(Integer.parseInt(request.getParameter("idx")),
                    Integer.parseInt(request.getParameter("id")));
  HitDetails details = bean.getDetails(hit);
  Query query = Query.parse(request.getParameter("query"), nutchConf);
  String language = ResourceBundle.getBundle("org.nutch.jsp.explain", request.getLocale()).getLocale().getLanguage();
  String requestURI = HttpUtils.getRequestURL(request).toString();
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
  // To prevent the character encoding declared with 'contentType' page
  // directive from being overriden by JSTL (apache i18n), we freeze it
  // by flushing the output buffer. 
  // see http://java.sun.com/developer/technicalArticles/Intl/MultilingualJSP/
  out.flush();
%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/i18n" prefix="i18n" %>
<i18n:bundle baseName="org.nutch.jsp.explain"/>
<html lang="<%= language %>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
<title>Nutch: <i18n:message key="title"/></title>
<jsp:include page="/include/style.html"/>
</head>

<body>

<jsp:include page="/header.html"/>

<h3><i18n:message key="page"/></h3>

<%=bean.getDetails(hit).toHtml()%>

<h3><i18n:message key="scoreForQuery">
  <i18n:messageArg value="<%=query%>"/>
</i18n:message>
</h3>

<%
String sfunctions =  request.getParameter("sfunctions");
if (sfunctions==null) {
	sfunctions=""; // use default
}
String functionsArray[]=sfunctions.split(" ");

String sboosts =  request.getParameter("sboosts");
if (sboosts==null) {
	sboosts=""; // use default
}
String boostsArray[]=sboosts.split(" ");

PwaFunctionsWritable functions=new PwaFunctionsWritable();
for (int i=0; i<functionsArray.length; i++) {
	if (!functionsArray[i].equals("")) {
		functions.addFunction(Integer.parseInt(functionsArray[i]), Float.parseFloat(boostsArray[i]));
	}
}
%>
<%=bean.getExplanation(query, hit, functions)%>

<jsp:include page="/include/footer.html"/>

</body>     
</html>
