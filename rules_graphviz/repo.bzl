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
    srcs = ["graphviz/bin/dot"],
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
        url = "https://gitlab.com/graphviz/graphviz/-/jobs/10852413719/artifacts/file/Packages/Darwin/23.6.0/Graphviz-13.1.2~dev.20250730.0050-Darwin.zip",
        sha256 = "641ee69f5686153bc601b5f8a32e253d9a352191f5bf869c54e875769d8ce3a6",
        strip_prefix = "Graphviz-13.1.2~dev.20250730.0050-Darwin",
        output = "graphviz",
    )

graphviz_repo = repository_rule(implementation = _graphviz_repo_impl)