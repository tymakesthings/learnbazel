GraphVizInfo = provider(doc = "GraphViz information", fields = [
    "dot_path"
])

def _toolchain_impl(ctx):
    return [
        platform_common.ToolchainInfo(
            graphviz_info = GraphVizInfo(
                dot_path = ctx.attr.dot_path
            )
        )
    ]

graphviz_toolchain = rule(
    implementation = _toolchain_impl,
    attrs = {
        "dot_path": attr.label(),
        #"dot_path": attr.string()
    },
)

def _dot_impl(ctx):
    graphviz_info = ctx.toolchains[":toolchain_type"].graphviz_info
    dot_path_target = graphviz_info.dot_path
    dot_depset = dot_path_target.files
    dot_file = None
    for f in dot_depset.to_list():
        if f.basename == "dot":
            dot_file = f
            break
    if dot_file == None:
        fail("dot executable not found")

    ctx.actions.run(
        inputs = [ctx.file.src],
        outputs = [ctx.outputs.out],
        arguments = [
            "-Tpng", ctx.file.src.path, "-o", ctx.outputs.out.path
        ],
        mnemonic = "RunningDot",
        tools = [dot_depset],
        executable = dot_file
    )

    # Is transitive necessary here?
    return [DefaultInfo(files = depset([ctx.outputs.out], transitive = [dot_depset]))]

dot_rule = rule(
    implementation = _dot_impl,
    attrs = {
        "src": attr.label(allow_single_file = True, mandatory = True),
        "out": attr.output(mandatory = True),
    },
    toolchains = [":toolchain_type"],
)

