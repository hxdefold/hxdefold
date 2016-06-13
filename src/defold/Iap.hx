package defold;

/**
    Functions for interacting with Apple's In-app purchases and Google's In-app billing.
**/
@:native("_G.iap")
extern class Iap {
    /**
        Buy product.
    **/
    static function buy(id:String, ?options:IapBuyOptions):Void;

    /**
        Finish buying product.
    **/
    static function finish(transaction:IapTransaction):Void;

    /**
        Get current provider id.
    **/
    static function get_provider_id():IapProviderId;

    /**
        List in-app products.
    **/
    static function list<T>(ids:lua.Table<Int,String>, callback:T->lua.Table<String,IapProduct>->IapError->Void):IapProviderId;

    /**
        Restore products (non-consumable).
    **/
    static function restore():Bool;

    /**
        Set transaction listener.

        The listener callback has the following signature: function(self, transaction, error).
        The error parameter is nil on success.
    **/
    static function set_listener<T>(listener:T->IapTransaction->IapError->Void):Void;
}

/**
    Options for the `Iap.buy` method.
**/
typedef IapBuyOptions = {
    /**
        Custom unique request id.

        Optional argument only available for Facebook IAP transactions.
    **/
    @:optional var request_id:String;
}

/**
    Transaction object used `Iap` methods.
**/
extern class IapTransaction {
    /**
        Product identifier.
    **/
    var ident:String;

    /**
        Transaction state.
    **/
    var state:IapTransactionState;

    /**
        Transaction date.
    **/
    var date:String;

    /**
        Original transaction.

        Only set when state == TRANS_STATE_RESTORED.
    **/
    var original_trans:IapTransaction;

    /**
        Transaction identifier.

        Only available when state == TRANS_STATE_PURCHASED, TRANS_STATE_UNVERIFIED or TRANS_STATE_RESTORED.
    **/
    var trans_ident:String;

    /**
        Transaction request id.

        Only if `receipt` is set and for Facebook IAP transactions when used in the `Iap.buy` call parameters.
    **/
    var request_id:String;

    /**
        Receipt.

        Only available when state == TRANS_STATE_PURCHASED or TRANS_STATE_UNVERIFIED.
    **/
    var receipt:String;

    /**
        Only available for Amazon IAP transactions.
    **/
    var user_id:String;
}

/**
    Possible transaction states enumeration (used by `IapTransaction.state` field).
**/
@:native("_G.iap")
@:enum extern abstract IapTransactionState({}) {
    /**
        Transaction failed.
    **/
    var TRANS_STATE_FAILED;

    /**
        Transaction purchased.
    **/
    var TRANS_STATE_PURCHASED;

    /**
        Transaction purchasing.

        Intermediate mode followed by `TRANS_STATE_PURCHASED`.
        Store provider support dependent.
    **/
    var TRANS_STATE_PURCHASING;

    /**
        Transaction restored.

        Only available on store providers supporting restoring purchases.
    **/
    var TRANS_STATE_RESTORED;

    /**
        Transaction unverified state, requires verification of purchase.
    **/
    var TRANS_STATE_UNVERIFIED;
}

/**
    Possible provider ids returned by `Iap.get_provider_id`.
**/
@:native("_G.iap")
@:enum extern abstract IapProviderId({}) {
    var PROVIDER_ID_GOOGLE;
    var PROVIDER_ID_AMAZON;
    var PROVIDER_ID_APPLE;
    var PROVIDER_ID_FACEBOOK;
}

/**
    IAP product information returned by `Iap.list`.
**/
typedef IapProduct = {
    /**
        Product id.
    **/
    var ident:String;
    var title:String;
    var description:String;
    var price:Float;
    var price_string:String;

    /**
        Only available on iOS.
    **/
    var currency_code:String;
}

/**
    Error type returned by `Iap` function callbacks.
**/
extern class IapError {
    var error:String;
    var reason:IapErrorReason;
}

/**
    Error reasons returned by `Iap` function callbacks.
**/
@:native("_G.iap")
@:enum extern abstract IapErrorReason({}) {
    /**
        Unspecified error.
    **/
    var REASON_UNSPECIFIED;

    /**
        User canceled.
    **/
    var REASON_USER_CANCELED;
}
