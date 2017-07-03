<div class="row">
    <div class="col-md-12 content-card">
        <h1>${post.title}</h1>
            
            <ul class="list-inline meta">
                <li><i class="fa fa-calendar"></i>${post.date?string('MMMM, dd yyyy')}</li>
                <li><i class="fa fa-user"></i>${post.author!config.site_author}</li>
                <#list post.tags as tag>
	            	<li><i class="fa fa-tag"></i><a href="/tags/${tag}${config.output_extension}">${tag}</a></li>
	        	 </#list>
            </ul>
            
            <#include "../commons/share-links.ftl">
       ${post.body}
       
    </div>
</div>
<#include "prev-next-post.ftl">
<#include "../commons/disqus.ftl">
