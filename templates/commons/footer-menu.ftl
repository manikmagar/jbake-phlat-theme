
<div class="col-md-8 col-xs-6">
    <ul class="list-inline links">
       <#list config.site_menus_footer as menuItem1>
		<li>
	        <a href="<#if (config['site_menus_footer_' + menuItem1 + '_url'] != "/")> ${content.rootpath}${config['site_menus_footer_' + menuItem1 + '_url']}<#else> ${config.site_host}</#if>">
	           
	                <i class="${config['site_menus_footer_' + menuItem1 + '_icon']}">&nbsp;</i>${config['site_menus_footer_' + menuItem1 + '_label']}
	            
	        </a>
		</li>
	</#list>
    </ul>
</div>
