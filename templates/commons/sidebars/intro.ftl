<div class="row">
	<div class="col-md-11 col-md-offset-1 card intro">
		<div class="logo">
			<a href="${config.sidebar_intro_about}"><img src="${config.site_host}${config.sidebar_intro_pic_src}" 
			alt="${config.sidebar_intro_header}"
				class="img-responsive img-circle" style="margin: 0 auto;"></a>
		</div>
		<br>
		<div class="col-md-12 text-center">
			<div class="header">
				<a href="${config.sidebar_intro_about}">${config.sidebar_intro_header}</a>
			</div>
			<div class="summary">
				<p>${config.sidebar_intro_summary}</p>
				<#include "social.ftl">
			</div>
		</div>
	</div>
</div>