<?php
/* 	path:	admin/controller/module/quickcheckout
*	author: dreamvention
*/

class ControllerModuleQuickcheckout extends Controller {
	private $error = array(); 
	private $texts = array('title', 'tooltip', 'description', 'text');
	public $route  = 'module/quickcheckout';
	public $mbooth = 'mbooth_quickcheckout.xml';
	public $module = 'quickcheckout';

	public function index() {   
		$this->load->language($this->route);
		$this->load->model('setting/setting');
		
		if(isset($this->request->get['store_id'])){ $store_id = $this->request->get['store_id']; }else{  $store_id = 0; }
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->session->data['success'] = $this->language->get('text_success');
			unset($this->session->data['aqc_settings']);

			if(isset($this->request->post['quickcheckout']['general']['settings']['value'])){
				$settings = str_replace("amp;", "", urldecode($this->request->post['quickcheckout']['general']['settings']['bulk']));
				parse_str($settings, $this->request->post );	
			}
			
			$this->model_setting_setting->editSetting($this->module, $this->request->post, $store_id);

			if(!isset($this->request->post['save'])){
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}
		
		$this->document->addStyle('view/stylesheet/shopunity/normalize.css');
		$this->document->addStyle('view/stylesheet/shopunity/icons.css');
		$this->document->addStyle('view/stylesheet/shopunity/shopunity.css');
		$this->document->addScript('view/javascript/shopunity/shopunity.js');
		$this->document->addScript('view/javascript/shopunity/jquery.nicescroll.min.js');
		$this->document->addScript('view/javascript/shopunity/jquery.tinysort.min.js');	
		$this->document->addScript('view/javascript/shopunity/jquery.autosize.min.js');		
		$this->document->addScript('view/javascript/shopunity/tooltip/tooltip.js');
		$this->document->addStyle('view/javascript/shopunity/codemirror/codemirror.css');
		$this->document->addScript('view/javascript/shopunity/codemirror/codemirror.js');
		$this->document->addScript('view/javascript/shopunity/codemirror/css.js');
		$this->document->addStyle('view/javascript/shopunity/uniform/css/uniform.default.css');
		$this->document->addScript('view/javascript/shopunity/uniform/jquery.uniform.min.js');

		$this->document->addLink('//fonts.googleapis.com/css?family=PT+Sans:400,700,700italic,400italic&subset=latin,cyrillic-ext,latin-ext,cyrillic', "stylesheet");
		
		$this->document->setTitle($this->language->get('heading_title_main'));
		$data['heading_title'] = $this->language->get('heading_title_main');
		$data['text_need_full_version'] = $this->language->get('text_need_full_version');

		$data['version'] = $this->get_version();
		$data['token'] =  $this->session->data['token'];
		$data['route'] = $this->route;
		$data['store_id'] = $store_id;
		$data['shopunity'] = $this->check_shopunity();
		$data['settings_yes'] = $this->language->get('settings_yes');
		$data['settings_no'] = $this->language->get('settings_no');
		$data['settings_display'] = $this->language->get('settings_display');
		$data['settings_require'] = $this->language->get('settings_require');
		$data['settings_always_show'] = $this->language->get('settings_always_show');
		$data['settings_enable'] = $this->language->get('settings_enable');
		$data['settings_select'] = $this->language->get('settings_select');
		$data['settings_image'] = $this->language->get('settings_image');
		$data['settings_second_step'] = $this->language->get('settings_second_step');
		
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$data['text_column_left'] = $this->language->get('text_column_left');
		$data['text_column_right'] = $this->language->get('text_column_right');

		$data['entry_product'] = $this->language->get('entry_product');
		$data['entry_limit'] = $this->language->get('entry_limit');
		$data['entry_image'] = $this->language->get('entry_image');
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		// Home
		$data['text_home'] = $this->language->get('text_home');
		$data['text_home_h1'] = $this->language->get('text_home_h1');
		$data['heading_title_slogan'] = $this->language->get('text_home_h2');
		$data['text_general_intro'] = $this->language->get('text_general_intro');
		$data['text_payment_address_intro'] = $this->language->get('text_payment_address_intro');
		$data['text_shipping_address_intro'] = $this->language->get('text_shipping_address_intro');
		$data['text_shipping_method_intro'] = $this->language->get('text_shipping_method_intro');
		$data['text_payment_method_intro'] = $this->language->get('text_payment_method_intro');
		$data['text_confirm_intro'] = $this->language->get('text_confirm_intro');
		$data['text_design_intro'] = $this->language->get('text_design_intro');
		$data['text_plugins_intro'] = $this->language->get('text_plugins_intro');
		
		// General
		$data['text_general'] = $this->language->get('text_general');
		$data['text_general_enable'] = $this->language->get('text_general_enable');
		$data['text_general_version'] = $this->language->get('text_general_version');
		$data['text_general_debug'] = $this->language->get('text_general_debug');	
		$data['text_debug_button'] = $this->language->get('text_debug_button');	

		
		$data['text_general_default'] = $this->language->get('text_general_default');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_guest'] = $this->language->get('text_guest');
		
		$data['text_step_login_option'] = $this->language->get('text_step_login_option');
		$data['step_login_option_login_display'] = $this->language->get('text_login');
		$data['step_login_option_register_display'] = $this->language->get('text_register');
		$data['step_login_option_guest_display'] = $this->language->get('text_guest');
		
		$data['text_general_main_checkout'] = $this->language->get('text_general_main_checkout');
		$data['text_general_min_order'] = $this->language->get('text_general_min_order');
		$data['text_general_min_quantity'] = $this->language->get('text_general_min_quantity');
		$data['language_min_order_text'] = $this->language->get('language_min_order_text');
		$data['language_min_quantity_text'] = $this->language->get('language_min_quantity_text');
		
		$data['text_general_default_email'] = $this->language->get('text_general_default_email');
		
		$data['text_general_settings'] = $this->language->get('text_general_settings');
		$data['text_general_settings_value'] = $this->language->get('text_general_settings_value');
		$data['text_position_module'] = $this->language->get('text_position_module');

		$data['text_login'] = $this->language->get('text_login');
		$data['text_login_intro'] = $this->language->get('text_login_intro');

		$data['text_social_login_required'] = $this->language->get('text_social_login_required');
		
		//Payment address
		$data['text_payment_address'] = $this->language->get('text_payment_address');	
		$data['text_guest_customer'] = $this->language->get('text_guest_customer');
		$data['text_registrating_customer'] = $this->language->get('text_registrating_customer');
		$data['text_logged_in_customer'] = $this->language->get('text_logged_in_customer');
		$data['text_payment_address_display_input'] = $this->language->get('text_payment_address_display_input');
		
		//Shipping address
		$data['text_shipping_address'] = $this->language->get('text_shipping_address');
		$data['text_shipping_address_display_input'] = $this->language->get('text_shipping_address_display_input');
		
		
		//Shipping method
		$data['text_shipping_method'] = $this->language->get('text_shipping_method');	
		$data['text_shipping_method_display'] = $this->language->get('text_shipping_method_display');	
		$data['text_shipping_method_display_options'] = $this->language->get('text_shipping_method_display_options');	
		$data['text_shipping_method_display_title'] = $this->language->get('text_shipping_method_display_title');	
		$data['text_shipping_method_input_style'] = $this->language->get('text_shipping_method_input_style');	
		$data['text_radio_style'] = $this->language->get('text_radio_style');	
		$data['text_select_style'] = $this->language->get('text_select_style');
		$data['text_shipping_method_default_option'] = $this->language->get('text_shipping_method_default_option');
		
		//Payment method
		$data['text_payment_method'] = $this->language->get('text_payment_method');
		$data['text_payment_method_display'] = $this->language->get('text_payment_method_display');
		$data['text_payment_method_display_options'] = $this->language->get('text_payment_method_display_options');
		$data['text_payment_method_display_images'] = $this->language->get('text_payment_method_display_images');
		$data['text_payment_method_display_title'] = $this->language->get('text_payment_method_display_title');
		$data['text_payment_method_input_style'] = $this->language->get('text_payment_method_input_style');
		$data['text_payment_method_default_option'] = $this->language->get('text_payment_method_default_option');
		
		//Cart
		$data['text_cart'] = $this->language->get('text_cart');
		$data['text_cart_display'] = $this->language->get('text_cart_display');
		$data['text_cart_columns_image'] = $this->language->get('text_cart_columns_image');
		$data['text_cart_columns_name'] = $this->language->get('text_cart_columns_name');
		$data['text_cart_columns_model'] = $this->language->get('text_cart_columns_model');
		$data['text_cart_columns_quantity'] = $this->language->get('text_cart_columns_quantity');
		$data['text_cart_columns_price'] = $this->language->get('text_cart_columns_price');
		$data['text_cart_columns_total'] = $this->language->get('text_cart_columns_total');
		$data['text_cart_option_coupon'] = $this->language->get('text_cart_option_coupon');
		$data['text_cart_option_voucher'] = $this->language->get('text_cart_option_voucher');
		$data['text_cart_option_reward'] = $this->language->get('text_cart_option_reward');
		
		//Payment
		$data['text_payment'] = $this->language->get('text_payment');

		//Confirm
		$data['text_confirm'] = $this->language->get('text_confirm');
		$data['text_confirm_display'] = $this->language->get('text_confirm_display');

		
		//Design
		$data['text_design'] = $this->language->get('text_design');
		$data['text_general_theme'] = $this->language->get('text_general_theme');
		$data['text_general_block_style'] = $this->language->get('text_general_block_style');
		$data['text_style_row'] = $this->language->get('text_style_row');
		$data['text_style_block'] = $this->language->get('text_style_block');
		$data['text_general_login_style'] = $this->language->get('text_general_login_style');
		$data['text_general_address_style'] = $this->language->get('text_general_address_style');
		$data['text_general_uniform'] = $this->language->get('text_general_uniform');	
		$data['text_general_only_quickcheckout'] = $this->language->get('text_general_only_quickcheckout');
		$data['text_style_popup'] = $this->language->get('text_style_popup');	
		$data['text_general_cart_image_size'] = $this->language->get('text_general_cart_image_size');
		$data['text_cart_image_size_width'] = $this->language->get('text_cart_image_size_width');
		$data['text_cart_image_size_height'] = $this->language->get('text_cart_image_size_height');
		$data['text_general_max_width'] = $this->language->get('text_general_max_width');
		$data['text_general_column'] = $this->language->get('text_general_column');
		$data['text_general_custom_style'] = $this->language->get('text_general_custom_style');
		$data['text_general_trigger'] = $this->language->get('text_general_trigger');
		$data['text_payment_address_description'] = $this->language->get('text_payment_address_description');
		$data['text_shipping_address_description'] = $this->language->get('text_shipping_address_description');
		$data['text_shipping_method_description'] = $this->language->get('text_shipping_method_description');
		$data['text_payment_method_description'] = $this->language->get('text_payment_method_description');
		$data['text_cart_description'] = $this->language->get('text_cart_description');
		$data['text_payment_description'] = $this->language->get('text_payment_description');
		$data['text_confirm_description'] = $this->language->get('text_confirm_description');
		
		$data['text_analytics'] = $this->language->get('text_analytics');
		$data['text_analytics_intro'] = $this->language->get('text_analytics_intro');	
		
		//Plugins
		$data['text_plugins'] = $this->language->get('text_plugins');
		
		//Tooltips
		$data['general_enable_tooltip'] = $this->language->get('general_enable_tooltip');
		$data['general_version_tooltip'] = $this->language->get('general_version_tooltip');
		$data['general_debug_tooltip'] = $this->language->get('general_debug_tooltip');
		$data['general_default_tooltip'] = $this->language->get('general_default_tooltip');
		$data['step_login_option_tooltip'] = $this->language->get('step_login_option_tooltip');
		$data['general_main_checkout_tooltip'] = $this->language->get('general_main_checkout_tooltip');
		$data['general_min_order_tooltip'] = $this->language->get('general_min_order_tooltip');
		$data['general_min_quantity_tooltip'] = $this->language->get('general_min_quantity_tooltip');
		$data['general_default_email_tooltip'] = $this->language->get('general_default_email_tooltip');
		$data['general_settings_tooltip'] = $this->language->get('general_settings_tooltip');
		$data['position_module_tooltip'] = $this->language->get('position_module_tooltip');
		
		$data['shipping_address_enable_tooltip'] = $this->language->get('shipping_address_enable_tooltip');
		
		$data['shipping_method_display_tooltip'] = $this->language->get('shipping_method_display_tooltip');
		$data['shipping_method_display_options_tooltip'] = $this->language->get('shipping_method_display_options_tooltip');
		$data['shipping_method_display_title_tooltip'] = $this->language->get('shipping_method_display_title_tooltip');
		$data['shipping_method_input_style_tooltip'] = $this->language->get('shipping_method_input_style_tooltip');
		$data['shipping_method_default_option_tooltip'] = $this->language->get('shipping_method_default_option_tooltip');
		
		$data['payment_method_display_tooltip'] = $this->language->get('payment_method_display_tooltip');
		$data['payment_method_display_options_tooltip'] = $this->language->get('payment_method_display_options_tooltip');
		$data['payment_method_display_images_tooltip'] = $this->language->get('payment_method_display_images_tooltip');
		$data['payment_method_input_style_tooltip'] = $this->language->get('payment_method_input_style_tooltip');
		$data['payment_method_default_option_tooltip'] = $this->language->get('payment_method_default_option_tooltip');
		
		$data['cart_display_tooltip'] = $this->language->get('cart_display_tooltip');
		$data['cart_option_coupon_tooltip'] = $this->language->get('cart_option_coupon_tooltip');
		$data['cart_option_voucher_tooltip'] = $this->language->get('cart_option_voucher_tooltip');
		$data['cart_option_reward_tooltip'] = $this->language->get('cart_option_reward_tooltip');
		
		$data['general_theme_tooltip'] = $this->language->get('general_theme_tooltip');
		$data['general_block_style_tooltip'] = $this->language->get('general_block_style_tooltip');
		$data['general_login_style_tooltip'] = $this->language->get('general_login_style_tooltip');
		$data['general_uniform_tooltip'] = $this->language->get('general_uniform_tooltip');
		$data['general_only_quickcheckout_tooltip'] = $this->language->get('general_only_quickcheckout_tooltip');
		$data['general_cart_image_size_tooltip'] = $this->language->get('general_cart_image_size_tooltip');
		$data['general_max_width_tooltip'] = $this->language->get('general_max_width_tooltip');
		$data['general_column_tooltip'] = $this->language->get('general_column_tooltip');
		$data['general_custom_style_tooltip'] = $this->language->get('general_custom_style_tooltip');
		$data['general_trigger_tooltip'] = $this->language->get('general_trigger_tooltip');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_save_and_stay'] = $this->language->get('button_save_and_stay');
		
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['button_remove'] = $this->language->get('button_remove');
		
		$data['tab_module'] = $this->language->get('tab_module');
		$data['action'] = $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'] . '&store_id='.$store_id, 'SSL');
		$data['module_link'] = $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');


		if (!file_exists(DIR_CATALOG.'../vqmod/xml/vqmod_extra_positions.xml')) {
       		$data['positions_needed'] = $this->language->get('positions_needed');
        }

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if(!$this->check_shopunity()){
			$data['error_warning'] =  $this->language->get('error_shopunity_required');
		}


  		$data['breadcrumbs'] = array();
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title_main'),
			'href'      => $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		

		$data['quickcheckout'] = array();
		
		if (isset($this->request->post['quickcheckout'])) {
			$data['quickcheckout'] = $this->request->post['quickcheckout'];

		} elseif ($this->model_setting_setting->getSetting('quickcheckout', $store_id)) { 
			$settings = $this->model_setting_setting->getSetting('quickcheckout', $store_id);
			$data['quickcheckout'] =  $settings['quickcheckout']; 
		}

		$data['quickcheckout_modules'] = array();
		if (isset($this->request->post['quickcheckout_module'])) {
			$data['quickcheckout_modules'] = $this->request->post['quickcheckout_module'];

		} elseif ($this->model_setting_setting->getSetting('quickcheckout', $store_id)) { 
			$modules = $this->model_setting_setting->getSetting('quickcheckout', $store_id);

			if(!empty($modules['quickcheckout_module'])){
				$data['quickcheckout_modules'] = $modules['quickcheckout_module'];	
			}else{
				$data['quickcheckout_modules'] = array();	
			}
		}	
		
		//These are default settings (located in system/config/quickcheckout_settings.php)
		$settings = $this->config->get('quickcheckout_settings');
		if(empty($settings)){
			$this->config->load('quickcheckout_settings');
			$settings = $this->config->get('quickcheckout_settings');
		}

		//System settings
		$settings['general']['default_email'] = $this->config->get('config_email');
		$settings['step']['payment_address']['fields']['agree']['information_id'] = $this->config->get('config_account_id');
		$settings['step']['payment_address']['fields']['agree']['error'][0]['information_id'] = $this->config->get('config_account_id');
		$settings['step']['confirm']['fields']['agree']['information_id'] = $this->config->get('config_checkout_id');
		$settings['step']['confirm']['fields']['agree']['error'][0]['information_id'] = $this->config->get('config_checkout_id');


		if(!empty($data['quickcheckout'])){
			$data['quickcheckout'] = $this->array_merge_recursive_distinct($settings, $data['quickcheckout']);
		}else{
			$data['quickcheckout'] = $settings;
		}

		$data['quickcheckout']['general']['store_id'] = $store_id;
		
		$lang = $this->language_merge($data['quickcheckout']['step']['payment_address']['fields'], $this->texts);
		$data['quickcheckout']['step']['payment_address']['fields'] = $this->array_merge_recursive_distinct($data['quickcheckout']['step']['payment_address']['fields'], $lang);
		
		$lang = $this->language_merge($data['quickcheckout']['step']['shipping_address']['fields'], $this->texts);
		$data['quickcheckout']['step']['shipping_address']['fields'] = $this->array_merge_recursive_distinct($data['quickcheckout']['step']['shipping_address']['fields'], $lang);
		
		$lang = $this->language_merge($data['quickcheckout']['step']['confirm']['fields'], $this->texts);
		$data['quickcheckout']['step']['confirm']['fields'] = $this->array_merge_recursive_distinct($data['quickcheckout']['step']['confirm']['fields'], $lang);
		
		//Get Shipping methods
		$this->load->model('setting/extension');
		$shipping_methods = glob(DIR_APPLICATION . 'controller/shipping/*.php');
		$data['shipping_methods'] = array();
		foreach ($shipping_methods as $shipping){
			$shipping = basename($shipping, '.php');
			$this->load->language('shipping/' . $shipping);
			$data['shipping_methods'][] = array(
				'code' => $shipping,
				'title' => $this->language->get('heading_title')
			);
		}

		//Get Payment methods
		$this->load->model('setting/extension');
		$payment_methods = glob(DIR_APPLICATION . 'controller/payment/*.php');
		$data['payment_methods'] = array();
		foreach ($payment_methods as $payment){
			$payment = basename($payment, '.php');
			$this->load->language('payment/' . $payment);
			$data['payment_methods'][] = array(
				'code' => $payment,
				'title' => $this->language->get('heading_title')
			);
		}
		
		//Get designes
		$dir    = DIR_CATALOG.'/view/theme/default/stylesheet/quickcheckout/theme';
		$files = scandir($dir);
		$data['themes'] = array();
		foreach($files as $file){
			if(strlen($file) > 6){
				$data['themes'][] = substr($file, 0, -4);
			}
		}
		
		//Get stores
		$this->load->model('setting/store');
		$results = $this->model_setting_store->getStores();
		if($results){
			$data['stores'][] = array('store_id' => 0, 'name' => $this->config->get('config_name'));
			foreach ($results as $result) {
				$data['stores'][] = array(
					'store_id' => $result['store_id'],
					'name' => $result['name']	
				);
			}	
		}
		
		//Social login
		$data['social_login'] = array();
		if($this->check_d_social_login()){
			$this->load->language('module/d_social_login');
			
			$this->config->load($this->check_d_social_login());
			$social_login_settings = $this->config->get('d_social_login_settings');

			if(!isset($data['quickcheckout']['general']['social_login'])){
				$data['quickcheckout']['general']['social_login'] = array();
			}

			$data['quickcheckout']['general']['social_login'] = $this->array_merge_recursive_distinct($social_login_settings, $data['quickcheckout']['general']['social_login']);

			$sort_order = array(); 
			foreach ($data['quickcheckout']['general']['social_login']['providers'] as $key => $value) {
				if(isset($value['sort_order'])){
	      			$sort_order[$key] = $value['sort_order'];
				}else{
					unset($providers[$key]);
				}
	    	}
			array_multisort($sort_order, SORT_ASC, $data['quickcheckout']['general']['social_login']['providers']);
			
			foreach($data['quickcheckout']['general']['social_login']['providers'] as $provoder){
				if(isset($provoder['id'])){
					$data['text_'.$provoder['id']] = $this->language->get('text_'.$provoder['id']);
				}
			}
		}
		
		$this->load->model('design/layout');
		
		$data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$this->template = 'module/quickcheckout.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}


	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/quickcheckout')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}

	public function check_d_social_login(){
		$result = false;
			if($this->isInstalled('d_social_login')){
				$full = DIR_SYSTEM . "config/d_social_login_settings.php";
				$light = DIR_SYSTEM . "config/d_social_login_light_settings.php"; 
				if (file_exists($full)) { 
					$result = 'd_social_login_settings';
				} elseif (file_exists($light)) {
					$result =  'd_social_login_light_settings';
				}
			}
		return $result;
	}
	
	
	public function install() {
		  $this->load->model('setting/setting');
		  $from = str_replace("admin", "vqmod/xml", DIR_APPLICATION) . "a_vqmod_quickcheckout.xml_"; 
		  $to = str_replace("admin", "vqmod/xml", DIR_APPLICATION) . "a_vqmod_quickcheckout.xml";
		  if (file_exists($from)) rename($from, $to);
		  $this->version_check(1);
		  
	}
		 
	public function uninstall() {
		  $this->load->model('setting/setting');
		  $from = str_replace("admin", "vqmod/xml", DIR_APPLICATION) . "a_vqmod_quickcheckout.xml"; 
		  $to = str_replace("admin", "vqmod/xml", DIR_APPLICATION) . "a_vqmod_quickcheckout.xml_";
		  if (file_exists($from)) rename($from, $to);
		  $this->version_check(0);
		  
	}
	
	public function language_merge($array, $texts){
		$this->load->model('catalog/information');
		$array_full = $array; 
		$result = array();
		foreach ($array as $key => $value){
			foreach ($texts as $text){
				if(isset($array_full[$text])){
					if(!is_array($array_full[$text])){
						$result[$text] = $this->language->get($array_full[$text]);	
					}else{
						if(isset($array_full[$text][(int)$this->config->get('config_language_id')])){
							$result[$text] = $array_full[$text][(int)$this->config->get('config_language_id')];
						}else{
							$result[$text] = current($array_full[$text]);
						}
					}
					if((strpos($result[$text], '%s') !== false) && isset($array_full['information_id'])){
						$information_info = $this->model_catalog_information->getInformation($array_full['information_id']);
						$result[$text] = sprintf($result[$text], $information_info['title']);	
					}
				}						
			}
			if(is_array($array_full[$key])){	
						$result[$key] = $this->language_merge($array_full[$key], $texts);	
			}
			
		}

		return $result;
		
	}
	
	public function array_merge_recursive_distinct( array &$array1, array &$array2 )
	{
	  $merged = $array1;	
	  foreach ( $array2 as $key => &$value )
		  {
			if ( is_array ( $value ) && isset ( $merged [$key] ) && is_array ( $merged [$key] ) )
			{
			  $merged [$key] = $this->array_merge_recursive_distinct ( $merged [$key], $value );
			}
			else
			{
			  $merged [$key] = $value;
			}
		  }
		
	  return $merged;
	}

	public function check_shopunity(){
		$file1 = DIR_APPLICATION . "mbooth/xml/mbooth_shopunity_admin.xml"; 
		$file2 = DIR_APPLICATION . "mbooth/xml/mbooth_shopunity_admin_patch.xml"; 
		if (file_exists($file1) || file_exists($file2)) { 
			return true;
		} else {
			return false;
		}

	}

	public function get_version(){
		$xml = file_get_contents(DIR_APPLICATION . 'mbooth/xml/' . $this->mbooth);

		$mbooth = new SimpleXMLElement($xml);

		return $mbooth->version ;
	}

	public function version_check($status = 1){
		$json = array();
		$this->load->language('module/quickcheckout');
		$this->mboot_script_dir = substr_replace(DIR_SYSTEM, '/admin/mbooth/xml/', -8);
		$str = file_get_contents($this->mboot_script_dir . 'mbooth_quickcheckout.xml');
		$xml = new SimpleXMLElement($str);
	
		$current_version = $xml->version ;
      
		if (isset($this->request->get['mbooth'])) { 
			$mbooth = $this->request->get['mbooth']; 
		} else { 
			$mbooth = 'mbooth_quickcheckout.xml'; 
		}

		$customer_url = HTTP_SERVER;
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "language` WHERE language_id = " . (int)$this->config->get('config_language_id') ); 
		$language_code = $query->row['code'];
		$ip = $this->request->server['REMOTE_ADDR'];

		$check_version_url = 'http://opencart.dreamvention.com/update/index.php?mbooth=' . $mbooth . '&store_url=' . $customer_url . '&module_version=' . $current_version . '&language_code=' . $language_code . '&opencart_version=' . VERSION . '&ip='.$ip . '&status=' .$status;
		
		$curl = curl_init();
		curl_setopt($curl, CURLOPT_URL, $check_version_url);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		$return_data = curl_exec($curl);
		$return_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
		curl_close($curl);

      if ($return_code == 200) {
         $data = simplexml_load_string($return_data);
	
         if ((string) $data->version == (string) $current_version || (string) $data->version <= (string) $current_version) {
			 
           $json['success']   = $this->language->get('text_no_update') ;

         } elseif ((string) $data->version > (string) $current_version) {
			 
			$json['attention']   = $this->language->get('text_new_update');
				
			foreach($data->updates->update as $update){

				if((string) $update->attributes()->version > (string)$current_version){
					$version = (string)$update->attributes()->version;
					$json['update'][$version] = (string) $update[0];
				}
			}
         } else {
			 
            $json['error']   = $this->language->get('text_error_update');
         }
      } else { 
         $json['error']   =  $this->language->get('text_error_failed');

      }

      if (file_exists(DIR_SYSTEM.'library/json.php')) { 
         $this->load->library('json');
         $this->response->setOutput(Json::encode($json));
      } else {
         $this->response->setOutput(json_encode($json));
      }
   }

   public function isInstalled($code) {
		$extension_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `code` = '" . $this->db->escape($code) . "'");
		
		if($query->row) {
			return true;
		}else{
			return false;
		}	
	}
}
?>