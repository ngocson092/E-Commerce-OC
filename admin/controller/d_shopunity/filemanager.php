<?php
/*
 *	location: admin/controller
 */

class ControllerDShopunityFilemanager extends Controller {

	private $codename = 'd_shopunity';
	private $route = 'd_shopunity/filemanager';
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

		if(!isset($this->request->get['codename'])){
			$this->session->data['error'] = $this->language->get('error_extension_not_found');
			$this->response->redirect($this->url->link('d_shopunity/extension', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->document->addStyle('view/javascript/d_shopunity/library/codemirror/lib/codemirror.css');
		$this->document->addScript('view/javascript/d_shopunity/library/codemirror/lib/codemirror.js');
		$this->document->addScript('view/javascript/d_shopunity/library/codemirror/mode/javascript/javascript.js');


		$codename = $this->request->get['codename'];
		$data = $this->model_d_shopunity_mbooth->getExtension($codename);
		$path = '/';
		if(isset($this->request->get['path'])){
			$path = $this->request->get['path'];
		}

		$folders = explode('/', ltrim( $path , '/' ));
		foreach($folders as $folder){
			$data['path'][] = array(
				'name' => $folder);
		}

		$data['file_content'] = false;
		$data['file_type'] = 'dir';
		$file = substr_replace(DIR_SYSTEM, '/', -8) . '/' . ltrim( $path , '/' );
		if(file_exists($file)){
			$data['file_content'] = file_get_contents($file, true);
			$data['file_type'] = filetype($file);
		}

		$data['path_up'] = false;
		$data['paths'] = array();
		if($path !== '/'){
			$path_up = explode('/', ltrim( $path , '/' ));
			$last_path = array_pop($path_up);
			$data['path_up'] = $this->url->link('d_shopunity/filemanager', 'token='.$this->session->data['token'] . '&codename='.$this->request->get['codename'].'&path=/'.implode('/', $path_up), 'SSL');
			
			$build_path = '';
			foreach($path_up as $folder){

				$build_path .= '/'.$folder;
				$data['paths'][] = array(
					'name' => $folder,
					'url' => $this->url->link('d_shopunity/filemanager', 'token='.$this->session->data['token'] . '&codename='.$this->request->get['codename'].'&path='.$build_path, 'SSL')
				);
			}

			$data['paths'][] = array(
				'name' => $last_path,
				'url' => false
			);
		}
		

   		$this->load->model('d_shopunity/mbooth');

		$data['home'] = $this->url->link('d_shopunity/filemanager', 'token='.$this->session->data['token'] . '&codename='.$this->request->get['codename'], 'SSL');

		$data['files'] = $this->createFileStructure($data['files'], $path);

		$data['profile'] = $this->load->controller('d_shopunity/account/profile');
   		$data['content_top'] = $this->load->controller('module/d_shopunity/content_top');
   		$data['content_bottom'] = $this->load->controller('module/d_shopunity/content_bottom');

   		$this->response->setOutput($this->load->view($this->route.'.tpl', $data));
	}

	private function createFileStructure($files, $path = '/'){
		$result = array();
		$path = ltrim( $path , '/' );
		foreach($files as $file){
			
			if($path){
				if (strpos($file, $path) !== 0) {
					continue;
				}
			}

			$file = preg_replace('/'.preg_quote($path, '/').'/', "", $file, 1);
			$folders = explode('/', ltrim( $file , '/' ));

			if($folders[0]){

				$type = @filetype( substr_replace(DIR_SYSTEM, '/', -8) . '/' . ltrim( $path , '/' ) .'/'.$folders[0]);
				
				$result[$folders[0]] = array(
					'name' => $folders[0],
					'type' => $type,
					'url' => $this->url->link('d_shopunity/filemanager', 'token='.$this->session->data['token'] . '&codename='.$this->request->get['codename'].'&path='.$path.'/'.$folders[0], 'SSL')
				);
			}
		
		}

		sort($result);

		return $result;
	}



	// public function item(){
		

 //   		//is logged in
	// 	if(!$this->model_d_shopunity_account->isLogged()){
	// 		$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
	// 	}
	// 	//extension id provided
	// 	if(!isset($this->request->get['extension_id'])){
	// 		$this->session->data['error'] = $this->language->get('error_extension_not_found');
	// 		$this->response->redirect($this->url->link('d_shopunity/extension', 'token=' . $this->session->data['token'], 'SSL'));
	// 	}

	// 	$extension_id = $this->request->get['extension_id'];

	// 	$this->load->model('d_shopunity/store');
 //   		$this->load->model('d_shopunity/extension');

 //   		$this->load->language('module/d_shopunity');
 //   		$this->load->language('d_shopunity/extension');


	// 	$data['extension'] = $this->model_d_shopunity_extension->getExtension($extension_id);

	// 	if(isset($data['extension']['developer'])){
	// 		$data['developer'] = $this->load->controller('d_shopunity/developer/profile', $data['extension']['developer']);
	// 	}else{
	// 		$data['developer'] = '';
	// 	}
		
	// 	//$extension_recurring_price_id = (isset($data['extension']['price'])) ? $data['extension']['price']['extension_recurring_price_id'] : 0;

	// 	$data['purchase'] = $this->url->link('d_shopunity/extension/purchase', 'token=' . $this->session->data['token'] . '&extension_id=' . $extension_id , 'SSL');
	// 	$data['install'] = $this->url->link('d_shopunity/extension/install', 'token=' . $this->session->data['token']  . '&extension_id=' . $extension_id , 'SSL');

 //   		$data['content_top'] = $this->load->controller('module/d_shopunity/content_top');
 //   		$data['content_bottom'] = $this->load->controller('module/d_shopunity/content_bottom');

 //   		$this->response->setOutput($this->load->view($this->route.'_item.tpl', $data));
	// }

	// public function edit(){

	// 	if(!$this->model_d_shopunity_account->isLogged()){
	// 		$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
	// 	}

	// 	if($this->request->get['codename']){
	// 		$codename = $this->request->get['codename'];
	// 	}else{
	// 		$this->session->data['error'] = 'Codename missing. Can not get Dependencies!';
	// 		$this->response->redirect($this->url->link('d_shopunity/extension', 'token=' . $this->session->data['token'], 'SSL'));
	// 	}

 //   		$this->load->model('d_shopunity/extension');

	// 	$required = $this->model_d_shopunity_mbooth->getDependencies($codename);
	// 	$filter_data['codename'] = array();
	// 	foreach($required as $require){
	// 		$filter_data['codename'][$require['codename']] = $require['codename'];
	// 	}

	// 	$data['extensions'] = $this->model_d_shopunity_extension->getExtensions($filter_data);

	// 	foreach($data['extensions'] as $extension){
	// 		unset($filter_data['codename'][$extension['codename']]);
	// 	}

	// 	$data['unregistered_extensions'] = array();
	// 	foreach($filter_data['codename'] as $filter_codename){
	// 		$data['unregistered_extensions'][] = array(
	// 			'codename' => $filter_codename,
	// 			'name' => $filter_codename
	// 			);
	// 	}

	// 	$data['profile'] = $this->load->controller('d_shopunity/account/profile');
 //   		$data['content_top'] = $this->load->controller('module/d_shopunity/content_top');
 //   		$data['content_bottom'] = $this->load->controller('module/d_shopunity/content_bottom');
 //   		$data = $this->_productThumb($data);
 //   		$this->response->setOutput($this->load->view($this->route.'_dependency.tpl', $data));
	// }

}