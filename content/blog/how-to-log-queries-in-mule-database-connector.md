title=How to log queries in Mule Database connector?
date=2015-11-17T15:45:36+00:00
author=Manik Magar
type=post
guid=https://manikmagar.wordpress.com/2015/11/17/how-to-log-queries-in-mule-database-connector/
permalink=/how-to-log-queries-in-mule-database-connector/
tags=Mule ESB
status=published
summary
~~~~~~
It&#8217;s a very common need to log queries that are being executed on database. In Mule Database connector, it doesn&#8217;t log the queries. To enable query logging to log files, you can add below to your log4j configuration &#8211;

> <AsyncLogger name=&#8221;org.mule.module.db&#8221; level=&#8221;DEBUG&#8221;/>

This will log any activity performed by components in that package which includes DB connector of Mule ESB.

Happy Coding!