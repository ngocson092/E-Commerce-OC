<?php 
	  //	echo '<pre>'.print_r( $layouts, 1 );die; 
$objlang = $this->registry->get('language');
?>
<div class="box nopadding builder-wrapper">
	<?php if( trim($heading) ){ ?>
	<div class="box-heading"><span><?php echo $objlang->get(trim($heading)); ?></span></div>
	<?php } ?>
	<div class="box-content"><div class="clearfix <?php echo $class ?>">
 	
 		<?php  $level = 1; $rows = $layouts; require( $template_builder ); ?>
	</div></div>
</div>	
