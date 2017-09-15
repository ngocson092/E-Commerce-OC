<?php $objlang = $this->registry->get('language'); ?>
<?php if ( isset($thumbnailurl) )  { ?>
<div class="widget-images <?php echo $addition_cls ?>  <?php if( isset($stylecls)&&$stylecls ) { ?>box-<?php echo $stylecls;?><?php } ?>">
	<?php if( isset($widget_heading)&&!empty($widget_heading) ){ ?>
	<div class="widget-heading box-heading">
		<?php echo $widget_heading; ?>
	</div>
	<?php } ?>
	<div class="widget-inner clearfix">
		 <div class="image-item">
		 	<img src="<?php echo $thumbnailurl; ?>"/>
		 	<?php if( $ispopup ){ ?>
		 	<a href="<?php echo $imageurl; ?>" class="pts-popup fancybox" title="<?php echo $objlang->get('Large Image');?>"><span class="icon icon-expand"></span></a>
		 	<?php } ?>		  
		 </div>
	</div>
</div>
<?php } ?>