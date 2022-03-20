const std = @import("std");

const glfw = @import("glfw");
const zgl = @import("zgl");

pub fn main() anyerror!void {
    try glfw.init(.{});
    defer glfw.terminate();

    const hints: glfw.Window.Hints = .{
        .context_version_major = 3,
        .context_version_minor = 2,
        .opengl_profile = .opengl_core_profile,
        .opengl_forward_compat = true,
        .resizable = false,
    };

    const window = try glfw.Window.create(
        640,
        480,
        "Hello ERE!",
        null,
        null,
        hints,
    );

    defer window.destroy();

    while (!window.shouldClose()) {
        try glfw.pollEvents();
    }
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
