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
				<h2><strong>#<?php echo $invoice['invoice_id']; ?></strong>: <?php echo $invoice['name']; ?></h2>
			</div>
			<div class="ibox-content">
				<div id="tab_order">
					<h2>Invoice</h2>
					<p>These are the purchases for the current shop. You may have more purchases for other shops. To view them, visit your account.</p>
					<?php if($invoice['invoice_orders']) {?>
					<table class="table">
					 	<thead>
					 		<tr>
					 			<th>#</th>
					 			<th>name</th>
								<th>quantity</th>
								<th>price</th>
								<th>total</th>
					 		</tr>

					 	</thead>
					 	<tbody>
						<?php $i = 0; foreach($invoice['invoice_orders'] as $order){ ?>
							<tr>
								<td>
									<?php echo ++$i; ?>
								</td>
								<td>
									<?php echo $order['name'] ?> from <?php echo $order['date_start'] ?> till <?php echo $order['date_finish'] ?>
								</td>
								<td>
									1
								</td>
								<td>
									<?php echo $order['recurring_price'] ?>
								</td>
								<td>
									<?php echo $order['recurring_price'] ?>
								</td>
							</tr>
						<?php } ?>
							<tr>
								<td colspan="4"></td>
								<td><?php echo $invoice['total_format'] ?></td>
							</tr>
						</tbody>
					</table>
					<?php } ?>
				</div>
				<div id="tab_history">
					<h2>History</h2>
					<p>These are the purchases for the current shop. You may have more purchases for other shops. To view them, visit your account.</p>
					<?php if($invoice['invoice_history']) {?>
						<table class="table">
						 	<thead>
						 		<tr>
						 			<th>ID</th>
						 			<th>date_added</th>
									<th>description</th>
									<th>order_status_id</th>
						 		</tr>

						 	</thead>
						 	<tbody>
							<?php foreach($invoice['invoice_history'] as $invoice_history){ ?>
								<tr>
									<td>
										<?php echo $invoice_history['invoice_history_id'] ?>
									</td>
									<td>
										<?php echo $invoice_history['date_added'] ?>
									</td>
									<td>
										<?php echo $invoice_history['description'] ?>
									</td>
									<td>
										<?php echo $invoice_history['invoice_status_id'] ?>
									</td>
								</tr>
							<?php } ?>
							</tbody>
						</table>
						<?php } ?>
				</div>
			</div>
		</div>
		<!-- <pre>
		<?php print_r($invoice); ?>
		</pre> -->
	</div>
</div>
<?php echo $content_bottom; ?>