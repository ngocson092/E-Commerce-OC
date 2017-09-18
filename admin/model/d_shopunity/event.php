<?php
/*
*  location: admin/model
*/
require_once(DIR_APPLICATION.'model/extension/d_shopunity/event.php');
class ModelDShopunityEvent extends ModelExtensionDShopunityEvent
{   
    public function __construct($registry)
    {
        parent::__construct($registry);
    }
}