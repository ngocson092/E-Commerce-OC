<?php 

$query['pavmegamenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavmegamenu' and `key` = 'pavmegamenu_module'";

$query['pavmegamenu'][]  = "DELETE FROM `".DB_PREFIX ."setting` WHERE `code`='pavmegamenu_params' and `key` = 'params'";
$query['pavmegamenu'][] =  " 
INSERT INTO `".DB_PREFIX ."setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES

(0, 0, 'pavmegamenu_params', 'pavmegamenu_params', '[{\"align\":\"aligned-fullwidth\",\"submenu\":1,\"cols\":1,\"group\":0,\"id\":92,\"rows\":[{\"cols\":[{\"widgets\":\"wid-8\",\"colwidth\":12}]}]},{\"submenu\":1,\"id\":86,\"align\":\"aligned-left\",\"cols\":1,\"group\":0,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]},{\"align\":\"aligned-left\",\"submenu\":1,\"cols\":1,\"group\":0,\"id\":99,\"rows\":[{\"cols\":[{\"type\":\"menu\",\"colwidth\":12}]}]}]', 0);

";


$query['pavblog'][] ="
INSERT INTO `".DB_PREFIX ."layout_route` (`layout_route_id`, `layout_id`, `store_id`, `route`) VALUES
(73, 14, 0, 'pavblog/%');
";
$query['pavblog'][] ="
INSERT INTO `".DB_PREFIX ."layout` (`layout_id`, `name`) VALUES
(14, 'Pav Blog');
";
?>

