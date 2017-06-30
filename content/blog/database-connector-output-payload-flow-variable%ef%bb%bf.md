---
id: 301
title=Database connector output as payload or flow variable﻿
date=2016-04-24T01:50:18+00:00
author=Manik Magar
summary: 'Database Connector allows you to connect to any relational database using JDBC and supports DDL as well as DML queries like Select, Insert, Update, Delete, Create etc. In this post, we will see how we can set the output of  any database call to be a flow variable instead of payload.'
type=post
guid=http://www.myjavaacademy.com/?p=301
permalink=/database-connector-output-payload-flow-variable%ef%bb%bf/
tags=Connectors,Mule ESB
status=published
~~~~~~
Database Connector is one of the very commonly used connector. This allows you to connect to any relational database using JDBC and supports DDL as well as DML queries like Select, Insert, Update, Delete, Create etc.

Usually when you use any connector in mule, the output of that connector becomes the payload of next message processor.

Consider below flow which gets contact details over HTTP inbound connector, then uses Database Connector to save it in MySQL database.

<pre class="brush: xml; title=; notranslate" title="">&lt;flow name="mule-demoFlow2"&gt;
		&lt;http:listener config-ref="HTTP_Listener_Configuration"
			path="/dbconn" doc:name="HTTP" /&gt;
		&lt;set-payload value="#[message.inboundProperties.'http.query.params']"
			doc:name="Set Payload" /&gt;
        &lt;db:insert config-ref="MySQL_Configuration" doc:name="Database"&gt;
            &lt;db:parameterized-query&gt;&lt;![CDATA[insert into contacts (firstname,lastname,emailid,zip) values (#[payload.firstName],#[payload.lastName],#[payload.emailid],#[payload.zip]);]]&gt;&lt;/db:parameterized-query&gt;
        &lt;/db:insert&gt;
		&lt;set-payload value="#['All data saved - '+ payload]"
			doc:name="Set Payload" /&gt;
		&lt;logger message="#[payload]" level="INFO" doc:name="Logger" /&gt;
	&lt;/flow&gt;
</pre>

So, Let&#8217;s send an HTTP request using Postman and look at the output.

<p id="lGfbseH">
  <a href="/img/2016/04/img_571c189eea19d.png"><img class="alignnone size-full wp-image-308 " src="/img/2016/04/img_571c189eea19d.png" alt="Database Connector output with target to flow variable" data-recalc-dims="1" /></a>
</p>

When Mule received this request, it processed the database connector insert operation. Result of Insert/Update/Delete SQL is always the number of rows affected by that statement. So in our case, as we inserted one row, output was 1 and same got set as a payload for subsequent processors.

Before we returned the response to HTTP, we set payload to below string. So the&nbsp;output we received on postman was &#8216;All data saved &#8211; 1&#8217;

<pre class="brush: xml; title=; notranslate" title="">&lt;set-payload value="#['All data saved - '+ payload]"
			doc:name="Set Payload" /&gt;</pre>

**But, what if we don&#8217;t want Database Connector to replace our output. Let&#8217;s say we are just writing a log entry in database and original payload should keep getting processed after log entry. In that case, we wouldn&#8217;t want to loose our original payload.**

There is one scope in mule, called &#8216;Message Enricher&#8217; which can set the output of processor in that scope to a flow variable. So we can wrap the db:insert call into an enricher with target set to &#8216;#[flowVars.rowsInserted]&#8217;. Then the output of insert statement i.e. number of rows inserted will be set as a flow variable, leaving our original payload unchanged.

<pre class="brush: xml; title=; notranslate" title="">&lt;enricher target="#[flowVars.rowsInserted]" doc:name="Message Enricher"&gt;
            &lt;db:insert config-ref="MySQL_Configuration" source="#[message.inboundProperties.'http.query.params']" doc:name="Database"&gt;
                &lt;db:parameterized-query&gt;&lt;![CDATA[insert into contacts (firstname,lastname,emailid,zip) values (#[payload.firstName],#[payload.lastName],#[payload.emailid],#[payload.zip]);]]&gt;&lt;/db:parameterized-query&gt;
            &lt;/db:insert&gt;
        &lt;/enricher&gt;
</pre>

**Wait, there is another easier way to do it.** Database Connector exposes an advanced property called _&#8216;target&#8217;_ **which adds enricher functionality to connector itself. &nbsp;Default value of &#8216;target&#8217; is &#8216;#[payload]&#8217; and so the output always gets set as payload. You can set target to any expression. Let&#8217;s set it to &#8216;#[flowVars.rowsInserted]&#8217; in our original flow.</p>

<p id="UuWxoJm">
  <a href="/img/2016/04/img_571c1df803feb.png"><img class="alignnone size-full wp-image-311 " src="/img/2016/04/img_571c1df803feb.png" alt="" srcset="/img/2016/04/img_571c1df803feb.png?w=557&ssl=1 557w, /img/2016/04/img_571c1df803feb.png?resize=300%2C130&ssl=1 300w" sizes="(max-width: 557px) 100vw, 557px" data-recalc-dims="1" /></a>
</p>

Now, if we submit the request again, then we can see a new variable &#8216;rowInserted&#8217; with value &#8216;1&#8217; after database call and our payload is still same map with contact details. Also, the output on postman should is&nbsp;&#8211; &#8216;All data saved &#8211; ParameterMap{[firstName=[Manik3], lastName=[M3], emailid=[mm3@test.com], zip=[123455]]}&#8217;

[<img class="alignnone size-full wp-image-310 " src="/img/2016/04/img_571c1dc10bf92.png" alt="" srcset="/img/2016/04/img_571c1dc10bf92.png?w=1418&ssl=1 1418w, /img/2016/04/img_571c1dc10bf92.png?resize=300%2C122&ssl=1 300w, /img/2016/04/img_571c1dc10bf92.png?resize=768%2C313&ssl=1 768w, /img/2016/04/img_571c1dc10bf92.png?resize=1024%2C417&ssl=1 1024w, /img/2016/04/img_571c1dc10bf92.png?resize=1200%2C488&ssl=1 1200w" sizes="(max-width: 1418px) 100vw, 1418px" data-recalc-dims="1" />](/img/2016/04/img_571c1dc10bf92.png)

&nbsp;

**

Target property could be very useful&nbsp;when we want to do different select queries in our flow and hold the results in flow variables for later use.**

Feel free to let me know your thoughts!

&nbsp;
