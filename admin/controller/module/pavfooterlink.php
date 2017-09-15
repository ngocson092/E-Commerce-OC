<?php
class ControllerModulePavfooterlink extends Controller {

	private $error = array();
	private $data;

	public function index() {

		$this->load->language('module/pavfooterlink');
		$this->load->model('setting/setting');
		$this->load->model('localisation/language');
		$this->load->model('design/layout');
		$this->load->model('extension/module');
		$this->load->model('extension/extension');

		$this->document->setTitle($this->language->get('heading_title'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('pavfooterlink', $this->request->post);
				$this->response->redirect($this->url->link('module/pavfooterlink', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
				$this->response->redirect($this->url->link('module/pavfooterlink', 'token=' . $this->session->data['token'].'&module_id='.$this->request->get['module_id'], 'SSL'));
			}

			$this->session->data['success'] = $this->language->get('text_success');
		}

		$this->_language();
		$this->_alert();
		$this->_breadcrumbs();

		$this->_data();

		$this->data['token'] = $this->session->data['token'];
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');


 		// Render 
		$this->data['header'] = $this->load->controller('common/header');
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('module/pavfooterlink.tpl', $this->data));
	}

	public function _language(){
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['entry_module_name'] = $this->language->get('entry_module_name');
		$this->data['entry_module_class'] = $this->language->get('entry_module_class');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_grouplinks'] = $this->language->get('entry_grouplinks');
		$this->data['entry_footer_title'] = $this->language->get('entry_footer_title');
		
		

		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_enabled'] = $this->language->get('text_enabled');

		// Languages
		$languages = $this->model_localisation_language->getLanguages();
		$this->data['languages'] = $languages;
	}

	public function _alert(){
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
	}

	public function _breadcrumbs(){
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/pavfooterlink', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
	}

	public function _data(){

		$this->data['footer_links'] = array();

		$groupLinks = array(1=>"Information",2=>"Customer Service", 3=>"Extra", 4=>"My Account", 99=>"Customize");

		$this->data['links'] = $groupLinks;		

		$this->data['extensions'] = $this->extensions("pavfooterlink", "&module_id");

		if (isset($this->request->get['module_id'])) {
			$module_id = $this->request->get['module_id']; $url = '&module_id='.$module_id;
		} else {
			$module_id = ''; $url = '';
		}
		$this->data['module_id'] = $module_id;

		$this->data['delete'] = $this->url->link('module/pavfooterlink/ndelete', 'token=' . $this->session->data['token'].$url, 'SSL');
		$this->data['action'] = $this->url->link('module/pavfooterlink', 'token=' . $this->session->data['token'].$url, 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		// GET DATA SETTING
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

		$this->data['footer_links'] = isset($module_info['footer_link'])?$module_info['footer_link']:array();


		$this->data['text_title'] = isset($module_info['text_title'])?$module_info['text_title']:array();

		// NAME
		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$this->data['name'] = $module_info['name'];
		} else {
			$this->data['name'] = '';
		}


		//  Class
		if (isset($this->request->post['class'])) {
			$this->data['class'] = $this->request->post['class'];
		} elseif (!empty($module_info)) {
			$this->data['class'] = isset($module_info['class']) ? $module_info['class'] : '';
		} else {
			$this->data['class'] = '';
		}

		// STATUS
		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$this->data['status'] = $module_info['status'];
		} else {
			$this->data['status'] = 1;
		}

		// groupLinks
		if (isset($this->request->post['groupLinks'])) {
			$this->data['groupLinks'] = $this->request->post['groupLinks'];
		} elseif (!empty($module_info)) {
			$this->data['groupLinks'] = $module_info['groupLinks'];
		} else {
			$this->data['groupLinks'] = 1;
		}
		
	}

	public function ndelete(){
		$this->load->model('extension/module');
		$this->load->language('module/pavfooterlink');
		if (isset($this->request->get['module_id'])) {
			$this->model_extension_module->deleteModule($this->request->get['module_id']);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('module/pavfooterlink', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

	public function extensions($extension, $module_id){
		$module_data = array();
		$this->load->model('extension/extension');
		$this->load->model('extension/module');
		$extensions = $this->model_extension_extension->getInstalled('module');
		$modules = $this->model_extension_module->getModulesByCode($extension);
		foreach ($modules as $module) {
			$module_data[] = array(
				'module_id' => $module['module_id'],
				'name'      => $module['name'],
				'edit'      => $this->url->link('module/pavfooterlink', 'token=' . $this->session->data['token'] . $module_id.'=' . $module['module_id'], 'SSL'),
				'delete'    => $this->url->link('extension/module/delete', 'token=' . $this->session->data['token'] . $module_id.'=' . $module['module_id'], 'SSL')
			);
		}
		$ex[] = array(
			'name'      => $this->language->get("create_module"),
			'module'    => $module_data,
			'edit'      => $this->url->link('module/' . $extension, 'token=' . $this->session->data['token'], 'SSL')
		);
		return $ex;
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/pavfooterlink')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}
?>