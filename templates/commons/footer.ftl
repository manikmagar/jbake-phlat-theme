
	<footer class="footer">
	    <div class="container">
	        <div class="row">
	        	<#include "footer-menu.ftl">
	        </div>
	        <div class="row">
	            <div class="col-md-12">
	                <p>
	                    <a href="https://github.com/manikmagar/jbake-phlat-theme">JBake Phlat Theme</a> Ported by <a href="https://twitter.com/manikmagar">Manik Magar</a>.
	                </p>
	            </div>
	        </div>
	    </div>
	</footer>

	<div id="back-to-top" class="hidden">
	    <a href="#top" class="well well-sm" onclick="$('html,body').animate({scrollTop:0},'slow');return false;">
	        <i class="glyphicon glyphicon-chevron-up"></i> Back to Top
	    </a>
	</div>

	

	<script src="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/js/jquery-2.2.1.min.js"></script>
	<script src="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/js/bootstrap.min.js"></script>
	<script src="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/js/highlight.min.js"></script>
	<script src="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/js/readingTime.js"></script>

	<script>hljs.initHighlightingOnLoad();</script>
	<script>
	    if(($(window).height() + 100) < $(document).height()) {
	        $('#back-to-top').removeClass('hidden').affix({
	            offset: {
	                top: 100
	            }
	        });
	    }
	</script>
		<#if (config.site_disqus_shortname?has_content)>
			<script id="dsq-count-scr" src="//${config.site_disqus_shortname}.disqus.com/count.js" async></script>
		</#if>
		<#if (config.site_google_trackingid?has_content)>
			<#include "commons/google-analytics.ftl" />
		</#if>
		<!-- This is called by default since this theme uses highlight.js -->
		<script>hljs.initHighlightingOnLoad();</script>
		<!--[if lte IE 8]><script src="/js/ie/respond.min.js"></script><![endif]-->

  </body>
</html>
