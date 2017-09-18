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
					<li class="active"><a href="<?php echo $href_order; ?>" >
						<span class="fa fa-user"></span> 
						<?php echo $tab_order; ?>
					</a></li>
					<li><a href="<?php echo $href_invoice; ?>" >
						<span class="fa fa-user"></span> 
						<?php echo $tab_invoice; ?>
					</a></li>
					<li><a href="<?php echo $href_transaction; ?>" >
						<span class="fa fa-user"></span> 
						<?php echo $tab_transaction; ?>
					</a></li>
				</ul>
				<h2>Orders</h2>
				<p>These are the purchases for the current shop. You may have more purchases for other shops. To view them, visit your account.</p>
				<?php if($orders_overdue['count']){ ?>
				<div>You have <?php echo $orders_overdue['count']; ?> orders overdue with a total of <?php echo $orders_overdue['total_format']; ?> </div>
					<br/>
					<a href="<?php echo $create_invoice; ?>" class="btn btn-primary">Create Invoice</a>
				<?php } ?>
			</div>
			<div class="ibox-content">
				 <?php if($orders){?>
				 <table class="table">
				 	<thead>
				 		<tr>
				 			<th>Order ID</th>
							<th>Image</th>
							<th>Description</th>
							<th>Action</th>
				 		</tr>

				 	</thead>
				 	<tbody>
					<?php foreach($orders as $order){ ?>
						<tr>
							<td>
								<?php echo $order['order_id'] ?>
							</td>
							<td>
								<div class="img-sm">
									<img src="<?php echo $order['store_extension']['processed_images'][0]['url']; ?>" class="img-responsive img-rounded" />
								</div>
							</td>
							<td>
								<a  href="<?php echo $order['url']; ?>" >
									<div class="h4 name"><?php echo $order['name'] ?></div>
								</a>
								<?php  if($order['order_active']) { ?>
									<p class="description">Payment due on <?php echo $order['date_next_invoice'] ?> : <?php echo $order['store_extension']['store_extension']['recurring_price_format']; ?></p>
									<?php if($order['order_invoiced'] && !$order['order_paid']) { ?>
									<div class="alert alert-danger">Payment is overdue. Please pay the invoice</div>
									<?php } ?>
								<?php }else{ ?>
									<div class="alert alert-info">This Order is inactive</div>
								<?php }?>
							</td>
							<td>
						        <div class="pull-right">
					                <?php if(!$order['store_extension']['installed']) { ?>
						                <?php  if($order['store_extension']['store_extension']['status']) { ?>
						                	<?php if(!$order['trial_expired'] || $order['order_paid']){ ?>
						                		<a class="btn btn-danger" href="<?php echo $order['suspend']; ?>" data-toggle="tooltip" data-original-title="Suspend"><span class="fa fa-ban"></span></a>
							        		<?php } ?>
							        	<?php }else{ ?>
										<a class="btn btn-primary" href="<?php echo $order['activate']; ?>" data-toggle="tooltip" data-original-title="Activate"><span class="fa fa-refresh"></span></a>
							        	<?php } ?>
						        	<?php }else{ ?>
										<div class="btn btn-link" data-toggle="tooltip" data-original-title="The extension for this order is installed and is working"><span class="fa fa-check"></span></div>
						        	<?php } ?>
					                <a class="btn btn-info	" href="<?php echo $order['url']; ?>" data-toggle="tooltip" data-original-title="View"><span class="fa fa-eye"></span></a>
						        </div>
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
					<?php if($orders) { ?>
					<a class="btn btn-default pull-right" href="<?php echo $next; ?>">Next <span class="fa fa-chevron-right"></span></a>
					<?php } ?>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- <pre>
	<?php print_r($orders); ?>
</pre> -->	
<?php echo $content_bottom; ?>