package defold;

import defold.types.HashOrString;

/**
    Functions for manipulating buffers and streams.
**/
@:native("_G.buffer")
extern class Buffer {
    /**
        Copy all data streams from one buffer to another, element wise.

        Each of the source streams must have a matching stream in the
        destination buffer. The streams must match in both type and size.
        The source and destination buffer can be the same.

        @param dst the destination buffer
        @param dstoffset the offset to start copying data to
        @param src the source data buffer
        @param srcoffset the offset to start copying data from
        @param count the number of elements to copy
    **/
    static function copy_buffer(dst:defold.types.Buffer, dstoffset:Int, src:defold.types.Buffer, srcoffset:Int, count:Int):Void;

    /**
        Copy a specified amount of data from one stream to another.

        The value type and size must match between source and destination streams.
        The source and destination streams can be the same.

        @param dst the destination stream
        @param dstoffset the offset to start copying data to (measured in value type)
        @param src the source data stream
        @param srcoffset the offset to start copying data from (measured in value type)
        @param count the number of values to copy (measured in value type)
    **/
    static function copy_stream(dst:BufferStream, dstoffset:Int, src:BufferStream, srcoffset:Int, count:Int):Void;

    /**
        Create a new data buffer containing a specified set of streams. A data buffer
        can contain one or more streams with typed data. This is useful for managing
        compound data, for instance a vertex buffer could contain separate streams for
        vertex position, color, normal etc.

        @param element_count The number of elements the buffer should hold
        @param declaration A table where each entry (table) describes a stream
    **/
    @:pure static function create(element_count:Int, declaration:lua.Table<Int,BufferStreamDeclaration>):defold.types.Buffer;

    /**
        Get a copy of all the bytes from a specified stream as a Lua string.

        @param buffer the source buffer
        @param stream_name the name of the stream
        @return the buffer data as a Lua string
    **/
    @:pure static function get_bytes(buffer:defold.types.Buffer, stream_name:HashOrString):String;

    /**
        Get a specified stream from a buffer.

        @param buffer the buffer to get the stream from
        @param stream_name the stream name
        @return the data stream
    **/
    @:pure static function get_stream(buffer:defold.types.Buffer, stream_name:HashOrString):BufferStream;
}

/**
    A buffer stream handle returned by `Buffer.get_stream`.
**/
extern class BufferStream extends lua.Table.AnyTable {}

/**
    Structure for buffer stream declaration used in `Buffer.create`.
**/
@:pure
typedef BufferStreamDeclaration = {
    /**
        The name of the stream.
    **/
    var name:HashOrString;

    /**
        The data type of the stream.
    **/
    var type:BufferStreamType;

    /**
        The number of values each element should hold.
    **/
    var count:Int;
}

@:native("_G.buffer")
@:enum extern abstract BufferStreamType(Int) {
    /**
        Float, single precision, 4 bytes
    **/
    var VALUE_TYPE_FLOAT32;

    /**
        Signed integer, 2 bytes
    **/
    var VALUE_TYPE_INT16;

    /**
        Signed integer, 4 bytes
    **/
    var VALUE_TYPE_INT32;

    /**
        Signed integer, 8 bytes
    **/
    var VALUE_TYPE_INT64;

    /**
        Signed integer, 1 byte
    **/
    var VALUE_TYPE_INT8;

    /**
        Unsigned integer, 2 bytes
    **/
    var VALUE_TYPE_UINT16;

    /**
        Unsigned integer, 4 bytes
    **/
    var VALUE_TYPE_UINT32;

    /**
        Unsigned integer, 8 bytes
    **/
    var VALUE_TYPE_UINT64;

    /**
        Unsigned integer, 1 byte
    **/
    var VALUE_TYPE_UINT8;
}
