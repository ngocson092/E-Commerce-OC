<?php 
	$objlang = $this->registry->get('language');  
	$ourl = $this->registry->get('url');

	$button_compare = $objlang->get("button_compare");
	$button_wishlist = $objlang->get("button_wishlist");
?>
<div class="product-block item-default" itemtype="http://schema.org/Product" itemscope>

	<div class="image">
		<?php if ($product['thumb']) {    ?>
	      	<?php if( $product['special'] ) {   ?>
	    	<span class="product-label-special label"><?php echo $objlang->get( 'text_sale' ); ?></span>
	    	<?php } ?>
				<a class="img" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="img-responsive" /></a>
		<?php } ?>
		<!-- zoom image-->
	    <?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
	    <a href="<?php echo $zimage;?>" class="product-zoom" title="<?php echo $product['name']; ?>">
	    	<i class="fa fa-search-plus"></i>
	    </a>
	    <?php } ?>

		<?php if ( isset($quickview) && $quickview ) { ?>
		<div class="product_quickview">
			<a class="quickview iframe-link" href="<?php echo $ourl->link('themecontrol/product','product_id='.$product['product_id']);?>" title="<?php echo $objlang->get('quick_view'); ?>">
				<i class='fa fa-eye'></i>
				<span><?php echo $objlang->get('quick_view'); ?></span>
			</a>
		</div>
		<?php } ?>
	</div>
	
	<div class="product-meta clearfix">
		<h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>	

		<?php if( isset($product['description']) ){ ?> 
			<div class="description" itemprop="description"><?php echo utf8_substr( strip_tags($product['description']),0,220);?>...</div>
		<?php } ?>	

		<?php if ( isset($product['rating']) ) { ?>
          <div class="rating">
            <?php for ($is = 1; $is <= 5; $is++) { ?>
            <?php if ($product['rating'] < $is) { ?>
            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
            <?php } else { ?>
            <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i>
            </span>
            <?php } ?>
            <?php } ?>
          </div>
         <?php } ?>

		<?php if ($product['price']) { ?>
		<div class="price" itemtype="http://schema.org/Offer" itemscope itemprop="offers">
			<?php if (!$product['special']) {  ?>
				<span class="special-price"><?php echo $product['price']; ?></span>
				<?php if( preg_match( '#(\d+).?(\d+)#',  $product['price'], $p ) ) { ?> 
				<meta content="<?php echo $p[0]; ?>" itemprop="price">
				<?php } ?>
			<?php } else { ?>
				<span class="price-new"><?php echo $product['special']; ?></span>
				<span class="price-old"><?php echo $product['price']; ?></span> 
				<?php if( preg_match( '#(\d+).?(\d+)#',  $product['special'], $p ) ) { ?> 
				<meta content="<?php echo $p[0]; ?>" itemprop="price">
				<?php } ?>
			<?php } ?>
			<meta content="<?php // echo $this->currency->getCode(); ?>" itemprop="priceCurrency">
		</div>
		<?php } ?>		

		<div class="product-hover"> 				     

		    <?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
				<div class="cart pull-left">
					<button data-loading-text="Loading..." type="button" value="<?php echo $button_cart; ?>" onclick="cart.addcart('<?php echo $product['product_id']; ?>');" class="addtocart"><span><?php echo $button_cart; ?></span></button>		
				</div>
			<?php } ?>

	    	<div class="wishlist pull-left">					
				<a class="btn btn-outline-inverse" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.addwishlist('<?php echo $product['product_id']; ?>');"><i class="fa-fw fa fa-heart-o"></i></a>	
			</div>
			<div class="compare pull-left">										
				<a class="btn btn-outline-inverse" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.addcompare('<?php echo $product['product_id']; ?>');"><i class="fa-fw fa fa-retweet"></i></a>	
			</div>	
		</div>
		

	</div>

</div>





