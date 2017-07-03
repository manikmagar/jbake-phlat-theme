<#include "commons/header.ftl">

	<div id="top" class="container">
		<div class="row" id="content-main">
		    <div class="col-md-8">
		    	 <div class="col-md-12 content-card">
        			<h1>Tag: ${tag}</h1>
	    			<#list tag_posts as post>
						<div class="row">
							<div class="col-sm-2 text-left">
								<h2>${post.date?string("YYYY")}</h2>
								<small>${post.date?string("MMM dd")}</small>
							</div>
							<div class="col-sm-10 text-left">
								<a href="${content.rootpath}${post.noExtensionUri!post.uri}" title="${post.title}"><h2>${post.title}</h2></a>
							</div>
						</div>
						<hr/>
					</#list>
		    	</div>
		    </div>
	        <div class="col-md-4">
	        	<#include "commons/sidebar.ftl">
	        </div>
	    </div>
	</div>	

<#include "commons/footer.ftl">