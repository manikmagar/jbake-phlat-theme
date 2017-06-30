<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">${config.site_title}</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
           <#list config.site_menus_main as menuItem1>
    			<li>
                    <a href="<#if (config['site_menus_main_' + menuItem1 + '_url'] != "/")> ${content.rootpath}${config['site_menus_main_' + menuItem1 + '_url']}<#else> ${config.site_host}</#if>">
                       
                            <i class="${config['site_menus_main_' + menuItem1 + '_icon']}">&nbsp;</i>${config['site_menus_main_' + menuItem1 + '_label']}
                        
                    </a>
            	</li>
			</#list>
            </ul>
        </div>
    </div>
</nav>