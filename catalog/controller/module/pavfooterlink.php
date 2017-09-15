<?php
class ControllerModulePavfooterlink extends Controller {

	private $data;

	public function index($setting) {
		static $module = 0;
		$this->load->language('common/footer');

		$languageID = $this->config->get('config_language_id');

		$default = array(
				'name' => 'Footer Title',
				'status' => 1,
				'groupLinks' => '1',
				'text_title' => 'Footer Column',
				'class'		=> ''
			);
		$setting = array_merge($default, $setting);
	
		$this->data['status'] = $setting['status'];
		$this->data['class'] = $setting['class'];
		
		$links = array();
		$group = $setting['groupLinks'];
		$this->data['group'] = $setting['groupLinks'];

		if ($group == 99) {
			$links = $this->_customlinks($setting['footer_link']);
		} elseif($group == 1) {
			$links = $this->_information();
		} elseif($group == 2) {
			$links = $this->_service();
		} elseif($group == 3) {
			$links = $this->_extra();
		} elseif($group == 4) {
			$links = $this->_account();
		}
		$this->data['text_title'] = isset($setting['text_title'][$languageID])?$setting['text_title'][$languageID]:'Footer Title';
		$this->data['links'] = $links;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavfooterlink.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/pavfooterlink.tpl', $this->data);
		} else {
			return $this->load->view('default/template/module/pavfooterlink.tpl', $this->data);
		}
	}

	public function _customlinks($links){
		$languageID = $this->config->get('config_language_id');
		$data = array();
		//echo "<pre>"; print_r($links); die;
		foreach ($links as $result) {
			$data[] = array(
				'icon' => $result['icon'],
				'title' => $result['title'][$languageID],
				'href' => $result['href'],
			);
		}

		return $data;		
	}

	public function _information(){
		$this->load->model('catalog/information');
		$informations = array();
		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$informations[] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}
		return $informations;
	}

	public function _service(){
		return $data = array(
			1 => array('title'=>$this->language->get('text_contact'), 'href'=>$this->url->link('information/contact')),
			2 => array('title'=>$this->language->get('text_return'), 'href'=>$this->url->link('account/return/add', '', 'SSL')),
			3 => array('title'=>$this->language->get('text_sitemap'), 'href'=>$this->url->link('information/sitemap')),
		);
	}

	public function _extra(){
		return $data = array(
			1 => array('title'=>$this->language->get('text_manufacturer'), 'href'=>$this->url->link('product/manufacturer') ),
			2 => array('title'=>$this->language->get('text_voucher'),      'href'=>$this->url->link('account/voucher', '', 'SSL') ),
			3 => array('title'=>$this->language->get('text_affiliate'),    'href'=>$this->url->link('affiliate/account', '', 'SSL') ),
			4 => array('title'=>$this->language->get('text_special'),      'href'=>$this->url->link('product/special')),
		);
	}

	public function _account(){
		return $data = array(
			1 => array('title'=>$this->language->get('text_account'),    'href'=>$this->url->link('account/account', '', 'SSL') ),
			2 => array('title'=>$this->language->get('text_order'),      'href'=>$this->url->link('account/order', '', 'SSL') ),
			3 => array('title'=>$this->language->get('text_wishlist'),   'href'=>$this->url->link('account/wishlist', '', 'SSL') ),
			4 => array('title'=>$this->language->get('text_newsletter'), 'href'=>$this->url->link('account/newsletter', '', 'SSL') ),
		);
	}
}
?>