<div class="ibox developer-profile">
	<div class="ibox-title">
		<h4>Categories</h4>
		<p>Browes categories to find interesting extensions</p>
	</div>
</div>
<ul class="list-group">
	<?php if($categories){?> 
		<?php foreach($categories as $category){ ?>
		<li class="list-group-item"><a href=""><h4><?php echo $category['name']; ?></h4><small><?php echo $category['description']; ?></small></a></li>
		<?php } ?>
	<?php } ?>
</ul>



