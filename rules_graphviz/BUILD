load("//:graphviz.bzl", "dot_rule")

package(default_visibility = ["//visibility:public"])

toolchain_type(name = "toolchain_type")

dot_rule(
    name = "test_dot_rule",
    src = "example.dot",
    out = "example.png",
)
