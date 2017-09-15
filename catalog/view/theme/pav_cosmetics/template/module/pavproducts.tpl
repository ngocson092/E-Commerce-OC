<?php
$span = 12/$cols; 
$id = rand(1,9)+substr(md5($heading_title),0,3);
$themeConfig = (array)$objconfig->get('themecontrol');
$listingConfig = array(
	'category_pzoom'                     => 1,
	'quickview'                          => 0,
	'show_swap_image'                    => 0,
	'product_layout'		             => 'default',
	'enable_paneltool'	                 => 0
);
$listingConfig      = array_merge($listingConfig, $themeConfig );
$categoryPzoom 	    = $listingConfig['category_pzoom'];
$quickview          = $listingConfig['quickview'];
$swapimg            = $listingConfig['show_swap_image'];
$categoryPzoom      = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0; 
$theme              = $objconfig->get('config_template');
if( $listingConfig['enable_paneltool'] && isset($_COOKIE[$theme.'_productlayout']) && $_COOKIE[$theme.'_productlayout'] ){
	$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
} 
$productLayout = DIR_TEMPLATE.$objconfig->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';	
if( !is_file($productLayout) ){
	$listingConfig['product_layout'] = 'default';
}
$productLayout = DIR_TEMPLATE.$objconfig->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
?>

<div class="box pav-categoryproducts clearfix">
	<?php if( !empty($module_description) ) { ?>
	<div class="module-desc">
		<?php echo $module_description;?>
	</div>
	<?php } ?>

	<div class="box-content <?php echo $prefix_class ?> clearfix">
		<div class="tab-nav pull-left">
			<ul class="h-tabs" id="producttabs<?php echo $id;?>">
				<?php foreach( $tabs as $tab => $category ) { 
					if( empty($category) ){ continue;}
					$tab = 'cattabs';
					///	echo '<pre>'.print_r( $category,1 ); die; 
					$products = $category['products'];
					$icon = $model_resize->resize( $category['image'], 279, 500 );
					$caturl = $url->link('product/category', 'path='.$category['category_id']);
					?>
					<li class="<?php echo $category['class'];?>">
						<div class="banner-category hidden-sm hidden-xs">						
							<a href="#tab-<?php echo $tab.$id.$category['category_id'];?>" data-toggle="tab">
							<?php if ( $icon ) { ?><img src="<?php echo $icon;?>" alt=""/><?php } ?>	
							</a>
						</div>
						
						<a href="<?php echo $caturl; ?>"  class="category_name">
							<span style="cursor: pointer;"><?php echo $category['category_name'];?></span>
						</a>
					</li>
				<?php } ?>
			</ul>			
		</div>

		<!-- ========Content======== -->
		<div class="tab-content pull-left"> 
			<?php foreach( $tabs as $tab => $category ) { 
				if( empty($category) ){ continue;}
				$tab = 'boxcats';
				$products = $category['products'];
				$icon = $model_resize->resize( $category['image'], 45,45 ); 
			?>
			<div class="tab-pane active <?php echo $category['class'];?> clearfix" id="tab-cattabs<?php echo $id.$category['category_id'];?>">	
				<?php if( count($products) > $itemsperpage ) { ?>
					<div class="carousel-controls">						
						<a class="carousel-control right" href="#<?php echo $tab.$id.$category['category_id'];?>" data-slide="prev">
							<em class="fa fa-angle-left"></em>
						</a>
						<a class="carousel-control left" href="#<?php echo $tab.$id.$category['category_id'];?>" data-slide="next">
							<em class="fa fa-angle-right"></em>
						</a>
					</div>
				<?php } ?>

				<div class="pavproducts<?php echo $id;?> slide" id="<?php echo $tab.$id.$category['category_id'];?>">
					<div class="carousel-inner">
						<?php $pages = array_chunk( $products, $itemsperpage);?>	
						<?php foreach ($pages as  $k => $tproducts ) { ?>
						<div class="item <?php if($k==0) {?>active<?php } ?>">
							<?php foreach( $tproducts as $i => $product ) { ?>
							<?php if( $i++%$cols == 0 ) { ?>
							<div class="row product-items">
							<?php } ?>
								<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-12 product-cols">
									<?php require( $productLayout );  ?> 
								</div>
							<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
							</div>
							<?php } ?>
							<?php } ?>
						</div>
						<?php } ?>
					</div>
				</div>			
			</div>	
			<?php } ?>
		</div>

	</div>		
</div>

<script type="text/javascript">
$(function () {
	$('.pavproducts<?php echo $id;?>').carousel({interval:99999999999999,auto:false,pause:'hover'});
	$('#producttabs<?php echo $id;?> a:first').tab('show');
});
</script>