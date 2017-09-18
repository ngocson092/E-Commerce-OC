<?php
/*
 *	location: admin/view
 */
?>
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="form-inline pull-right">
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo $heading_title; ?> <?php echo $version; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if (!empty($error)) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if (!empty($success)) { ?>
		<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body">
				<div class="login">
					<div class="logo">Shopunity</div>
					<p class="description">
						Welcome to the most advance module manager in opencart community. 
						When becoming a member of Shopunity, you get access to many cool 
						features such as: automatic install, store update, module update 
						notification, subscribtion to commercial extensions and more. Now 
						managing your modules is as simple as pushing a button.
					</p>
					<form action="<?php echo $action_connect; ?>" method="post">
						<?php foreach($store_info as $key => $value) {?>
							<input type="hidden" name="<?php echo $key; ?>" value="<?php echo $value; ?>"/>
						<?php } ?>
						<button class="btn btn-success btn-lg"><span class="fa fa-plug"></span> Connect to <strong>Shopunity</strong></button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<?php echo $footer; ?>