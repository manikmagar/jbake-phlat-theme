<#include "commons/header.ftl">
	
	<div id="top" class="container">
		<div class="row" id="content-main">
		    <div class="col-md-8">
			    <#list published_posts as post>
			    	<#include "post/content-list.ftl">
			    </#list>
			    <#include "post/prev-next.ftl">
		    </div>
	        <div class="col-md-4">
	        	<#include "commons/sidebar.ftl">
	        </div>
	    </div>
	</div>

<#include "commons/footer.ftl">