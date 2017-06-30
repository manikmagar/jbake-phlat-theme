title=How to deploy wordpress on tomcat
date=2016-04-12
author=Manik Magar
type=post
guid=http://www.myjavaacademy.com/?p=21
permalink=/deploy-wordpress-tomcat/
tags=Wordpress
status=published
summary=How to deploy wordpress on tomcat
~~~~~~
<a href="http://wordpress.org" target="_blank">WordPress</a> is a very popular content management system to create Blogs and websites.

If you have existing java application hosted on tomcat server then adding wordpress to same tomcat might save in terms of memory and resource utilization.

Now you can deploy wordpress on any java based application server like tomcat, thanks to <a href="http://quercus.caucho.com/" target="_blank">Quercus</a>.

> Quercus is Caucho Technology&#8217;s 100% Java implementation of PHP 5 released under the Open Source GPL license. Quercus comes with many PHP modules and extensions like PDF, PDO, MySQL, and JSON. Quercus allows for tight integration of Java services with PHP scripts, so using PHP with JMS or Grails is a quick and painless endeavor.

It has been more simplified by <a href="http://bonfab.io/2016/01/jwordpress-4-4-1/" target="_blank">bonfab.io</a> which created a maven based WAR project that includes Quercus and wordpress.

For more updates, you can follow &#8211; <a href="http://bonfab.io/2016/01/jwordpress-4-4-1/" target="_blank">bonfab.io blog</a> but here are steps for quick reference &#8211;

  1. Download JWordpress war from <a href="https://bitbucket.org/bfx/jwordpress" target="_blank">here</a>.
  2. Download mysql java connector jar from <a href="https://dev.mysql.com/downloads/connector/j/" target="_blank">here</a> and add it in WEB-INF/lib.
  3. If you are using <a href="https://mariadb.com" target="_blank">MariaDB</a>, then get the mariadb java connector from <a href="https://mariadb.com/kb/en/mariadb/about-mariadb-connector-j/" target="_blank">here</a>.
  4. Deploy this WAR to tomcat and start the tomcat.
  5. Make sure you create one database user in mysql/mariadb with one empty database for our new wordpress.
  6. Access http://localhost:8080/JWordpress and you should see the famous 5 minute setup of wordpress. Configure the database and you should be all set.

You can even create this war with Maven as described on <a href="https://bitbucket.org/bfx/jwordpress" target="_blank">JWordpress repository</a>.

Hope that helps!

&nbsp;