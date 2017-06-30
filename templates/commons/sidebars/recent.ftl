<div class="row">
    <div class="col-md-11 col-md-offset-1 card">
        <h5>Recent Posts</h5>
        <ul class="list-unstyled posts-recent">
            <#list published_posts as post>
                	<#if (post?counter > config.sidebar_postAmount?number) ><#break/></#if>
                <li><a href="${content.rootpath}${post.noExtensionUri!post.uri}">${post.title}</a></li>
            </#list>
        </ul>
    </div>
</div>
