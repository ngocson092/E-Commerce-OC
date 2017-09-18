<div class="extension-thumb" id="extension_thumb_<?php echo $extension['codename']; ?>">
	<div class="ibox">
		<!-- <?php if(!empty($extension['description_short'])) {?>
        <p class="absolute-description">
            <?php echo $extension['description_short']; ?>
        </p>
        <?php } ?> -->
        <div class="loading">
        	<i class="fa fa-refresh fa-spin fa-3x fa-fw"></i>
			<span class="sr-only">Loading...</span>
        </div>
		<a href="<?php echo $extension['url']; ?>">
		   <img class="img-responsive" src="<?php echo $extension['processed_images'][1]['url']; ?>" alt="" />
		</a>
		<div class="ibox-content clearfix">
		    <div class="caption">
		        <h4 class="name">
		            <?php echo $extension['name']; ?>
		        </h4>
		        <p class="info">
		        	<span class="version label label-info">v<?php echo $extension['version']; ?></span>
					<?php if($extension['installed'] && $extension['store_extension'] && !$extension['store_extension']['status']) { ?>
		        		<span class="version label label-danger" data-toggle="tooltip" data-original-title="This extension is installed, yet you do not have an order or the invoice is not paid.">Unpaid</span>
		        	<?php } ?>
		        </p>

				<div class="pull-right">
					<?php if($extension['installable'] && !$extension['installed']){ ?>
		            	<!-- install -->
		            	<a class="btn btn-success btn-sm popup-extension" data-href="<?php echo $extension['popup']; ?>&theme=extension_thumb"  data-toggle="tooltip" data-original-title="Install"><span class="fa fa-magic"></span></a>
		            <?php } ?>
		            
		        	<?php if($extension['updatable'] && $extension['installed']){ ?>
		        		<!-- update -->
		        		<a class="btn btn-success btn-sm popup-extension" data-href="<?php echo $extension['popup']; ?>&theme=extension_thumb&action=update"  data-toggle="tooltip" data-original-title="Update"><span class="fa fa-refresh"></span></a>
		        	<?php } ?>
		        	
			       
					<?php if($extension['purchasable'] ){ ?>
			        	<!-- purchase -->
			        	<div class="purchase-extension btn-group form-inline">
							<?php if(!empty($extension['price'])){ ?>
				             <select class="form-control input-sm">
								<?php foreach($extension['prices'] as $price){ ?>
								<option value="<?php echo $price['extension_recurring_price_id']; ?>"><?php echo $price['recurring_price_format']; ?> / <?php echo $price['recurring_duration']; ?> days</option>
								<?php } ?>
							</select>
				          
				            <?php } ?>
				            <a class="btn btn-primary btn-sm pull-right" data-extension-id="<?php echo $extension['extension_id'];?>">Buy</a>
						</div>
					<?php } ?>

		            <?php if($extension['installed']){ ?>
						<!-- delete -->
						<a class="btn btn-danger btn-sm show-loading delete-extension" data-href="<?php echo $extension['uninstall']; ?>&theme=extension_thumb"  data-toggle="tooltip" data-original-title="Delete"><span class="fa fa-trash-o"></span></a>	
		            <?php } ?>

					<?php if($extension['suspendable'] && !$extension['installed']){ ?>
		            	<!-- suspend -->
		            	<a class="btn btn-danger btn-sm show-loading suspend-extension" data-href="<?php echo $extension['suspend']; ?>&theme=extension_thumb" data-toggle="tooltip" data-original-title="Suspend"><span class="fa fa-ban"></span></a>
		        	<?php } ?>	        	
					
			        <?php if($extension['activate']){ ?>
			        	<!-- activate -->
						<a class="btn btn-success btn-sm activate-extension hide" data-href="<?php echo $extension['activate']; ?>"  data-toggle="tooltip" data-original-title="Activate"><span class="fa fa-power-off "></span></a>
					<?php } ?>

					<?php if($extension['deactivate']){ ?>
						<!-- deactivate -->
						<a class="btn btn-danger btn-sm deactivate-extension hide" data-href="<?php echo $extension['deactivate']; ?>"  data-toggle="tooltip" data-original-title="Deactivate"><span class="fa fa-power-off "></span></a>
					<?php } ?>
					
		        	<?php if($extension['commercial'] && !$extension['purchasable'] && !$extension['installable']){ ?>
		        		<!-- pay invoice -->
						<a class="btn btn-danger btn-sm btn-sm" href="<?php echo $extension['billing']; ?>" data-toggle="tooltip" data-original-title="Billing">Pay invoice</a>
		        	<?php } ?>
		        </div>


		    </div>
	    </div>
	    <div class="ibox-footer clearfix hide">
	    	<div class="rating">
	    		<span class="fa fa-star"></span>
	    		<span class="fa fa-star"></span>
	    		<span class="fa fa-star"></span>
	    		<span class="fa fa-star"></span>
	    		<span class="fa fa-star"></span>
	    	</div>
	    	<div class="reviews"><span class="fa fa-comments"></span> 342</div>
	    	<div class="downloads"><span class="fa fa-cloud-download"></span> 34</div>
	    </div>
	</div>
</div>