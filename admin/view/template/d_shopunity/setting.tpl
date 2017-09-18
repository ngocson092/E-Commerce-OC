<?php
/*
 *	location: admin/view
 */
?>
<?php echo $content_top; ?>


		<div class="form-group">
			<label class="col-sm-2 control-label" for="button_update"><?php echo $entry_update; ?></label>
			<div class="col-sm-2">
				<a id="button_update" class="btn btn-primary btn-block"><i class="fa fa-refresh"></i> <?php echo $button_update; ?></a>
			</div>
			<div class="col-sm-8">
				<div id="notification_update"></div>
			</div>
		</div><!-- //update -->
<script>
	$('body').on('click', '#button_update', function(){
		$.ajax( {
			url: '<?php echo $update; ?>',
			type: 'post',
			dataType: 'json',

			beforeSend: function() {
				$('#button_update').find('.fa-refresh').addClass('fa-spin');
			},

			complete: function() {
				$('#button_update').find('.fa-refresh').removeClass('fa-spin');
			},

			success: function(json) {
				console.log(json);

				if(json['error']){
					$('#notification_update').html('<div class="alert alert-danger m-b-none">' + json['error'] + '</div>')
				}

				if(json['warning']){
					$html = '';

					if(json['update']){
						$.each(json['update'] , function(k, v) {
							$html += '<div>Version: ' +k+ '</div><div>'+ v +'</div>';
						});
					}
					$('#notification_update').html('<div class="alert alert-warning alert-inline">' + json['warning'] + $html + '</div>')
				}

				if(json['success']){
					$('#notification_update').html('<div class="alert alert-success alert-inline">' + json['success'] + '</div>')
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
</script>
<?php echo $content_bottom; ?>
