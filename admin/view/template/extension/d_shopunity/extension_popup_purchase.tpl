<div class="extension-popup" id="extension_<?php echo $extension['extension_id']; ?>">
    <div class="row">
        <div class="col-md-6 text-center">
            <div class="m-b">
                <p>Purchase with voucher</p>
                <i class="fa fa-tag fa-4x"></i>
            </div>
            <a class="btn btn-primary btn-lg m-b claim-external-order" data-href="<?php echo $claim_external_order; ?>">Vaucher</a>
            <p>If you have purchased a license from another market like Opencart, you can claim your voucher to purchase the license here</p>
        </div>
        <div class="col-md-6 text-center">
            <div class="m-b">
                <p>Your current balance</p>
                <span style="font-size: 32px;"><?php echo $account['balance_format']; ?></span>
                <a href="<?php echo $add_money; ?>" target="_blank" class="btn btn-success btn-xs add-to-balance"><i class="fa fa-plus"></i></a>
            </div>
            <div class="purchase-extension  form-inline">
                <?php if(!empty($extension['price'])){ ?>
                     <select class="form-control input-lg pull-left hide">
                        <?php foreach($extension['prices'] as $price){ ?>
                        <option value="<?php echo $price['extension_recurring_price_id']; ?>"><?php echo $price['recurring_price_format']; ?> / <?php echo $price['recurring_duration']; ?> days</option>
                        <?php } ?>
                    </select>
                <?php } ?>
                <a class="btn btn-primary btn-lg m-b" data-extension-id="<?php echo $extension['extension_id'];?>">Credit</a>
            </div>
            <p>You can purchase any extension with Shopunity Credit. Simply visit the shopunity billing and add credit via paypal.</p>
        </div>

    </div>
</div>