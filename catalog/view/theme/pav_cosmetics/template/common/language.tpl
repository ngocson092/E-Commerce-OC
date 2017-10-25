<?php if (count($languages) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="language">
  <div class="btn-group">
    <button type="button" class="btn btn-theme-normal">
    <?php foreach ($languages as $language) { ?>
    <?php if ($language['code'] == $code) { ?>
      <?php echo $language['name']; ?>
    <?php } ?>
    <?php } ?>
    <i class="fa fa-angle-down"></i>
  </button>
    <ul class="dropdown-menu">
      <?php foreach ($languages as $language) { ?>
      <li><a href="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
  <input type="hidden" name="code" value="" />
  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
</form>
<?php } ?>
