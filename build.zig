const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("hello", "src/hello.zig");
    exe.setTarget(std.zig.CrossTarget{ .cpu_arch = .wasm32, .os_tag = .wasi });
    exe.setBuildMode(mode);
    exe.install();
}
