load("@rules_graphviz//:graphviz.bzl", "dot_png")

dot_png(
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