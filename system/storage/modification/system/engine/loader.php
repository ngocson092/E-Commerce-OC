<?php
final class Loader {
	private $registry;

	public function __construct($registry) {
		$this->registry = $registry;
	}

	public function controller($route, $data = array()) {

        //d_opencart_patch.xml 1
        if(strpos($route, 'module/') === 0){
            if(file_exists(DIR_APPLICATION . 'controller/extension/' . $route . '.php')){
                $route = 'extension/'.$route;
            }
        }
        if(strpos($route, 'total/') === 0){
            if(file_exists(DIR_APPLICATION . 'controller/extension/' . $route . '.php')){
                $route = 'extension/'.$route;
            }
        }
        if(strpos($route, 'analytics/') === 0){
            if(file_exists(DIR_APPLICATION . 'controller/extension/' . $route . '.php')){
                $route = 'extension/'.$route;
            }
        }
        if(strpos($route, 'fraud/') === 0){
            preg_match("/(\/)/", $route, $match);
            $test_route = (count($match) > 1) ? preg_replace("/(\/)[a-z0-9_\-]+$/", "", $route) : $route;
            if(file_exists(DIR_APPLICATION . 'controller/extension/' . $test_route . '.php')){
                $route = 'extension/'.$route;
            }
        }
        if(strpos($route, 'payment/') === 0){
            preg_match("/(\/)/", $route, $match);
            $test_route = (count($match) > 1) ? preg_replace("/(\/)[a-z0-9_\-]+$/", "", $route) : $route;
            if(file_exists(DIR_APPLICATION . 'controller/extension/' . $test_route . '.php')){
                $route = 'extension/'.$route;
            }
        }
        if(strpos($route, 'captcha/') === 0){
            preg_match("/(\/)/", $route, $match);
            $test_route = (count($match) > 1) ? preg_replace("/(\/)[a-z0-9_\-]+$/", "", $route) : $route;
            if(file_exists(DIR_APPLICATION . 'controller/extension/' . $test_route . '.php')){
                $route = 'extension/'.$route;
            }
        }
            
		// $this->event->trigger('pre.controller.' . $route, $data);

		$parts = explode('/', str_replace('../', '', (string)$route));

		// Break apart the route
		while ($parts) {
			$file = DIR_APPLICATION . 'controller/' . implode('/', $parts) . '.php';
			$class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', implode('/', $parts));

			if (is_file($file)) {
				include_once(modification($file));

				break;
			} else {
				$method = array_pop($parts);
			}
		}


        //d_opencart_patch.xml 2
        if(!is_file($file)){
            return false;
        }
            

        //d_opencart_patch.xml 2
        if(!is_file($file)){
            return false;
        }
            
		$controller = new $class($this->registry);

		if (!isset($method)) {
			$method = 'index';
		}

		// Stop any magical methods being called
		if (substr($method, 0, 2) == '__') {
			return false;
		}

		$output = '';

		if (is_callable(array($controller, $method))) {
			$output = call_user_func(array($controller, $method), $data);
		}

		// $this->event->trigger('post.controller.' . $route, $output);

		return $output;
	}

	public function model($model, $data = array()) {
		// $this->event->trigger('pre.model.' . str_replace('/', '.', (string)$model), $data);

		$model = str_replace('../', '', (string)$model);

		$file = DIR_APPLICATION . 'model/' . $model . '.php';
		$class = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model);

		if (file_exists($file)) {
			include_once(modification($file));

			$this->registry->set('model_' . str_replace('/', '_', $model), new $class($this->registry));
		} else {
			trigger_error('Error: Could not load model ' . $file . '!');
			exit();
		}

		// $this->event->trigger('post.model.' . str_replace('/', '.', (string)$model), $output);
	}

	public function view($template, $data = array()) {
		// $this->event->trigger('pre.view.' . str_replace('/', '.', $template), $data);


            //d_twig_manager.xml 1
            $output = $this->controller('event/d_twig_manager/support', array('route' => $template, 'data' => $data));
            if($output){
                return $output;
            }
            
		$file = DIR_TEMPLATE . $template;

		if (file_exists($file)) {
			extract($data);

			ob_start();

			require(modification($file));

			$output = ob_get_contents();

			ob_end_clean();
		} else {
			trigger_error('Error: Could not load template ' . $file . '!');
			exit();
		}

		// $this->event->trigger('post.view.' . str_replace('/', '.', $template), $output);

		return $output;
	}

	public function helper($helper) {
		$file = DIR_SYSTEM . 'helper/' . str_replace('../', '', (string)$helper) . '.php';

		if (file_exists($file)) {
			include_once(modification($file));
		} else {
			trigger_error('Error: Could not load helper ' . $file . '!');
			exit();
		}
	}

	public function config($config) {
		$this->registry->get('config')->load($config);
	}

	public function language($language) {
		return $this->registry->get('language')->load($language);
	}
}
