<?php 

class ControllerExtensionDQuickcheckoutPaymentAddress extends Controller {
   
    public function index($config){

        $this->load->model('account/address');
        $this->load->model('extension/d_quickcheckout/method');
        $this->load->model('extension/d_quickcheckout/address');
        $this->load->model('extension/module/d_quickcheckout');
        $this->model_extension_module_d_quickcheckout->logWrite('Controller:: payment_address/index');

        if(!$config['general']['compress']){
            $this->document->addScript('catalog/view/javascript/d_quickcheckout/model/payment_address.js');
            $this->document->addScript('catalog/view/javascript/d_quickcheckout/view/payment_address.js');
        }

        $data['text_address_existing'] = $this->language->get('text_address_existing');
        $data['text_address_new'] = $this->language->get('text_address_new');

        $data['col'] = $config['account']['guest']['payment_address']['column'];
        $data['row'] = $config['account']['guest']['payment_address']['row'];

        $json['account'] = $this->session->data['account'];
        $json['payment_address'] = $this->session->data['payment_address'];
        $json['shipping_required'] = $this->model_extension_d_quickcheckout_method->shippingRequired();
        
        //logged
        if($this->customer->isLogged()){

            $json['addresses'] = $this->model_extension_d_quickcheckout_address->getAddresses();

            if (!empty($this->session->data['payment_address']['address_id'])) {
                $json['payment_address']['address_id'] = $this->session->data['payment_address']['address_id'];
            } else {
                $json['payment_address']['address_id'] = $this->customer->getAddressId();
            }
        }

        $data['json'] = json_encode($json);

        // if(VERSION >= '2.2.0.0'){
        //     $template = 'd_quickcheckout/payment_address';
        // }elseif (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/d_quickcheckout/payment_address.tpl')) {
        //     $template = $this->config->get('config_template') . '/template/d_quickcheckout/payment_address.tpl';
        // } else {
        //     $template = 'default/template/d_quickcheckout/payment_address.tpl';
        // }
        
        $this->load->model('extension/d_opencart_patch/load');
        return $this->model_extension_d_opencart_patch_load->view('d_quickcheckout/payment_address', $data);
	}

