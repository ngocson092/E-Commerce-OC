<?php
/*
 *	location: admin/view
 */
?>
<?php echo $content_top; ?>
<div class="row">
	<div class="col-md-3">
		<ul class="list-group">
 
			<li class="list-group-item"><a href="<?php echo $all; ?>"><h4>All</h4><small>All extensions</small></a></li>
			<li class="list-group-item"><a href="<?php echo $commercial; ?>"><h4>Commercial</h4><small>List of commercial extensions</small></a></li>
			<li class="list-group-item"><a href="<?php echo $free; ?>"><h4>Free</h4><small>List of free extensions</small></a></li>
		</ul>
		<?php echo $categories; ?>
		
	</div>
	<div class="col-md-9">
		<div class="ibox">
			<div class="ibox-title">
				<h4>Search for extensions</h4>
				<p>
					<div class="input-group input-group-lg">
						<input type="text" name="search" class="form-control" value="<?php echo $search; ?>" placeholder="Search for...">
						<span class="input-group-btn">
							<button class="btn btn-default search" data-href="<?php echo $search_href; ?>" type="button">Search</button>
						</span>
					</div><!-- /input-group -->
				</p>
				<!-- <p>
					<span class="label label-primary">Primary</span>
					<span class="label label-primary">Primary</span>
					<span class="label label-primary">Primary</span>
					<span class="label label-primary">Primary</span>
					<span class="label label-primary">Primary</span>
				</p> -->
			</div>
		</div>
		<!-- <div class="ibox clearfix">
			<div class="btn-group pull-right" data-toggle="buttons">
			  <label class="btn btn-primary active">
			    <input type="radio" name="options" id="option1" autocomplete="off" checked> Latest
			  </label>
			  <label class="btn btn-primary">
			    <input type="radio" name="options" id="option2" autocomplete="off"> Popular
			  </label>
			</div>
		</div> -->
		
		<div class="row">
			<?php if($extensions) { ?>
				<?php foreach($extensions as $extension) { ?>
					<div class="col-md-3 col-sm-6">
						<?php include(DIR_APPLICATION.'view/template/d_shopunity/extension_thumb.tpl'); ?>
					</div>
				<?php } ?>
			<?php } ?>
		</div>
		<div>
			<?php if($page > 1) {?>
			<a class="btn btn-default" href="<?php echo $prev; ?>"><span class="fa fa-chevron-left"></span> Prev</a>
			<?php } ?>
			<?php if(count($extensions) == 12) { ?>
			<a class="btn btn-default pull-right" href="<?php echo $next; ?>">Next <span class="fa fa-chevron-right"></span></a>
			<?php } ?>
		</div>
	</div>
</div>
<!-- <pre>
	<?php print_r($extensions); ?>
</pre>  -->
<?php echo $content_bottom; ?>