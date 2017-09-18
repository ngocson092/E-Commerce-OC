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

    <?php if($extension['updatable'] && $extension['installed']){ ?>
        <?php if($extension['update_available']){?>
            <!-- update -->
            <div class="alert alert-info">
                <div class="row">
                    <div class="col-md-8">
                        <h4>New version available.</h4>
                        <?php foreach($extension['changelog'] as $changelog){ ?>
                            <p><strong><?php echo $changelog['version']; ?></strong> <?php echo $changelog['change']; ?></p>
                        <?php } ?>
                    </div>
                    <div class="col-md-4">
                        <a class="btn btn-info pull-right show-loading popup-extension m-b" data-href="<?php echo $extension['popup']; ?>&theme=extension_thumb_row&action=update"  data-toggle="tooltip" data-original-title="Update"><span class="fa fa-refresh"></span> Install v<?php echo $extension['version']; ?></a>
                    </div>
                </div>
            </div>
        <?php } ?>
    <?php } ?>
    <?php include(DIR_APPLICATION.'view/template/extension/d_shopunity/purchase_modal.tpl'); ?>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $('.extension-show-thumb').fadeIn();
    });
</script>
</body>
</html>