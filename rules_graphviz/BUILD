load("//:graphviz.bzl", "system_dot_rule", "graphviz_toolchain")

toolchain_type(name = "toolchain_type")

graphviz_toolchain(
    name = "graphviz_darwin_arm64",
    dot_path = "/opt/homebrew/bin/dot",
)

toolchain(
    name = "graphviz_darwin_arm64_toolchain",
    exec_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:aarch64"
    ],
    target_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:aarch64"
    ],
    toolchain = ":graphviz_darwin_arm64",
    toolchain_type = ":toolchain_type",
)

system_dot_rule(
    name = "test_system_dot_rule",
    src = "example.dot",
    out = "example.png",
)
