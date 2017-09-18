<?php
class ControllerPaymentStripePayments extends Controller {
	public function index() {
		$this->load->language('payment/stripe_payments');

		$data['text_credit_card'] = $this->language->get('text_credit_card');
		$data['text_wait'] = $this->language->get('text_wait');

		$data['entry_cc_owner'] = $this->language->get('entry_cc_owner');
		$data['entry_cc_number'] = $this->language->get('entry_cc_number');
		$data['entry_cc_expire_date'] = $this->language->get('entry_cc_expire_date');
		$data['entry_cc_cvv2'] = $this->language->get('entry_cc_cvv2');

		$data['button_confirm'] = $this->language->get('button_confirm');
		$data['button_back'] = $this->language->get('button_back');
        
        	if ($this->config->get('stripe_payments_mode') == 'live') {
        		$data['stripe_payments_public_key'] = $this->config->get('stripe_payments_public_key');
        	}
        	else {
        		$data['stripe_payments_public_key'] = $this->config->get('stripe_payments_public_key_test');	
        	}
        	
        	$data['config_ssl'] = $this->config->get('config_ssl');

		$data['months'] = array();

		for ($i = 1; $i <= 12; $i++) {
			$data['months'][] = array(
				'text'  => strftime('%B', mktime(0, 0, 0, $i, 1, 2000)), 
				'value' => sprintf('%02d', $i)
			);
		}

		$today = getdate();

		$data['year_expire'] = array();

		for ($i = $today['year']; $i < $today['year'] + 11; $i++) {
			$data['year_expire'][] = array(
				'text'  => strftime('%Y', mktime(0, 0, 0, 1, 1, $i)),
				'value' => strftime('%Y', mktime(0, 0, 0, 1, 1, $i)) 
			);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/stripe_payments.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/stripe_payments.tpl', $data);
		} else {
			return $this->load->view('default/template/payment/stripe_payments.tpl', $data);
		}	
		
	}

	public function confirm() {
		$this->load->model('checkout/order');

		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
        
        $amount = (int)($this->currency->format($order_info['total'], $order_info['currency_code'], 1.00000, false) * 100);
        
        //Load Stripe Library
        require_once('./vendor/stripe/stripe-php/lib/Stripe.php');
        
        if ($this->config->get('stripe_payments_mode') == 'live') {
		$stripe = array(
	          "secret_key"      => $this->config->get('stripe_payments_private_key'),
	          "publishable_key" => $this->config->get('stripe_payments_public_key')
	        );
       	}
        else {
        	$stripe = array(
	          "secret_key"      => $this->config->get('stripe_payments_private_key_test'),
	          "publishable_key" => $this->config->get('stripe_payments_public_key_test')
	        );	
	}
        
        
        Stripe::setApiKey($stripe['secret_key']);
        $token  = $_POST['stripeToken'];
        $error = null;
        try {
            $customer = Stripe_Customer::create(array(
                'email' => $order_info['email'],
                'card'  => $token
            ));
            $charge = Stripe_Charge::create(array(
                'customer' => $customer->id,
                'amount'   => $amount,     //amount in cents only
                'currency' => $order_info['currency_code'],
                'metadata' => array(
                    'order_id'  => $this->session->data['order_id'],
                    'customer'  => $order_info['payment_firstname']. ' ' .$order_info['payment_lastname'],
                    'email'     => $order_info['email'],
                    'phone'     => $order_info['telephone']
                ),
                'description' => 'Order ID# '. $this->session->data['order_id']
            ));
        } catch(Stripe_CardError $e) {
            // Error card processing
            $error = $e->jsonBody['error'];
        }
		//create object to use as json
		$json = array();

		//If successful log transaction in opencart system
		if (!$error) {
			$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('stripe_payments_order_status_id'));

			$json['success'] = $this->url->link('checkout/success', '', 'SSL');
		} else {
			$json['error'] = (string)$error['message'];
            		$json['details'] = $error;
		}

		$this->response->setOutput(json_encode($json));
	}
}
?>
