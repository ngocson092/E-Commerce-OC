<?php if (count($currencies) > 1) { ?>
<div class="currency-wrapper">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="currency">
  <div class="btn-group">
    <button type="button" class="btn btn-theme-normal">
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['symbol_left'] && $currency['code'] == $code) { ?>
    <span><span class="symbol"><?php echo $currency['symbol_left']; ?></span><span class="hidden-xs"><?php echo $currency['title']; ?></span></span>
    <?php } elseif ($currency['symbol_right'] && $currency['code'] == $code) { ?>
    <span><?php echo $currency['symbol_right']; ?><?php echo $currency['title']; ?></span>
    <?php } ?>
    <?php } ?>
   
    <i class="fa fa-angle-down"></i>
  </button>
    <ul class="dropdown-menu">
      <?php foreach ($currencies as $currency) { ?>
      <?php if ($currency['symbol_left']) { ?>
      <li><a class="currency-select list-item" href="javascript:void(0);" name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_left']; ?> <?php echo $currency['title']; ?></a></li>
      <?php } else { ?>
      <li><a class="currency-select list-item" href="javascript:void(0);" name="<?php echo $currency['code']; ?>"><?php echo $currency['symbol_right']; ?> <?php echo $currency['title']; ?></a></li>
      <?php } ?>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
</div>
<?php } ?>
