title=Create Fixed width file with DataWeave in Mule 3.7
date=2016-04-18T03:43:03+00:00
author=Manik Magar
type=post
guid=http://www.myjavaacademy.com/?p=239
permalink=/create-fixed-width-file-dataweave-mule-3-7/
tags=DataWeave,Mule ESB
status=published
summary=Create Fixed width file with DataWeave in Mule 3.7
featured=/images/pic01.jpg
banner=true
~~~~~~
In <a href="http://www.myjavaacademy.com/parse-fixed-width-text-file-dataweave-mule-esb/" target="_blank">previous post</a>,&nbsp;we saw how to consume and process fixed width file using&nbsp;DataWeave in Mule ESB 3.7. In this post we will see how we can generate fixed width file using&nbsp;DataWeave in Mule 3.7. As I mentioned in previous post, DataWeave support for fixed width files has been introduced in Mule ESB 3.8 but&nbsp;It may not be always possible to upgrade our ESB version just for this purpose. That is why we will see how to achieve this transformation in 3.7.

There are third party java libraries that can be used with Mule to process fixed width files. But what if we don&#8217;t want to use any other libraries? Well, there is a way to generate fixed width files with just DataWeave.

Let&#8217;s refer to our <a href="http://www.myjavaacademy.com/parse-fixed-width-text-file-dataweave-mule-esb/" target="_blank">previous example</a>&nbsp;and we will use the output of that flow to regenerate our original-like fixed width file.

###### Input:

Here is the JSON that we generated in previous example, we will use that as Input in this example and then we will convert it into fixed width.

<pre>
[
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

###### DataWeave Processing:

Here is a DataWeave code that would transform this JSON into fixed width text file &#8211;

<pre>
%dw 1.0
%output application/csv header=false
---
 (payload map {
         Id: rightPad($.Id,3,' '),
         Day: rightPad($.Day,4,' '),
         Shout: rightPad($.Shout,20,' ')
     }) map {
     	row: ($ pluck $ joinBy "")
     }
</pre>

&nbsp;

Let&#8217;s understand how this code works &#8211;

  1. Output directive defines output to be application/csv and we have turned off header in output.
  2. First we will map the payload to format the values as we require in our output.&nbsp;There is no in-built rightPad function in DataWeave so we will have to write a [MEL global function](https://docs.mulesoft.com/mule-user-guide/v/3.7/dataweave-reference-documentation#global-mel-functions) in our mule-config.xml. Add below code to your mule config &#8211; 

<pre>
&lt;configuration doc:name="Configuration"&gt;
	&lt;expression-language&gt;
		&lt;global-functions&gt;
			def rightPad(value,length,padChar) {
				return org.apache.commons.lang3.StringUtils.rightPad(value,length,padChar);
			}
		&lt;/global-functions&gt;
	&lt;/expression-language&gt;
&lt;/configuration&gt;

</pre>
    
   Now this MEL function can be used in our DataWeave. What it does is, for given string value, it appends the padChar to make value of given length. Eg. Shout field should be of length 20 characters in output and if required pad input with &#8216; &#8216; to make it 20 characters i.e. fixed length 🙂</li> 
    
   * Then we apply second map to iterate over object collection we prepared in step 2. For every object, we will create a object with single property of key &#8216;row&#8217; and value would be constructed by joining all the values of every&nbsp;property in object. If we don&#8217;t turn off headers in output, very first line in our output will contain &#8216;row&#8217;.</ol> 
    
   ###### Output:
    
Here is the output of above transformation &#8211;
    
<pre>
001MON STARTWORK 
001TUE PROGRESSWORK
001WED TAKEABREAK
001THU RESUMEWORK
001FRI FINISHWORK
001SAT CHILLDOWN
001SUN GRABABEER

</pre>
    
    
    
Record Structure we generated is &#8211;
    
<pre>
Id - Start Position: 0, length: 3
Day - Start Position: 3, length: 4
Shout - Start Position:7, length: 20
</pre>
    
If you want to add a prefix or suffix to every column, then it can be done by adding mapObject function before pluck. For example, if we change mapObject to include two fields, prefix and suffix, then our output will look like shown below. Remember, you can also do it in your first map where we make each property of fixed length.
    
mapObject Code:
    
<pre>
%dw 1.0
%output application/csv header=false
---
 (payload map {
         Id: rightPad($.Id,3,' '),
         Day: rightPad($.Day,4,' '),
         Shout: rightPad($.Shout,20,' ')
     }) map {
     	row: ($ mapObject {
             Suffix:'Suffix',
             '$$':$,
             Post:'Prefix'
         } pluck $ joinBy "")
     }
</pre>
    
Here is the output of above change in DataWeave code, Note the static strings are around each column &#8211;
    
<pre>
Suffix001PrefixSuffixMON PrefixSuffixSTARTWORK           Prefix
Suffix001PrefixSuffixTUE PrefixSuffixPROGRESSWORK        Prefix
Suffix001PrefixSuffixWED PrefixSuffixTAKEABREAK          Prefix
Suffix001PrefixSuffixTHU PrefixSuffixRESUMEWORK          Prefix
Suffix001PrefixSuffixFRI PrefixSuffixFINISHWORK          Prefix
Suffix001PrefixSuffixSAT PrefixSuffixCHILLDOWN           Prefix
Suffix001PrefixSuffixSUN PrefixSuffixGRABABEER           Prefix

</pre>
    
That&#8217;s all Folks! Here we saw, how we can use DataWeave code in Mule 3.7 to convert any file format into a fixed width text format and also how to apply formatting on each column.
    
Feel free to let me know what you think or any questions, I will be happy to help.