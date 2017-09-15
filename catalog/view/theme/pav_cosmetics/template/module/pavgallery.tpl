<?php $id = rand(); ?>

<?php ?>
<div class="box gallery hidden-sm hidden-xs">
  
  <div class="box-heading"><span><?php echo $heading_title;?></span></div>
    <div class="box-content">
		<div class="banner-img <?php echo $prefix; ?>">
			<?php foreach( $banners as $banner ) { ?>
				<a href="<?php echo $banner['image'];?>" class="group<?php echo $id;?>" title="<?php echo $banner['title'];?>">
				<img src="<?php echo $banner['thumb'];?>" title="<?php echo $banner['title'];?>">
				</a>
			<?php } ?>
		</div>
	</div>
</div> 
<script type="text/javascript">
$(document).ready(function() {
	$('.banner-img').magnificPopup({
		type:'image',
		delegate: 'a',
		gallery: {
			enabled:true
		}
	});
});
</script>