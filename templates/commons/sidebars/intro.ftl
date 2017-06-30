<div class="row">
	<div class="col-md-11 col-md-offset-1 card">
		<div class="profile-userpic">
			<a href="${config.sidebar_intro_about}"><img src="${config.sidebar_intro_pic_src}" 
			alt="${config.sidebar_intro_header}"
				class="img-responsive" style="margin: 0 auto;"></a>
		</div>
		<br>
		<div class="col-md-12 text-center">
			<div class="profile-usertitle-name">
				<a href="${config.sidebar_intro_about}"><b>${config.sidebar_intro_header}</b></a>
			</div>
			<div class="profile-usertitle-job">
				<p>
					<i>${config.sidebar_intro_summary}</i>
				</p>
				<#include "social.ftl">
			</div>
		</div>
	</div>
</div>