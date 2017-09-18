<?php
/*
 *	location: admin/view
 */
?>
<?php echo $content_top; ?>
<div class="row">
	
	<div class="col-md-12">
		<div class="ibox">
			<div class="ibox-title">
				<h4>Search for extensions</h4>
				<p>
					<div class="input-group input-group-lg">
						<input type="text" class="form-control" placeholder="Search for...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button">Go!</button>
						</span>
					</div><!-- /input-group -->
				</p>
				
			</div>
		</div>

		<div class="ibox">
			<div class="ibox-title">
				<h4>Purchased modules.</h4>
				<p>These modules have been purchased. You can use them only for this webshop.</p>
			</div>
		
			<?php if($extensions){ ?>
			<div class="ibox-content">
				<?php foreach($extensions as $extension) { ?>

					<?php include(DIR_APPLICATION.'view/template/d_shopunity/extension_thumb_row.tpl'); ?>

				<?php } ?>
			</div>
			<?php }else{ ?>
				<div class="bs-callout bs-callout-info">No store modules to display</div>
			<?php } ?>
		</div>
		<div class="ibox">
			<div class="ibox-title">
				<h4>Unknown Modules.</h4>
				<p>These modules are not regestered with the shopunity network.</p>
			</div>
			<?php if($unregistered_extensions){ ?>
			<div class="ibox-content">
				<?php foreach($unregistered_extensions as $extension) { ?>

					<?php include(DIR_APPLICATION.'view/template/d_shopunity/extension_unregistered.tpl'); ?>

				<?php } ?>
			</div>
			<?php }else{ ?>
				<div class="bs-callout bs-callout-info">No local modules to display</div>
			<?php } ?>
		</div>
	</div>
</div>
<?php echo $content_bottom; ?>
