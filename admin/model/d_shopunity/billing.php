<?php
/*
*  location: admin/model
*/
require_once(DIR_APPLICATION.'model/extension/d_shopunity/billing.php');
class ModelDShopunityBilling extends ModelExtensionDShopunityBilling
{   
    public function __construct($registry)
    {
        parent::__construct($registry);
    }
}