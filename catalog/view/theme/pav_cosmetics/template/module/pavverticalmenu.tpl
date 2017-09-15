<?php $objlang = $this->registry->get('language');?>
<div id="pav-verticalmenu" class="box pav-verticalmenu highlighted hidden-xs hidden-sm">
	<div class="box-heading">
		<span><?php echo $objlang->get('text_catalog_menu'); ?></span>
		<span class="shapes round"><em class="shapes bottom"></em></span>
	</div>
	<div class="box-content">
		<div class="navbar navbar-default">
			<div id="verticalmenu" class="verticalmenu" role="navigation">
				<div class="navbar-header">
					<a href="javascript:;" data-target=".navbar-collapse" data-toggle="collapse" class="navbar-toggle" type="button">
				        <span class="fa fa-bars"></span>
				     </a>
					<div class="collapse navbar-collapse navbar-ex1-collapse">
					<?php echo $treemenu; ?>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>