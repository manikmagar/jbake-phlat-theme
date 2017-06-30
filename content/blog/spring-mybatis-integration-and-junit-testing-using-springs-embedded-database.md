title=Spring MyBatis Integration and JUnit Testing using Spring’s embedded database
date=2013-01-01
author=Manik Magar
type=post
guid=https://manikmagar.wordpress.com/?p=79
permalink=/spring-mybatis-integration-and-junit-testing-using-springs-embedded-database/
tags=JUnit,MyBatis,Spring Framework
status=published
~~~~~~
Let’s look at a simple example to see how we can integrate MyBatis in Spring Application.

Maven POM for the demo &#8211;

<pre class="xml">&lt;project xmlns=<span class="str">"http://maven.apache.org/POM/4.0.0"</span> 
xmlns:xsi=<span class="str">"http://www.w3.org/2001/XMLSchema-instance"</span> 
xsi:schemaLocation=<span class="str">"http://maven.apache.org/POM/4.0.0 
http://maven.apache.org/xsd/maven-4.0.0.xsd"</span>&gt;
  &lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
  &lt;groupId&gt;com.mms.blogs&lt;/groupId&gt;
  &lt;artifactId&gt;MyBatisSpringDemo&lt;/artifactId&gt;
  &lt;version&gt;1.0.0-SNAPSHOT&lt;/version&gt;
  &lt;packaging&gt;war&lt;/packaging&gt;
  &lt;name&gt;MyBatisSpringDemo&lt;/name&gt;
      &lt;dependencies&gt;
      &lt;dependency&gt;
          &lt;groupId&gt;org.mybatis&lt;/groupId&gt;
          &lt;artifact    Id&gt;mybatis-spring&lt;/artifactId&gt;
          &lt;version&gt;1.1.1&lt;/version&gt;
      &lt;/dependency&gt;
      &lt;dependency&gt;
          &lt;groupId&gt;junit&lt;/groupId&gt;
          &lt;artifactId&gt;junit&lt;/artifactId&gt;
          &lt;version&gt;4.10&lt;/version&gt;
      &lt;/dependency&gt;
      &lt;dependency&gt;
          &lt;groupId&gt;org.springframework&lt;/groupId&gt;
          &lt;artifactId&gt;spring-test&lt;/artifactId&gt;
          &lt;version&gt;3.2.0.RELEASE&lt;/version&gt;
      &lt;/dependency&gt;
      &lt;dependency&gt;
          &lt;groupId&gt;org.springframework&lt;/groupId&gt;
          &lt;artifactId&gt;spring-tx&lt;/artifactId&gt;
          &lt;version&gt;3.2.0.RELEASE&lt;/version&gt;
      &lt;/dependency&gt;
      &lt;dependency&gt;
          &lt;groupId&gt;org.hsqldb&lt;/groupId&gt;
          &lt;artifactId&gt;hsqldb&lt;/artifactId&gt;
          &lt;version&gt;2.2.9&lt;/version&gt;
      &lt;/dependency&gt;
      &lt;dependency&gt;
          &lt;groupId&gt;org.springframework&lt;/groupId&gt;
          &lt;artifactId&gt;spring-core&lt;/artifactId&gt;
          &lt;version&gt;3.2.0.RELEASE&lt;/version&gt;
      &lt;/dependency&gt;
      &lt;dependency&gt;
          &lt;groupId&gt;org.springframework&lt;/groupId&gt;
          &lt;artifactId&gt;spring-context&lt;/artifactId&gt;
          &lt;version&gt;3.2.0.RELEASE&lt;/version&gt;
      &lt;/dependency&gt;
  &lt;/dependencies&gt;
&lt;/project&gt;</pre>

## MyBatis Mapper &#8211;

MyBatis is driven by a Mapper Interface that defines the methods to interact against database. SQL mapping code is defined in a xml file defined by the same name of the Mapper Interface.

Mapping to work correctly, below three things should match for each mapper &#8211;

  1. Interface file name and package
  2. Xml file name and its location should be same as Interface.
  3. namespace in xml file.

