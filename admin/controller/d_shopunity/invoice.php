<?php
/*
 *	location: admin/controller
 */

class ControllerDShopunityInvoice extends Controller {

	private $codename = 'd_shopunity';
	private $route = 'd_shopunity/invoice';
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

		$data['text_invoice_status_0'] =  $this->language->get('text_invoice_status_0');
		$data['text_invoice_status_1'] =  $this->language->get('text_invoice_status_1');
		$data['text_invoice_status_2'] =  $this->language->get('text_invoice_status_2');
		$data['text_invoice_status_3'] =  $this->language->get('text_invoice_status_3');
		$data['text_invoice_status_4'] =  $this->language->get('text_invoice_status_4');
		
		$data['href_order'] =  $this->url->link('d_shopunity/order', 'token=' . $this->session->data['token'], 'SSL');
		$data['href_invoice'] = $this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL');
		$data['href_transaction'] = $this->url->link('d_shopunity/transaction', 'token=' . $this->session->data['token'], 'SSL');

		$filter_data = array();
		$data['page'] = 1;
		if(isset($this->request->get['page'])){
			$filter_data['page'] = $this->request->get['page'];
			$data['page'] = $this->request->get['page'];
		}

		$data['profile'] = $this->load->controller('d_shopunity/account/profile');
		$data['invoices'] = $this->model_d_shopunity_billing->getInvoices($filter_data);
	
		$data['prev'] = $this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'].'&page='.($data['page']-1), 'SSL');
		$data['next'] = $this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'].'&page='.($data['page']+1), 'SSL');

   		$data['content_top'] = $this->load->controller('module/d_shopunity/content_top');
   		$data['content_bottom'] = $this->load->controller('module/d_shopunity/content_bottom');

   		$this->response->setOutput($this->load->view($this->route.'.tpl', $data));
	}

	public function item(){

		if(!$this->model_d_shopunity_account->isLogged()){
			$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if(!isset($this->request->get['invoice_id'])){

			$this->session->data['error'] = 'Order_id missing!';
			$this->response->redirect($this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL'));

		}

		$invoice_id = $this->request->get['invoice_id'];

		$this->load->language('d_shopunity/billing');
   		$this->load->model('d_shopunity/billing');

   		$data['tab_order'] =  $this->language->get('tab_order');
		$data['tab_invoice'] =  $this->language->get('tab_invoice');
		$data['tab_transaction'] =  $this->language->get('tab_transaction');
		
		$data['href_order'] =  $this->url->link('d_shopunity/order', 'token=' . $this->session->data['token'], 'SSL');
		$data['href_invoice'] = $this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL');
		$data['href_transaction'] = $this->url->link('d_shopunity/transaction', 'token=' . $this->session->data['token'], 'SSL');

		$data['invoice'] = $this->model_d_shopunity_billing->getInvoice($invoice_id);
		$data['profile'] = $this->load->controller('d_shopunity/account/profile');

   		$data['content_top'] = $this->load->controller('module/d_shopunity/content_top');
   		$data['content_bottom'] = $this->load->controller('module/d_shopunity/content_bottom');

   		$this->response->setOutput($this->load->view($this->route.'_item.tpl', $data));
	}

	public function create(){

		if(!$this->model_d_shopunity_account->isLogged()){
			$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->load->model('d_shopunity/billing');
   		$result = $this->model_d_shopunity_billing->addInvoice();

		if(!empty($result['error'])){
			$this->session->data['error'] = $result['error'];
		}elseif(!empty($result['success'])){
			$this->session->data['success'] = $result['success'];
		}

		$this->response->redirect($this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function pay(){

		if(!$this->model_d_shopunity_account->isLogged()){
			$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if(!isset($this->request->get['invoice_id'])){

			$this->session->data['error'] = 'order_id missing!';
			$this->response->redirect($this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL'));

		}

		$invoice_id = $this->request->get['invoice_id'];

   		$this->load->model('d_shopunity/billing');

   		$invoice = $this->model_d_shopunity_billing->payInvoice($invoice_id);

   		if(!empty($invoice['error'])){
			$this->session->data['error'] = $invoice['error'];
		}elseif(!empty($invoice['success'])){
			$this->session->data['success'] = $invoice['success'];
		}

		$this->response->redirect($this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL'));

	}

	public function refund(){

		if(!$this->model_d_shopunity_account->isLogged()){
			$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if(!isset($this->request->get['invoice_id'])){

			$this->session->data['error'] = 'order_id missing!';
			$this->response->redirect($this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL'));

		}

		$invoice_id = $this->request->get['invoice_id'];

   		$this->load->model('d_shopunity/billing');

   		$invoice = $this->model_d_shopunity_billing->refundInvoice($invoice_id);

   		if(!empty($invoice['error'])){
			$this->session->data['error'] = $invoice['error'];
		}elseif(!empty($invoice['success'])){
			$this->session->data['success'] = $invoice['success'];
		}

		$this->response->redirect($this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL'));

	}

	public function cancel(){

		if(!$this->model_d_shopunity_account->isLogged()){
			$this->response->redirect($this->url->link('d_shopunity/account/login', 'token=' . $this->session->data['token'], 'SSL'));
		}

		if(!isset($this->request->get['invoice_id'])){

			$this->session->data['error'] = 'order_id missing!';
			$this->response->redirect($this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL'));

		}

		$invoice_id = $this->request->get['invoice_id'];

   		$this->load->model('d_shopunity/billing');

   		$invoice = $this->model_d_shopunity_billing->cancelInvoice($invoice_id);

   		if(!empty($invoice['error'])){
			$this->session->data['error'] = $invoice['error'];
		}elseif(!empty($invoice['success'])){
			$this->session->data['success'] = $invoice['success'];
		}

		$this->response->redirect($this->url->link('d_shopunity/invoice', 'token=' . $this->session->data['token'], 'SSL'));

	}


	
}