    public function update(){       
        $this->load->model('extension/module/d_quickcheckout');
        $this->load->model('extension/d_quickcheckout/address');
        $this->load->model('extension/d_quickcheckout/method');
        $this->load->model('extension/d_quickcheckout/order');
        $this->load->model('extension/d_quickcheckout/custom_field');
        $json = array();

        //payment address
        $json = $this->prepare($json);
        //shipping address
        $json = $this->load->controller('extension/d_quickcheckout/shipping_address/prepare', $json);

        //tax
        $this->model_extension_d_quickcheckout_address->updateTaxAddress();

        //shipping methods
        $json = $this->load->controller('extension/d_quickcheckout/shipping_method/prepare', $json);

        //payment method - for xshipping (optimization needed)
        $json = $this->load->controller('extension/d_quickcheckout/payment_method/prepare', $json);

        //totals
        $json = $this->load->controller('extension/d_quickcheckout/cart/prepare', $json);
        $totals = array();
        $taxes = $this->cart->getTaxes();
        $total = 0;

        $total_data = array(
            'totals' => &$totals,
            'taxes'  => &$taxes,
            'total'  => &$total
        );

        $json['totals'] = $this->session->data['totals'] = $this->model_extension_d_quickcheckout_order->getTotals($total_data);
        $json['total'] = $this->model_extension_d_quickcheckout_order->getCartTotal($total);
        
        //order
        $json['order_id'] = $this->session->data['order_id'] = $this->load->controller('extension/d_quickcheckout/confirm/updateOrder');

        //payment
        $json = $this->load->controller('extension/d_quickcheckout/payment/prepare', $json);

        //statistic
        $statistic = array(
            'update' => array(
                'payment_address' => 1
            )
        );
        $this->model_extension_module_d_quickcheckout->updateStatistic($statistic);
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function prepare($json){
        $this->load->model('account/address');
        $this->load->model('extension/d_quickcheckout/address');
        $this->load->model('extension/d_quickcheckout/custom_field');

        //post

        if(isset($this->request->post['payment_address'])){

            //fix &amp;
            foreach ($this->request->post['payment_address'] as $key => $value) {
                if(is_array($this->request->post['payment_address'][$key])){
                    foreach ($this->request->post['payment_address'][$key] as $custom_field_type => $custom_field_data) {
                        if(is_array($custom_field_data)){
                            foreach ($custom_field_data as $custom_field_id => $custom_field_value) {
                                if(!is_array($custom_field_value)){
                                    $this->request->post['payment_address'][$key][$custom_field_type][$custom_field_id] = htmlspecialchars_decode($custom_field_value);

                                } else {
                                    foreach ($custom_field_value as $cfv_key => $cfv_value) {
                                        $this->request->post['payment_address'][$key][$custom_field_type][$custom_field_id][$cfv_key] = htmlspecialchars_decode($cfv_value);
                                    }
                                }
                            }
                        }
                    }
                } else {
                    $this->request->post['payment_address'][$key] = htmlspecialchars_decode($value);
                }
            }

            if(isset($this->session->data['payment_address']['customer_group_id']) && isset($this->request->post['payment_address']['customer_group_id'])){
                if($this->session->data['payment_address']['customer_group_id'] != $this->request->post['payment_address']['customer_group_id']){
                    $json['payment_address_refresh'] = true;
                    $json['shipping_address_refresh'] = true;
                }
            }
            if(isset($this->session->data['payment_address']['country_id']) && isset($this->request->post['payment_address']['country_id'])){
                if($this->session->data['payment_address']['country_id'] != $this->request->post['payment_address']['country_id']){
                    $json['payment_address_refresh'] = true;
                    $json['shipping_address_refresh'] = true;
                }
            }
            if(isset($this->session->data['payment_address']['city_id']) && isset($this->request->post['payment_address']['city_id'])){
                if($this->session->data['payment_address']['city_id'] != $this->request->post['payment_address']['city_id']){
                    $json['payment_address_refresh'] = true;
                    $json['shipping_address_refresh'] = true;
                }
            }

            //update address data if contry_id or zone_id changed
            $this->request->post['payment_address'] = $this->model_extension_d_quickcheckout_address->compareAddress($this->request->post['payment_address'], $this->session->data['payment_address']);
           

            //if logged in and address_id set and is not empty - fetch address by address_id
            if($this->customer->isLogged()){
                if(!empty($this->request->post['payment_address']['address_id'])
                    && $this->request->post['payment_address']['address_id'] !== 'new' 
                    && $this->request->post['payment_address']['address_id'] !== $this->session->data['payment_address']['address_id'] 
                    ){
                    
                    $this->request->post['payment_address'] = $this->model_extension_d_quickcheckout_address->getAddress($this->request->post['payment_address']['address_id']);
                }
            }
            if(isset($this->request->post['payment_address']['customer_group_id'])){

                $this->request->post['payment_address']['custom_field'] = ((!empty($this->request->post['payment_address']['custom_field']['account'])) ? array('account' => $this->request->post['payment_address']['custom_field']['account']) : $this->model_extension_d_quickcheckout_custom_field->setCustomFieldsDefaultSessionData('account',$this->request->post['payment_address']['customer_group_id'])) + ((!empty($this->request->post['payment_address']['custom_field']['address'])) ? array('address' => $this->request->post['payment_address']['custom_field']['address']) : $this->model_extension_d_quickcheckout_custom_field->setCustomFieldsDefaultSessionData('address', $this->request->post['payment_address']['customer_group_id']));
            }
                    
          //   print_r(  $this->session->data['payment_address'] );
            if((isset($this->request->post['payment_address']['custom_field']) && is_array($this->request->post['payment_address']['custom_field']))){
                
                $this->request->post['payment_address'] = array_merge($this->request->post['payment_address'], $this->model_extension_d_quickcheckout_custom_field->setCustomFieldValue($this->request->post['payment_address']['custom_field']));
            }
            //merge post into session
            $this->session->data['payment_address'] = array_merge($this->session->data['payment_address'], $this->request->post['payment_address']);
                  
        }
        
        $this->model_extension_d_quickcheckout_custom_field->updateCustomFieldsConfigData('payment_address');

        //session
        if($this->customer->isLogged()){
            if(empty($this->session->data['payment_address']['address_id'])){
                if($this->model_account_address->getAddresses()){
                    $this->session->data['payment_address']['address_id'] = $this->customer->getAddressId();
                    $this->session->data['payment_address'] = current($this->model_extension_d_quickcheckout_address->getAddresses());
                }else{
                    $this->session->data['payment_address']['country_id'] =  $this->config->get('config_country_id');
                    $this->session->data['payment_address']['zone_id'] = $this->config->get('config_zone_id');
                }
            }

            if(!isset($this->session->data['payment_address']['shipping_address'])){
                $this->session->data['payment_address']['shipping_address'] = 0;
            }
            if(empty($this->session->data['payment_address']['address_id'])){
                $this->session->data['payment_address']['address_id'] = 'new';
            }else if($this->session->data['payment_address']['address_id'] !== 'new'){
               $this->session->data['payment_address']['shipping_address'] = 0; 
            }


        }else{

            $this->session->data['guest'] = array(
                'customer_group_id' => (!empty($this->request->post['payment_address']['customer_group_id'])) ? $this->request->post['payment_address']['customer_group_id'] : $this->session->data['guest']['customer_group_id'],
                'firstname' => (!empty($this->request->post['payment_address']['firstname'])) ? $this->request->post['payment_address']['firstname'] : $this->session->data['guest']['firstname'],
                'lastname' => (!empty($this->request->post['payment_address']['lastname'])) ? $this->request->post['payment_address']['lastname'] : $this->session->data['guest']['lastname'],
                'email' => (!empty($this->request->post['payment_address']['email'])) ? $this->request->post['payment_address']['email'] : $this->session->data['guest']['email'],
                'telephone' => (!empty($this->request->post['payment_address']['telephone'])) ? $this->request->post['payment_address']['telephone'] : $this->session->data['guest']['telephone'],
                'fax' => (!empty($this->request->post['payment_address']['fax'])) ? $this->request->post['payment_address']['fax'] : $this->session->data['guest']['fax'],
                'custom_field' => (!empty($this->request->post['payment_address']['custom_field'])) ? $this->request->post['payment_address']['custom_field'] :  array('account' => array()),
                'shipping_address' => (!empty($this->request->post['payment_address']['shipping_address'])) ? $this->request->post['payment_address']['shipping_address'] : $this->session->data['guest']['shipping_address'],
            );
        
        }


        $json['payment_address'] = $this->session->data['payment_address'];


        return $json;

    }

}