<?php $olang = $this->registry->get('language'); ?>
<div class="product-filter clearfix">
  <div class="display pull-left">
    <div class="btn-group group-switch pull-left">
      <button type="button" id="list-view" class="btn btn-switch" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
      <button type="button" id="grid-view" class="btn btn-switch active" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
    </div>
    <div class="sort pull-right">
      <span  for="input-sort"><?php echo $text_sort; ?></span>
      <select class="form-control" id="input-sort" onchange="location = this.value;">
        <?php foreach ($sorts as $sorts) { ?>
        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
        <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
   
    <div class="limit pull-right">
      <span  for="input-limit"><?php echo $text_limit; ?></span>
      <select id="input-limit" class="form-control" onchange="location = this.value;">
        <?php foreach ($limits as $limits) { ?>
        <?php if ($limits['value'] == $limit) { ?>
        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
  </div> 

  <div class="filter-right pull-right">
     <div class="product-compare pull-right"><a href="<?php echo $compare; ?>" class="btn btn-theme-primary" id="compare-total"><?php echo $text_compare; ?></a></div>
      
     </div> 
   
</div> 
 
