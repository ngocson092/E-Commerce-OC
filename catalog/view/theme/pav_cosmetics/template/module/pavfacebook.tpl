<div class="box hidden-sm hidden-xs">
	<div class="facebook-wrapper" style="width:<?php echo  $width;?>" >
	<?php if(isset($application_id) && $application_id) { ?>
		<div id="fb-root"></div>
		<script>(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) return;
		js = d.createElement(s); js.id = id;
		js.src = "//connect.facebook.net/<?php echo $displaylanguage ?>/all.js#xfbml=1&appId=<?php echo $application_id ?>";
		fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));</script>
	<?php } else {?>
		<script>(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) return;
		js = d.createElement(s); js.id = id;
		js.src = "//connect.facebook.net/<?php echo $displaylanguage ?>/all.js#xfbml=1";
		fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));</script>
		<?php } ?>

	<div class="fb-like-box" data-href="<?php echo $page_url; ?>" data-colorscheme="<?php echo $colorscheme;?>" data-height="<?php echo $height; ?>" data-width="<?php echo $width; ?>" data-show-faces="<?php echo ($show_faces ? 'true' : 'false'); ?>" data-stream="<?php echo ($tream ? 'true' : 'false'); ?>" data-show-border="<?php echo ( trim($border_color) ?'true':'false') ; ?>" data-header="<?php echo ($header ? 'true' : 'false'); ?>"></div>
</div>
</div>