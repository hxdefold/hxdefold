package defold;

@:native("_G.iap")
extern class Iap {
    static function buy(id:String, ?options:IapBuyOptions):Void;
    static function finish(transaction:IapTransaction):Void;
    static function get_provider_id():IapProviderId;
    static function list<T>(ids:lua.Table<Int,String>, callback:T->lua.Table<String,IapProduct>->IapError->Void):IapProviderId;
    static function restore():Bool;
    static function set_listener<T>(listener:T->IapTransaction->IapError->Void):Void;
}

typedef IapBuyOptions = {
    @:optional var request_id:String;
}

extern class IapTransaction {
    var ident:String;
    var state:IapTransactionState;
    var date:String;
    var trans_ident:String;
    var request_id:String;
    var receipt:String;
    var user_id:String;
}

@:native("_G.iap")
@:enum extern abstract IapTransactionState({}) {
    var TRANS_STATE_FAILED;
    var TRANS_STATE_PURCHASED;
    var TRANS_STATE_PURCHASING;
    var TRANS_STATE_RESTORED;
    var TRANS_STATE_UNVERIFIED;
}

@:native("_G.iap")
@:enum extern abstract IapProviderId({}) {
    var PROVIDER_ID_GOOGLE;
    var PROVIDER_ID_AMAZON;
    var PROVIDER_ID_APPLE;
    var PROVIDER_ID_FACEBOOK;
}

typedef IapProduct = {
    var ident:String;
    var title:String;
    var description:String;
    var price:Float;
    var price_string:String;
    var currency_code:String;
}

typedef IapError = {
    var error:String;
    var reason:IapErrorReason;
}

@:native("_G.iap")
@:enum extern abstract IapErrorReason({}) {
    var REASON_UNSPECIFIED;
    var REASON_USER_CANCELED;
}
