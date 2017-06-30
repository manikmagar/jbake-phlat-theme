title=File outbound endpoint and inline transformers-refs to write flow variables to file
date=2016-06-02T04:03:00+00:00
author=Manik Magar
type=post
guid=https://myjavaacademy.com/?p=521
permalink=/file-outbound-endpoint-inline-transformers-refs-write-flow-variables-file/
tags=DataWeave,Endpoints,Mule ESB
status=published
summary=In this post, we will see how we can use inline transformers for writing flow variable content to file
~~~~~~
In this post, we will see how we can use inline transformers for writing flow variable content to file. At the end of this post, you will know how to achieve below things in Mule &#8211;

  1. Generate multiple transformation outputs with DataWeave
  2. Write flow variable content to file in Mule
  3. Use inline transformer-ref&#8217;s to pre-process payload for file:outbound-endpoint

<!--more-->

### Sample Flow &#8211;

Here is our flow that achieve&#8217;s all of the above objectives &#8211;
  
```
<?xml version="1.0" encoding="UTF-8"?>

<mule xmlns:file="http://www.mulesoft.org/schema/mule/file"
	xmlns:dw="http://www.mulesoft.org/schema/mule/ee/dw" xmlns:json="http://www.mulesoft.org/schema/mule/json"
	xmlns="http://www.mulesoft.org/schema/mule/core" xmlns:doc="http://www.mulesoft.org/schema/mule/documentation"
	xmlns:spring="http://www.springframework.org/schema/beans" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-current.xsd
http://www.mulesoft.org/schema/mule/core http://www.mulesoft.org/schema/mule/core/current/mule.xsd
http://www.mulesoft.org/schema/mule/file http://www.mulesoft.org/schema/mule/file/current/mule-file.xsd
http://www.mulesoft.org/schema/mule/ee/dw http://www.mulesoft.org/schema/mule/ee/dw/current/dw.xsd
http://www.mulesoft.org/schema/mule/json http://www.mulesoft.org/schema/mule/json/current/mule-json.xsd">
	<expression-transformer expression="#[return flowVars.file2content]"
		name="ExpressionForFile2" doc:name="Expression" />
	<expression-transformer expression="#[return flowVars.file3content]"
		name="Expression" doc:name="Expression" />
	<json:json-to-xml-transformer name="JSON_to_XML"
		doc:name="JSON to XML" />
	<flow name="mule1Flow">
		<file:inbound-endpoint path="input"
			responseTimeout="10000" doc:name="File" />
		<dw:transform-message doc:name="Transform Message">
			<dw:input-payload doc:sample="json.json" />
			<dw:set-payload><![CDATA[%dw 1.0
%output application/json
---
{
	(payload.file1)
	
}]]></dw:set-payload>
			<dw:set-variable variableName="file2content"><![CDATA[%dw 1.0
%output application/json
---
{
	(payload.file2)
}]]></dw:set-variable>
			<dw:set-variable variableName="file3content"><![CDATA[%dw 1.0
%output application/json
---
{
	(payload.file3)
}]]></dw:set-variable>
		</dw:transform-message>
		<file:outbound-endpoint path="output"
			outputPattern="file1.json" responseTimeout="10000" doc:name="File" />
		<file:outbound-endpoint path="output"
			outputPattern="file2.json" responseTimeout="10000" transformer-refs="ExpressionForFile2"
			doc:name="File" />
		<file:outbound-endpoint path="output"
			outputPattern="file3.xml" responseTimeout="10000" transformer-refs="Expression JSON_to_XML"
			doc:name="File" />
	</flow>
</mule>
```

### 

### DataWeave

In our flow, we have three <dw:set-* tags.

  1. **<dw:set-payload>:** The output of this transformation will be set as a payload to next transformer in flow.
  2. **<dw:set-variable> :** We have 2 of such tags. Each tag specifies an unique variableName attribute. The output of this transformation will be set as a flowVariable with key specified in variableName attribute. _<span style="text-decoration: underline;">So, now we know how to set DataWeave output to flow variable and generate multiple transformations with single DataWeave.</span>_

&nbsp;

### File Outbound Endpoint

