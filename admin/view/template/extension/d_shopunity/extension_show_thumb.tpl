<!DOCTYPE html>
<html>
<head>

    <?php foreach ($styles as $style) { ?>
    <link type="text/css" href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>
    <?php foreach ($scripts as $script) { ?>
    <script type="text/javascript" src="<?php echo $script; ?>"></script>
    <?php } ?>
    <style>
        .extension-show-thumb{
            display: none;
        }
        .extension-thumb .ibox-content{
            border: 1px solid #efefef;
            border-top: none;
        }
         
    </style>
</head>
<body>
<div class="extension-show-thumb">
    <?php echo $extension; ?>
    <?php include(DIR_APPLICATION.'view/template/extension/d_shopunity/purchase_modal.tpl'); ?>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $('.extension-show-thumb').fadeIn();
    });
</script>
</body>
</html>

