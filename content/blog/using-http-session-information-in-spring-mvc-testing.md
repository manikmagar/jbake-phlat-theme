title=Using HTTP Session information in Spring MVC Testing
date=2013-01-21
author=Manik Magar
type=post
guid=https://manikmagar.wordpress.com/?p=93
permalink=/using-http-session-information-in-spring-mvc-testing/
tags=JUnit,Spring MVC
status=published
~~~~~~
With Spring 3.2, MVC testing is now integrated in the framework itself as Spring-test project. These are simple and easy ways to test your MVC. A simple introduction can be read <a href="http://blog.springsource.org/2012/11/12/spring-framework-3-2-rc1-spring-mvc-test-framework/" target="_blank">here</a>.

A very common scenario in any web application is dependency on User Authenticated Sessions in-between multiple requests.

For a usual MVC testing we can write a test case to test functionality. We will see here how we can use applications Authentication service to authenticate user and use its session across multiple requests.

Here is a pom.xml &#8211;

<pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">project</span> <span class="attr">xmlns</span><span class="kwrd">="http://maven.apache.org/POM/4.0.0"</span> 
<span class="attr">xmlns:xsi</span><span class="kwrd">="http://www.w3.org/2001/XMLSchema-instance"</span> 
<span class="attr">xsi:schemaLocation</span><span class="kwrd">="http://maven.apache.org/POM/4.0.0 
http://maven.apache.org/xsd/maven-4.0.0.xsd"</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">modelVersion</span><span class="kwrd">&gt;</span>4.0.0<span class="kwrd">&lt;/</span><span class="html">modelVersion</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>SpringMVC<span class="kwrd">&lt;/</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">packaging</span><span class="kwrd">&gt;</span>war<span class="kwrd">&lt;/</span><span class="html">packaging</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">name</span><span class="kwrd">&gt;</span>SpringMVC<span class="kwrd">&lt;/</span><span class="html">name</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">dependencies</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">groupId</span><span class="kwrd">&gt;</span>org.springframework<span class="kwrd">&lt;/</span><span class="html">groupId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>spring-webmvc<span class="kwrd">&lt;/</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>3.2.0.RELEASE<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;/</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">groupId</span><span class="kwrd">&gt;</span>org.springframework<span class="kwrd">&lt;/</span><span class="html">groupId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>spring-test<span class="kwrd">&lt;/</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>3.2.0.RELEASE<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;/</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">groupId</span><span class="kwrd">&gt;</span>junit<span class="kwrd">&lt;/</span><span class="html">groupId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>junit<span class="kwrd">&lt;/</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>4.10<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;/</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">groupId</span><span class="kwrd">&gt;</span>javax.servlet<span class="kwrd">&lt;/</span><span class="html">groupId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>servlet-api<span class="kwrd">&lt;/</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>3.0-alpha-1<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">scope</span><span class="kwrd">&gt;</span>provided<span class="kwrd">&lt;/</span><span class="html">scope</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;/</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
     <span class="kwrd">&lt;</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">groupId</span><span class="kwrd">&gt;</span>com.jayway.jsonpath<span class="kwrd">&lt;/</span><span class="html">groupId</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>json-path<span class="kwrd">&lt;/</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>0.8.1<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">scope</span><span class="kwrd">&gt;</span>compile<span class="kwrd">&lt;/</span><span class="html">scope</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">optional</span><span class="kwrd">&gt;</span>true<span class="kwrd">&lt;/</span><span class="html">optional</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;/</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">groupId</span><span class="kwrd">&gt;</span>org.codehaus.jackson<span class="kwrd">&lt;/</span><span class="html">groupId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>jackson-mapper-asl<span class="kwrd">&lt;/</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>1.9.11<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;/</span><span class="html">dependency</span><span class="kwrd">&gt;</span>

      <span class="kwrd">&lt;</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">groupId</span><span class="kwrd">&gt;</span>org.springframework<span class="kwrd">&lt;/</span><span class="html">groupId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>spring-core<span class="kwrd">&lt;/</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>3.2.0.RELEASE<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;/</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">groupId</span><span class="kwrd">&gt;</span>org.codehaus.jackson<span class="kwrd">&lt;/</span><span class="html">groupId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>jackson-core-asl<span class="kwrd">&lt;/</span><span class="html">artifactId</span><span class="kwrd">&gt;</span>
          <span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>1.9.11<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;/</span><span class="html">dependency</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;/</span><span class="html">dependencies</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">version</span><span class="kwrd">&gt;</span>1.0.0<span class="kwrd">&lt;/</span><span class="html">version</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">groupId</span><span class="kwrd">&gt;</span>com.mms.blogs<span class="kwrd">&lt;/</span><span class="html">groupId</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">project</span><span class="kwrd">&gt;</span></pre>

