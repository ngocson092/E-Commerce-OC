<?php
/*
 *	location: admin/view
 */
?>
<?php echo $content_top; ?>
<div class="row">
	<div class="col-md-3">
		<?php echo $profile; ?>
	</div>
	<div class="col-md-9">
		<div class="ibox">
			<div class="ibox-title">
				<ul class="nav nav-tabs">
					<li><a href="<?php echo $href_order; ?>" >
						<span class="fa fa-user"></span> 
						<?php echo $tab_order; ?>
					</a></li>
					<li><a href="<?php echo $href_invoice; ?>" >
						<span class="fa fa-user"></span> 
						<?php echo $tab_invoice; ?>
					</a></li>
					<li class="active"><a href="<?php echo $href_transaction; ?>" >
						<span class="fa fa-user"></span> 
						<?php echo $tab_transaction; ?>
					</a></li>
				</ul>
				<h2>Transactions</h2>
				<p>These are the purchases for the current shop. You may have more purchases for other shops. To view them, visit your account.</p>
			</div>
			<div class="ibox-content">
				 <?php if($transactions){?>
				 <table class="table">
				 	<thead>
				 		<tr>
				 			<th>Order ID</th>
							<th>Description</th>
							<th>Amount</th>
				 		</tr>

				 	</thead>
				 	<tbody>
					<?php foreach($transactions as $transaction){ ?>
						<tr>
							<td>
								<?php echo $transaction['date_added'] ?>
							</td>
							<td>
								<div class="h4 name">#<?php echo $transaction['user_transaction_id'] ?> <?php echo $transaction['description'] ?></div>
							</td>
							<td>
								<?php echo $transaction['amount_format'] ?>
							</td>
						</tr>
					<?php } ?>
					</tbody>
				</table>
				<?php } ?>
				<div class="clearfix">
					<?php if($page > 1) {?>
					<a class="btn btn-default" href="<?php echo $prev; ?>"><span class="fa fa-chevron-left"></span> Prev</a>
					<?php } ?>
					<?php if($transactions) { ?>
					<a class="btn btn-default pull-right" href="<?php echo $next; ?>">Next <span class="fa fa-chevron-right"></span></a>
					<?php } ?>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- <pre>
	<?php print_r($transactions); ?>
</pre>  -->
<?php echo $content_bottom; ?>