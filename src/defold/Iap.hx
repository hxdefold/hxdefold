package defold;

/**
    Functions and constants for interacting with Apple's In-app purchases
    and Google's In-app billing.
**/
@:native("_G.iap")
extern class Iap {
    /**
        Perform a product purchase.

        Calling `Iap.finish` is required on a successful transaction if auto_finish_transactions is disabled in project settings.

        @param id product to buy
        @param options table of optional parameters as properties.
    **/
    static function buy(id:String, ?options:IapBuyOptions):Void;

    /**
        Finish buying product.

        Explicitly finish a product transaction.

        Calling `Iap.finish` is required on a successful transaction if auto_finish_transactions is disabled in project settings (otherwise ignored).
        The `transaction.state` field must equal iap.TRANS_STATE_PURCHASED.

        @param transaction transaction table parameter as supplied in listener callback
    **/
    static function finish(transaction:IapTransaction):Void;

    /**
        Get current provider id.

        @return provider id.
    **/
    static function get_provider_id():IapProviderId;

    /**
        List in-app products.

        @param ids table to get information about
        @param callback result callback
    **/
    static function list<T>(ids:lua.Table<Int,String>, callback:T->lua.Table<String,IapProduct>->IapError->Void):IapProviderId;

    /**
        Restore products (non-consumable).

        @return false if current store doesn't support handling restored transactions, otherwise true
    **/
    static function restore():Bool;

    /**
        Set transaction listener.

        The listener callback has the following signature: function(self, transaction, error) where transaction is a table
        describing the transaction and error is a table. The error parameter is nil on success.

        @param listener listener function
    **/
    static function set_listener<T>(listener:T->IapTransaction->Null<IapError>->Void):Void;
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
    @:optional var original_trans:IapTransaction;

    /**
        Transaction identifier.

        Only available when state == TRANS_STATE_PURCHASED, TRANS_STATE_UNVERIFIED or TRANS_STATE_RESTORED.
    **/
    @:optional var trans_ident:String;

    /**
        Transaction request id.

        Only if `receipt` is set and for Facebook IAP transactions when used in the `Iap.buy` call parameters.
    **/
    @:optional var request_id:String;

    /**
        Receipt.

        Only set when state == TRANS_STATE_PURCHASED or TRANS_STATE_UNVERIFIED.
    **/
    @:optional var receipt:String;

    /**
        Only available for Amazon IAP transactions.
    **/
    var user_id:String;
}

/**
    Possible transaction states enumeration (used by `IapTransaction.state` field).
**/
@:native("_G.iap")
@:enum extern abstract IapTransactionState(Int) {
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
    /**
        Iap provider id for Google.
    **/
    var PROVIDER_ID_GOOGLE;

    /**
        Provider id for Amazon.
    **/
    var PROVIDER_ID_AMAZON;

    /**
        Provider id for Apple.
    **/
    var PROVIDER_ID_APPLE;

    /**
        Provider id for Facebook.
    **/
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
