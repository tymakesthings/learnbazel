def _graphviz_repo_impl(ctx):
    ctx.file("message.txt", "This is from _graphviz_repo_impl")
    ctx.file("BUILD", 
    """
load("@rules_graphviz//:graphviz.bzl", "graphviz_toolchain")

filegroup(
    name = "message_file",
    srcs = ["message.txt"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "graphviz_darwin_arm64_file",
    srcs = glob(["graphviz/**"]),
    visibility = ["//visibility:public"]
)

graphviz_toolchain(
    name = "graphviz_darwin_arm64",
    dot_path = ":graphviz_darwin_arm64_file",
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
    toolchain_type = "@rules_graphviz//:toolchain_type",
)
    """,
)
    ctx.download_and_extract(
        url = "https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/13.1.2/Darwin_23.6.0_graphviz-13.1.2-arm64.tar.gz",
        sha256 = "85504546cb9fecc45aa07da8a882dc7d2d0c516853fb5cb3412494c0fd6792e1",
        strip_prefix = "build",
        output = "graphviz",
    )

graphviz_repo = repository_rule(implementation = _graphviz_repo_impl)