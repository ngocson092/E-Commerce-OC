<?php
/*
*  location: admin/model
*/
require_once(DIR_APPLICATION.'model/extension/d_shopunity/store.php');
class ModelDShopunityStore extends ModelExtensionDShopunityStore
{   
    public function __construct($registry)
    {
        parent::__construct($registry);
    }
}