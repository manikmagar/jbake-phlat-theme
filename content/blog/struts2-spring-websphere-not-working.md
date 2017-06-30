title=Struts2-Spring-WebSphere not working
date=2012-04-15
author=Manik Magar
type=post
guid=http://manikmagar.wordpress.com/?p=68
permalink=/struts2-spring-websphere-not-working/
tags=Spring Framework
status=published
~~~~~~
I created an application with Struts2 and Spring. It worked perfectly on tomcat 5.5. But when I deployed it on WebSphere 6, i was not able to call any action except static jsp files. I was getting HTTP 404 for all requests. I found solution on – 

<http://www.ibm.com/developerworks/forums/thread.jspa?threadID=158327> 

<http://www-01.ibm.com/support/docview.wss?uid=swg24014758> 

<http://stackoverflow.com/questions/1337786/struts2-doesnt-find-jsp-files>