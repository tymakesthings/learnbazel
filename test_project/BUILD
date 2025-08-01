load("@rules_graphviz//:graphviz.bzl", "system_dot_rule")

system_dot_rule(
    name = "example",
    src = "example.dot",
    out = "example.png",
)

genrule(
    name = "show_message",
    srcs = ["@the_graphviz_repo//:message_file"],
    outs = ["output.txt"],
    cmd = "cp $< $@",
)