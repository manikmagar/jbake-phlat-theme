title=Flex error &#8216;Reference error 1056 :Cannot create property myname on mycustomobject&#8217;.	  &#8216;'
date=2011-07-24
author=Manik Magar
type=post
guid=https://manikmagar.wordpress.com/2011/07/24/flex-error-reference-error-1056-cannot-create-property-myname-on-mycustomobject/
permalink=/flex-error-reference-error-1056-cannot-create-property-myname-on-mycustomobject/
tags=Flex
status=published
summary=Flex error &#8216;Reference error 1056 :Cannot create property myname on mycustomobject&#8217;.	  &#8216;'
~~~~~~
Some times we get this error in flex &#8211;

Reference error 1056 :Cannot create property myname on mycustomobject.

You will get this error if you are setting/accessing any property that dose not exist on any object which is not declared as dynamic.The base class &#8216;Object&#8217; is a dynamic class. 

What is dynamic class? &#8211; below declaration will make mycustomeobject as dynamic and allows addition/deletion of properties at runtime. 

Public dynamic class mycustomeobject{

} 

You can do &#8211;
  
mycustomeobject[&#8216;prop1&#8217;] = value1; 

Prop1 need not be present at compile time. Same statemne will give us this reference error if we do not declare that class as dynamic.

Also you can delete the properties at runtime-

delete mycustomeobject.prop1;

If you are planning to use dynamic objects, its always good you check property existance before you use it &#8211;

mycustomobject.hasOwnProperty(&#8216;prop1&#8217;)

Hope this helps &#8230; Have fun!