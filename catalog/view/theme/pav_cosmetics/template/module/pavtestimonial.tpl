<?php $objlang = $this->registry->get('language');?>
<?php if( count($testimonials) ) { ?>
	<?php $id = rand(1,10)+rand();?>
   <div id="pavtestimonial<?php echo $id;?>" class="box carousel slide pavtestimonial special">
   		<div class="box-heading">
			<i class="fa fa-comments"></i><span><?php echo $objlang->get("text_testimonial");?></span>
		</div>
		<div class="carousel-inner">
			<?php $pages = array_chunk( $testimonials, $row); $span = 12/$cols; ?>
			<?php foreach ($pages as  $k => $testimonials ) { ?>
				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach ($testimonials as $i => $testimonial) {  ?>
						<?php if( $i++%$cols == 0 ) { ?>
						<div class="row">
						<?php } ?>
			 				<div class="testimonial-item col-md-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-12">
								<?php if(  $testimonial['description'] ) { ?>
								<div class="testimonial">
									<div class="testimonial-info">
										<span class="fa fa-quote-left pull-left"></span>
										<div class="description pull-left"><?php echo $testimonial['description']; ?></div>
									</div>
								</div>
								<?php } ?>
								
								<?php if(  $testimonial['profile'] ) { ?>
								<div class="avatar-profile">
									<div class="t-avatar pull-left"><img  alt="<?php echo strip_tags($testimonial['profile']); ?>" src="<?php echo $testimonial['thumb']; ?>" class="img-circle"/></div>
									<div class="profile pull-left"><?php echo $testimonial['profile']; ?></div>
								</div>
								<?php } ?>
								<?php if( $testimonial['video_link']) { ?>
								<a class="colorbox-t" href="<?php echo $testimonial['video_link'];?>"><?php echo $this->language->get('text_watch_video_testimonial');?></a>
								<?php } ?>
							</div>
						<?php if( $i%$cols == 0 || $i==count($testimonials) ) { ?>
						</div>
						<?php } ?>
					<?php } ?>
				</div>
			<?php }?>
		</div>

		<?php if( count($testimonials) / $cols > 0 ){ ?>
			<a class="carousel-control left" href="#pavtestimonial<?php echo $id;?>" data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#pavtestimonial<?php echo $id;?>" data-slide="next">&rsaquo;</a>
		<?php } ?>
    </div>
    <?php if( count($testimonials) / $cols > 0 ){ ?>
	<script type="text/javascript">
	<!--
		$('#pavtestimonial<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
	-->
	</script>
	<?php } ?>
	<script type="text/javascript"><!--
		$(document).ready(function() {
		  $('.colorbox-t').magnificPopup({iframe:true, innerWidth:640, innerHeight:390});
		});
//--></script> 
<?php } ?>
