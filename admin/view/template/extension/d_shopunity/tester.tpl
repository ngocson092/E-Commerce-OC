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
						<input type="text" class="form-control fuzzy-search" placeholder="Search for...">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button">Go!</button>
						</span>
					</div><!-- /input-group -->
				</p>
				
			</div>
		</div>

		<div class="ibox">
			<div class="ibox-title">
				<h4>Tastable modules.</h4>
				<p>These modules have to bested by you.</p>
			</div>
		
			<?php if($extensions){ ?>
			<div id="list_search_1" class="ibox-content p-n">
				<ul class="list list-unstyled">
				<?php foreach($extensions as $extension) { ?>

					<li><?php include(DIR_APPLICATION.'view/template/extension/d_shopunity/extension_thumb_row.tpl'); ?></li>

				<?php } ?>
				</ul>
			</div>
			<?php }else{ ?>
				<div class="bs-callout bs-callout-info">No store modules to display</div>
			<?php } ?>
	
		</div>
	</div>
</div>

<script>
	
	var options = {
	  valueNames: [ 'name' ], 
	  plugins: [ ListFuzzySearch() ]
	};

	var userList1 = new List('list_search_1', options);

	$('.fuzzy-search').on("keyup",function(){
        userList1.search($(this).val());
    }); 

</script>
<?php echo $content_bottom; ?>
