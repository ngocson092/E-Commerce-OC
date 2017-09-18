<ul class="list-group">
	<?php if($categories){?> 
		<?php foreach($categories as $category){ ?>
		<li class="list-group-item"><a href="<?php echo $category['href']; ?>"><h4><?php echo $category['name']; ?></h4><small><?php echo $category['description']; ?></small></a></li>
		<?php } ?>
	<?php } ?>
</ul>



