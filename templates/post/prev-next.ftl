<#if (config.index_paginate && numberOfPages > 1) >
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-4" style="text-align: left; padding-left: 0px">
                    <a class="<#if (previousFileName?? == false) >disabled </#if>btn btn-default" href="${content.rootpath}${previousFileName!'#'}" 
                    	role="button" style="border-radius: 0px; display: block"> <i class="fa fa-arrow-circle-left" aria-hidden="true"></i> PREVIOUS</a>
                </div>
                <div class="col-md-4" style="text-align: right; padding-right: 0px">
                	<a
	                class="btn btn-default disabled"  style="border-radius: 0px; display: block"> ${currentPageNumber} of ${numberOfPages} </a>
	           </div>
                <div class="col-md-4" style="text-align: right; padding-right: 0px">
                    <a class="<#if (nextFileName?? == false) >disabled </#if> btn btn-default" href="${content.rootpath}${nextFileName!'#'}" 
                    	role="button" style="border-radius: 0px; display: block">NEXT <i class="fa fa-arrow-circle-right" aria-hidden="true"></i> </a>
                </div>
            </div>
        </div>
    </div>
</#if>
