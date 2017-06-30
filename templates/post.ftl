<#include "commons/header.ftl">
	
	<div id="top" class="container">
		<div class="row" id="content-main">
		    <div class="col-md-8">
		    	<#assign post = content />
		    	<#include "post/content-single.ftl">
		    </div>
	        <div class="col-md-4">
	        	<#include "commons/sidebar.ftl">
	        </div>
	    </div>
	</div>

	
<#include "commons/footer.ftl">