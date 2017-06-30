title=Flex Tree and GroupingCollection
date=2011-08-21
author=Manik Magar
type=post
guid=http://manikmagar.wordpress.com/?p=56
permalink=/flex-tree-and-groupingcollection/
tags=Flex
status=published
summary=Flex Tree and GroupingCollection
~~~~~~
**How to display flat view datacollection in mx:Tree component?**

dataProvider for Tree control requires an Object of tree data or ArrayCollection or XMLListCollection. But many times we need to display the GroupingCollection object into Tree. Below example how can we do that using the root object of GroupingCollection.

1. Create a Tree.
  
2. Instantiate a flat data source (arcData)
  
3. Create GroupingCollection2 (Flex 4), as pre required Grouping Fields.
  
4. Whenever arcData, the base collection, changes; call refreshTree() function.

<pre>&lt;?xml version="1.0" encoding="utf-8"?&gt;
&lt;s:WindowedApplication xmlns:fx="http://ns.adobe.com/mxml/2009"
                       xmlns:s="library://ns.adobe.com/flex/spark"
                       xmlns:mx="library://ns.adobe.com/flex/mx" creationComplete="windowedapplication1_creationCompleteHandler(event)" xmlns:local="*" width="318" height="400"&gt;
    &lt;s:layout&gt;
        &lt;s:VerticalLayout/&gt;
    &lt;/s:layout&gt;
    &lt;fx:Script&gt;
        &lt;![CDATA[
            import mx.events.CollectionEvent;
            import mx.events.FlexEvent;

            protected function windowedapplication1_creationCompleteHandler(event:FlexEvent):void
            {
                refreshTree();    
            }

            private function refreshTree():void{
                gc.refresh();
                myTree.dataProvider = gc.getRoot();
            }

        ]]&gt;
    &lt;/fx:Script&gt;
    &lt;fx:Declarations&gt;

        &lt;s:ArrayCollection id="arcData"&gt;
                &lt;local:TestItem year="2009" month="Jan" label="Jan Report 1"/&gt;
                &lt;local:TestItem year="2009" month="Jan" label="Jan Report 2"/&gt;
                &lt;local:TestItem year="2009" month="July" label="July Report 1"/&gt;
                &lt;local:TestItem year="2009" month="July" label="July Report 2"/&gt;
                &lt;local:TestItem year="2010" month="Feb" label="Feb Report 1"/&gt;
                &lt;local:TestItem year="2010" month="Feb" label="Feb Report 2"/&gt;
                &lt;local:TestItem year="2010" month="Dec" label="Dec Report 1"/&gt;
                &lt;local:TestItem year="2010" month="Dec" label="Dec Report 2"/&gt;
        &lt;/s:ArrayCollection&gt;

        &lt;mx:GroupingCollection2 id="gc" source="{arcData}"&gt;
            &lt;mx:grouping&gt;
                &lt;mx:Grouping&gt;
                    &lt;mx:fields&gt;
                        &lt;mx:GroupingField name="year"/&gt;
                        &lt;mx:GroupingField name="month"/&gt;    
                    &lt;/mx:fields&gt;
                &lt;/mx:Grouping&gt;
            &lt;/mx:grouping&gt;
        &lt;/mx:GroupingCollection2&gt;
    &lt;/fx:Declarations&gt;

    &lt;mx:Tree id="myTree" dataProvider="{gc.getRoot()}" labelField="GroupLabel" width="100%" height="100%"&gt;

    &lt;/mx:Tree&gt;

&lt;/s:WindowedApplication&gt;</pre>

Hope this helps.

&nbsp;

<div id="attachment_64" style="width: 336px" class="wp-caption alignnone">
  <a href="/img/2011/08/testgc.jpg"><img class="size-full wp-image-64" title="TestGC" src="/img/2011/08/testgc.jpg?resize=326%2C434" alt="Flex Tree and GroupingCollection2" data-recalc-dims="1" /></a>
  
  <p class="wp-caption-text">
    Flex Tree and GroupingCollection2
  </p>
</div>

&nbsp;