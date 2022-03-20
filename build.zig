const std = @import("std");

const glfw = @import("libs/mach-glfw/build.zig");

pub fn build(b: *std.build.Builder) void {
    // standard executable setup
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("ere", "src/main.zig");

    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    exe.addPackagePath("glfw", "libs/mach-glfw/src/main.zig");
    glfw.link(b, exe, .{});
    exe.linkSystemLibrary("epoxy");
    exe.linkSystemLibrary("GL");
    exe.addPackagePath("zgl", "libs/zgl/zgl.zig");

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // Tests
    const exe_tests = b.addTest("src/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);

    exe.install();
}
