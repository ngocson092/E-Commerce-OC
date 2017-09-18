<div class="extension-popup" id="extension_popup_<?php echo $extension['codename']; ?>">
		
		<div class="row m-b description">
			
			<div class="col-md-4 text-center">
				<img class="img-responsive img-rounded m-b" src="<?php echo $extension['processed_images'][1]['url']; ?>" alt="" />
				<p>
					<a class="btn btn-success text-start install-extension" data-href="<?php echo $action; ?>" data-extension_id="<?php echo $extension['extension_id']; ?>" data-codename="<?php echo $extension['codename']; ?>">Install</a>
					<a class="btn  btn-link text-process hide" disabled="disabled"><span class="fa fa-refresh fa-spin"></span> Installing...</a>
					<a class="btn  btn-link text-complete hide" disabled="disabled">Installed</a>
					<?php if($admin){ ?>
						<a class="btn  btn-info text-complete hide" href="<?php  echo $admin;  ?>"><span class="fa fa-pencil"></span> Admin</a>
					<?php } ?>
				</p>
			</div>
			<div class="col-md-8">
				<h3><?php  echo $extension['name'];  ?> <span class="label label-default"><?php  echo $extension['version'];  ?></span></h3>
				<p><?php  echo $extension['description_short']; ?></p>
				
			</div>
		</div>

		
		<ul class="nav nav-tabs" role="tablist">
			<?php if(!empty($extension['required'])){?><li role="presentation" class="active"><a href="#dependencies" aria-controls="dependencies" role="tab" data-toggle="tab">Dependencies</a></li><?php } ?>
			<li role="presentation"><a href="#log" aria-controls="log" role="tab" data-toggle="tab">Log</a></li>
			<li role="presentation"><a href="#mbooth" aria-controls="mbooth" role="tab" data-toggle="tab">Mbooth</a></li>
		</ul>
		<div class="tab-content">
		<?php if(!empty($extension['required'])){?>
		
			<div role="tabpanel" class="tab-pane active" id="dependencies">
				<div class="alert alert-info">This extension relies on the extensions below to properly function. Most of the dependencies are free and will be installed automatically, yet there may be some dependencies that you will be required to purchase before you can use the main extension</div>
				<?php foreach ($extension['required'] as $key => $required) { ?>
					<hr/>
					<div class="row" id="required_<?php echo $required['codename']; ?>">
						<div class="col-md-1"><?php echo $key+1; ?></div>
						<div class="col-md-2"><img class="img-responsive img-thumbnail img-rounded m-b" src="<?php echo $required['processed_images'][1]['url']; ?>" alt="" /></div>
						<div class="col-md-5">
							<p><?php echo $required['name']; ?> <?php if($required['status']) {?> <span class="label label-default"><?php echo $required['version']; ?><span> <?php }else{ ?><span class="label label-danger">Inactive</span> <?php } ?> </p>
							<p><?php if($required['commercial']) { ?><span class="label label-warning">Commercial</span><?php }else{ ?><span class="label label-info">Free</span><?php } ?></p>
						</div>
						<div class="col-md-4 text-right">
							<?php if($required['installed']){ ?>
								<span class="label label-info">installed</span>
							<?php } ?>
							<?php if(!$required['installed'] && $required['installable']){ ?>
								<span class="label label-warning  to-be-installed">
									<span class="text-start">Will be installed</span>
									<span class="text-process hide"><span class="fa fa-refresh fa-spin"></span> installing</span>
									<span class="text-complete hide">installed</span>
								</span>
								<span class="label label-danger  hide">
									<span class="text-error">Error</span>
								</span>
							<?php } ?>
							<?php if(!$required['installed'] && !$required['installable'] && $required['purchasable']){ ?>
								<span class="label label-danger ">Please purchase</span>
							<?php } ?>
							<?php if(!$required['installed'] && !$required['installable'] && !$required['purchasable']){ ?>
								<span class="label label-danger ">Can not be installed</span>
							<?php } ?>
							<?php if($extension['activate']){ ?>
					        	<!-- activate -->
								<a class="btn btn-success activate-extension hide" data-href="<?php echo $required['activate']; ?>"  data-toggle="tooltip" data-original-title="Activate"><span class="fa fa-power-off "></span></a>
							<?php } ?>

							<?php if($extension['deactivate']){ ?>
								<!-- deactivate -->
								<a class="btn btn-danger deactivate-extension hide" data-href="<?php echo $required['deactivate']; ?>"  data-toggle="tooltip" data-original-title="Deactivate"><span class="fa fa-power-off "></span></a>
							<?php } ?>
						</div>
						<div class="col-md-12"></div>
					</div>
				

				<?php } ?>
			</div>
		<?php } ?>
			<div role="tabpanel" class="tab-pane" id="log">
				<pre class="log">The installation process will be logged here.</pre>
			</div>
			<div role="tabpanel" class="tab-pane" id="mbooth">
				<pre class="mbooth"><?php echo $mbooth; ?></pre>
			</div>
		</div>
</div>