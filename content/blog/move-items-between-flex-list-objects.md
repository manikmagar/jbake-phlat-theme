title=Move Items between Flex List objects
date=2009-02-25
author=Manik Magar
type=post
guid=http://manikmagar.wordpress.com/?p=15
permalink=/move-items-between-flex-list-objects/
tags=Flex
status=published
~~~~~~

In this article we will see how to move data in between Lists. Same approach can be implemented to move the items across the other components like datagrid, advancedatagrid etc.

In the application mxml file, we will add two List components and two buttons.

<div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;width:97.5%;font-family:&#39;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;margin:20px 0 10px;padding:4px;" id="codeSnippetWrapper">
  <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> &lt;mx:List id=<span style="color:#006080;">"sourceList"</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span>    width=<span style="color:#006080;">"100"</span> height=<span style="color:#006080;">"200"</span>/&gt;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span>&#160; </pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum4">   4:</span> &lt;mx:Button id=<span style="color:#006080;">"moveToLeft"</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum5">   5:</span>    label=<span style="color:#006080;">"Add"</span>/&gt;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum6">   6:</span>   &lt;mx:Button id=<span style="color:#006080;">"moveToRight"</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum7">   7:</span>    label=<span style="color:#006080;">"Remove"</span> /&gt;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum8">   8:</span>&#160; </pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum9">   9:</span> &lt;mx:List id=<span style="color:#006080;">"destList"</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum10">  10:</span>    width=<span style="color:#006080;">"100"</span> height=<span style="color:#006080;">"200"</span>/&gt; </pre>
    
    <p>
      <!--CRLF--></div> </div> 
      
      <p>
        &#160;&#160;&#160; <br />Now, in <mx:Script> create two variables of type ArrayCollection. We will declare these two variables as <a href="http://livedocs.adobe.com/flex/3/html/help.html?content=databinding_8.html" target="_blank">[Bindable]</a> so that these can be used for dynamic binding in mxml code.
      </p>
      
      <div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;width:97.5%;font-family:&#39;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;margin:20px 0 10px;padding:4px;" id="codeSnippetWrapper">
        <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
          <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> [Bindable]</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span>   <span style="color:#0000ff;">private</span> var listData:ArrayCollection = <span style="color:#0000ff;">new</span> ArrayCollection([<span style="color:#006080;">"Item A"</span>,<span style="color:#006080;">"Item B"</span>,<span style="color:#006080;">"Item C"</span>,<span style="color:#006080;">"Item D"</span>,<span style="color:#006080;">"Item E"</span>,<span style="color:#006080;">"Item F"</span>]);</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span>      </pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum4">   4:</span>   [Bindable]</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum5">   5:</span>   <span style="color:#0000ff;">private</span> var filteredData:ArrayCollection = <span style="color:#0000ff;">new</span> ArrayCollection();</pre>
          
          <p>
            <!--CRLF--></div> </div> 
            
            <p>
              <br />&#160;&#160; <br />We have initialized the listData variable to some String items. Now we will use these collections as data providers for our lists. Lets change the List declarations to use the bindings.
            </p>
            
            <p>
              &#160;
            </p>
            
            <div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;width:97.5%;font-family:&#39;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;margin:20px 0 10px;padding:4px;" id="codeSnippetWrapper">
              <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
                <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> &lt;mx:List id=<span style="color:#006080;">"sourceList"</span></pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span>  width=<span style="color:#006080;">"100"</span> height=<span style="color:#006080;">"200"</span></pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span>  dataProvider=<span style="color:#006080;">"{listData}"</span>/&gt;</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum4">   4:</span>&#160; </pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum5">   5:</span> x:List id=<span style="color:#006080;">"destList"</span></pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum6">   6:</span>  width=<span style="color:#006080;">"100"</span> height=<span style="color:#006080;">"200"</span></pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum7">   7:</span>  dataProvider=<span style="color:#006080;">"{filteredData}"</span>/&gt;  </pre>
                
                <p>
                  <!--CRLF-->
                  
                  <!--CRLF--></div> </div> 
                  
                  <p>
                    <br />Great we are ready with lists populated with data. Now lets add a function calls to handle the button click events. Change the button declaration code and add the click event handlers for each button.
                  </p>
                  
                  <p>
                  </p>
                  
                  <div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;width:97.5%;font-family:&#39;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;margin:20px 0 10px;padding:4px;" id="codeSnippetWrapper">
                    <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
                      <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> &lt;mx:Button id=<span style="color:#006080;">"moveToLeft"</span></pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span>  label=<span style="color:#006080;">"Add"</span></pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span>  click=<span style="color:#006080;">"addItems(event)"</span>/&gt;</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum4">   4:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum5">   5:</span> &lt;mx:Button id=<span style="color:#006080;">"moveToRight"</span></pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum6">   6:</span>  label=<span style="color:#006080;">"Remove"</span></pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum7">   7:</span>  click=<span style="color:#006080;">"removeItem(event)"</span>/&gt; </pre>
                      
                      <p>
                        <!--CRLF--></div> </div> 
                        
                        <p>
                          <br />&#160; <br />but where are the functions addItems and removeItem?? We are yet to define them. In <mx:Script> lets write some action script to perform action.
                        </p>
                        
                        <div style="border-bottom:silver 1px solid;text-align:left;border-left:silver 1px solid;line-height:12pt;background-color:#f4f4f4;width:97.5%;font-family:&#39;direction:ltr;max-height:200px;font-size:8pt;overflow:auto;border-top:silver 1px solid;cursor:text;border-right:silver 1px solid;margin:20px 0 10px;padding:4px;" id="codeSnippetWrapper">
                          <div style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;padding:0;" id="codeSnippet">
                            <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum1">   1:</span> <span style="color:#0000ff;">private</span> function addItems(eventL:MouseEvent):<span style="color:#0000ff;">void</span>{</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum2">   2:</span>    var obj:Object;</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum3">   3:</span>    <span style="color:#008000;">// Iterate through selected items collection and add it to filtered data collection object.</span></pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum4">   4:</span>    <span style="color:#0000ff;">for</span> each (obj in sourceList.selectedItems){</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum5">   5:</span>     filteredData.addItem(obj);</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum6">   6:</span>    }</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum7">   7:</span>    <span style="color:#008000;">// De-Select all selected items after adding each one to destination.</span></pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum8">   8:</span>    sourceList.selectedItems = [];</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum9">   9:</span>   }</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum10">  10:</span>&#160; </pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum11">  11:</span> <span style="color:#0000ff;">private</span> function removeItem(event:MouseEvent):<span style="color:#0000ff;">void</span>{</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum12">  12:</span>    var obj:Object;</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum13">  13:</span>    <span style="color:#0000ff;">for</span> each (obj in destList.selectedItems){</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum14">  14:</span>     filteredData.removeItemAt(filteredData.getItemIndex(obj));</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:white;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum15">  15:</span>    }</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="text-align:left;line-height:12pt;background-color:#f4f4f4;width:100%;font-family:&#39;direction:ltr;color:black;font-size:8pt;overflow:visible;border-style:none;margin:0;padding:0;"><span style="color:#606060;" id="lnum16">  16:</span>   }</pre>
                            
                            <p>
                              <!--CRLF--></div> </div> 
                              
                              <p>
                                &#160;&#160; <br />You will see we are actully performing addition and removal on filteredData collection object, rather than List object. Remember, we have made filterData object as [Bindable], so whatever we do with filteredData, changes are immediately reflected in destination list.
                              </p>
                              
                              <p>
                                Cool &#8230; we are ready to move!
                              </p>