	<#if (config.render_tags == true)  && post.tags?? >
		<ul class="tags" style="margin-top: 15px; margin-left: 0px">
			<#list post.tags as tag>
            	<li style=""><a href="/tags/${tag}${config.output_extension}">${tag}</a></li>
        	 </#list>
    	</ul>
 	</#if>
 	
 	
