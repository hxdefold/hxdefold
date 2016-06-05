package defold.support;

import haxe.extern.EitherType;
import defold.Vector3;
import defold.Vector4;
import defold.Quaternion;
import defold.Hash;
import defold.Url;

typedef GoProperty = EitherType<Float,EitherType<Hash,EitherType<Url,EitherType<Vector3,EitherType<Vector4,EitherType<Quaternion,Bool>>>>>>
