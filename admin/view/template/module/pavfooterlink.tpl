<?php 
	echo $header; 
	echo $column_left;
?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form" data-toggle="tooltip" title="" class="btn btn-primary" data-original-title="Save"><i class="fa fa-save"></i></button>
				<a class="btn btn-danger" href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div><!-- End div#page-header -->

	<div id="page-content" class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
			<?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if (isset($success) && !empty($success)) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
			</div>
			<div class="panel-body">
				<?php if(!empty($module_id)) { ?>
				<div class="action pull-right">
					<a onclick="confirm('Are you sure?') ? location.href='<?php echo $delete; ?>' : false;" data-toggle="tooltip" title="" class="btn btn-danger btn-sm" data-original-title="Delete"><i class="fa fa-remove"> Delete</i></a>
				</div>
				<?php } ?>
				<ul class="nav nav-tabs" role="tablist">
					<?php if ($extensions) { ?>
					<?php foreach ($extensions as $extension) { ?>
					<?php $actived = (empty($module_id))?"class='active'":''; ?>
					<li <?php echo $actived; ?>><a href="<?php echo $extension['edit']; ?>" ><i class="fa fa-plus-circle"></i> <?php echo $extension['name']; ?></a></li>
					<?php $i=0; foreach ($extension['module'] as $m) { $i++;?>
					<?php $active = ($m['module_id'] == $module_id)?'class="active"':''; ?>
					<li <?php echo $active; ?>><a href="<?php echo $m['edit']; ?>" ><i class="fa fa-minus-circle"></i> <?php echo $m['name']; ?></a></li>
					<?php } //end modules?>
					<?php } //end extensions?>
					<?php } //end if?>
				</ul>
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
					<div class="tab-pane">
						<table class="table noborder">
							<tr>
								<td class="col-sm-2 control-label"><?php echo $entry_module_name; ?></td>
								<td class="col-sm-10"><input class="form-control nostyle" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_module_name; ?>"/></td>
							</tr>
							<tr>
								<td class="col-sm-2 control-label"><?php echo $entry_module_class; ?></td>
								<td class="col-sm-10"><input class="form-control nostyle" name="class" value="<?php echo $class; ?>" placeholder="<?php echo $entry_module_class; ?>"/></td>
							</tr>							
							<tr>
								<td class="col-sm-2 control-label"><?php echo $entry_status; ?></td>
								<td class="col-sm-10">
									<select class="form-control nostyle" name="status">
										<?php if ($status) { ?>
										<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_enabled; ?></option>
										<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
								</td>
							</tr>
							<tr>
								<td class="col-sm-2 control-label"><?php echo $entry_grouplinks; ?></td>
								<td class="col-sm-10">
									<select class="form-control nostyle" name="groupLinks" id="grouplinks">
										<?php foreach ($links as $key => $value) { ?>
										<?php $selected = ($key == $groupLinks)?'selected="selected"':''; ?>
										<option <?php echo $selected; ?> value="<?php echo $key; ?>"><?php echo $value; ?></option>
										<?php } ?>
									</select>
								</td>
							</tr>
							<tr>
								<td class="col-sm-2 control-label"><?php echo $entry_footer_title; ?></td>
								<td class="col-sm-10">
									<?php foreach ($languages as $language) { ?>
										<div class="input-group nostyle">
											<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"></span>
											<input type="text" name="text_title[<?php echo $language['language_id']; ?>]" value="<?php echo isset($text_title[$language['language_id']])?$text_title[$language['language_id']]:''; ?>" class="form-control nostyle"/>
										</div>	
									<?php } ?>
								</td>
							</tr>
						</table>
						
						<table id="links" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<td class="text-left" style="width:15%"><?php echo "Icon"; ?></td>
									<td class="text-right" style="width:45%"><?php echo "Title"; ?></td>
									<td class="text-right" style="width:40%"><?php echo "Link"; ?></td>
									<td></td>
								</tr>
							</thead>
							<tbody>
								<?php $link_row = 0; ?>
								<?php foreach ($footer_links as $link) { ?>
								<tr id="link-row<?php echo $link_row;?>">
									<td class="text-left">
										<input type="text" name="footer_link[<?php echo $link_row;?>][icon]" value="<?php echo $link['icon']; ?>" class="form-control"/>
									</td>
									<td class="text-right">
										<?php foreach ($languages as $language) { ?>
										<div class="input-group">
											<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"></span>
											<input type="text" name="footer_link[<?php echo $link_row;?>][title][<?php echo $language['language_id']; ?>]" value="<?php echo $link['title'][$language['language_id']]; ?>" class="form-control nostyle"/>
										</div>	
										<?php } ?>
									</td>
									<td class="text-right">
										<input type="text" name="footer_link[<?php echo $link_row;?>][href]" value="<?php echo $link['href']; ?>" class="form-control"/>
									</td>
									<td>
										<button type="button" onclick="$('#link-row<?php echo $link_row;?>').remove();" data-toggle="tooltip" title="" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
									</td>
								</tr>
								<?php $link_row++; ?>
								<?php } ?>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="3"></td>
									<td class="text-left"><button type="button" onclick="addLink();" data-toggle="tooltip" title="" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
								</tr>
							</tfoot>
						</table>
						
					</div>
				</form>
			</div>
		</div><!-- end div content form -->

		</div>
	</div><!-- End div#page-content -->

</div><!-- End div#content -->
<style type="text/css">
	.noborder tbody > tr > td {border: 1px solid #fff;}
	.nostyle { width: 36%; }
</style>
<script type="text/javascript"><!--
<?php if($groupLinks==99) { ?>
	$("#links").show();
<?php } else { ?>
	$("#links").hide();
<?php }?>
$('#grouplinks').change(function() {
	var option = $(this).val();
	if(option == 99) {
		$("#links").show();
	} else {
		$("#links").hide();
	}
 });

var link_row = <?php echo $link_row; ?>;

function addLink() {
	html  = '<tr id="link-row' + link_row + '">';
	html += '	<td class="text-left">';
	html += '		<input type="text" name="footer_link['+link_row+'][icon]" value="fa fa-facebook" class="form-control"/>';
	html += '	</td>';
	html += '	<td class="text-right">';
				<?php foreach ($languages as $language) { ?>
	html += '		<div class="input-group">';
	html += '			<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"></span>';
	html += '			<input type="text" name="footer_link['+link_row+'][title][<?php echo $language['language_id']; ?>]" value="Footer Link" class="form-control nostyle"/>';
	html += '		</div>';
				<?php } ?>
	html += '	</td>';
	html += '	<td class="text-right">';
	html += '		<input type="text" name="footer_link['+link_row+'][href]" value="#" class="form-control"/>';
	html += '	</td>';
	html += '	<td class="text-left"><button type="button" onclick="$(\'#link-row' + link_row  + '\').remove();" data-toggle="tooltip" title="" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';
	
	$('#links tbody').append(html);
	link_row++;
}
//--></script> 
<?php echo $footer; ?>