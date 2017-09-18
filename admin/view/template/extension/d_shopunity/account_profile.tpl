<div class="ibox account-profile">
	<div class="ibox-content">
		<div class="image">
			<img src="<?php echo $account['image']; ?>" class="img-responsive"/>
		</div>
		<div class="caption">
			
			<div class="h1 username"><?php echo $account['username']; ?></div>
			<div class="h2 balance"><?php echo $account['balance_format']; ?>
				<a class="btn btn-success btn-xs add-to-balance" href="<?php echo $add_money; ?>" target="_blank"><span class="fa fa-plus"></span></a>
			</div>
			<div class="h4 name"><?php echo $account['firstname']; ?> <?php echo $account['lastname']; ?></div>
		</div>
	</div>
</div>