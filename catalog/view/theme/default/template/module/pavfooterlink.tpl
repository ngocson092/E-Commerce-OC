<?php if($status) { ?>
	<h5><?php echo $text_title; ?></h5>

	<?php if($group==99) { ?>
	<ul class="list-unstyled">
		<?php foreach ($links as $link) { ?>
		<li><i class="<?php echo $link['icon']; ?>">&nbsp;</i><a href="<?php echo $link['href']; ?>"> <?php echo $link['title']; ?></a></li>
		<?php } ?>
	</ul>
	<?php } else { // contact footer?>
	<ul class="list-unstyled">
		<?php foreach ($links as $link) { ?>
		<li><a href="<?php echo $link['href']; ?>"><?php echo $link['title']; ?></a></li>
		<?php } ?>
	</ul>
	<?php } ?>
<?php } ?>