&#160;

Let’s configure Spring MVC. Here is SpringMVC-context.xml &#8211;

<pre class="csharpcode"><span class="kwrd">&lt;?</span><span class="html">xml</span> <span class="attr">version</span><span class="kwrd">="1.0"</span> <span class="attr">encoding</span><span class="kwrd">="UTF-8"</span>?<span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">beans</span> <span class="attr">xmlns</span><span class="kwrd">="http://www.springframework.org/schema/beans"</span>
        <span class="attr">xmlns:context</span><span class="kwrd">="http://www.springframework.org/schema/context"</span>
        <span class="attr">xmlns:mvc</span><span class="kwrd">="http://www.springframework.org/schema/mvc"</span>
    <span class="attr">xmlns:xsi</span><span class="kwrd">="http://www.w3.org/2001/XMLSchema-instance"</span>
    <span class="attr">xsi:schemaLocation</span><span class="kwrd">="http://www.springframework.org/schema/beans
                     http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
                     http://www.springframework.org/schema/mvc
                     http://www.springframework.org/schema/mvc/spring-mvc-3.2.xsd
                     http://www.springframework.org/schema/context
                     http://www.springframework.org/schema/context/spring-context-3.2.xsd"</span><span class="kwrd">&gt;</span>
                     
    
    <span class="kwrd">&lt;</span><span class="html">mvc:annotation-driven</span><span class="kwrd">/&gt;</span>
    
    
    <span class="kwrd">&lt;</span><span class="html">context:component-scan</span> <span class="attr">base-package</span><span class="kwrd">="com.mms.blogs.demo.SpringMVC"</span><span class="kwrd">/&gt;</span>

    <span class="kwrd">&lt;</span><span class="html">bean</span> <span class="attr">class</span><span class="kwrd">="org.springframework.web.servlet.view.InternalResourceViewResolver"</span><span class="kwrd">&gt;</span>
        <span class="kwrd">&lt;</span><span class="html">property</span> <span class="attr">name</span><span class="kwrd">="prefix"</span><span class="kwrd">&gt;</span>
            <span class="kwrd">&lt;</span><span class="html">value</span><span class="kwrd">&gt;</span>/WEB-INF/jsp/<span class="kwrd">&lt;/</span><span class="html">value</span><span class="kwrd">&gt;</span>
        <span class="kwrd">&lt;/</span><span class="html">property</span><span class="kwrd">&gt;</span>
        <span class="kwrd">&lt;</span><span class="html">property</span> <span class="attr">name</span><span class="kwrd">="suffix"</span><span class="kwrd">&gt;</span>
            <span class="kwrd">&lt;</span><span class="html">value</span><span class="kwrd">&gt;</span>.jsp<span class="kwrd">&lt;/</span><span class="html">value</span><span class="kwrd">&gt;</span>
        <span class="kwrd">&lt;/</span><span class="html">property</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;/</span><span class="html">bean</span><span class="kwrd">&gt;</span>

<span class="kwrd">&lt;/</span><span class="html">beans</span><span class="kwrd">&gt;</span></pre>

&#160;

web.ml

