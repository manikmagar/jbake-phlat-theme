title=Connecting to local database in adobe AIR
date=2011-01-02T07:45:17+00:00
author=Manik Magar
type=post
guid=https://manikmagar.wordpress.com/2011/01/02/connecting-to-local-database-in-adobe-air/
permalink=/connecting-to-local-database-in-adobe-air/
tags=Adobe AIR,Database,Flex,Oracle
status=published
summary=Connecting to local database in adobe AIR
~~~~~~
I wanted to create a sample desktop application using Adobe AIR. Application was supposed to get the data from local oracle express edition database. I started working on it but soon i realize that I cannot connect to local database through AIR. I googled a lot but could not find anything. So i decided to create something new and then i started working on <a href="http://code.google.com/p/air-db-connector/" target="_blank">AirDBConnector</a>.

AirDBConnector has three parts &#8211;

  1. java4airdb – Local Java Server that sits between air application and database.
  2. air-lib – flex library that provides API for DB communication.
  3. sql-gen – An Air application to generate sql query configurations.

## java4airdb:

Its a java application that uses ServerThread and listens on particular port for air application db requests.

  * airdb.connector.port : Specifies port to be used for communication.
  * airdb.connector.sql-config: Path to sql config file.
  * java4airdb.bat : Batch file to start java server for db interaction.
  * java4airdb.jar: Java jar file

Starting server is very simple just define the connector port in properties file, specify the sql-config file path and run the java4airdb.bat file.

***This requires Java5+. Set JAVA_HOME property.**&#160;

## sql-gen:

Its a very simple utility air application to generate sql-config file in proper syntax.

[<img style="display:inline;border-width:0;" title="SqlGen1" border="0" alt="SqlGen1" src="/img/2011/01/sqlgen1_thumb.png?resize=505%2C319" data-recalc-dims="1" />](/img/2011/01/sqlgen1.png) 

&#160;

1. Run AirDbConfigGenerator. Click on ‘New Config’. Enter DSN Name. If required username and password.

[<img style="display:inline;border-width:0;" title="image" border="0" alt="image" src="/img/2011/01/image_thumb.png?resize=513%2C324" data-recalc-dims="1" />](/img/2011/01/image.png)

2. To add SQL queries, click on ‘+’ button in SQL queries. Add below fields and Save Query.

  * Unique query id per config file.
  * query type: Select, Insert/Update, Proc/Function
  * SQL query
  * Parameters

You can have any number of queries in config file.

[<img style="display:inline;border-width:0;" title="image" border="0" alt="image" src="/img/2011/01/image_thumb1.png?resize=524%2C331" data-recalc-dims="1" />](/img/2011/01/image1.png)

&#160;

3. Once you are done with adding all queries. Click on ‘Generate XML’ button on top to generate sql-config.xml file.

Thats It! you have successfully generated you sql-config.xml and you can find it on desktop.

**<u>Isn’t that easy. You do not need to know XML syntaxes.</u>**

**<u></u>**

Sample XML file &#8211;

