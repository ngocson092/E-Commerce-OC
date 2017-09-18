<div class="extension-popup" id="extension_<?php echo $extension['extension_id']; ?>">
		
		<div class="row">
			
			<div class="col-md-4">
				<img class="img-responsive img-thumbnail img-rounded m-b" src="<?php echo $extension['processed_images'][1]['url']; ?>" alt="" />
			</div>
			<div class="col-md-8">
				<h3><?php  echo $extension['name'];  ?> <span class="label label-default"><?php  echo $extension['version'];  ?></span></h3>
				<p><?php  echo $extension['description_short']; ?></p>
				<p><a class="btn btn-primary test-extension" data-href="<?php echo $extension['test']; ?>" data-extension_id="<?php echo $extension['extension_id']; ?>">Install</a></p>
			</div>
		</div>
		<?php if(!empty($extension['required'])){?>
		<div class="required">
			<h4>Dependencies</h4>
			<div class="alert alert-info">This extension relies on the extensions below to properly function. Most of the dependencies are free and will be installed automatically, yet there may be some dependencies that you will be required to purchase before you can use the main extension</div>
			<?php foreach ($extension['required'] as $key => $required) { ?>
				<hr/>
				<div class="row" id="required_<?php echo $required['extension_id']; ?>">
					<div class="col-md-1"><?php echo $key+1; ?></div>
					<div class="col-md-2"><img class="img-responsive img-thumbnail img-rounded m-b" src="<?php echo $required['processed_images'][1]['url']; ?>" alt="" /></div>
					<div class="col-md-5"><?php echo $required['name']; ?> <?php if($required['status']) {?> <span class="label label-default"><?php echo $required['version']; ?><span> <?php }else{ ?><span class="label label-danger">Inactive</span> <?php } ?> </div>
					<div class="col-md-4 ">
						<?php if($required['installed']){ ?>
							<span class="btn btn-default pull-right">installed</span>
						<?php } ?>
						<?php if(!$required['installed'] && $required['installable']){ ?>
							<span class="btn btn-success pull-right to-be-installed">
								<span class="text-start">Will be installed</span>
								<span class="text-process hide"><span class="fa fa-refresh fa-spin"></span></span>
								<span class="text-complete hide">installed</span>
							</span>
							<span class="btn btn-danger pull-right hide">
								<span class="text-error">Error</span>
							</span>
						<?php } ?>
						<?php if(!$required['installed'] && !$required['installable'] && $required['purchasable']){ ?>
							<span class="btn btn-danger pull-right">Please purchase</span>
						<?php } ?>
						<?php if(!$required['installed'] && !$required['installable'] && !$required['purchasable']){ ?>
							<span class="btn btn-danger pull-right">Can not be installed</span>
						<?php } ?>
					</div>
					<div class="col-md-12"></div>
				</div>

			<?php } ?>
		</div>
		<?php } ?>
		<pre class="log"></pre>
</div>