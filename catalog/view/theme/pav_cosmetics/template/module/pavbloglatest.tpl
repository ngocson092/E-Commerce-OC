<div class="box pav-block bloglatest">
	<div class="box-heading">
		<span><?php echo $heading_title; ?></span>
	</div>
	<div class="pavblog-latest clearfix" >
		<?php if( !empty($blogs) ) { ?>
		<div class="row">
			<?php foreach( $blogs as $key => $blog ) { $key = $key + 1;?>
			<div class="col-md-<?php echo floor(12/$cols);?> col-sm-<?php echo floor(12/$cols);?> col-xs-12 pavblock">
				<div class="blog-item">					
					<div class="blog-body">
						<?php if( $blog['thumb']  )  { ?>
							<div class="image">
								<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" alt="<?php echo $blog['title'];?>" class="img-responsive"/>
								<div class="ImageOverlayC"></div>
							</div>
						<?php } ?>
						
						<div class="group-blog">
							<div class="blog-title">
								<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a>
							</div>
							<div class="blog-meta">
								<i class="fa fa-pencil"></i>
								<span class="created">
									<!-- <span class="day"><?php echo date("d",strtotime($blog['created']));?></span> -->
									<!-- <span class="month"><?php echo date("M",strtotime($blog['created']));?></span> -->
									<?php echo date("d M, y",strtotime($blog['created']));?>
								</span>
							</div>
							<div class="description">
								<?php $blog['description'] = strip_tags($blog['description']); ?>
								<?php echo utf8_substr( $blog['description'],0, 150 );?>...
							</div>
							<div class="btn-more-link">
								<a href="<?php echo $blog['link'];?>" class="readmore"><?php echo $objlang->get('text_readmore');?></a>
							</div>							
						</div>
						
					</div>						
				</div>
			</div>
			<?php if( ( $key%$cols==0 || $key == count($blogs)) ){  ?>

			<?php } ?>
			<?php } ?>
		</div>
		<?php } ?>
	</div>
</div>
