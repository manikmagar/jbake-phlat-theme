title=How to Read YAML in Java with Jackson
date=2016-05-15T18:25:10+00:00
author=Manik Magar
summary: "In this post, we will see how we can use Jackson's YamlFactory to read YAML files into Java Beans."
type=post
guid=https://www.myjavaacademy.com/?p=392
permalink=/read-yaml-java-jackson/
tags=Java, YAML
status=published
~~~~~~
In this post, we will see how we can use Jackson&#8217;s YamlFactory to read YAML files into Java Beans. 

#### What is YAML?

> <a href="http://yaml.org" target="_blank">YAML</a> is a human friendly data serialization
    
> standard for all programming languages. 

YAML is very handy to write system configuration files. [Yaml.org](http://yaml.org) has a list of libraries that you can use to process YAML files in different languages like PHP, Java, Python, Perl etc.

<a href="https://github.com/FasterXML/jackson" target="_blank">Jackson</a> is one of the best JSON library for java. Now with YAML extension of Jackson, we can use Jackson to process YAML in Java. Jackson&#8217;s YAML extension uses <a href="https://bitbucket.org/asomov/snakeyaml/" target="_blank">SnakeYAML</a> library to parse YAML. 

#### Maven Project Dependencies

We need Jackason databind and Jackson&#8217;s YAML extension. Below dependencies should get our demo code working &#8211;

<pre class="brush: xml; title=; notranslate" title="">&lt;dependencies&gt;
  	&lt;dependency&gt;
  		&lt;groupId&gt;com.fasterxml.jackson.dataformat&lt;/groupId&gt;
  		&lt;artifactId&gt;jackson-dataformat-yaml&lt;/artifactId&gt;
  		&lt;version&gt;2.3.0&lt;/version&gt;
  	&lt;/dependency&gt;
  	&lt;dependency&gt;
  		&lt;groupId&gt;com.fasterxml.jackson.core&lt;/groupId&gt;
  		&lt;artifactId&gt;jackson-databind&lt;/artifactId&gt;
  		&lt;version&gt;2.2.3&lt;/version&gt;
  	&lt;/dependency&gt;
  	&lt;dependency&gt;
  		&lt;groupId&gt;org.apache.commons&lt;/groupId&gt;
  		&lt;artifactId&gt;commons-lang3&lt;/artifactId&gt;
  		&lt;version&gt;3.4&lt;/version&gt;
  	&lt;/dependency&gt;
  &lt;/dependencies&gt;
</pre>

#### Reading YAML file to Java Objects

Let&#8217;s consider below sample YAML file for demo purpose &#8211;

<pre># Details of a user
---
name: Test User
age: 30
address:
  line1: My Address Line 1
  line2: Address line 2
  city: Washington D.C.
  zip: 20000
roles: 
  - User
  - Editor
</pre>

Let&#8217;s create User.java Bean to hold our YAML data.

<pre class="brush: java; title=; notranslate" title="">package com.mms.mja.blog.demo.yaml;

import java.util.Map;

public class User {
	private String name;
	private int age;
	private Map&lt;String, String&gt; address;
	private String[] roles;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public Map&lt;String, String&gt; getAddress() {
		return address;
	}
	public void setAddress(Map&lt;String, String&gt; address) {
		this.address = address;
	}
	public String[] getRoles() {
		return roles;
	}
	public void setRoles(String[] roles) {
		this.roles = roles;
	}
}
</pre>

Now, here is our code using Jackson&#8217;s YamlFactory to read YAML into User bean &#8211;

<pre class="brush: java; title=; notranslate" title="">package com.mms.mja.blog.demo.yaml;

import java.io.File;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory;

public class YamlTesting {

	public static void main(String[] args) {
		ObjectMapper mapper = new ObjectMapper(new YAMLFactory());
		try {
			User user = mapper.readValue(new File("user.yaml"), User.class);
			System.out.println(ReflectionToStringBuilder.toString(user,ToStringStyle.MULTI_LINE_STYLE));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
</pre>

ReflectionToStringBuilder is just a util class to print Java Object to String. Here is the output of this program &#8211; 

<pre class="brush: java; title=; notranslate" title="">com.mms.mja.blog.demo.yaml.User@36d4b5c[
  name=Test User
  age=30
  address={line1=My Address Line 1, line2=Address line 2, city=Washington D.C., zip=20000}
  roles={User,Editor}
]

</pre>

YamlFactory has taken care of mapping address into MAP and roles into String array. We can also create Address.java bean class to hold Address data and use it instead of MAP in User bean. YamlFactory will take care of creating Address object using YAML values.

#### References:

  1. <a href="https://github.com/FasterXML/jackson-dataformat-yaml" target="_blank">Jackson Yaml Extension</a>
  2. <a href="http://yaml.org" target="_blank">YAML</a>