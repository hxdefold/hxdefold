package defold.support;

import haxe.extern.EitherType;
import defold.Hash;
import defold.Url;

typedef HashOrStringOrUrl = EitherType<Hash,EitherType<String,Url>>