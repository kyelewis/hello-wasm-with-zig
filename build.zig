const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("hello", "src/zig/hello.zig");
    exe.setTarget(std.zig.CrossTarget{ .cpu_arch = .wasm32, .os_tag = .freestanding });
    exe.setBuildMode(mode);
    exe.install();
}
