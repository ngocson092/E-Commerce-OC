<?php
$sconfig = $this->registry->get('config'); 
$config = $sconfig->get('themecontrol');
if( isset($layoutID) && $layoutID ){
	$modules = $helper->getCloneModulesInLayout( $blockid, $layoutID ); 
}else {
	$modules = $helper->getModulesByPosition( $blockid ); 
}
 
if( count($modules) ){
$cols = isset($config['block_'.$blockid])&& $config['block_'.$blockid]?(int)$config['block_'.$blockid]:count($modules);	
$class = $helper->calculateSpans( $ospans, $cols );
?>
<section class="<?php echo str_replace('_','-',$blockid); ?> <?php $blockcls;?>" id="pavo-<?php echo str_replace('_','-',$blockid); ?>">
	<div class="container">
		<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
		<?php if(  $i++%$cols == 0 || count($modules)==1  ){  $j=1;?><div class="row"><?php } ?>	
		<div class="<?php echo $class[$j];?> <?php echo isset($tmcols)?$tmcols:'';?> <?php echo isset($prefixclass)?$prefixclass:'';?>"><?php echo $module; ?></div>
		<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
		<?php  $j++;  } ?>	
	</div>
</section>
<?php } ?>