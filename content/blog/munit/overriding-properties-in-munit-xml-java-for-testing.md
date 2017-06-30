+++
author = "Manik Magar"
categories = ["MUnit"]
date = "2016-07-24T22:41:09-04:00"
description = ""
featured = ""
featuredalt = ""
featuredpath = ""
linktitle = ""
title = "Overriding Properties in MUnit XML and Java for testing"
type = "post"
url = "/blog/2016/07/24/overriding-properties-in-munit-xml-java-for-testing/"
tags=munit, properties
+++
It is very common for any mule application to use external properties files.  **In this post, we will see how we can override properties values for testing.** We will also cover how we can write to temporary folder during munit test, disable connector mocking and asserting file existence.

For demonstration purpose, we will have a flow that uses DataWeave to convert xml file into csv and writes to an output folder using `file:outbound-endpoint`. Let's read the output path from properties file with key `explore.mule.target.folder`.  As we are going to write file during testing, we will need munit not to mock the connectors.

Here is our production code that declares a `context:property-placeholder` to read properties from `src/main/resources/explore-mule.properties`

```xml
<?xml version="1.0" encoding="UTF-8"?>

<mule xmlns:context="http://www.springframework.org/schema/context"
	xmlns:dw="http://www.mulesoft.org/schema/mule/ee/dw"
	xmlns:file="http://www.mulesoft.org/schema/mule/file"
	xmlns="http://www.mulesoft.org/schema/mule/core" xmlns:doc="http://www.mulesoft.org/schema/mule/documentation"
	xmlns:spring="http://www.springframework.org/schema/beans" version="EE-3.8.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="
http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-current.xsd
http://www.mulesoft.org/schema/mule/ee/dw http://www.mulesoft.org/schema/mule/ee/dw/current/dw.xsd
http://www.mulesoft.org/schema/mule/file http://www.mulesoft.org/schema/mule/file/current/mule-file.xsd http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-current.xsd
http://www.mulesoft.org/schema/mule/core http://www.mulesoft.org/schema/mule/core/current/mule.xsd">

    <context:property-placeholder location="explore-mule.properties"/>


    <flow name="properties-testingFlow3">
        <file:inbound-endpoint path="input3" moveToDirectory="output" responseTimeout="10000" doc:name="File"/>
        <dw:transform-message doc:name="Transform Message">
            <dw:input-payload doc:sample="sample_data/empty.xml"/>
            <dw:set-payload resource="classpath:dwl/employees2.dwl"/>
        </dw:transform-message>
        <file:outbound-endpoint path="${explore.mule.target.folder}" outputPattern="output.csv" doc:name="File"/>
    </flow>

</mule>

```



## Overriding Properties in XML

Similar to specifying properties in production code, we can create a copy of properties files under `/src/test/resource/env/test/explore-mule.properties` and refer to it inside xml using `context:property-placeholder`.

Below XML MUnit suite shows this option in action. In test explore-mule.properties, we set `explore.mule.target.folder=test-output` and then verify that output.csv exists after test case executes.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<mule xmlns:context="http://www.springframework.org/schema/context"
	xmlns="http://www.mulesoft.org/schema/mule/core" xmlns:doc="http://www.mulesoft.org/schema/mule/documentation" xmlns:munit="http://www.mulesoft.org/schema/mule/munit" xmlns:spring="http://www.springframework.org/schema/beans" xmlns:core="http://www.mulesoft.org/schema/mule/core" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-current.xsd
