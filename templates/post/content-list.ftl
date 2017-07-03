<div class="row">
    <div class="col-md-12 content-card">
        <h1><a href="${content.rootpath}${post.noExtensionUri!post.uri}">${post.title}</a></h1>
        <ul class="list-inline">
            <li><i class="fa fa-calendar"></i>${post.date?string('MMMM, dd yyyy')}</li>
            <li><i class="fa fa-user"></i>${post.author!config.site_author}</li>
        </ul>
        <p class="summary">${post.summary!''}</p>
        <div class="text-right"><a class="btn btn-custom" href="${content.rootpath}${post.noExtensionUri!post.uri}" role="button">Read More</a></div>
    </div>
</div>