<pre class="csharpcode"><span class="kwrd">&lt;?</span><span class="html">xml</span> <span class="attr">version</span><span class="kwrd">="1.0"</span> <span class="attr">encoding</span><span class="kwrd">="UTF-8"</span>?<span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">web-app</span> <span class="attr">xmlns:xsi</span><span class="kwrd">="http://www.w3.org/2001/XMLSchema-instance"</span> 
<span class="attr">xmlns</span><span class="kwrd">="http://java.sun.com/xml/ns/javaee"</span> 
<span class="attr">xmlns:web</span><span class="kwrd">="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"</span> 
<span class="attr">xsi:schemaLocation</span><span class="kwrd">="http://java.sun.com/xml/ns/javaee 
http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"</span> 
<span class="attr">id</span><span class="kwrd">="WebApp_ID"</span> <span class="attr">version</span><span class="kwrd">="3.0"</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">display-name</span><span class="kwrd">&gt;</span>SpringMVC<span class="kwrd">&lt;/</span><span class="html">display-name</span><span class="kwrd">&gt;</span>
  
  <span class="kwrd">&lt;</span><span class="html">context-param</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">param-name</span><span class="kwrd">&gt;</span>contextConfigLocation<span class="kwrd">&lt;/</span><span class="html">param-name</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">param-value</span><span class="kwrd">&gt;</span>/WEB-INF/classes/SpringMVC-context.xml<span class="kwrd">&lt;/</span><span class="html">param-value</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;/</span><span class="html">context-param</span><span class="kwrd">&gt;</span>
  
  <span class="kwrd">&lt;</span><span class="html">listener</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">listener-class</span><span class="kwrd">&gt;</span>org.springframework.web.context.ContextLoaderListener<span class="kwrd">&lt;/</span><span class="html">listener-class</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;/</span><span class="html">listener</span><span class="kwrd">&gt;</span>
  
  <span class="kwrd">&lt;</span><span class="html">servlet</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">servlet-name</span><span class="kwrd">&gt;</span>SpringMVC<span class="kwrd">&lt;/</span><span class="html">servlet-name</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">servlet-class</span><span class="kwrd">&gt;</span>org.springframework.web.servlet.DispatcherServlet<span class="kwrd">&lt;/</span><span class="html">servlet-class</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;/</span><span class="html">servlet</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">servlet-mapping</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">servlet-name</span><span class="kwrd">&gt;</span>SpringMVC<span class="kwrd">&lt;/</span><span class="html">servlet-name</span><span class="kwrd">&gt;</span>
      <span class="kwrd">&lt;</span><span class="html">url-pattern</span><span class="kwrd">&gt;</span>/*<span class="kwrd">&lt;/</span><span class="html">url-pattern</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;/</span><span class="html">servlet-mapping</span><span class="kwrd">&gt;</span>
  
  <span class="kwrd">&lt;</span><span class="html">welcome-file-list</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>index.html<span class="kwrd">&lt;/</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>index.htm<span class="kwrd">&lt;/</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>index.jsp<span class="kwrd">&lt;/</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>default.html<span class="kwrd">&lt;/</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>default.htm<span class="kwrd">&lt;/</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>default.jsp<span class="kwrd">&lt;/</span><span class="html">welcome-file</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;/</span><span class="html">welcome-file-list</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">web-app</span><span class="kwrd">&gt;</span></pre>

&#160;

Until here was all configuration part of the application. Now let’s see the java classes involved in our testing.

User, a value object that will hold the user information and will reside in session object once user passes authentication.

<pre class="csharpcode">package com.mms.blogs.demo.SpringMVC.vo;

<span class="kwrd">public</span> <span class="kwrd">class</span> User {

    <span class="kwrd">private</span> String userid;
    <span class="kwrd">private</span> String firstName;
    <span class="kwrd">private</span> String lastName;
    <span class="kwrd">public</span> String getUserid() {
        <span class="kwrd">return</span> userid;
    }
    <span class="kwrd">public</span> <span class="kwrd">void</span> setUserid(String userid) {
        <span class="kwrd">this</span>.userid = userid;
    }
    <span class="kwrd">public</span> String getFirstName() {
        <span class="kwrd">return</span> firstName;
    }
    <span class="kwrd">public</span> <span class="kwrd">void</span> setFirstName(String firstName) {
        <span class="kwrd">this</span>.firstName = firstName;
    }
    <span class="kwrd">public</span> String getLastName() {
        <span class="kwrd">return</span> lastName;
    }
    <span class="kwrd">public</span> <span class="kwrd">void</span> setLastName(String lastName) {
        <span class="kwrd">this</span>.lastName = lastName;
    }
}</pre>

Let’s take a look at LoginController. This will be an entry point to our application where User will be authenticated and a session object will be set for the user. Subsequent requests from this user will expect a User object in session with his information. More info on Session Attributes can be read on [http://vard-lokkur.blogspot.com/2011/01/spring-mvc-session-attributes-handling.html](http://vard-lokkur.blogspot.com/2011/01/spring-mvc-session-attributes-handling.html "http://vard-lokkur.blogspot.com/2011/01/spring-mvc-session-attributes-handling.html")

Note a declaration of @SessionAttribute with key as “user” and type as “User”. This means, when we create a User object and put it in return model with key “user”, framework will synchronize this object with Session and put it in session.

&#160;

<pre class="csharpcode">package com.mms.blogs.demo.SpringMVC.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mms.blogs.demo.SpringMVC.vo.User;

@Controller
@RequestMapping(<span class="kwrd">value</span>=<span class="str">"/login"</span>,method=RequestMethod.POST)
@SessionAttributes(<span class="kwrd">value</span>=<span class="str">"user"</span>,types=User.<span class="kwrd">class</span>)
<span class="kwrd">public</span> <span class="kwrd">class</span> LoginController {

    @RequestMapping(<span class="kwrd">value</span>=<span class="str">"/authenticate"</span>,method=RequestMethod.POST)
    <span class="kwrd">public</span> String authenticate(@RequestParam String userid, Model model){
        <span class="rem">// effectively you can put your any LoginService here to authenticate user</span>
        User user = <span class="kwrd">new</span> User();
        user.setUserid(userid);
        user.setFirstName(<span class="str">"Manik"</span>);
        user.setLastName(<span class="str">"M"</span>);
        <span class="rem">// Since we have defined SessionAttribute user, this object will be stored at SessionLevel</span>
        model.addAttribute(<span class="str">"user"</span>, user);
        
        <span class="kwrd">return</span> <span class="str">"Home"</span>;
    }
    
}</pre>

&#160;

&#160;

Now as we have LoginController ready, lets see another controller that will consume this User session to print user name. Here is a simple EchoUserController that gets the User object from session and returns to caller. something to note here &#8211;

  * This declares a SessionAttribute user, so will expect one pre-set in session. 
  * getUser method has a argument with @ModelAttribute(“user”). This means when this method is called, framework will expect a session attribute with key “user” and type “User”. If this exists, framework will pass it to the method else it will throw an exception for missing session attribute and call to invoke this method will fail. 
  * For some reason, if session attribute with key “user” exists but value is null then we can implement our own check. 

&#160;

&#160;

<pre class="csharpcode">package com.mms.blogs.demo.SpringMVC.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mms.blogs.demo.SpringMVC.vo.User;

@Controller
@SessionAttributes(<span class="kwrd">value</span>=<span class="str">"user"</span>,types=User.<span class="kwrd">class</span>)
@RequestMapping(<span class="kwrd">value</span>=<span class="str">"/echo"</span>)
<span class="kwrd">public</span> <span class="kwrd">class</span> EchoUserController {

    @RequestMapping(<span class="kwrd">value</span>=<span class="str">"/getuser"</span>,method=RequestMethod.POST)
    <span class="kwrd">public</span> @ResponseBody User getUser(@ModelAttribute(<span class="str">"user"</span>) User user, BindingResult result, Model model){
        <span class="kwrd">if</span>(user == <span class="kwrd">null</span>){
            <span class="kwrd">throw</span> <span class="kwrd">new</span> RuntimeException(<span class="str">"User not found"</span>);
        }
        <span class="kwrd">return</span> user;
    }
}</pre>

&#160;

So we are all set with a layout to test our requests using Spring MVC test. Look at the below test class and we will go over each test case &#8211;

<pre class="csharpcode">package com.mms.blogs.demo.SpringMVC.Controller;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@WebAppConfiguration(<span class="kwrd">value</span>=<span class="str">"src/main/webapp"</span>)
@ContextConfiguration(locations={<span class="str">"classpath:SpringMVC-context.xml"</span>})
<span class="kwrd">public</span> <span class="kwrd">class</span> EchoUserControllerTest extends AbstractJUnit4SpringContextTests {

    @Autowired
    <span class="kwrd">private</span> WebApplicationContext webapp;
    
    <span class="kwrd">private</span> MockMvc mockMvc;
    
    @Before
    <span class="kwrd">public</span> <span class="kwrd">void</span> setup(){
        <span class="kwrd">this</span>.mockMvc = MockMvcBuilders.webAppContextSetup(webapp).build();
    }
    
    @Test
    <span class="kwrd">public</span> <span class="kwrd">void</span> testAuthenticate() throws Exception{
        <span class="kwrd">this</span>.mockMvc.perform(MockMvcRequestBuilders.post(<span class="str">"/login/authenticate"</span>)
                                .param(<span class="str">"userid"</span>, <span class="str">"MMS1"</span>))
                                .andExpect(MockMvcResultMatchers.status().isOk())
                                .andExpect(MockMvcResultMatchers.model().attributeExists(<span class="str">"user"</span>))
                                .andDo(MockMvcResultHandlers.print());
    }
    
    @Test
    <span class="kwrd">public</span> <span class="kwrd">void</span> testGetUser1() throws Exception{
        
        <span class="kwrd">this</span>.mockMvc.perform(MockMvcRequestBuilders.post(<span class="str">"/echo/getuser"</span>)).
            andExpect(MockMvcResultMatchers.jsonPath(<span class="str">"$.userid"</span>).<span class="kwrd">value</span>(<span class="str">"mms"</span>));
    }
    
    @Test
    <span class="kwrd">public</span> <span class="kwrd">void</span> testGetUser2() throws Exception{
    
        ResultActions auth =<span class="kwrd">this</span>.mockMvc.perform(MockMvcRequestBuilders.post(<span class="str">"/login/authenticate"</span>)
                                                .param(<span class="str">"userid"</span>, <span class="str">"MMS1"</span>));
        
        MvcResult result = auth.andReturn();
        
        MockHttpSession session = (MockHttpSession)result.getRequest().getSession();
        
        RequestBuilder echoUserReq = MockMvcRequestBuilders.post(<span class="str">"/echo/getuser"</span>).session(session);
        
        <span class="kwrd">this</span>.mockMvc.perform(echoUserReq)
                .andDo(MockMvcResultHandlers.print()).
            andExpect(MockMvcResultMatchers.jsonPath(<span class="str">"$.userid"</span>).<span class="kwrd">value</span>(<span class="str">"MMS1"</span>));
    }
}</pre>

&#160;

setup() method will initialize and build a MockMVC object for us using our webapp and configuration.

&#160;

testAuthenticate() tests our LoginController.authenticate(). It passes userid to authenticate and setup session. This test should pass.

&#160;

testGetUser1() tests our EchoUserController.getUser() method. This test case call getUser and expects value of userid property in returned User object to match with “MMS1”. So as we have seen earlier, getUser method expects a session attribute user. Every request in MockMVC is independent of other. Calling testAuthenticate() first and the testGetUser1() will run different contexts and hence session set by former will not be visible to later. Here, testGetUser1()&#160; is expected to fail for missing user attribute in session.

&#160;

testGetUser2() agains tests getUser() method but here difference is we will be providing authenticated session to it. To do so, we will call authenticate method first &#8211; 

<pre class="csharpcode">ResultActions auth =<span class="kwrd">this</span>.mockMvc
                .perform(MockMvcRequestBuilders.post(<span class="str">"/login/authenticate"</span>)
                                                .param(<span class="str">"userid"</span>, <span class="str">"MMS1"</span>));</pre>

&#160;

This call will authenticate user and set up a session for it. Let’s get the result of it in ‘auth’ of type ResultAction.

Second step is now to retrieve Session object from this response to use further.

<pre class="csharpcode">MvcResult result = auth.andReturn();
            
MockHttpSession session = (MockHttpSession)result.getRequest().getSession();</pre>

&#160;

So we got an authenticated session for this user. Now we can pass this session to any other request. Let’s call our getUser() method again but this time setting session on the request.

<pre class="csharpcode">RequestBuilder echoUserReq = MockMvcRequestBuilders.post(<span class="str">"/echo/getuser"</span>).session(session);</pre>

Here, we build our request and attach a session to it. With this we have made an authenticated session available to this request to getuser. Once done, below test step is expected to pass, returning User object.

<pre class="csharpcode"><span class="kwrd">this</span>.mockMvc.perform(echoUserReq)
                .andDo(MockMvcResultHandlers.print()).
            andExpect(MockMvcResultMatchers.jsonPath(<span class="str">"$.userid"</span>).<span class="kwrd">value</span>(<span class="str">"MMS1"</span>));</pre>

&#160;

&#160;

We are done! See, it’s so easy to use sessions in testing. This also makes sure we are testing our getUser with real sessions created by actual LoginController and not any dummy session created for testing purpose where there is a chance that it may differ from actual sessions created by application via LoginController.

&#160;

Enjoy!!