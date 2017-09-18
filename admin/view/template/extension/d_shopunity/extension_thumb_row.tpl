<div class="extension-thumb extension-thumb-row"  id="extension_thumb_<?php echo $extension['codename']; ?>">
	<div class="row">
		<div class="col-md-1">
			<a href="<?php echo $extension['url']; ?>">
			   <img class="img-responsive img-rounded m-b" src="<?php echo $extension['processed_images'][1]['url']; ?>" alt="" />
			</a>
			<?php if($extension['downloadable'] && $extension['tester_status_id']){?>
			<p class="m-b m-t text-center">
				<?php if($extension['tester_status_id'] == 0 || $extension['tester_status_id'] == 3 || $extension['tester_status_id'] == 6) { ?>
					<span class="label label-danger">
				<?php } ?>
				<?php if($extension['tester_status_id'] == 1 || $extension['tester_status_id'] == 2) { ?>
					<span class="label label-info">
				<?php } ?>
				<?php if($extension['tester_status_id'] == 4) { ?>
					<span class="label label-warning">
				<?php } ?>
				<?php if($extension['tester_status_id'] == 5) { ?>
					<span class="label label-success">
				<?php } ?>

					<?php echo ${'text_tester_status_'.$extension['tester_status_id']}; ?>
				</span>
			</p>
			<?php } ?>
		</div>
		<div class="col-md-2">
			<strong class="name"><?php echo $extension['name']; ?></strong>
			<span class="label label-default"><?php echo $extension['current_version']; ?></span> 
			<?php if(!empty($extension['part_of_pack'])) {?>
                <span class="label label-info">Part of pack</span>
            <?php } ?>
			<p class="m-t m-b">
				<?php if($extension['installed'] || $extension['admin'] || ($extension['submittable'] && $extension['installed']) || $extension['downloadable']){ ?>	
					<div class="m-b">
					<?php if($extension['installed'] || $extension['downloadable']){ ?>	
						<a class="btn btn-info btn-xs show-extension-json" data-href="<?php echo $extension['json']; ?>" data-toggle="tooltip" data-original-title="mbooth.json"><span class="fa fa-code"></span></a>
					<?php } ?>
					<?php if($extension['admin']){ ?>
						<a class="btn btn-info btn-xs  show-loading" href="<?php echo $extension['admin']; ?>"  data-toggle="tooltip" data-original-title="Admin"><span class="fa fa-pencil"></span></a>
					<?php } ?>

					<?php if($extension['submittable'] && $extension['installed']){ ?>
		                <a class="btn btn-warning btn-xs  show-loading submit-extension" data-href="<?php echo $extension['submit']; ?>" data-toggle="tooltip" data-original-title="Submit"><span class="fa fa-cloud-upload"></span></a>
			        <?php } ?>

					<?php if($extension['downloadable'] && $extension['installed']){ ?>
		        		<a class="btn btn-default btn-xs download-extension" data-href="<?php echo $extension['download']; ?>"  data-toggle="tooltip" data-original-title="Download"><span class="fa fa-download"></span></a>
		        		<a class="btn btn-default btn-xs " href="<?php echo $extension['filemanager']; ?>"  data-toggle="tooltip" data-original-title="Filemanager"><span class="fa fa-file-code-o"></span></a>
			        	
			        <?php } ?>
					
					<?php if($extension['submittable'] && $extension['extension_id'] == 1){ ?>
		                <a class="btn btn-warning btn-xs show-loading developer-update-extension" data-href="<?php echo $extension['developer_update']; ?>" data-toggle="tooltip" data-original-title="Update everywhere"><span class="fa fa-globe"></span></a>
			        <?php } ?>
			        
			    	</div>
		    	<?php } ?>
			</p>
			
			

			
		</div>
		
		<div class="col-md-5">
			<p class="text-muted m-b"><?php echo $extension['description_short']; ?></p> 

	
			<?php if($extension['downloadable'] && $extension['tester_comment']){ ?>
				<div class="alert alert-danger"><strong>Tester's reason for rejection</strong><br/><?php echo $extension['tester_comment']; ?></div>
			<?php } ?>
	
			<?php if($extension['update_available']){?>
				<div class="alert alert-info"><?php echo $text_new_version_available; ?> <?php echo $extension['version']; ?></div>
			<?php } ?>
	</div>
		<div class="col-md-1 col-xs-3">
			<?php if(!empty($extension['developer'])){ ?>
				<a class="developer">
				   <img class="img-responsive img-circle" data-toggle="tooltip" data-original-title="<?php echo $extension['developer']['name']; ?>" src="<?php echo $extension['developer']['image']; ?>" />
				</a>
			<?php } ?>
		</div>
		
		<div class="col-md-3 col-xs-9">
			<div class="pull-right m-b">
				<div class="form-inline">
	            
	            <?php if($extension['installable'] && !$extension['installed']){ ?>
		            	<!-- install -->
		            	<a class="btn btn-success show-loading popup-extension" data-href="<?php echo $extension['popup']; ?>&theme=extension_thumb_row"  data-toggle="tooltip" data-original-title="Install"><span class="fa fa-magic"></span></a>
		            <?php } ?>
		            
		        	<?php if($extension['updatable'] && $extension['installed']){ ?>
		        		<!-- update -->
		        		<a class="btn btn-success show-loading popup-extension" data-href="<?php echo $extension['popup']; ?>&theme=extension_thumb_row&action=update"  data-toggle="tooltip" data-original-title="Update"><span class="fa fa-refresh"></span></a>
		        	<?php } ?>
		        	
			       
					<?php if($extension['purchasable'] ){ ?>
			        	<!-- purchase -->
			        	<div class=" btn-group">
							<?php if(!empty($extension['price'])){ ?>
				             <select class="form-control">
								<?php foreach($extension['prices'] as $price){ ?>
								<option value="<?php echo $price['extension_recurring_price_id']; ?>"><?php echo $price['recurring_price_format']; ?> / <?php echo $price['recurring_duration']; ?> days</option>
								<?php } ?>
							</select>
				          
				            <?php } ?>
				           
				            <a class="btn btn-primary pull-right popup-purchase" data-href="<?php echo $extension['popup_purchase']; ?>&theme=extension_thumb_row" data-extension-id="<?php echo $extension['extension_id'];?>">Get it</a>
						</div>
					<?php } ?>


		            <?php if($extension['installed']){ ?>
						<!-- delete -->
						<a class="btn btn-danger show-loading delete-extension" data-href="<?php echo $extension['uninstall']; ?>&theme=extension_thumb_row"  data-toggle="tooltip" data-original-title="Delete"><span class="fa fa-trash-o"></span></a>	
		            <?php } ?>

					<?php if($extension['suspendable'] && !$extension['installed']){ ?>
		            	<!-- suspend -->
		            	<a class="btn btn-danger show-loading suspend-extension" data-href="<?php echo $extension['suspend']; ?>" data-toggle="tooltip" data-original-title="Suspend"><span class="fa fa-ban"></span></a>
		        	<?php } ?>	        	
					
			        <?php if($extension['activate']){ ?>
			        	<!-- activate -->
						<a class="btn btn-success activate-extension hide" data-href="<?php echo $extension['activate']; ?>"  data-toggle="tooltip" data-original-title="Activate"><span class="fa fa-power-off "></span></a>
					<?php } ?>

					<?php if($extension['deactivate']){ ?>
						<!-- deactivate -->
						<a class="btn btn-danger deactivate-extension hide" data-href="<?php echo $extension['deactivate']; ?>"  data-toggle="tooltip" data-original-title="Deactivate"><span class="fa fa-power-off "></span></a>
					<?php } ?>
					
					
		        	<?php if($extension['commercial'] && !$extension['purchasable'] && !$extension['installable']){ ?>
		        		<!-- pay invoice -->
						<a class="btn btn-danger" href="<?php echo $extension['billing']; ?>" data-toggle="tooltip" data-original-title="Billing">Pay invoice</a>
		        	<?php } ?>
				</div>
		        <?php if($extension['testable']){ ?>
		        <br/>
		        <div class="form-inline pull-right">
	                <a class="btn btn-primary show-loading approve-extension" data-href="<?php echo $extension['approve']; ?>" data-toggle="tooltip" data-original-title="Approve"><span class="fa fa-thumbs-up"></span></a>
	                <a class="btn btn-danger show-loading disapprove-extension" data-href="<?php echo $extension['disapprove']; ?>" data-toggle="tooltip" data-original-title="Disaprove"><span class="fa fa-thumbs-down"></span></a>
	                <a class="btn btn-warning show-loading popup-extension" data-href="<?php echo $extension['popup']; ?>&theme=extension_thumb_row&action=test" ><span class="fa fa-cloud-download"></span></a>
		        </div>
		        <?php } ?>
	        </div>
		</div>
	</div>
</div>