<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="stripe-payments-form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
      <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
    </div>
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="stripe-payments-form">
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="stripe_payments_public_key"><?php echo $entry_public; ?></label>
          <div class="col-sm-10">
            <input size="40" type="text" name="stripe_payments_public_key" value="<?php echo $stripe_payments_public_key; ?>" placeholder="Stripe Public Live Key" id="stripe_payments_public_key" class="form-control" />
          </div>
        </div>
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="stripe_payments_private_key"><?php echo $entry_key; ?></label>
          <div class="col-sm-10">
            <input size="40" type="text" name="stripe_payments_private_key" value="<?php echo $stripe_payments_private_key; ?>" placeholder="Stripe Private Live Key" id="stripe_payments_private_key" class="form-control" />
          </div>
        </div>
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="stripe_payments_public_key_test"><?php echo $entry_public_test; ?></label>
          <div class="col-sm-10">
            <input size="40" type="text" name="stripe_payments_public_key_test" value="<?php echo $stripe_payments_public_key_test; ?>" placeholder="Stripe Public Test Key" id="stripe_payments_public_key_test" class="form-control" />
          </div>
        </div>
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="stripe_payments_private_key_test"><?php echo $entry_key_test; ?></label>
          <div class="col-sm-10">
            <input size="40" type="text" name="stripe_payments_private_key_test" value="<?php echo $stripe_payments_private_key_test; ?>" placeholder="Stripe Private Test Key" id="stripe_payments_private_key_test" class="form-control" />
          </div>
        </div>
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="stripe_payments_mode"><?php echo $entry_mode; ?></label>
          <div class="col-sm-10">
            <select name="stripe_payments_mode" id="stripe_payments_mode" class="form-control">
              <?php if ($stripe_payments_mode == 'live') { ?>
              <option value="live" selected="selected"><?php echo $text_live; ?></option>
              <?php } else { ?>
              <option value="live"><?php echo $text_live; ?></option>
              <?php } ?>
              <?php if ($stripe_payments_mode == 'test') { ?>
              <option value="test" selected="selected"><?php echo $text_test; ?></option>
              <?php } else { ?>
              <option value="test"><?php echo $text_test; ?></option>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="input-mode"><?php echo $entry_method; ?></label>
          <div class="col-sm-10">
            <select name="stripe_payments_method" id="stripe_payments_method-mode" class="form-control">
              <option value="charge" selected="selected"><?php echo $text_charge; ?></option>
            </select>
          </div>
        </div>
        <div class="form-group required">
          <label class="col-sm-2 control-label" for="stripe_payments_order_status_id-mode"><?php echo $entry_order_status; ?></label>
          <div class="col-sm-10">
            <select name="stripe_payments_order_status_id" id="stripe_payments_order_status_id-mode" class="form-control">
              <?php foreach ($order_statuses as $order_status) { ?>
              <?php if ($order_status['order_status_id'] == $stripe_payments_order_status_id) { ?>
              <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-2 control-label" for="stripe_payments_geo_zone_id-mode"><?php echo $entry_geo_zone; ?></label>
          <div class="col-sm-10">
            <select name="stripe_payments_geo_zone_id" id="stripe_payments_geo_zone_id-mode" class="form-control">
              <option value="0"><?php echo $text_all_zones; ?></option>
              <?php foreach ($geo_zones as $geo_zone) { ?>
              <?php if ($geo_zone['geo_zone_id'] == $stripe_payments_geo_zone_id) { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-2 control-label" for="stripe_payments_status-mode"><?php echo $entry_status; ?></label>
          <div class="col-sm-10">
            <select name="stripe_payments_status" id="stripe_payments_status-mode" class="form-control">
              <?php if ($stripe_payments_status) { ?>
              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_enabled; ?></option>
              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="col-md-2 control-label" for="stripe_payments_total"><?php echo $entry_total; ?></label>
          <div class="col-sm-10">
            <input size="20" type="text" name="stripe_payments_total" value="<?php echo $stripe_payments_total; ?>" placeholder="Payments Total Minimum" id="stripe_payments_total" class="form-control" />
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-2 control-label" for="stripe_payments_total"><?php echo $entry_sort_order; ?></label>
          <div class="col-sm-10">
            <input size="1" type="text" name="stripe_payments_sort_order" value="<?php echo $stripe_payments_sort_order; ?>" placeholder="0" id="stripe_payments_sort_order" class="form-control" />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>
