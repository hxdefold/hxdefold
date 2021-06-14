package defold;

/**
    Functions and constants for interacting with Apple's In-app purchases
    and Google's In-app billing.
**/
@:native("_G.iap")
extern class Iap {
    /**
        Perform a product purchase.

        Calling `Iap.finish` is required on a successful transaction if `auto_finish_transactions` is disabled in project settings.

        @param id product to buy
        @param options table of optional parameters as properties.
    **/
    static function buy(id:String, ?options:IapBuyOptions):Void;

    /**
        Purchase a premium license.

        Performs a purchase of a premium game license. The purchase transaction
        is handled like regular iap purchases; calling the currently se iap_listener with the
        transaction results.

        This function does not work when testing the application locally in the Gameroom client.
    **/
    static function buy_premium():Void;

    /**
        Finish buying product.

        Explicitly finish a product transaction.

        Calling `Iap.finish` is required on a successful transaction
        if `auto_finish_transactions` is disabled in project settings. Calling this function
        with `auto_finish_transactions` set will be ignored and a warning is printed.
        The `transaction.state` field must equal `IapTransactionState.TRANS_STATE_PURCHASED`.

        @param transaction transaction table parameter as supplied in listener callback
    **/
    static function finish(transaction:IapTransaction):Void;

    /**
        Get current provider id.

        @return provider id.
    **/
    static function get_provider_id():IapProviderId;

    /**
        Check if user has already purchased premium license.

        Checks if a license for the game has been purchased by the user.
        You should provide a callback function that will be called with the result of the check.

        This function does not work when testing the application locally in the Gameroom client.

        @param callbackresult callback
    **/
    static function has_premium<T>(callback:(self:T, has_premium:Bool)->Void):Void;

    /**
        List in-app products.

        Nested calls, that is calling `Iap.list` from within the callback is not supported.
        Doing so will result in call being ignored with the engine reporting "Unexpected callback set".

        @param ids table to get information about
        @param callback result callback
    **/
    static function list<T>(ids:lua.Table<Int,String>, callback:(self:T, products:lua.Table<String,IapProduct>, error:Null<IapError>)->Void):Void;

    /**
        Restore products (non-consumable).

        @return `true` if current store supports handling restored transactions, otherwise `false`.
    **/
    static function restore():Bool;

    /**
        Set purchase transaction listener.

        The listener callback has the following signature: function(self, transaction, error) where transaction is a table
        describing the transaction and error is a table. The error parameter is nil on success.

        @param listener listener function
    **/
    static function set_listener<T>(listener:(self:T, transaction:IapTransaction, error:Null<IapError>)->Void):Void;
}

/**
    Options for the `Iap.buy` method.
**/
typedef IapBuyOptions = {
    /**
        Optional custom unique request id to set for this transaction.
        The id becomes attached to the payment within the Graph API.

        Facebook only.
    **/
    @:optional var request_id:String;
}

/**
    Transaction object used `Iap` methods.
**/
extern class IapTransaction {
    /**
        The product identifier.
    **/
    var ident:String;

    /**
        Transaction state.
    **/
    var state:IapTransactionState;

    /**
        The date and time for the transaction.
    **/
    var date:String;

    /**
        The transaction identifier.

        This field is only set when state is TRANS_STATE_RESTORED, TRANS_STATE_UNVERIFIED or TRANS_STATE_PURCHASED.
    **/
    @:optional var trans_ident:String;

    /**
        The transaction receipt.

        This field is only set when state is TRANS_STATE_PURCHASED or TRANS_STATE_UNVERIFIED.
    **/
    @:optional var receipt:String;

    /**
        Apple only. The original transaction.

        This field is only set when state is TRANS_STATE_RESTORED.
    **/
    @:optional var original_trans:IapTransaction;

    /**
        Google Play only. A string containing the signature of the purchase data that was signed with the private key of the developer.
    **/
    @:optional var signature:String;

    /**
        Facebook only. This field is set to the optional custom unique request id
        request_id if set in the `Iap.buy` call parameters.
    **/
    @:optional var request_id:String;

    /**
        Facebook Gameroom only. The purchase token.
    **/
    @:optional var purchase_token:String;

    /**
        Facebook Gameroom only. The currency used for the purchase.
    **/
    @:optional var currency:String;

    /**
        Facebook Gameroom only. The amount the player will be charged for a single unit of this product.
    **/
    @:optional var amount:Int;

    /**
        Facebook Gameroom only. The quantity of this item the user is purchasing.
    **/
    @:optional var quantity:Int;

    /**
        Amazon Pay only. The user ID.
    **/
    @:optional var user_id:String;

    /**
        Amazon Pay only. If true, the SDK is running in Sandbox mode. This only allows interactions with the Amazon AppTester. Use this mode only for testing locally.
    **/
    @:optional var is_sandbox_mode:Bool;

    /**
        Amazon Pay only. The cancel date for the purchase. This field is only set if the purchase is canceled.
    **/
    @:optional var cancel_date:String;

    /**
        Amazon Pay only. Is set to true if the receipt was canceled or has expired; otherwise false.
    **/
    @:optional var canceled:Bool;
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

    /**
        Provider id for Facebook Gameroom.
    **/
    var PROVIDER_ID_GAMEROOM;
}

/**
    IAP product information returned by `Iap.list`.
**/
typedef IapProduct = {
    /**
        The product identifier.
    **/
    var ident:String;

    /**
        The product title.
    **/
    var title:String;

    /**
        The product description.
    **/
    var description:String;

    /**
        The price of the product.
    **/
    var price:Float;

    /**
        The price of the product, as a formatted string (amount and currency symbol).
    **/
    var price_string:String;

    /**
        The currency code. On Google Play, this reflects the merchant's locale, instead of the user's.
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
