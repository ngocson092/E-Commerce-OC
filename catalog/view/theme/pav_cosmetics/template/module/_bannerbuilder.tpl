<?php foreach ( $rows as $row) { 
	 			$row->level = '';
	 			$row->attrs = '';
	 	?>
	    <?php if ( $level==1 ){	 ?>
	        <div class="pts-container <?php if ( isset($row->parallax)&&$row->parallax ) { ?> pts-parallax <?php } ?>" <?php echo $row->attrs?>>        
	        	<div class="pts-inner">
	    <?php } ?>  
	    <div class="row row-level-<?php echo $level; ?>"><div class="row-inner <?php echo $row->cls; ?> clearfix">
	        <?php foreach( $row->cols as $col ) { ?>
	            <div class="col-lg-<?php echo $col->lgcol; ?> col-md-<?php echo $col->mdcol;?> col-sm-<?php echo $col->smcol;?> col-xs-<?php echo $col->xscol;?>">
	            <div class="col-inner">
	                <?php foreach ( $col->widgets as $widget ){ ?>
	                	<?php if( isset($widget->image) ) { ?>
	                    <div class="banner-wrapper">
	                    	<?php if($widget->link ){ ?>
                        	<a href="<?php echo $widget->link; ?>"><img alt="banner" src="<?php echo $url.'/image/'.$widget->image; ?>" class="img-responsive"></a>
                        	<?php }else { ?>
                        	<img src="<?php echo $url.'/image/'.$widget->image; ?>" alt="banner" class="img-responsive">
                        	<?php } ?>
                   		</div>
                   		<?php } ?>
	                <?php } ?>
	                <?php if (isset($col->rows)&&$col->rows) { ?>
	                    <?php   
	                        $rows = $col->rows;
	                 
	                        $level = $level + 1;
	                     	require( $template_builder );
	      					$level = $level - 1; 
	                    ?>
	                <?php } ?>
	            </div></div>
	        <?php } ?>
	    </div></div>
	    <?php if ($level==1 ) { ?>
	            </div></div>
	    <?php } ?>
<?php } ?> 
