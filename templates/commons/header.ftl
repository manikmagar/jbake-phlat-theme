<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <title>${config.site_title}<#if (content.title)??> - <#escape x as x?xml>${content.title}</#escape></#if></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="${content.author!config.site_author}">
    <meta name="keywords" content="">
    <meta name="generator" content="JBake">
    
    <#if (config.google_webmaster?has_content)>
    	<meta name="google-site-verification" content="${config.google_webmaster}" />
    </#if>
    <#if (config.bing_webmaster?has_content)>
    	<meta name="msvalidate.01" content="${config.bing_webmaster}" />
    </#if>
    <#if (config.alexa_id?has_content)>
    	<meta name="alexaVerifyID" content="${config.alexa_id}" />
    </#if>
    


    <link href="/feed.xml" rel="alternate" type="application/rss+xml" title="${config.site_title}" />
    <link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/css/highlightjs-themes/androidstudio.css" />
    <link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/css/font-awesome.min.css" />
    <link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/css/phlat.css" />
    <link rel="stylesheet" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/css/phlat-custom.css" />

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="<#if (content.rootpath)??>${content.rootpath}<#else></#if>js/html5shiv.min.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <!--<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">-->
    <link rel="shortcut icon" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>img/favicon/favicon.png">
  </head>
  <body>
  	
  		<#include "menu.ftl">
  	
  