We have three file outbound endpoints in our flow. Let&#8217;s look at each of them &#8211;

  * **Write file1.json: **This is a normal file outbound endpoint that writes the flow payload to file1.json. If we look back to our DataWeave, first transformation sets the payload content for this endpoint.

<pre class="lang:xhtml decode:true">&lt;file:outbound-endpoint path="output"
			outputPattern="file1.json" responseTimeout="10000" doc:name="File" /&gt;
</pre>

&nbsp;

  * **Write file2.json:** Now this is the file outbound endpoint that writes content of a flow variable to file2.json. First snippet below, shows a file outbound endpoint defined with additional attribute <span class="lang:default highlight:0 decode:true crayon-inline">transformer-refs=&#8221;ExpressionForFile2&#8243;</span> . ExpressionForFile2 is a global <span class="lang:default decode:true crayon-inline ">expression-transformer</span>  as shown in second snippet. The expression of this transformer is a Mule Expression that returns a flow variable content that we want to write to file. I have added a simple form here, but you can write any complex expression that resolves to some content. Output of this expression will be the payload for this file outbound endpoint. _Important thing to note here is_, this payload scope is local to this endpoint i.e. it will <span style="text-decoration: underline;">NOT</span> override your flow&#8217;s current payload. _<span style="text-decoration: underline;">So, now we know how to write flow variable, in fact any content like session variable, properties etc to file using file outbound endpoint.</span>_

<pre class="toolbar-overlay:false lang:default decode:true" title="file:outbound-endpoint">&lt;file:outbound-endpoint path="output"
			outputPattern="file2.json" responseTimeout="10000" <strong>transformer-refs="ExpressionForFile2"</strong>
			doc:name="File" /&gt;</pre>

<pre class="toolbar-overlay:false lang:default decode:true " title="Expression for file2">&lt;expression-transformer expression="#[return flowVars.file2content]"
		name="ExpressionForFile2" doc:name="Expression" /&gt;</pre>

&nbsp;

  * **Write file3.xml:** To further demonstrate the inline transformers, let&#8217;s look at the third file outbound endpoint. This endpoint uses two inline transformers as shown in below two snippets. When we specify more than one transformers then Mule will always apply them in the sequence as specified in declaration. First, endpoint&#8217;s payload will be set as file3content flow variable which is a JSON generated by DataWeave. Then we apply, JSON\_to\_XML transformer to convert that JSON into XML. At the end, this XML will be written to file3.xml. <span style="text-decoration: underline;"><em>So, now we know how we can use multiple transformers to pre-process the input of an endpoint.</em></span>

<pre class="toolbar-overlay:false lang:default decode:true">&lt;file:outbound-endpoint path="output"
			outputPattern="file3.xml" responseTimeout="10000" <strong>transformer-refs="Expression JSON_to_XML"</strong>
			doc:name="File" /&gt;</pre>

<pre class="toolbar-overlay:false lang:default decode:true">&lt;expression-transformer expression="#[return flowVars.file3content]"
		name="Expression" doc:name="Expression" /&gt;
&lt;json:json-to-xml-transformer name="JSON_to_XML"
		doc:name="JSON to XML" /&gt;</pre>

&nbsp;

<span style="text-decoration: underline;"><em><strong>Note:</strong> This example uses file:outbound-endpoint but transformer-refs attribute is available on other endpoints too and this post may be extended to apply similar concept on other endpoints.</em></span>

&nbsp;

Finally, let&#8217;s see our input and files generated by this flow &#8211;

Input JSON &#8211;

<pre class="toolbar-overlay:false lang:default decode:true">{
	"file1": {
		"text": "This content is for file 1"
	},
	"file2": {
		"text": "This content is for file 2"
	},
	"file3": {
		"text": "This content is for file 3"
	}

}</pre>

file1.json &#8211;

<pre class="toolbar-overlay:false lang:default decode:true ">{
  "text": "This content is for file 1"
}</pre>

file2.json &#8211;

<pre class="toolbar-overlay:false lang:default decode:true">{
  "text": "This content is for file 2"
}</pre>

file3.xml &#8211;

<pre class="toolbar-overlay:false lang:default decode:true ">&lt;?xml version='1.0'?&gt;
&lt;text&gt;This content is for file 3&lt;/text&gt;</pre>

&nbsp;

Hope This Helps! Let me know your thoughts about this.