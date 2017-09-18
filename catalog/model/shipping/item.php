<?php
class ModelShippingItem extends Model {
	function getQuote($address) {
		$this->load->language('shipping/item');

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('item_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");

		if (!$this->config->get('item_geo_zone_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}

		$method_data = array();

		if ($status) {
			$items = 0;

			foreach ($this->cart->getProducts() as $product) {
				if ($product['shipping']) {
					$items += $product['quantity'];
				}
			}

			$quote_data = array();

            $text = $this->currency->format($this->tax->calculate($this->config->get('item_cost') * $items, $this->config->get('item_tax_class_id'), $this->config->get('config_tax')));
            $cost = $this->config->get('item_cost') * $items;

            if($this->config->get('item_enable_cost_by_product')){
                $cost = 0;
                foreach ($this->cart->getProducts() as $product) {
                   $cost += $product['shipping_cost'] * $product['quantity'];
                }
                $text = $this->currency->format($cost, $this->config->get('item_tax_class_id'), $this->config->get('config_tax'));
            }

			$quote_data['item'] = array(
				'code'         => 'item.item',
				'title'        => $this->language->get('text_description'),
				'cost'         => $cost,
				'tax_class_id' => $this->config->get('item_tax_class_id'),
				'text'         => $text
			);

			$method_data = array(
				'code'       => 'item',
				'title'      => $this->language->get('text_title'),
				'quote'      => $quote_data,
				'sort_order' => $this->config->get('item_sort_order'),
				'error'      => false
			);
		}

		return $method_data;
	}
}