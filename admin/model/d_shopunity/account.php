<?php
/*
*  location: admin/model
*/
require_once(DIR_APPLICATION.'model/extension/d_shopunity/account.php');
class ModelDShopunityAccount extends ModelExtensionDShopunityAccount
{   
    public function __construct($registry)
    {
        parent::__construct($registry);
    }
}