const std = @import("std");
const expect = std.testing.expect;

const SomeStruct = struct {
    field: i32,
};

fn couldFail() anyerror!i32 {
    return 1;
}

var some_struct: SomeStruct = undefined;

test "fixed" {
    if (@import("builtin").zig_backend == .stage2_c) return error.SkipZigTest; // TODO

    some_struct = SomeStruct{
        .field = couldFail() catch @as(i32, 0),
    };
    try expect(some_struct.field == 1);
}
