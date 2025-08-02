load("//:graphviz.bzl", "system_dot_rule")

package(default_visibility = ["//visibility:public"])

toolchain_type(name = "toolchain_type")

system_dot_rule(
    name = "test_system_dot_rule",
    src = "example.dot",
    out = "example.png",
)
