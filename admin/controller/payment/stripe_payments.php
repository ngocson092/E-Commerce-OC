<?php 
class ControllerPaymentStripePayments extends Controller {
	private $error = array(); 

	public function index() {
		$this->load->language('payment/stripe_payments');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('stripe_payments', $this->request->post);				

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_test'] = $this->language->get('text_test');
		$data['text_live'] = $this->language->get('text_live');
		$data['text_authorization'] = $this->language->get('text_authorization');
		$data['text_charge'] = $this->language->get('text_charge');		

		$data['entry_public'] = $this->language->get('entry_public');
		$data['entry_key'] = $this->language->get('entry_key');
		$data['entry_public_test'] = $this->language->get('entry_public_test');
		$data['entry_key_test'] = $this->language->get('entry_key_test');
		$data['entry_mode'] = $this->language->get('entry_mode');
		$data['entry_method'] = $this->language->get('entry_method');
		$data['entry_total'] = $this->language->get('entry_total');
		$data['entry_order_status'] = $this->language->get('entry_order_status');		
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['public'])) {
			$data['error_public'] = $this->error['public'];
		} else {
			$data['error_public'] = '';
		}

		if (isset($this->error['key'])) {
			$data['error_key'] = $this->error['key'];
		} else {
			$data['error_key'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('payment/stripe_payments', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$data['action'] = HTTPS_SERVER . 'index.php?route=payment/stripe_payments&token=' . $this->session->data['token'];

		$data['cancel'] = HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token'];

		if (isset($this->request->post['stripe_payments_public_key'])) {
			$data['stripe_payments_public_key'] = $this->request->post['stripe_payments_public_key'];
		} else {
			$data['stripe_payments_public_key'] = $this->config->get('stripe_payments_public_key');
		}
		
		if (isset($this->request->post['stripe_payments_public_key_test'])) {
			$data['stripe_payments_public_key_test'] = $this->request->post['stripe_payments_public_key_test'];
		} else {
			$data['stripe_payments_public_key_test'] = $this->config->get('stripe_payments_public_key_test');
		}

		if (isset($this->request->post['stripe_payments_private_key'])) {
			$data['stripe_payments_private_key'] = $this->request->post['stripe_payments_private_key'];
		} else {
			$data['stripe_payments_private_key'] = $this->config->get('stripe_payments_private_key');
		}
		
		if (isset($this->request->post['stripe_payments_private_key_test'])) {
			$data['stripe_payments_private_key_test'] = $this->request->post['stripe_payments_private_key_test'];
		} else {
			$data['stripe_payments_private_key_test'] = $this->config->get('stripe_payments_private_key_test');
		}

		if (isset($this->request->post['stripe_payments_mode'])) {
			$data['stripe_payments_mode'] = $this->request->post['stripe_payments_mode'];
		} else {
			$data['stripe_payments_mode'] = $this->config->get('stripe_payments_mode');
		}

		if (isset($this->request->post['stripe_payments_method'])) {
			$data['stripe_payments_method'] = $this->request->post['stripe_payments_method'];
		} else {
			$data['stripe_payments_method'] = $this->config->get('stripe_payments_method');
		}

		if (isset($this->request->post['stripe_payments_order_status_id'])) {
			$data['stripe_payments_order_status_id'] = $this->request->post['stripe_payments_order_status_id'];
		} else {
			$data['stripe_payments_order_status_id'] = $this->config->get('stripe_payments_order_status_id'); 
		} 

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		if (isset($this->request->post['stripe_payments_geo_zone_id'])) {
			$data['stripe_payments_geo_zone_id'] = $this->request->post['stripe_payments_geo_zone_id'];
		} else {
			$data['stripe_payments_geo_zone_id'] = $this->config->get('stripe_payments_geo_zone_id'); 
		} 

		$this->load->model('localisation/geo_zone');

		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		if (isset($this->request->post['stripe_payments_status'])) {
			$data['stripe_payments_status'] = $this->request->post['stripe_payments_status'];
		} else {
			$data['stripe_payments_status'] = $this->config->get('stripe_payments_status');
		}

		if (isset($this->request->post['stripe_payments_total'])) {
			$data['stripe_payments_total'] = $this->request->post['stripe_payments_total'];
		} else {
			$data['stripe_payments_total'] = $this->config->get('stripe_payments_total');
		}

		if (isset($this->request->post['stripe_payments_sort_order'])) {
			$data['stripe_payments_sort_order'] = $this->request->post['stripe_payments_sort_order'];
		} else {
			$data['stripe_payments_sort_order'] = $this->config->get('stripe_payments_sort_order');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('payment/stripe_payments.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'payment/stripe_payments')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['stripe_payments_public_key']) {
			$this->error['public'] = $this->language->get('error_public');
		}

		if (!$this->request->post['stripe_payments_private_key']) {
			$this->error['key'] = $this->language->get('error_key');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
