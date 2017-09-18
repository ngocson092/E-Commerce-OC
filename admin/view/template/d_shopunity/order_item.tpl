<?php
/*
 *	location: admin/view
 */
?>
<?php echo $content_top; ?>
<div class="row">
	<div class="col-md-3">
		<?php include(DIR_APPLICATION.'view/template/d_shopunity/extension_thumb.tpl'); ?>

		<?php echo $developer; ?>
	</div>
	<div class="col-md-9">
		<div class="ibox">

			<div class="ibox-title">
				<h2><strong>#<?php echo $order['order_id']; ?></strong>: <?php echo $order['name']; ?></h2>
			</div>
			<div class="ibox-content">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab_history" data-toggle="tab">
						<span class="fa fa-user"></span> 
						<?php echo $tab_history; ?>
					</a></li>
					<li><a href="#tab_invoice" data-toggle="tab">
						<span class="fa fa-user"></span> 
						<?php echo $tab_invoice; ?>
					</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="tab_history">
						<h2>Order History</h2>
						<p>These are the purchases for the current shop. You may have more purchases for other shops. To view them, visit your account.</p>
						<?php if($order['order_history']) {?>
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
							<?php foreach($order['order_history'] as $order_history){ ?>
								<tr>
									<td>
										<?php echo $order_history['order_history_id'] ?>
									</td>
									<td>
										<?php echo $order_history['date_added'] ?>
									</td>
									<td>
										<?php echo $order_history['description'] ?>
									</td>
									<td>
										<?php echo ($order_history['order_status_id']) ? '<span class="label label-success">active</span>' : '<span class="label label-danger">inactive</span>'; ?>
									</td>
								</tr>
							<?php } ?>
							</tbody>
						</table>
						<?php } ?>
					</div>
					<div class="tab-pane" id="tab_invoice">
						<h2>Order Invoices</h2>
						<p>These are the purchases for the current shop. You may have more purchases for other shops. To view them, visit your account.</p>
						<?php if($order['order_invoices']) {?>
						<table class="table">
						 	<thead>
						 		<tr>
						 			<th>ID</th>
									<th>name</th>
									<th>date_start</th>
									<th>date_finish</th>
									<th>invoice_status_id</th>
									<th>price (total)</th>
						 		</tr>

						 	</thead>
						 	<tbody>
							<?php foreach($order['order_invoices'] as $invoice){ ?>
								<?php $invoice_order = array(); ?>
								<?php foreach($invoice['invoice_orders'] as $invoice_order) {?>
									<?php if($invoice_order['order_id'] == $order['order_id']) {?>
										<?php break; ?>
									<?php } ?>
								<?php } ?>
								<tr>
									<td>
										<?php echo $invoice['invoice_id'] ?>
									</td>
									<td>
										<?php echo $invoice['name'] ?>
									</td>
									<td>
										<?php echo $invoice_order['date_start'] ?>
									</td>
									<td>
										<?php echo $invoice_order['date_finish'] ?>
									</td>
									<td>
										<?php echo $invoice['invoice_status_id'] ?>
									</td>
									<td>
										<?php echo $invoice_order['recurring_price']; ?>
										(<?php echo $invoice['total_format']; ?>)
									</td>
								</tr>
							<?php } ?>
							</tbody>
						</table>
						<?php } ?>
					</div>
				</div>
			</div>
		</div>
		<!-- <pre>
		<?php print_r($order); ?>
		</pre> -->
	</div>
</div>
<?php echo $content_bottom; ?>