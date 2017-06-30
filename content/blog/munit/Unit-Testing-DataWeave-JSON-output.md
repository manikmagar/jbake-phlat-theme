author = "Manik Magar"
categories = ["MUnit"]
date = "2016-09-27T14:20:20-04:00"
description = "Often we generate JSON using DataWeave. What about testing it?"
featured = ""
featuredalt = ""
featuredpath = ""
linktitle = ""
title = "Unit Testing DataWeave JSON output"
type = "post"
url = "/blog/2016/09/27/Unit-Testing-DataWeave-JSON-Output-with-MUnit/"
tags=munit, dataweave, json
~~~~~~
In the [previous post](https://unittesters.com/blog/2016/07/20/Unit-Testing-Mule-DataWeave-Scripts-with-MUnit/) about unit testing DataWeave scripts with MUnit and JUnit, I showed you how to verify Java and CSV output of DataWeave scripts. We also looked at some error troubleshooting in dataweave scripts.

Now, lets look at DataWeave with JSON output and how we can test the content of our output with MUnit and JUnit.

## DataWeave Script

Let's use the same DataWeave script from our [previous post](https://unittesters.com/blog/2016/07/20/Unit-Testing-Mule-DataWeave-Scripts-with-MUnit/) and change the output type to `application/json`.

```scala
%dw 1.0
%output application/json
---
payload.root.*employee map {

		name: $.fname ++ ' ' ++ $.lname,
		dob: $.dob,
		age: (now as :string {format: "yyyy"}) -  
				(($.dob as :date {format:"MM-dd-yyyy"}) as :string {format:"yyyy"})

}
```

#### Input XML Payload:

```xml
<?xml version='1.0' encoding='UTF-8'?>
<root>
	<employee>
		<fname>M1</fname>
		<lname>M2</lname>
		<dob>01-01-1980</dob>
	</employee>
	<employee>
		<fname>A1</fname>
		<lname>A2</lname>
		<dob>12-23-1995</dob>
	</employee>
</root>
```

#### Expected output:

```json
[
  {
    "name": "M1 M2",
    "dob": "01-01-1980",
    "age": 36
  },
  {
    "name": "A1 A2",
    "dob": "12-23-1995",
    "age": 21
  }
]
```

## Writing MUnit XML Test Case

As we saw in previous post, output of DataWeave will be instance of WeaveOutputHandler class. Any transformer capable of consuming output streams can consume this output. As we are expecting json output, we will use `json-to-object-transformer` with a return class of `java.util.ArrayList`. Once we have the java list of json, we can validate any data elements. Here is out xml test case -

```xml
    <munit:test name="dataweave-testing-suite-jsonTest" description="MUnit Test">
        <munit:set payload="#[getResource('sample_data/employees.xml').asStream()]" mimeType="application/xml" doc:name="Set Message"/>
        <flow-ref name="dataweave-testingSub_Flow" doc:name="dataweave-testingSub_Flow"/>
        <json:json-to-object-transformer returnClass="java.util.ArrayList" doc:name="JSON to Object"/>
        <munit:assert-on-equals expectedValue="#[2]" actualValue="#[payload.size()]" doc:name="Assert Equals"/>
        <munit:assert-on-equals expectedValue="#[36]" actualValue="#[payload[0].age]" doc:name="Assert Equals"/>
    </munit:test>
```

**Note:** It may also be possible to convert the DataWeave output to JSON string and then use [JSON evaluator](https://docs.mulesoft.com/mule-user-guide/v/3.7/non-mel-expressions-configuration-reference#expression-evaluator-reference) for MEL Expression.

## Writing Java JUnit Test Case

We can also use java to write our test case. Logic and steps will be similar to that of xml. Here is our java test case -

```java
@Test
	public void testJsonOutput() throws Exception {
		String payload = FileUtils.readFileToString(
				new File(DataWeaveTests.class.getClassLoader().getResource("sample_data/employees.xml").getPath()));

		MuleEvent event = testEvent(payload);
		((DefaultMuleMessage) event.getMessage()).setMimeType(MimeTypes.APPLICATION_XML);

		MuleEvent reply = runFlow("dataweave-testingSub_Flow", event);

		//Create and initialise JSON to Object transformer. All below steps are required.
		JsonToObject jto = new JsonToObject();
		jto.setMuleContext(muleContext);
		jto.setReturnDataType(DataTypeFactory.create(ArrayList.class, HashMap.class));
		jto.initialise();


		List<Map> data = (List<Map>) jto.transform(reply.getMessage().getPayloadAsString(), reply);

		Assert.assertEquals(2, data.size());
		Assert.assertEquals(36, data.get(0).get("age"));
	}
```
**Note:** If you run into some error like "more than one transformers found" for getPayloadAsString() method, then try using  `ObjectToString` transformer to convert to dataweave output to String.

```java
ObjectToString ots = new ObjectToString();
		ots.setMuleContext(muleContext);
		ots.initialise();
		List<Map> data = (List<Map>) jto.transform(ots.transform(reply.getMessage().getPayload()), reply);
```

And That's all about it, so simple :)

Hope this helps to write safe code!
