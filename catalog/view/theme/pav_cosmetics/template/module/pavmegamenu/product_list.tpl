<?php if( isset($widget_name)){
?>
<h3 class="menu-title"><?php echo $widget_name;?></h3>
<?php
}?>
<div class="widget-product-list">
  <div class="widget-inner">
    
      <?php foreach ($products as $product) { ?>
      <div class="product-block clearfix pull-left">
        <div class="w-product">
          <?php if ($product['thumb']) { ?>
          <div class="image">
            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
          </div>
          <?php } ?>
          <div class="product-meta">
            <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
            <?php if ($product['price']) { ?>
            <div class="price">
              <?php if (!$product['special']) { ?>
              <?php echo $product['price']; ?>
              <?php } else { ?>
              <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
              <?php } ?>
            </div>
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
            
          </div>
        </div>
        </div>
      <?php } ?>
      
  </div>
</div>