<div class="csharpcode">
  <pre class="alt"><span class="kwrd">&lt;</span><span class="html">sql-config</span><span class="kwrd">&gt;</span></pre>

  <pre>  <span class="kwrd">&lt;</span><span class="html">connection</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt">    <span class="kwrd">&lt;</span><span class="html">dsn</span> <span class="attr">password</span><span class="kwrd">="password"</span> <span class="attr">name</span><span class="kwrd">="MyDSN"</span> <span class="attr">username</span><span class="kwrd">="user1"</span><span class="kwrd">/&gt;</span></pre>

  <pre>  <span class="kwrd">&lt;/</span><span class="html">connection</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt">  <span class="kwrd">&lt;</span><span class="html">queries</span><span class="kwrd">&gt;</span></pre>

  <pre>    <span class="kwrd">&lt;</span><span class="html">select</span> <span class="attr">id</span><span class="kwrd">="Query1"</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt">      <span class="kwrd">&lt;</span><span class="html">sql</span><span class="kwrd">&gt;</span>Select * from test_table1 where id=?<span class="kwrd">&lt;/</span><span class="html">sql</span><span class="kwrd">&gt;</span></pre>

  <pre>      <span class="kwrd">&lt;</span><span class="html">parameters</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt">        <span class="kwrd">&lt;</span><span class="html">parameter</span><span class="kwrd">&gt;</span></pre>

  <pre>          <span class="kwrd">&lt;</span><span class="html">name</span><span class="kwrd">&gt;</span>param1<span class="kwrd">&lt;/</span><span class="html">name</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt">          <span class="kwrd">&lt;</span><span class="html">type</span><span class="kwrd">&gt;</span>BIGINT<span class="kwrd">&lt;/</span><span class="html">type</span><span class="kwrd">&gt;</span></pre>

  <pre>          <span class="kwrd">&lt;</span><span class="html">typeVal</span><span class="kwrd">&gt;</span>-5<span class="kwrd">&lt;/</span><span class="html">typeVal</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt">        <span class="kwrd">&lt;/</span><span class="html">parameter</span><span class="kwrd">&gt;</span></pre>

  <pre>      <span class="kwrd">&lt;/</span><span class="html">parameters</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt">    <span class="kwrd">&lt;/</span><span class="html">select</span><span class="kwrd">&gt;</span></pre>

  <pre>  <span class="kwrd">&lt;/</span><span class="html">queries</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt"><span class="kwrd">&lt;/</span><span class="html">sql-config</span><span class="kwrd">&gt;</span></pre>
</div>

.csharpcode, .csharpcode pre

{

font-size: small;

color: black;

font-family: consolas, &#8220;Courier New&#8221;, courier, monospace;

background-color: #ffffff;

/\*white-space: pre;\*/

}

.csharpcode pre { margin: 0em; }

