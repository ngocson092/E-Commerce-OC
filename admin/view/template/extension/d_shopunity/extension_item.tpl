<?php
/*
 *	location: admin/view
 */
?>
<?php echo $content_top; ?>
<div class="extention-item">
	<div class="ibox">
		<div class="ibox-content">
			<h1>
				<?php echo $extension['name']; ?>
				<?php echo $extension['current_version']; ?>
			</h1>
			<p><?php echo $extension['description_short']; ?></p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-3">
			<div class="ibox">
				<img src="<?php echo $extension['processed_images'][2]['url']; ?>" class="img-responsive"/>
			</div>
			<div class="ibox">
				<div class="ibox-title">
					User Actions
				</div>
				<div class="ibox-content">
					
					<?php if($extension['installable'] && !$extension['installed']){ ?>
		            	<!-- install -->
		            	<a class="btn btn-success btn-block m-b popup-extension" data-href="<?php echo $extension['popup']; ?>&theme=extension_thumb_row"  data-toggle="tooltip" data-original-title="Install"><span class="fa fa-magic"></span> Install</a>
		            <?php } ?>
		            
		        	<?php if($extension['updatable'] && $extension['installed']){ ?>
		        		<!-- update -->
		        		<a class="btn btn-success btn-block m-b popup-extension" data-href="<?php echo $extension['popup']; ?>&theme=extension_thumb_row&action=update"  data-toggle="tooltip" data-original-title="Update"><span class="fa fa-refresh"></span> Update</a>
		        	<?php } ?>
		        	
			       
					<?php if($extension['purchasable'] ){ ?>
			        	<!-- purchase -->
			        	<div  >
							<?php if(!empty($extension['price'])){ ?>
				             <select class="form-control m-b">
								<?php foreach($extension['prices'] as $price){ ?>
								<option value="<?php echo $price['extension_recurring_price_id']; ?>"><?php echo $price['recurring_price_format']; ?> / <?php echo $price['recurring_duration']; ?> days</option>
								<?php } ?>
							</select>
							<?php } ?>
							<a class="btn btn-primary btn-block m-b popup-purchase" data-href="<?php echo $extension['popup_purchase']; ?>" data-extension-id="<?php echo $extension['extension_id'];?>">Get it</a>
						</div>

					<?php } ?>

		            <?php if($extension['installed']){ ?>
						<!-- delete -->
						<a class="btn btn-danger btn-block m-b delete-extension" data-href="<?php echo $extension['uninstall']; ?>&theme=extension_thumb_row"  data-toggle="tooltip" data-original-title="Delete"><span class="fa fa-trash-o"></span> Delete</a>	
		            <?php } ?>

					<?php if($extension['suspendable'] && !$extension['installed']){ ?>
		            	<!-- suspend -->
		            	<a class="btn btn-danger btn-block m-b suspend-extension" data-href="<?php echo $extension['suspend']; ?>" data-toggle="tooltip" data-original-title="Suspend"><span class="fa fa-ban"></span> Suspend</a>
		        	<?php } ?>	        	
					
			        <?php if($extension['activate']){ ?>
			        	<!-- activate -->
						<a class="btn btn-success btn-block m-b activate-extension hide" data-href="<?php echo $extension['activate']; ?>"  data-toggle="tooltip" data-original-title="Activate"><span class="fa fa-power-off "></span> Activate</a>
					<?php } ?>

					<?php if($extension['deactivate']){ ?>
						<!-- deactivate -->
						<a class="btn btn-danger btn-block m-b deactivate-extension hide" data-href="<?php echo $extension['deactivate']; ?>"  data-toggle="tooltip" data-original-title="Deactivate"><span class="fa fa-power-off "></span> Deactivate</a>
					<?php } ?>
					
					
		        	<?php if($extension['commercial'] && !$extension['purchasable'] && !$extension['installable']){ ?>
		        		<!-- pay invoice -->
						<a class="btn btn-danger btn-block m-b" href="<?php echo $extension['billing']; ?>" data-toggle="tooltip" data-original-title="Billing">Pay invoice</a>
		        	<?php } ?>

		        	
				</div>
			</div>
			<?php if($extension['installed'] || $extension['admin'] || $extension['testable']){ ?>
			<div class="ibox">
				<div class="ibox-title">
					Developer & Tester Actions
					<?php if($extension['downloadable'] && $extension['tester_status_id']){?>
						<?php if($extension['tester_status_id'] == 0 || $extension['tester_status_id'] == 3 || $extension['tester_status_id'] == 6) { ?>
							<span class="label label-danger pull-right">
						<?php } ?>
						<?php if($extension['tester_status_id'] == 1 || $extension['tester_status_id'] == 2 || $extension['tester_status_id'] == 4) { ?>
							<span class="label label-info pull-right">
						<?php } ?>
						<?php if($extension['tester_status_id'] == 5) { ?>
							<span class="label label-success pull-right">
						<?php } ?>

							<?php echo ${'text_tester_status_'.$extension['tester_status_id']}; ?>
						</span>
					<?php } ?>
				</div>
				<div class="ibox-content">

					<?php if($extension['installed']){ ?>	
						<!-- json -->
						<a class="btn btn-info  show-extension-json" data-href="<?php echo $extension['json']; ?>" data-toggle="tooltip" data-original-title="mbooth.json"><span class="fa fa-code"></span></a>
					<?php } ?>
					<?php if($extension['admin']){ ?>
						<!-- admin -->
						<a class="btn btn-info " href="<?php echo $extension['admin']; ?>"  data-toggle="tooltip" data-original-title="Admin"><span class="fa fa-pencil"></span></a>
					<?php } ?>

					<?php if($extension['submittable'] && $extension['installed']){ ?>
						<!-- submit -->
		                <a class="btn btn-warning submit-extension" data-href="<?php echo $extension['submit']; ?>" data-toggle="tooltip" data-original-title="Submit"><span class="fa fa-cloud-upload"></span></a>
			        <?php } ?>

					<?php if($extension['downloadable'] && $extension['installed']){ ?>
						<!-- download -->
		        		<a class="btn btn-default download-extension" data-href="<?php echo $extension['download']; ?>"  data-toggle="tooltip" data-original-title="Download"><span class="fa fa-download"></span></a>
		        		<!-- filemanager -->
		        		<a class="btn btn-default " href="<?php echo $extension['filemanager']; ?>"  data-toggle="tooltip" data-original-title="Filemanager"><span class="fa fa-file-code-o"></span></a>
			        <?php } ?>

			        <?php if($extension['testable']){ ?>
		
		                <a class="btn btn-primary approve-extension" data-href="<?php echo $extension['approve']; ?>" data-toggle="tooltip" data-original-title="Approve"><span class="fa fa-thumbs-up"></span></a>
		                <a class="btn btn-danger disapprove-extension" data-href="<?php echo $extension['disapprove']; ?>" data-toggle="tooltip" data-original-title="Disaprove"><span class="fa fa-thumbs-down"></span></a>
		                <a class="btn btn-warning popup-extension" data-href="<?php echo $extension['popup']; ?>&theme=extension_thumb_row&action=test" data-toggle="tooltip" data-original-title="Test"><span class="fa fa-cloud-download"></span></a>
			  
			        <?php } ?>


				</div>
	    	</div>
	    	<?php } ?>
	        <?php echo $developer; ?>
		</div>
		<div class="col-md-9">
			<div class="ibox">
				<div class="ibox-content">
					<?php if($extension['downloadable'] && $extension['tester_comment']){ ?>
						<div class="alert alert-info"><?php echo $extension['tester_comment']; ?></div>
					<?php } ?>
					<div class="description"><?php echo html_entity_decode($extension['description']); ?></div>
				</div>
			</div>
			<!-- <pre>	
				<?php print_r($extension );?>
			</pre>  -->
		</div>
	</div>
</div>
<script>
	$(document).on('click', '.purchase .btn', function(){
		var href = $(this).attr('href');
			href += '&extension_recurring_price_id='+$(this).parents('.purchase').find('select').val();
			//console.log(href);
			location.href = href;
		return false;

	});
</script>
<?php echo $content_bottom; ?>