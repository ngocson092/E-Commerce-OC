<?php
class Action {
	private $file;
	private $class;
	private $method;
	private $args = array();

	public function __construct($route, $args = array()) {

        //d_opencart_patch.xml action
        $parts = explode('/', preg_replace('/[^a-zA-Z0-9_\/]/', '', (string)$route));
        $this->method = 'index';
        while ($parts) {
            $path = implode('/', $parts);
            $file = DIR_APPLICATION . 'controller/' . $path . '.php';
            if (is_file($file)) {
                $this->file = $file;
                $this->class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $path);
                break;
            } else {
                $this->method = array_pop($parts);
            }
        }
        if ($args) {
            $this->args = $args;
        }
        return;
        //the following code will be ignored.
            
		$parts = explode('/', str_replace('../', '', (string)$route));

		// Break apart the route
		while ($parts) {
			$file = DIR_APPLICATION . 'controller/' . implode('/', $parts) . '.php';

			if (is_file($file)) {
				$this->file = $file;

				$this->class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', implode('/', $parts));
				break;
			} else {
				$this->method = array_pop($parts);
			}
		}

		if (!$this->method) {
			$this->method = 'index';
		}

		$this->args = $args;
	}

	public function execute($registry) {
		// Stop any magical methods being called
		if (substr($this->method, 0, 2) == '__') {
			return false;
		}

		if (is_file($this->file)) {
			include_once(modification($this->file));

			$class = $this->class;

			$controller = new $class($registry);

			if (is_callable(array($controller, $this->method))) {
				return call_user_func(array($controller, $this->method), $this->args);
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
}
