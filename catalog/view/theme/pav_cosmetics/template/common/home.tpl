<?php echo $header; ?> <?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>

<div class="warpper">
	<div class="container">
		<div class="row">
		  	<?php if( $SPAN[0] ): ?>
				<aside id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
					<?php echo $column_left; ?>
				</aside>	
			<?php endif; ?> 
		  	
		   	<section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
		   		<div id="content">
		   			<div class="content-top"><?php echo $content_top; ?></div>
		   			<div class="content-bottom"><?php echo $content_bottom; ?></div>
		   		</div>
		    </section> 
			<?php if( $SPAN[2] ): ?>
				<aside id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
					<?php echo $column_right; ?>
				</aside>
			<?php endif; ?>
		</div>
	</div>
</div>
<?php echo $footer; ?>