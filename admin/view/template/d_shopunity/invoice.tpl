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
					<li  class="active"><a href="<?php echo $href_invoice; ?>" >
						<span class="fa fa-user"></span> 
						<?php echo $tab_invoice; ?>
					</a></li>
					<li><a href="<?php echo $href_transaction; ?>" >
						<span class="fa fa-user"></span> 
						<?php echo $tab_transaction; ?>
					</a></li>
				</ul>
				<h2>Invoices</h2>
				<p>These are the purchases for the current shop. You may have more purchases for other shops. To view them, visit your account.</p>
			</div>
			<div class="ibox-content">
				 <?php if($invoices){?>
				 <table class="table">
				 	<thead>
				 		<tr>
				 			<th>Order ID</th>
							<th>Description</th>
							<th>Status</th>
							<th>Total</th>
							<th>Action</th>
				 		</tr>

				 	</thead>
				 	<tbody>
					<?php foreach($invoices as $invoice){ ?>
						<tr>
							<td>
								<?php echo $invoice['invoice_id'] ?>
							</td>
							
							<td>
								<a href="<?php echo $invoice['url']; ?>">
									<div class="h4 name"><?php echo $invoice['name'] ?></div>
								</a>
								<p class="description"><?php echo $invoice['date_added'] ?> </p>
								<?php if(!$invoice['invoice_status_id']){ ?>
									<div class="alert alert-danger">
										This invoice is overdue - please pay it as soon as possible.
									</div>

								<?php } ?>
							</td>
							<td>
								<?php echo ${'text_invoice_status_'.$invoice['invoice_status_id']}; ?>
							</td>
							<td>
								<?php echo $invoice['total_format'] ?>
							</td>
							<td>
								
						        <div class="pull-right">
					                <?php if($invoice['invoice_status_id'] == 0){ ?>
					                <a class="btn btn-success" href="<?php echo $invoice['pay']; ?>" data-toggle="tooltip" data-original-title="Pay"><span class="fa fa-money"></span></a>
						       		<?php }elseif($invoice['refundable']){ ?>
						       		<a class="btn btn-warning" href="<?php echo $invoice['refund']; ?>" data-toggle="tooltip" data-original-title="Refund"><span class="fa fa-repeat"></span></a>
						       		<?php } ?>
						       		<?php if($invoice['cancelable']){ ?> 
									<a class="btn btn-danger" href="<?php echo $invoice['cancel']; ?>" data-toggle="tooltip" data-original-title="Cancel"><span class="fa fa-ban"></span></a>
						       		<?php } ?>
					                <a class="btn btn-info	" href="<?php echo $invoice['url']; ?>" data-toggle="tooltip" data-original-title="View"><span class="fa fa-eye"></span></a>

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
					<?php if($invoices) { ?>
					<a class="btn btn-default pull-right" href="<?php echo $next; ?>">Next <span class="fa fa-chevron-right"></span></a>
					<?php } ?>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- <pre>
	<?php print_r($invoices); ?>
</pre>	 -->
<?php echo $content_bottom; ?>