title=Iterate through ActionScript Object properties – AS Reflection
date=2009-09-20
author=Manik Magar
type=post
guid=http://manikmagar.wordpress.com/2009/09/20/iterate-through-actionscript-object-properties-as-reflection/
permalink=/iterate-through-actionscript-object-properties-as-reflection/
tags=Flex
status=published
~~~~~~

I was wondering if reflection is possible in ActionScript or not. After diving into API, i got something which seems like reflection in Flex. 

ActionScript API provide one class ObjectUtil. It contains some helper methods like compare, dateComapre etc for handling objects.

This class also has one very useful method getClassInfo(). Below code shows usage of this method to iterate through properties of an object &#8211;


```
 <?xml version="1.0" encoding="utf-8"?>
    <mx:Application xmlns:mx="http://www.adobe.com/2006/mxml" 
        width="100%" height="100%" creationComplete="init(event)">
       <mx:Script>
           <![CDATA[
               import mx.utils.ObjectUtil;
               private function init(event:Event):void{
                   printProperties1();
                   printProperties2();
               }
               private function printProperties1():void{
                   var props:Object = ObjectUtil.getClassInfo(this);
                   for each (var p:QName in props.properties){
                       var propName:String = p.localName;
                       var propValue:Object = this[propName];
                       trace(propName +":"+ propValue);
                   }    
              }
              private function printProperties2():void{
                  var excludes:Array = ['x','y'];
                  var props:Object = ObjectUtil.getClassInfo(this,excludes);
                  for each (var p:QName in props.properties){
                      var propName:String = p.localName;
                      var propValue:Object = this[propName];
                      trace(propName +":"+ propValue);
                  }    
              }
          ]]>
      </mx:Script>
  </mx:Application>
```
    
printProperties1() method should print all properties of Application class. Second implementation printProperties2() shows excluding certain properties from search.

Even though this introspection is not like java or any other language reflection but still its very useful since flex supports dynamic objects. To iterate through properties of dynamic objects this method can be used.
      
Hope this helps!