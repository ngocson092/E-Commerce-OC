<?php
/*
 *	location: admin/controller
 */

class ControllerDShopunityOrder extends Controller {
	
	private $codename = 'd_shopunity';
	private $route = 'd_shopunity/order';
	private $extension = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->load->model('d_shopunity/mbooth');
		$this->load->model('d_shopunity/account');

		$this->extension = $this->model_d_shopunity_mbooth->getExtension($this->codename);
	}

	public function index(){
		if(!$this->model_d_shopunity_account->isLogged()){
			$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->load->language('d_shopunity/billing');
   		$this->load->model('d_shopunity/billing');
		
		$data['tab_order'] =  $this->language->get('tab_order');
		$data['tab_invoice'] =  $this->language->get('tab_invoice');
		$data['tab_transaction'] =  $this->language->get('tab_transaction');
		
		$data['href_order'] =  $this->url->link('d_shopunity/order', 'token=' . $this->session->data['token'], 'SSL');
		$data['href_invoice'] = $this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL');
		$data['href_transaction'] = $this->url->link('d_shopunity/transaction', 'token=' . $this->session->data['token'], 'SSL');

		$filter_data = array();
		$data['page'] = 1;
		if(isset($this->request->get['page'])){
			$filter_data['page'] = $this->request->get['page'];
			$data['page'] = $this->request->get['page'];
		}

		$data['orders'] = $this->model_d_shopunity_billing->getOrders($filter_data);
		$data['profile'] = $this->load->controller('d_shopunity/account/profile');
		$data['orders_overdue'] = $this->model_d_shopunity_billing->getOrdersOverdue();
		$data['create_invoice'] = $this->url->link('d_shopunity/invoice/create', 'token=' . $this->session->data['token'], 'SSL');

		$data['prev'] = $this->url->link('d_shopunity/order', 'token=' . $this->session->data['token'].'&page='.($data['page']-1), 'SSL');
		$data['next'] = $this->url->link('d_shopunity/order', 'token=' . $this->session->data['token'].'&page='.($data['page']+1), 'SSL');

   		$data['content_top'] = $this->load->controller('module/d_shopunity/content_top');
   		$data['content_bottom'] = $this->load->controller('module/d_shopunity/content_bottom');

   		$this->response->setOutput($this->load->view($this->route.'.tpl', $data));
	}

	public function item(){

		if(!$this->model_d_shopunity_account->isLogged()){
			$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if(!isset($this->request->get['order_id'])){
			$this->session->data['error'] = 'Order_id missing!';
			$this->response->redirect($this->url->link('d_shopunity/account', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$order_id = $this->request->get['order_id'];
		
   		$this->load->language('d_shopunity/billing');
   		$this->load->model('d_shopunity/billing');

   		
		$data['tab_order'] =  $this->language->get('tab_order');
		$data['tab_invoice'] =  $this->language->get('tab_invoice');
		$data['tab_transaction'] =  $this->language->get('tab_transaction');
		
		$data['href_order'] =  $this->url->link('d_shopunity/order', 'token=' . $this->session->data['token'], 'SSL');
		$data['href_invoice'] = $this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL');
		$data['href_transaction'] = $this->url->link('d_shopunity/transaction', 'token=' . $this->session->data['token'], 'SSL');

		$data['tab_history'] =  $this->language->get('tab_history');
		$data['tab_invoice'] =  $this->language->get('tab_invoice');

		$data['order'] = $this->model_d_shopunity_billing->getOrder($order_id);
		$data['extension'] = $data['order']['store_extension'];

		if(isset($data['extension']['developer'])){
			$data['developer'] = $this->load->controller('d_shopunity/developer/profile', $data['extension']['developer']);
		}else{
			$data['developer'] = '';
		}

   		$data['content_top'] = $this->load->controller('module/d_shopunity/content_top');
   		$data['content_bottom'] = $this->load->controller('module/d_shopunity/content_bottom');

   		$this->response->setOutput($this->load->view($this->route.'_item.tpl', $data));
	}
}