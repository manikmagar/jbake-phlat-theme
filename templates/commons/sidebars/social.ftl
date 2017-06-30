<div class='demopadding'>
	
	<#if (config.sidebar_social_github?has_content) >
		<div class='icon social gh'><a href="//github.com/${config.sidebar_social_github}" target="_blank" title="Github"><i class="fa fa-github"></i></a></div>
	</#if>
	<#if (config.sidebar_social_facebook?has_content) >
		<div class='icon social fb'><a href="//facebook.com/${config.sidebar_social_facebook}" target="_blank" title="Facebook"><i class="fa fa-facebook"></i></a></div>
	</#if>
	<#if (config.sidebar_social_twitter?has_content) >
		<div class='icon social tw'><a target="_blank" href="//twitter.com/${config.sidebar_social_twitter}"><i class="fa fa-twitter"></i></a></div>
	</#if>
	
	<#if (config.sidebar_social_linkedin?has_content) >
		<div class='icon social in'><a href="//linkedin.com/in/${config.sidebar_social_linkedin}" target="_blank" title="LinkedIn"><i class="fa fa-linkedin"></i></a></div>
	</#if>
	
	<#if (config.sidebar_social_email?has_content) >
		<div class='icon social'><a href="//linkedin.com/in/${config.sidebar_social_linkedin}" target="_blank" title="E-mail"><i class="fa fa-envelope"></i></a></div>
	</#if>

	
</div> 	
