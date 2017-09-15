<div class="pav-newsletter">
	<div class="box<?php echo $prefix; ?> newsletter_block" id="newsletter_<?php echo $position.$module;?>">
		<div class="box-content">
			<form id="formNewLestter" method="post" action="<?php echo $action; ?>" class="form-group formNewLestter">
	            <div class="box-heading">
		            	<span><?php echo $objlang->get("Newsletter");?></span>	
	            </div>
	            <div class="description"><?php echo html_entity_decode( $description );?></div>
	            <div class="group clearfix">
	                <input type="text" placeholder="Your email ..." class="inputNew form-control email" <?php if(!isset($customer_email)): ?> <?php endif; ?> size="18" name="email">
	                <button type="submit" name="submitNewsletter" class="button_mini btn btn-theme-primary pull-right submitNewsletter"><?php echo $objlang->get("button_subscribe");?><i class="fa-fw fa fa-long-arrow-right"></i></button>
	             
	                <input type="hidden" value="1" name="action">
	                <div class="valid"></div>                
	            </div>   

			</form>
			<?php if (!empty($social)): ?>
			    <?php  echo html_entity_decode( $social );?>
			<?php endif ?>
		</div>
	</div>		
</div>
<script type="text/javascript"><!--

	$( document ).ready(function() {
		var id = 'newsletter_<?php echo $position.$module;?>';
		$('#'+id+' .box-heading').bind('click', function(){
			$('#'+id).toggleClass('active');
		});

		$('#formNewLestter').on('submit', function() {
			var email = $('.inputNew').val();
			$(".success_inline, .warning_inline, .error").remove();
			if(!isValidEmailAddress(email)) {				
			$('.valid').html("<div class=\"error alert alert-danger\"><?php echo $objlang->get('valid_email'); ?><button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div></div>");
			$('.inputNew').focus();
			return false;
		}
		var url = "<?php echo $action; ?>";
		$.ajax({
			type: "post",
			url: url,
			data: $("#formNewLestter").serialize(),
			dataType: 'json',
			success: function(json)
			{
				$(".success_inline, .warning_inline, .error").remove();
				if (json['error']) {
					$('.valid').html("<div class=\"warning_inline alert alert-danger\">"+json['error']+"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div>");
				}
				if (json['success']) {
					$('.valid').html("<div class=\"success_inline alert alert-success\">"+json['success']+"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div>");
				}
			}
		});
		return false;
	});
});

function isValidEmailAddress(emailAddress) {
	var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
	return pattern.test(emailAddress);
}
--></script>