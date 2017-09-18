<div class="ibox developer-generate-module">
	<div class="ibox-title">
				<h4>Generate a new module based on another one</h4>
	</div>
	<div class="ibox-content">
		<form  action="<?php echo $action; ?>" method="POST" class="form-inline">
		    <label for="exampleInputName2">Template module</label>
		    <select name="template_codename" class="form-control ">
					<?php foreach($extensions as $extension){?>
						<option value="<?php echo $extension['codename']; ?>"><?php echo $extension['codename']; ?></option>
					<?php } ?>
				</select>
		    <input type="text" class="form-control" id="exampleInputEmail2" name="codename" placeholder="codename">
		  <input type="submit" class="btn btn-default" value="Generate">
		</form>
		<form>
	</div>
</div>
