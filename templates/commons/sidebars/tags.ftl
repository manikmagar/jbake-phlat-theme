	
        <div class="row">
            <div class="col-md-11 col-md-offset-1 content-card card">
                <h5>Tags</h5>
                <ul class="list-inline tags" style="margin-top: 15px; margin-left: 0px">
					<#list alltags as tag>
		            	<li style=""><a href="/tags/${tag}${config.output_extension}">${tag}</a></li>
		        	 </#list>
		    	</ul>
            </div>
        </div>

