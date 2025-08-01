def _graphviz_repo_impl(ctx):
    ctx.file("message.txt", "This is from _graphviz_repo_impl")
    ctx.file("BUILD", 
    """
filegroup(
    name = "message_file",
    srcs = ["message.txt"],
    visibility = ["//visibility:public"],
)
    """,
)

graphviz_repo = repository_rule(implementation = _graphviz_repo_impl)