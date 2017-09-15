<div id="banner<?php echo $module; ?>" class="box banner hidden-xs hidden-sm">
  <?php foreach ($banners as $banner) { ?>
  <?php if ($banner['link']) { ?>
  <div class="effect"><a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" class="img-responsive" /></a></div>
  <?php } else { ?>
  <div class="effect"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" class="img-responsive" /></div>
  <?php } ?>
  <?php } ?>
</div>