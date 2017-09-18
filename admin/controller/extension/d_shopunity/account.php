<?php
/*
 *	location: admin/controller
 */

class ControllerExtensionDShopunityAccount extends Controller {
	private $codename = 'd_shopunity';
	private $route = 'extension/d_shopunity/account';
	private $extension = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->load->model('extension/d_shopunity/mbooth');
		$this->load->model('extension/d_shopunity/account');

		$this->extension = $this->model_extension_d_shopunity_mbooth->getExtension($this->codename);
	}

	public function index(){
		//nothing
	}

	public function login(){

   		if($this->model_extension_d_shopunity_account->isLogged()){
			$this->response->redirect($this->url->link('extension/d_shopunity/extension', 'token=' . $this->session->data['token'], 'SSL'));
		}

		//documentation http://t4t5.github.io/sweetalert/
		$this->document->addStyle('view/javascript/d_shopunity/library/sweetalert/sweetalert.css');
		$this->document->addScript('view/javascript/d_shopunity/library/sweetalert/sweetalert.min.js');

		$this->document->addStyle('view/stylesheet/shopunity/bootstrap.css');
		$this->document->addStyle('view/stylesheet/d_shopunity/d_shopunity.css');
        $this->document->addStyle('view/stylesheet/d_shopunity/d_shopunity_layout.css');
		$this->document->addScript('view/javascript/d_shopunity/d_shopunity.js');
		
		$this->load->language('extension/module/d_shopunity');
   		$this->load->language('extension/d_shopunity/account');
   		$this->load->model('user/user');


   		// Breadcrumbs
		$data['breadcrumbs'] = array(); 
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL')
			);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
			);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link($this->route.'/login', 'token=' . $this->session->data['token'], 'SSL')
			);

        if (!extension_loaded('curl')) {
            $data['error'] = $this->language->get('error_curl');
        }

        if (!extension_loaded('zlib')) {
            $data['error'] = $this->language->get('error_zlib');
        }

        if (!extension_loaded('zip')) {
            $data['error'] = $this->language->get('error_zip');
        }

		// Notification
		if(!empty($this->session->data['success'])){
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}
		if(!empty($this->session->data['error'])){
			$data['error'] = $this->session->data['error'];
			unset($this->session->data['error']);
		}
		

   		$this->document->setTitle($this->language->get('heading_title'));
   		$data['heading_title'] = $this->language->get('heading_title');
   		$data['version'] = $this->model_extension_d_shopunity_mbooth->getVersion($this->codename);
		$data['text_edit'] = $this->language->get('text_edit');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$this->load->model('extension/d_shopunity/extension');

		$data['extensions'] = false;
		if(!$this->config->get('welcome_extensions_visited')){
		$filter_data = array(
			'codename'=> array(
				'd_visual_designer',
				'd_blog_module',
				'd_quickcheckout_lite',
				'd_seo_module'
			)
		);
		$data['extensions'] = $this->model_extension_d_shopunity_extension->getExtensions($filter_data);
		
			$this->session->data['welcome_extensions'] = $filter_data;
			$this->load->model('setting/setting');
			$this->model_setting_setting->editSetting('welcome_extensions', array('welcome_extensions_visited' => '1'));
		}

		$data['action_connect'] = $this->model_extension_d_shopunity_account->getAuthorizeUrl('extension/d_shopunity/account/callback');
		if(VERSION >= '2.3.0.0'){	
			$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
		}else{
			$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		}
		
		$user = $this->model_user_user->getUser($this->user->getId());
		$data['store_info'] = array(
			'name' => $this->config->get('config_name'),
			'description' => $this->config->get('config_meta_description'),
			'version' => VERSION,
			'url' => HTTP_CATALOG,
			'ssl_url' => HTTPS_CATALOG,
			'dir' => DIR_CATALOG,
			'server_ip' => $this->request->server['SERVER_ADDR'],
			'db_driver' => DB_DRIVER,
			'db_host' => DB_HOSTNAME,
			'db_user' => DB_USERNAME,
			'db_password' => DB_USERNAME,
			'db_name' => DB_DATABASE,
			'db_prefix' => DB_PREFIX,
			'connected' => 1,
			'admin_url' => HTTPS_SERVER,
			'admin_user' => $user['username'],
			'admin_email' => $user['email'],
		);
		$data['button_connect'] = $this->language->get('button_connect');

   		$data['header'] = $this->load->controller('common/header');
   		$data['column_left'] = $this->load->controller('common/column_left');
   		$data['footer'] = $this->load->controller('common/footer');

   		$this->response->setOutput($this->load->view($this->route.'_login.tpl', $data));
   	}

   	public function callback(){

		$json = $this->model_extension_d_shopunity_account->getToken('extension/d_shopunity/account/callback');
	
		if ($json) {
			if(isset($json['access_token'])){
				$this->model_extension_d_shopunity_account->login($json);
				$this->response->redirect($this->url->link('extension/d_shopunity/extension', 'token=' . $this->session->data['token'], 'SSL'));
	
			}else{
				$this->session->data['error']   = $this->language->get('error_connection_failed');
			}
			
		}else{
			$this->session->data['error']   = $this->language->get('error_not_json');
		}
			
		$this->response->redirect($this->url->link('extension/d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function profile(){
		$this->document->addStyle('view/stylesheet/d_shopunity/d_shopunity.css');
		$data['account'] = $this->model_extension_d_shopunity_account->getAccount();

		$data['add_money'] = 'https://shopunity.net/index.php?route=billing/transaction';

		return $this->load->view('extension/d_shopunity/account_profile.tpl', $data);
	}

	public function logout(){
		$this->model_extension_d_shopunity_account->logout();
		$this->response->redirect($this->url->link('extension/d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
	}
}