http://www.mulesoft.org/schema/mule/munit http://www.mulesoft.org/schema/mule/munit/current/mule-munit.xsd
http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-current.xsd
http://www.mulesoft.org/schema/mule/core http://www.mulesoft.org/schema/mule/core/current/mule.xsd">

 <context:property-placeholder location="env/test/explore-mule.properties"/>

    <munit:config name="munit" doc:name="MUnit configuration" mock-connectors="false"/>
    <spring:beans>
        <spring:import resource="classpath:sample-flows.xml"/>
    </spring:beans>
    <munit:test name="sample-flows-test-suite-properties-testingFlow3Test" description="Test">
    	<munit:set
			payload="#[getResource('sample_data/employees.xml').asStream()]"
			doc:name="Set Message" mimeType="application/xml" />
        <flow-ref name="properties-testingFlow3" doc:name="Flow-ref to properties-testingFlow3"/>
        <munit:assert-true condition="#[new java.io.File('./test-output/output.csv').exists()]" doc:name="Assert True"/>

    </munit:test>
</mule>

```

Don't forget to disable connector mocking by adding `mock-connectors="false"` in `munit:config`.



## Overriding Properties in FunctionalMunitSuite

When you write a munit test case in java using FunctionalMunitSuite, it is more flexible to set properties. When `FunctionalMunitSuite` creates the mocking configuration during init, it calls a protected method `protected Properties getStartUpProperties() `  to get the properties for tests. Default implementation in FunctionalMUnitSuite returns null but we can easily override this function in our test suite to return an instance of `java.util.Properties`.

One benefit of this over xml approach is, you get to use power of java while setting properties values. In this example, we will use `org.junit.rules.TemporaryFolder` to create a temporary folder and set that as a target folder. If we really use this as a junit `Rule` then JUnit can take care of deleting temporary folder, but here we can use that as rule because `getStartUpProperties` is called once a testSuite/context initialization so we will keep reference to our properties and folders. So we will also add an `AfterClass` method to delete this folder.

Below Java code shows this in action. At the end of our test case, we assert that the target temporary folder contains output.csv.

```java
package com.mms.mule.explore;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import org.hamcrest.MatcherAssert;
import org.hamcrest.Matchers;
import org.junit.AfterClass;
import org.junit.Test;
import org.junit.rules.TemporaryFolder;
import org.mule.DefaultMuleMessage;
import org.mule.api.MuleEvent;
import org.mule.munit.runner.functional.FunctionalMunitSuite;
import org.mule.transformer.types.MimeTypes;
import org.mule.util.FileUtils;

public class PropertiesTestSuite extends FunctionalMunitSuite {

	private Properties props;
	private static TemporaryFolder tempFolder;

	@Override
	protected String getConfigResources() {
		return "sample-flows.xml";
	}

	@Override
	protected boolean haveToMockMuleConnectors() {
		return false;
	}

	@AfterClass
	public static void cleanup(){
		tempFolder.delete();
	}

	@Override
	protected Properties getStartUpProperties() {
		props = super.getStartUpProperties();
		if(props == null){
			props = new Properties();
		}
		tempFolder = new TemporaryFolder();
		try {
			tempFolder.create();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String path =tempFolder.getRoot().getAbsolutePath();
		System.out.println("Setting path to - "+ path);
		props.setProperty("explore.mule.target.folder", path);

		return props;
	}

	@Test
	public void testFileWriting() throws Exception{
		String payload = FileUtils.readFileToString(new File(DataWeaveTests.class.getClassLoader().getResource("sample_data/employees.xml").getPath()));

		MuleEvent event = testEvent(payload);
		((DefaultMuleMessage)event.getMessage()).setMimeType(MimeTypes.APPLICATION_XML);

		MuleEvent reply = runFlow("properties-testingFlow3", event);

		MatcherAssert.assertThat(new File(tempFolder.getRoot(), "output.csv").exists(),Matchers.equalTo(Boolean.TRUE));
	}
}

```

Don't forget to override `haveToMockMuleConnectors()` and return false to allow file writing.

As an alternative to overriding `getStartUpProperties` method, you can also create a sample munit xml config with context:properties-placeholder and then use that inside `getConfigResources()` method.


## Test Application Source
Test Application source code is available on Github [here](https://github.com/UnitTesters/explore-mule).


## Conclusion

MUnit provides a very stable environment for testing mule flows. You can easily override your production properties inside MUnit XML as well as Java test suite.
