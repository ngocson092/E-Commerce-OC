<!-- Quick Checkout v4.1.2 by Dreamvention.com quickcheckout/login.tpl -->
<?php if($login_style == 'popup') { ?>

  <div id="option_login_popup_trigger_wrap" <?php echo ($count) ? '' : 'class="qc-hide"'; ?>>
    <span id="option_register_popup" <?php if(!$data['option']['register']['display']){ echo 'class="qc-hide"'; } ?>>
        <input type="radio" name="account" value="register" id="register" <?php echo ($account == 'register') ? 'checked="checked"' : ''; ?> class="styled" data-refresh="1"  autocomplete='off' />
      <label for="register"><?php echo $data['option']['register']['title']; ?></label>
    </span>
    <span id="option_guest_popup" style="display:<?php if(!$data['option']['guest']['display']){ echo 'none'; } ?>;">
      <input type="radio" name="account" value="guest" id="guest" <?php echo ($account == 'guest') ? 'checked="checked"' : ''; ?> class="styled" data-refresh="1"  autocomplete='off'/>
      <label for="guest"><?php echo $data['option']['guest']['title']; ?></label>
    </span>
    <a id="option_login_popup_trigger" class="button btn btn-primary <?php echo (!$data['option']['login']['display']) ? 'qc-hide' : ''; ?>"><?php echo $button_login; ?></a>

    <?php if (isset($providers)) { ?>
      <style>
      #quickcheckout #d_social_login{
        display: inline-block;
        float: right;
        margin-right: 10px;
      }
      <?php foreach($providers as $provider){ ?>
        #quickcheckout #dsl_<?php echo $provider['id']; ?>_button{
          background:  <?php echo $provider['background_color']; ?>
        }
        #quickcheckout #dsl_<?php echo $provider['id']; ?>_button:active{
          background: <?php echo $provider['background_color_active']; ?>;
        }
      <?php } ?>
      </style> 
      <div id="d_social_login">
        <span class="dsl-label "><?php echo $button_sign_in; ?></span>
        <?php foreach($providers as $provider){ ?><?php if ($provider['enabled']) { ?><a id="dsl_<?php echo $provider['id']; ?>_button" class="dsl-button" href="index.php?route=module/d_social_login/provider_login&provider=<?php echo $provider['id']; ?>"><span class="l-side"><span class="dsl-icon-<?php echo $provider['id']; ?>"></span></span><span class="r-side"><?php echo $provider['heading']; ?></span></a><?php }  ?><?php } ?>
      </div>
    <?php }  ?>
  </div>
  <div id="option_login_popup_wrap" class="box-popup-wrap">
    <div id="option_login_popup" class="box-popup" style="display:<?php if(!$data['option']['login']['display']){ echo 'none'; } ?> ;">
  <div class="box-heading"><?php echo $text_returning_customer; ?></div>
  <div class="box-content">
    <div class="block-row email">
      <label for="login_email"><?php echo $entry_email; ?></label>
      <input type="text" name="email" value="" id="login_email" />
    </div>
    <div class="block-row password">
      <label for="login_password"><?php echo $entry_password; ?></label>
      <input type="password" name="password" value="" id="login_password"/>
    </div>
    <div class="block-row button-login">
      <input type="button" value="<?php echo $button_login; ?>" id="button_login_popup" class="button btn btn-primary" />
      <a id="remeber_password" href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a> </div>
    <div class="clear" ></div>
  </div>
  <div class="close">x</div>
</div>
</div>

<script><!--
$(function(){
  if($.isFunction($.fn.uniform)){
    $(" .styled, input:radio.styled").uniform().removeClass('styled');
  }
  $(document).on('click', '#option_login_popup_trigger', function(){
    $('#option_login_popup_wrap').show()
  })
  $(document).on('click', '#option_login_popup .close', function(){
    $('#option_login_popup_wrap').hide()
  })
})
//--></script>

