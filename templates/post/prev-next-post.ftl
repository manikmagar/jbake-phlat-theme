
<div class="row">
    <div class="col-md-12">
        <div class="row">
        	
            <div class="col-md-4" style="text-align: left; padding-left: 0px">
            	<#if (post.previousContent)??>
                <a href="${content.rootpath}${post.previousContent.noExtensionUri!post.previousContent.uri}" 
                class="btn btn-default"  role="button" style="border-radius: 0px; display: block"> <i class="fa fa-arrow-circle-left" aria-hidden="true"></i> ${content.previousContent.title}</a>
                 </#if>
            </div>
            
            <div class="col-md-4 col-md-offset-4" style="text-align: right; padding-right: 0px">
            	<#if (post.nextContent)??> 
		        <a href="${content.rootpath}${post.nextContent.noExtensionUri!post.nextContent.uri}" 
		                class=" btn btn-default"  role="button" style="border-radius: 0px; display: block">${content.nextContent.title} <i class="fa fa-arrow-circle-right" aria-hidden="true"></i> </a>
		        </#if>
            </div>
        </div>
    </div>
</div>