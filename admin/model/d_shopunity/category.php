<?php
/*
*  location: admin/model
*/
require_once(DIR_APPLICATION.'model/extension/d_shopunity/category.php');
class ModelDShopunityCategory extends ModelExtensionDShopunityCategory
{   
    public function __construct($registry)
    {
        parent::__construct($registry);
    }
}