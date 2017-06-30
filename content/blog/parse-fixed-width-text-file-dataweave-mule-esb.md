title=Parse Fixed width text file with DataWeave in Mule ESB
date=2016-04-15T16:44:43+00:00
author=Manik Magar
type=post
guid=http://www.myjavaacademy.com/?p=38
permalink=/parse-fixed-width-text-file-dataweave-mule-esb/
tags=DataWeave,Mule ESB
status=published
~~~~~~
With Mule 3.7.0, a new modeling and transformation language was introduced, DataWeave. This is more powerful than its predecessor DataMapper which is marked as deprecated in Mule 3.7

DataWeave component appears as &#8220;Transform Message&#8221; in Mule Anypoint Studio under Mule Palette. DataWeave in Mule 3.7 supports processing of JSON, Java, CSV, EDI, XML, Pojo etc. One format that was missing in DataWeave support was Fixed Width text format. As per the <a href="http://blogs.mulesoft.com/biz/mule/new-mule-3-8-studio-6-0-beta-releases/" target="_blank">beta release notes of Mule 3.8</a>, DataWeave in Mule 3.8 is going to support fixed width text files. But for many of us, it may not be possible to upgrade Mule server for this.

## So How to Process fixed width text file with DataWeave in Mule 3.7?

So for those who use Mule 3.7 with DataWeave and still want to process fixed width text files, here is the workaround for it.

Let&#8217;s consider below fixed with sample text file &#8211;

<pre class="brush: plain; title=; notranslate" title="">001MONSTARTWORK
001TUEPROGRESSWORK
001WEDTAKEABREAK
001THURESUMEWORK
001FRIFINISHWORK
001SATCHILLDOWN
001SUNGRABABEER
</pre>

**Record definition is &#8211;**

<pre>Id - Start Position: 0, length: 3
Day - Start Position: 3, length: 3
Shout - Start Position:6, length: 13</pre>

Here is our sample flow that reads the file from input directory, applies dataweave transformation and writes the generated file to output directory.

<div id="attachment_135" style="width: 322px" class="wp-caption aligncenter">
  <img class="wp-image-135 size-full" src="/img/2016/04/Mule_DW_FixedWidth_Flow-1.png?resize=312%2C130" alt="Mule_DW_FixedWidth_Flow" srcset="/img/2016/04/Mule_DW_FixedWidth_Flow-1.png?w=312&ssl=1 312w, /img/2016/04/Mule_DW_FixedWidth_Flow-1.png?resize=300%2C125&ssl=1 300w" sizes="(max-width: 312px) 100vw, 312px" data-recalc-dims="1" />
  
  <p class="wp-caption-text">
    Mule flow to convert fixed width text file to JSON
  </p>
</div>

XML Flow &#8211;

<pre class="brush: xml; title=; notranslate" title="">&lt;flow name="DW-FixedWidth-Processing"&gt;
        &lt;file:inbound-endpoint responseTimeout="10000" doc:name="File" moveToDirectory="output" path="input"/&gt;
        &lt;dw:transform-message doc:name="Transform Message" metadata:id="44c29528-4f2b-4aa6-a454-bf2fe7b8de57"&gt;
            &lt;dw:input-payload doc:sample="string_1.dwl"/&gt;
            &lt;dw:set-payload&gt;&lt;![CDATA[%dw 1.0 %output application/json --- (payload splitBy "\n") map { Id:$[0..2], Day:$[3..5], Shout:trim $[6..18] } ]]&gt;&lt;/dw:set-payload&gt;
        &lt;/dw:transform-message&gt;
        &lt;file:outbound-endpoint path="output" outputPattern="output.txt" responseTimeout="10000" doc:name="File"/&gt;
    &lt;/flow&gt;

</pre>

Let&#8217;s look at the DataWeave code now &#8211;

<pre class="brush: plain; title=; notranslate" title="">%dw 1.0
%output application/json
---
(payload splitBy "\n") map {
	Id:$[0..2],
	Day:$[3..5],
	Shout:$[6..18]
}
</pre>

As our payload is going to be file content i.e. String, we will split the content with new line char &#8220;\n&#8221;. Note the parenthesis used for \`payload splitBy &#8220;\n&#8221;\` which makes the output of that expression, input for map. Now, we have split our payload by newline so inside map we will be reading each line from our file and can be accessed with default alias $.

As per our record definition, Id field starts at 0 and is of 3 character long. So we map our Id by using <a href="https://docs.mulesoft.com/mule-user-guide/v/3.7/dataweave-reference-documentation#range-selector" target="_blank">Range Selector on String</a> $[0..2] which is $[startIndex..endIndex]. Similarly we can select Day and Shout also.

We have intentionally used &#8220;\n&#8221; instead of &#8220;\r\n&#8221; to make sure our code works on windows as well as UNIX. Note that, for the last field our actual file content ends at 18th position but on windows formatted files, there should be &#8220;\r&#8221; at 19th position. As we will only map until last fixed position, &#8220;\r&#8221; should not be a problem. In case you see carriage returns in output then most probably you have included this last character in your output too.

Now, we have seen how we can split the fields in dataweave. You can actually write any logic on the fields. For example, to avoid any empty spaces in shout field we can use trim function.

<pre class="brush: plain; title=; notranslate" title="">shout: trim $[6:18]

</pre>

Here is our output from above transformation &#8211;

<pre>[
  {
    "Id": "001",
    "Day": "MON",
    "Shout": "STARTWORK"
  },
  {
    "Id": "001",
    "Day": "TUE",
    "Shout": "PROGRESSWORK"
  },
  {
    "Id": "001",
    "Day": "WED",
    "Shout": "TAKEABREAK"
  },
  {
    "Id": "001",
    "Day": "THU",
    "Shout": "RESUMEWORK"
  },
  {
    "Id": "001",
    "Day": "FRI",
    "Shout": "FINISHWORK"
  },
  {
    "Id": "001",
    "Day": "SAT",
    "Shout": "CHILLDOWN"
  },
  {
    "Id": "001",
    "Day": "SUN",
    "Shout": "GRABABEER"
  }
]

</pre>

With this example, we learned how to consume fixed width text file with DataWeave in Mule 3.7.

**Next see how to** [create fixed width flat file using DataWeave in Mule 3.7](http://www.myjavaacademy.com/create-fixed-width-file-dataweave-mule-3-7/)

Feel free to let me know what you think or any questions, I will be happy to help.