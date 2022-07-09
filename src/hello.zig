const std = @import("std");

fn hello() []const u8 {
    return "Hello, zig in wasm";
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{s}", .{hello()});
}