.csharpcode .rem { color: #008000; }

.csharpcode .kwrd { color: #0000ff; }

.csharpcode .str { color: #006080; }

.csharpcode .op { color: #0000c0; }

.csharpcode .preproc { color: #cc6633; }

.csharpcode .asp { background-color: #ffff00; }

.csharpcode .html { color: #800000; }

.csharpcode .attr { color: #ff0000; }

.csharpcode .alt

{

background-color: #f4f4f4;

width: 100%;

margin: 0em;

}

.csharpcode .lnum { color: #606060; }

## air-lib:

This provides flex API to communicate to JAVA server. Integration with your AIR application is very easy, you just need to add AirDBConnector.swc in you application.

Below code shows the sample usage of library API &#8211;

<div class="csharpcode">
  &#160;
</div>

<div class="csharpcode">
  <pre class="alt"><span class="lnum">   1:  </span><span class="kwrd">&lt;?</span><span class="html">xml</span> <span class="attr">version</span><span class="kwrd">="1.0"</span> <span class="attr">encoding</span><span class="kwrd">="utf-8"</span>?<span class="kwrd">&gt;</span></pre>

  <pre><span class="lnum">   2:  </span><span class="kwrd">&lt;</span><span class="html">mx:WindowedApplication</span> <span class="attr">xmlns:mx</span><span class="kwrd">="http://www.adobe.com/2006/mxml"</span> </pre>

  <pre class="alt"><span class="lnum">   3:  </span>    <span class="attr">layout</span><span class="kwrd">="vertical"</span> <span class="attr">xmlns:airdb</span><span class="kwrd">="com.mm.apps.airdb.*"</span></pre>

  <pre><span class="lnum">   4:  </span>    <span class="attr">creationComplete</span><span class="kwrd">="airDB.init();"</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt"><span class="lnum">   5:  </span>    </pre>

  <pre><span class="lnum">   6:  </span>    <span class="kwrd">&lt;</span><span class="html">mx:Script</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt"><span class="lnum">   7:  </span>        <span class="kwrd">&lt;!</span>[CDATA[</pre>

  <pre><span class="lnum">   8:  </span>            import com.mm.apps.airdb.AirConnectorEvent;</pre>

  <pre class="alt"><span class="lnum">   9:  </span>            private function onIncomingData(event:AirConnectorEvent):void{</pre>

  <pre><span class="lnum">  10:  </span>               dg.dataProvider = event.resultRows;</pre>

  <pre class="alt"><span class="lnum">  11:  </span>            } </pre>

  <pre><span class="lnum">  12:  </span>        ]]<span class="kwrd">&gt;</span></pre>

  <pre class="alt"><span class="lnum">  13:  </span>    <span class="kwrd">&lt;/</span><span class="html">mx:Script</span><span class="kwrd">&gt;</span></pre>

  <pre><span class="lnum">  14:  </span>    </pre>

  <pre class="alt"><span class="lnum">  15:  </span>    <span class="kwrd">&lt;</span><span class="html">airdb:AirDBConnector</span> <span class="attr">id</span><span class="kwrd">="airDB"</span> <span class="attr">serverPort</span><span class="kwrd">="9000"</span> </pre>

  <pre><span class="lnum">  16:  </span>        <span class="attr">serverAddress</span><span class="kwrd">="localhost"</span> </pre>

  <pre class="alt"><span class="lnum">  17:  </span>        <span class="attr">dataReceived</span><span class="kwrd">="onIncomingData(event)"</span><span class="kwrd">/&gt;</span></pre>

  <pre><span class="lnum">  18:  </span>    </pre>

  <pre class="alt"><span class="lnum">  19:  </span>    <span class="kwrd">&lt;</span><span class="html">mx:Button</span> <span class="attr">label</span><span class="kwrd">="Get Data"</span> <span class="attr">click</span><span class="kwrd">="{airDB.executeQuery('get_frameworks');}"</span><span class="kwrd">/&gt;</span></pre>

  <pre><span class="lnum">  20:  </span>    </pre>

  <pre class="alt"><span class="lnum">  21:  </span>    <span class="kwrd">&lt;</span><span class="html">mx:DataGrid</span> <span class="attr">id</span><span class="kwrd">="dg"</span> <span class="attr">x</span><span class="kwrd">="10"</span> <span class="attr">y</span><span class="kwrd">="423"</span> <span class="attr">height</span><span class="kwrd">="250"</span> <span class="attr">width</span><span class="kwrd">="100%"</span><span class="kwrd">&gt;</span></pre>

  <pre><span class="lnum">  22:  </span>        <span class="kwrd">&lt;</span><span class="html">mx:columns</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt"><span class="lnum">  23:  </span>            <span class="kwrd">&lt;</span><span class="html">mx:DataGridColumn</span> <span class="attr">dataField</span><span class="kwrd">="framework_id"</span><span class="kwrd">/&gt;</span></pre>

  <pre><span class="lnum">  24:  </span>            <span class="kwrd">&lt;</span><span class="html">mx:DataGridColumn</span> <span class="attr">dataField</span><span class="kwrd">="name"</span><span class="kwrd">/&gt;</span></pre>

  <pre class="alt"><span class="lnum">  25:  </span>            <span class="kwrd">&lt;</span><span class="html">mx:DataGridColumn</span> <span class="attr">dataField</span><span class="kwrd">="version"</span><span class="kwrd">/&gt;</span></pre>

  <pre><span class="lnum">  26:  </span>            <span class="kwrd">&lt;</span><span class="html">mx:DataGridColumn</span> <span class="attr">dataField</span><span class="kwrd">="description"</span><span class="kwrd">/&gt;</span></pre>

  <pre class="alt"><span class="lnum">  27:  </span>            <span class="kwrd">&lt;</span><span class="html">mx:DataGridColumn</span> <span class="attr">dataField</span><span class="kwrd">="source_url"</span><span class="kwrd">/&gt;</span></pre>

  <pre><span class="lnum">  28:  </span>        <span class="kwrd">&lt;/</span><span class="html">mx:columns</span><span class="kwrd">&gt;</span></pre>

  <pre class="alt"><span class="lnum">  29:  </span>    <span class="kwrd">&lt;/</span><span class="html">mx:DataGrid</span><span class="kwrd">&gt;</span>        </pre>

  <pre><span class="lnum">  30:  </span>    </pre>

  <pre class="alt"><span class="lnum">  31:  </span><span class="kwrd">&lt;/</span><span class="html">mx:WindowedApplication</span><span class="kwrd">&gt;</span></pre>
</div>

.csharpcode, .csharpcode pre

{

font-size: small;

color: black;

font-family: consolas, &#8220;Courier New&#8221;, courier, monospace;

background-color: #ffffff;

/\*white-space: pre;\*/

}

.csharpcode pre { margin: 0em; }

.csharpcode .rem { color: #008000; }

.csharpcode .kwrd { color: #0000ff; }

.csharpcode .str { color: #006080; }

.csharpcode .op { color: #0000c0; }

.csharpcode .preproc { color: #cc6633; }

.csharpcode .asp { background-color: #ffff00; }

.csharpcode .html { color: #800000; }

.csharpcode .attr { color: #ff0000; }

.csharpcode .alt

{

background-color: #f4f4f4;

width: 100%;

margin: 0em;

}

.csharpcode .lnum { color: #606060; }

.csharpcode, .csharpcode pre

{

font-size: small;

color: black;

font-family: consolas, &#8220;Courier New&#8221;, courier, monospace;

background-color: #ffffff;

/\*white-space: pre;\*/

}

.csharpcode pre { margin: 0em; }

.csharpcode .rem { color: #008000; }

.csharpcode .kwrd { color: #0000ff; }

.csharpcode .str { color: #006080; }

.csharpcode .op { color: #0000c0; }

.csharpcode .preproc { color: #cc6633; }

.csharpcode .asp { background-color: #ffff00; }

.csharpcode .html { color: #800000; }

.csharpcode .attr { color: #ff0000; }

.csharpcode .alt

{

background-color: #f4f4f4;

width: 100%;

margin: 0em;

}

.csharpcode .lnum { color: #606060; }

**<u>Line 15:</u>** Create an instance of AirDBConnector. Specify serverPort, serverAddress and event handling method for dataReceived event.

**<u>_<font color="#0000ff">Line 4: THE MOST IMPORTANT, CALL airDB.init()</font>_</u>**

**<u>Line 19:</u>** on button click, query with id ‘get_frameworks’ is executed by calling executeQuery method on airDB. Optionally you can also pass parameters and callback function to executeQuery method. Below are two flavours of execute query method. These two methods returns an unique string id for each method call. If required you can use this id to match with the result id in event object.

<div class="csharpcode">
  <pre class="alt"><span class="lnum">   1:  </span>executeQuery(queryId:String, callback:Function = <span class="kwrd">null</span>):String</pre>

  <pre><span class="lnum">   2:  </span>&#160;</pre>

  <pre class="alt"><span class="lnum">   3:  </span>executeQueryParams(queryId:String, <span class="kwrd">params</span>:Array, callback:Function = <span class="kwrd">null</span>):String</pre>
</div>

&#160;

callback function must have below signature-

<pre class="csharpcode">function (<span class="kwrd">event</span>:AirConnectorEvent) void</pre>

.csharpcode, .csharpcode pre

{

font-size: small;

color: black;

font-family: consolas, &#8220;Courier New&#8221;, courier, monospace;

background-color: #ffffff;

/\*white-space: pre;\*/

}

.csharpcode pre { margin: 0em; }

.csharpcode .rem { color: #008000; }

.csharpcode .kwrd { color: #0000ff; }

.csharpcode .str { color: #006080; }

.csharpcode .op { color: #0000c0; }

.csharpcode .preproc { color: #cc6633; }

.csharpcode .asp { background-color: #ffff00; }

.csharpcode .html { color: #800000; }

.csharpcode .attr { color: #ff0000; }

.csharpcode .alt

{

background-color: #f4f4f4;

width: 100%;

margin: 0em;

}

.csharpcode .lnum { color: #606060; }

AirConnectorEvent has below set of properties &#8211;

  * message – XML Response from java4db. Sample XML Response is &#8211;

<pre class="csharpcode"><span class="kwrd">&lt;?</span><span class="html">xml</span> <span class="attr">version</span><span class="kwrd">="1.0"</span> <span class="attr">encoding</span><span class="kwrd">="UTF-8"</span> <span class="attr">standalone</span><span class="kwrd">="no"</span>?<span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">transporter</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">message</span><span class="kwrd">&gt;</span>Query with id end is processed.<span class="kwrd">&lt;/</span><span class="html">message</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">status</span><span class="kwrd">&gt;</span>100<span class="kwrd">&lt;/</span><span class="html">status</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">data</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">result</span> <span class="attr">size</span><span class="kwrd">="4"</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">row</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">framework_id</span><span class="kwrd">&gt;</span>1<span class="kwrd">&lt;/</span><span class="html">framework_id</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">name</span><span class="kwrd">&gt;</span>Spring<span class="kwrd">&lt;/</span><span class="html">name</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>3.0.5<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">description</span><span class="kwrd">&gt;</span>Spring Framework<span class="kwrd">&lt;/</span><span class="html">description</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">source_url</span><span class="kwrd">&gt;</span>http://www.springsource.com<span class="kwrd">&lt;/</span><span class="html">source_url</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">row</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">row</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">framework_id</span><span class="kwrd">&gt;</span>2<span class="kwrd">&lt;/</span><span class="html">framework_id</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">name</span><span class="kwrd">&gt;</span>Spring<span class="kwrd">&lt;/</span><span class="html">name</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>2.0<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">description</span><span class="kwrd">&gt;</span>Spring Framework<span class="kwrd">&lt;/</span><span class="html">description</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">source_url</span><span class="kwrd">&gt;</span>http://www.springsource.com<span class="kwrd">&lt;/</span><span class="html">source_url</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">row</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">row</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">framework_id</span><span class="kwrd">&gt;</span>3<span class="kwrd">&lt;/</span><span class="html">framework_id</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">name</span><span class="kwrd">&gt;</span>Hibernate<span class="kwrd">&lt;/</span><span class="html">name</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>2.0<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">description</span><span class="kwrd">&gt;</span>Hibernate<span class="kwrd">&lt;/</span><span class="html">description</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">source_url</span><span class="kwrd">&gt;</span>Hibernate.com<span class="kwrd">&lt;/</span><span class="html">source_url</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">row</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">row</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">framework_id</span><span class="kwrd">&gt;</span>4<span class="kwrd">&lt;/</span><span class="html">framework_id</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">name</span><span class="kwrd">&gt;</span>Hibernate<span class="kwrd">&lt;/</span><span class="html">name</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>3.0<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">description</span><span class="kwrd">&gt;</span>Hibernate<span class="kwrd">&lt;/</span><span class="html">description</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">source_url</span><span class="kwrd">&gt;</span>Hibernate.com<span class="kwrd">&lt;/</span><span class="html">source_url</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">row</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">result</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">data</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">requestId</span><span class="kwrd">&gt;</span>B540B76E-4433-46F5-64DF-459F46715E16<span class="kwrd">&lt;/</span><span class="html">requestId</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">transporter</span><span class="kwrd">&gt;</span></pre>

.csharpcode, .csharpcode pre

{

font-size: small;

color: black;

font-family: consolas, &#8220;Courier New&#8221;, courier, monospace;

background-color: #ffffff;

/\*white-space: pre;\*/

}

.csharpcode pre { margin: 0em; }

.csharpcode .rem { color: #008000; }

.csharpcode .kwrd { color: #0000ff; }

.csharpcode .str { color: #006080; }

.csharpcode .op { color: #0000c0; }

.csharpcode .preproc { color: #cc6633; }

.csharpcode .asp { background-color: #ffff00; }

.csharpcode .html { color: #800000; }

.csharpcode .attr { color: #ff0000; }

.csharpcode .alt

{

background-color: #f4f4f4;

width: 100%;

margin: 0em;

}

.csharpcode .lnum { color: #606060; }

  * resultId : Unique id for each db request
  * resultRowCount: Number of row return by select query
  * resultRow: XMLList containing <row> elements from response. You can use this property for assignment to dataProviders.

[<img style="display:inline;border-width:0;" title="image" border="0" alt="image" src="/img/2011/01/image_thumb2.png?resize=559%2C448" data-recalc-dims="1" />](/img/2011/01/image2.png)

&#160;

&#160;

&#160;

So that’s all. I hope this is easy to interact with local database.

Project home &#8211; [http://code.google.com/p/air-db-connector/](http://code.google.com/p/air-db-connector/ "http://code.google.com/p/air-db-connector/")

Download Release 1.0 &#8211; [http://code.google.com/p/air-db-connector/downloads/list](http://code.google.com/p/air-db-connector/downloads/list "http://code.google.com/p/air-db-connector/downloads/list")

&#160;

Please let me know your comments/issues/changes.
