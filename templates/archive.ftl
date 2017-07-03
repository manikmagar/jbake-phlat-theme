<#include "commons/header.ftl">
	
	<div id="top" class="container">
		<div class="row" id="content-main">
		    <div class="col-md-8 content-card archived-posts">
        			<h1>Archived Posts</h1>
	    			<#list published_posts as post>
						<div class="row">
							<div class="col-sm-2 text-left">
								<h2>${post.date?string("YYYY")}</h2>
								<small>${post.date?string("MMM dd")}</small>
							</div>
							<div class="col-sm-10 text-left">
								<a href="${content.rootpath}${post.noExtensionUri!post.uri}" title="${post.title}"><h2>${post.title}</h2></a>
								 <ul class="list-inline tags" style="margin-top: 15px; margin-left: 0px">
									<#list post.tags as tag>
						            	<li style=""><a href="/tags/${tag}${config.output_extension}">${tag}</a></li>
						        	 </#list>
						    	</ul>
							</div>
						</div>
						<hr/>
					</#list>
		    </div>
	        <div class="col-md-4">
	        	<#include "commons/sidebar.ftl">
	        </div>
	    </div>
	</div>	
	
<#include "commons/footer.ftl">