<?php }else{ ?>

<div id="login_wrap">
  <div id="option_login" class="box box-border <?php echo (!$data['option']['login']['display'])? 'qc-hide' :''; ?>"  style="width: <?php echo $width; ?>%">
    <div class="box-heading"><?php echo $text_returning_customer; ?></div>
    <div class="box-content">
      <div class="block-row email">
        <label for="login_email"><?php echo $entry_email; ?></label>
        <input type="text" name="email" value="" id="login_email" />
      </div>
      <div class="block-row password">
        <label for="login_password"><?php echo $entry_password; ?></label>
        <input type="password" name="password" value="" id="login_password"/>
      </div>
      <div class="block-row button-login">
        <input type="button" value="<?php echo $button_login; ?>" id="button_login" class="button btn btn-primary" />
        <a id="remeber_password" href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a> 
      </div>
      <?php if (isset($providers)) { ?>

        <style>
        #quickcheckout #d_social_login{
        padding-top: 20px;
        clear: both;
        }
        <?php foreach($providers as $provider){ ?>
          #quickcheckout #dsl_<?php echo $provider['id']; ?>_button{
            background:  <?php echo $provider['background_color']; ?>
          }
          #quickcheckout #dsl_<?php echo $provider['id']; ?>_button:active{
            background: <?php echo $provider['background_color_active']; ?>;
          }
        <?php } ?>
        </style>
        <div id="d_social_login">
          <span class="dsl-label dsl-label-icons"><?php echo $button_sign_in; ?></span>
          <?php foreach($providers as $provider){ ?><?php if ($provider['enabled']) { ?><a id="dsl_<?php echo $provider['id']; ?>_button" class="dsl-button dsl-button-icons" href="index.php?route=module/d_social_login/provider_login&provider=<?php echo $provider['id']; ?>"><span class="l-side"><span class="dsl-icon-<?php echo $provider['id']; ?>"></span></span><span class="r-side"><?php echo $provider['heading']; ?></span></a><?php }  ?><?php } ?>
        </div>
      <?php } ?>
    </div>
  </div>
  <div id="option_register" class="box box-border <?php if ($account == 'register') { ?> selected <?php } ?>" style="display:<?php if(!$data['option']['register']['display']){ echo 'none'; } ?>; width: <?php echo $width; ?>%">
    <div class="box-heading"><?php echo $text_new_customer; ?></div>
    <div class="box-content">
      <div class="block-row register">
        <input type="radio" name="account" value="register" id="register" <?php echo ($account == 'register') ? 'checked="checked"' : ''; ?> class="styled" data-refresh="1"  autocomplete='off' />
        <label for="register"><?php echo $data['option']['register']['title']; ?></label>
      </div>
      <div class="block-row text"><?php echo $data['option']['register']['description']; ?></div>
      <div class="clear" ></div>
    </div>
  </div>
  <?php if ($guest_checkout) { ?>
  <div id="option_guest" class="box box-border <?php if ($account == 'guest') { ?> selected <?php } ?>" style="display:<?php if(!$data['option']['guest']['display']){ echo 'none'; } ?>; width: <?php echo $width; ?>%">
    <div class="box-heading"><?php echo $text_guest; ?></div>
    <div class="box-content">
      <div class="block-row guest">
        <input type="radio" name="account" value="guest" id="guest" <?php echo ($account == 'guest') ? 'checked="checked"' : ''; ?> class="styled" data-refresh="1"  autocomplete='off'/>
        <label for="guest"><?php echo $data['option']['guest']['title']; ?></label>
      </div>
      <div class="block-row text"><?php echo $data['option']['guest']['description']; ?></div>
      <div class="clear" ></div>
    </div>
  </div>
  <?php } ?>
</div>

<script><!--
$(function(){
  if($.isFunction($.fn.uniform)){
    $(" .styled, input:radio.styled").uniform().removeClass('styled');
  }
});
$(document).ready(function(){      
    setHeight('#step_1 .box-content');   
})
var maxHeight = 0;
function setHeight(column) {
  column = $(column);
  column.each(function() {       
    if($(this).height() > maxHeight) {
      maxHeight = $(this).outerHeight();
    }
  });

}
//--></script>
<?php } //if login_style ?>