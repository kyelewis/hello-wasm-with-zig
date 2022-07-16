const std = @import("std");

var inputBuffer: ?[]u8 = null;
var outputBuffer: ?[]u8 = null;

const BufferType = enum(u8) {
    input = 1,
    output = 2,
};

extern fn onRendered(usize) void;

export fn render() void {
    const length = createRenderString();
    onRendered(length);
}

export fn alloc(whichBuffer: u8) [*]u8 {
    const allocator = std.heap.page_allocator;
    const memory = allocator.alloc(u8, 50) catch @panic("couldn't alloc");
    if (whichBuffer == @enumToInt(BufferType.input)) {
        inputBuffer = memory;
    } else if (whichBuffer == @enumToInt(BufferType.output)) {
        outputBuffer = memory;
    }
    return memory.ptr;
}

fn createRenderString() usize {

    // Read input buffer
    const inputString = std.mem.span(@ptrCast([*:0]const u8, inputBuffer.?.ptr));

    // @todo loop through and separate each line
    //const lines = std.mem.tokenize(inputString, "\n");
    //while (line = lines.next().? != null) {

    // read first character for type
    const tag = switch (inputString[0]) {
        'b' => "strong",
        'i' => "em",
        'h' => "h1",
        'n' => "button",
        't' => "input",
        else => "p",
    };

    // Write to output buffer
    const result = std.fmt.bufPrint(outputBuffer.?, "<{s}>{s}</{s}>", .{ tag, inputString[1..], tag }) catch @panic("Couldn't write");

    return result.len;
}

pub fn main() void {}
