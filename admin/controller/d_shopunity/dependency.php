<?php
/*
 *	location: admin/controller
 */

class ControllerDShopunityDependency extends Controller {

	private $codename = 'd_shopunity';
	private $route = 'd_shopunity/dependency';
	private $extension = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->load->model('d_shopunity/mbooth');
		$this->load->model('d_shopunity/account');
		$this->load->model('d_shopunity/extension');

		$this->extension = $this->model_d_shopunity_mbooth->getExtension($this->codename);

	}

	public function index(){

		if(!$this->model_d_shopunity_account->isLogged()){
			$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if($this->request->get['codename']){
			$codename = $this->request->get['codename'];
		}else{
			$this->session->data['error'] = 'Codename missing. Can not get Dependencies!';
			$this->response->redirect($this->url->link('d_shopunity/extension', 'token=' . $this->session->data['token'], 'SSL'));
		}


   		$this->load->language('d_shopunity/extension');
   		$this->load->model('d_shopunity/extension');

   		$data['text_tester_status_1'] = $this->language->get('text_tester_status_1');
   		$data['text_tester_status_2'] = $this->language->get('text_tester_status_2');
   		$data['text_tester_status_3'] = $this->language->get('text_tester_status_3');
   		$data['text_tester_status_4'] = $this->language->get('text_tester_status_4');
   		$data['text_tester_status_5'] = $this->language->get('text_tester_status_5');
   		$data['text_tester_status_6'] = $this->language->get('text_tester_status_6');

		$required = $this->model_d_shopunity_mbooth->getDependencies($codename);
		$filter_data['codename'] = array();
		foreach($required as $require){
			$filter_data['codename'][$require['codename']] = $require['codename'];
		}

		$data['extensions'] = $this->model_d_shopunity_extension->getExtensions($filter_data);

		foreach($data['extensions'] as $extension){
			unset($filter_data['codename'][$extension['codename']]);
		}

		$data['unregistered_extensions'] = array();
		foreach($filter_data['codename'] as $filter_codename){
			$data['unregistered_extensions'][] = array(
				'codename' => $filter_codename,
				'name' => $filter_codename
				);
		}

		$data['profile'] = $this->load->controller('d_shopunity/account/profile');

   		$data['content_top'] = $this->load->controller('module/d_shopunity/content_top');
   		$data['content_bottom'] = $this->load->controller('module/d_shopunity/content_bottom');

   		$this->response->setOutput($this->load->view($this->route.'.tpl', $data));
	}
}