EmployeeMapper.java &#8211;

<pre class="csharpcode">package com.mms.blogs.demo.mybatisspring.mapper;

import com.mms.blogs.demo.mybatisspring.vo.Employee;

<span class="kwrd">public</span> <span class="kwrd">interface</span> EmployeeMapper {

    <span class="kwrd">public</span> Employee getEmployeeName(<span class="kwrd">long</span> empId);

    <span class="kwrd">public</span> <span class="kwrd">void</span> insertEmployee(Employee employee);

}</pre>

EmployeeMapper.xml &#8211;

<pre class="csharpcode">&lt;?xml version=<span class="str">"1.0"</span> encoding=<span class="str">"UTF-8"</span>?&gt;
&lt;!DOCTYPE mapper PUBLIC <span class="str">"-//mybatis.org//DTD Mapper 3.0//EN"</span> 
<span class="str">"http://mybatis.org/dtd/mybatis-3-mapper.dtd"</span>&gt;

&lt;mapper <span class="kwrd">namespace</span>=<span class="str">"com.mms.blogs.demo.mybatisspring.mapper.EmployeeMapper"</span>&gt;

    &lt;select id=<span class="str">"getEmployeeName"</span> parameterType=<span class="str">"long"</span>
        resultType=<span class="str">"com.mms.blogs.demo.mybatisspring.vo.Employee"</span>&gt;
        SELECT empid, first_name firstName,last_name lastName from employee <span class="kwrd">where</span>
        empid=#{empid}
    &lt;/select&gt;

    &lt;insert id=<span class="str">"insertEmployee"</span> parameterType=<span class="str">"com.mms.blogs.demo.mybatisspring.vo.Employee"</span>&gt;
        insert into employee (empid,first_name,last_name) values
        (#{empid},#{firstName},#{lastName})
    &lt;/insert&gt;

&lt;/mapper&gt;</pre>

Employee.java – VO Object

<pre class="csharpcode">package com.mms.blogs.demo.mybatisspring.vo;

import org.springframework.stereotype.Component;

@Component
<span class="kwrd">public</span> <span class="kwrd">class</span> Employee {
    <span class="kwrd">private</span> <span class="kwrd">long</span> empid;
    <span class="kwrd">private</span> String firstName;
    <span class="kwrd">private</span> String lastName;
    <span class="kwrd">public</span> <span class="kwrd">long</span> getEmpid() {
        <span class="kwrd">return</span> empid;
    }
    <span class="kwrd">public</span> <span class="kwrd">void</span> setEmpid(<span class="kwrd">long</span> empid) {
        <span class="kwrd">this</span>.empid = empid;
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

## Spring Application Context &#8211;

Following is the application context for this demo &#8211;

<pre class="csharpcode">&lt;?xml version=<span class="str">"1.0"</span> encoding=<span class="str">"UTF-8"</span>?&gt;
&lt;beans xmlns=<span class="str">"http://www.springframework.org/schema/beans"</span>
        xmlns:context=<span class="str">"http://www.springframework.org/schema/context"</span>
        xmlns:jdbc=<span class="str">"http://www.springframework.org/schema/jdbc"</span>
    xmlns:xsi=<span class="str">"http://www.w3.org/2001/XMLSchema-instance"</span>
    xsi:schemaLocation=<span class="str">"http://www.springframework.org/schema/beans
                     http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
                     http://www.springframework.org/schema/context
                     http://www.springframework.org/schema/context/spring-context-3.2.xsd
                     http://www.springframework.org/schema/jdbc
                     http://www.springframework.org/schema/jdbc/spring-jdbc-3.2.xsd"</span>&gt;

    &lt;context:annotation-config/&gt;

    &lt;context:component-scan <span class="kwrd">base</span>-package=<span class="str">"com.mms.blogs.demo.mybatisspring"</span>&gt;&lt;/context:component-scan&gt;

    &lt;jdbc:embedded-database id=<span class="str">"dataSource"</span>&gt;
        &lt;jdbc:script location=<span class="str">"classpath:schema.sql"</span>/&gt;
    &lt;/jdbc:embedded-database&gt;

    &lt;bean id=<span class="str">"transactionManager"</span> <span class="kwrd">class</span>=<span class="str">"org.springframework.jdbc.datasource.DataSourceTransactionManager"</span>&gt;
        &lt;property name=<span class="str">"dataSource"</span> <span class="kwrd">ref</span>=<span class="str">"dataSource"</span>/&gt;
    &lt;/bean&gt;

    &lt;bean <span class="kwrd">class</span>=<span class="str">"org.mybatis.spring.SqlSessionFactoryBean"</span> id=<span class="str">"sqlSessionFactory"</span>&gt;
        &lt;property name=<span class="str">"dataSource"</span> <span class="kwrd">ref</span>=<span class="str">"dataSource"</span>/&gt;
    &lt;/bean&gt;

    &lt;bean <span class="kwrd">class</span>=<span class="str">"org.mybatis.spring.mapper.MapperScannerConfigurer"</span>&gt;
        &lt;property name=<span class="str">"sqlSessionFactoryBeanName"</span> <span class="kwrd">value</span>=<span class="str">"sqlSessionFactory"</span>/&gt;
        &lt;property name=<span class="str">"basePackage"</span> <span class="kwrd">value</span>=<span class="str">"com.mms.blogs.demo.mybatisspring.mapper"</span>/&gt;
     &lt;/bean&gt;

&lt;/beans&gt;</pre>

  1. Enable annotation config to Autowire our Spring configuration and also Autowire MyBatis mappers where ever needed.
  2. component-scan provides base package to look for components.
  3. TransactionManager to handle transactions
  4. Spring’s embedded database instance. This loads the sample teable Employee into embedded database using sql defined in compile.sql script.
  5. Bean for org.mybatis.spring.SqlSessionFactoryBean to configure the datasource.
  6. MapperScannerConfigurer – This class initializes a bean for each of the mapper interface defined in basePackage and injects sqlSessionFactory instance in it. This enables Autowiring of the mapper interfaces in code.

Schema.sql &#8211;

<pre class="csharpcode">create table employee(
    empid BIGINT,
    first_name varchar(50),
    last_name varchar(50)
    );</pre>

So with all above configuration MyBatis is now integrated with Spring. Let’s write a simple JUnit to test our integration &#8211;

<pre class="csharpcode">package com.mms.blogs.demo.mybatisspring.mapper;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mms.blogs.demo.mybatisspring.vo.Employee;

@RunWith(SpringJUnit4ClassRunner.<span class="kwrd">class</span>)
@ContextConfiguration(<span class="kwrd">value</span>={<span class="str">"classpath:applicationContext.xml"</span>})
<span class="kwrd">public</span> <span class="kwrd">class</span> EmployeeTest extends AbstractTransactionalJUnit4SpringContextTests {

    @Autowired
    <span class="kwrd">private</span> EmployeeMapper employeeMapper;

    @Before
    <span class="kwrd">public</span> <span class="kwrd">void</span> insertEmployee(){
        Employee emp = <span class="kwrd">new</span> Employee();
        emp.setEmpid(1);
        emp.setFirstName(<span class="str">"Manik"</span>);
        emp.setLastName(<span class="str">"Magar"</span>);
        employeeMapper.insertEmployee(emp);
    }

    @Test
    <span class="kwrd">public</span> <span class="kwrd">void</span> testEmployee(){
        System.<span class="kwrd">out</span>.println(<span class="str">"testEmployee"</span>);
        Employee emp = employeeMapper.getEmployeeName(1);
        Assert.assertNotNull(emp);
    }

}</pre>

Cheers!
  
**Where is the source? &#8230; It&#8217;s** <a title="MyBatisSpingDemo" href="https://github.com/manikmagar/mms_repo/tree/master/MyBatisSpringDemo" target="_blank">here</a>

&nbsp;

References

[http://www.mybatis.org/spring/](http://www.mybatis.org/spring/ "http://www.mybatis.org/spring/")