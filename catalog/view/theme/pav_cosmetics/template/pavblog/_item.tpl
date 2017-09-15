<div class="blog-item"><div class="row">
	<div class="col-md-3 col-sm-3 col-xs-12">
		<div class="image">
			<?php if( $blog['thumb'] && $cat_show_image )  { ?>
			<img class="img-responsive" src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>"/>
			<?php } ?>
		</div>
	</div>
	<div class="col-md-9 col-sm-9 col-xs-12">
		<div class="blog-content">
			<div class="blog-body">
				<h3 class="blog-title">	<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></h3>
				<div class="blog-meta">
					<?php if( $cat_show_created ) { ?>
					<span class="created">
						<span class="day"><?php echo date("d",strtotime($blog['created']));?></span>
						<span class="month"><?php echo date("M",strtotime($blog['created']));?></span> /
						<span class="month"><?php echo date("Y",strtotime($blog['created']));?></span>
					</span>
					<?php } ?>
					<?php if( $blog_show_author ) { ?>
					<span class="author"><i class="fa fa-pencil"></i><?php echo $objlang->get("text_write_by");?></span> <span class="t-color"><?php echo $blog['author'];?></span>
					<?php } ?>
					<?php if( $blog_show_category ) { ?>
					<span class="publishin">
						<span><i class="fa fa-thumb-tack"></i><?php echo $objlang->get("text_published_in");?></span>
						<a href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
					</span>
					<?php } ?>
					<?php if( $blog_show_hits ) { ?>
					<span class="hits"><span><i class="fa fa-insert-template"></i><?php echo $objlang->get("text_hits");?></span> <span class="t-color"> <?php echo $blog['hits'];?></span></span>
					<?php } ?>
					<?php if( $blog_show_comment_counter ) { ?>
					<span class="comment_count"><span><i class="fa fa-comment"></i><?php echo $objlang->get("text_comment_count");?></span><span class="t-color"> <?php echo $blog['comment_count'];?></span></span>
					<?php } ?>
				</div>
				<?php if( $cat_show_description ) {?>
				<div class="description">
					<?php echo $blog['description'];?>
				</div>
				<?php } ?>
				<?php if( $cat_show_readmore ) { ?>
				<div class="btn-more-link">
					<a href="<?php echo $blog['link'];?>" class="readmore btn btn-outline"><?php echo $objlang->get('text_readmore');?></a>
				</div>
				<?php } ?>
			</div>
		</div>
	</div>
</div></div>
