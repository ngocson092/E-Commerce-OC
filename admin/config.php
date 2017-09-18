<?php

// HTTP
define('HTTP_SERVER', 'http://' . $_SERVER['HTTP_HOST'] .rtrim(dirname($_SERVER['PHP_SELF']), '/.\\').'/');
define('HTTP_CATALOG', 'http://' . $_SERVER['HTTP_HOST']  .'/');
define('HTTP_IMAGE', 'http://' . $_SERVER['HTTP_HOST']  .'/image/');

// HTTPS
define('HTTPS_SERVER', 'http://' . $_SERVER['HTTP_HOST'] .rtrim(dirname($_SERVER['PHP_SELF']), '/.\\').'/');
define('HTTPS_CATALOG', 'http://' . $_SERVER['HTTP_HOST']  .'/');
define('HTTPS_IMAGE', 'http://' . $_SERVER['HTTP_HOST']  .'/image/');

// DIR
define('DIR_APPLICATION', realpath(dirname(__FILE__)) .'/');
define('DIR_SYSTEM', realpath(dirname(__FILE__)) .'/../system/');
define('DIR_DATABASE', realpath(dirname(__FILE__)) .'/../system/database/');
define('DIR_LANGUAGE', realpath(dirname(__FILE__)) .'/../admin/language/');
define('DIR_TEMPLATE', realpath(dirname(__FILE__)) .'/../admin/view/template/');
define('DIR_CONFIG', realpath(dirname(__FILE__)) .'/../system/config/');
define('DIR_IMAGE', realpath(dirname(__FILE__)) .'/../image/');
define('DIR_CACHE', realpath(dirname(__FILE__)) .'/../system/cache/');
define('DIR_DOWNLOAD', realpath(dirname(__FILE__)) .'/../download/');
define('DIR_LOGS', realpath(dirname(__FILE__)) .'/../system/logs/');
define('DIR_CATALOG', realpath(dirname(__FILE__)) .'/../catalog/');
define('DIR_MODIFICATION', realpath(dirname(__FILE__)) .'/../system/storage/modification/');

if (file_exists('../database/cfg.php')) {
    require_once('../database/cfg.php');
}

