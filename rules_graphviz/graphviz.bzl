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
        "dot_path": attr.string(mandatory = True),
    },
)

def _system_dot_impl(ctx):
    graphviz_info = ctx.toolchains[":toolchain_type"].graphviz_info
    ctx.actions.run_shell(
        inputs = [ctx.file.src],
        outputs = [ctx.outputs.out],
        command = "{dot_path} -Tpng {input} -o {output}".format(
            dot_path = graphviz_info.dot_path,
            input = ctx.files.src[0].path,
            output = ctx.outputs.out.path,
        ),
        mnemonic = "SystemDot",
        
    )

    return [DefaultInfo(files = depset([ctx.outputs.out]))]

system_dot_rule = rule(
    implementation = _system_dot_impl,
    attrs = {
        "src": attr.label(allow_single_file = True, mandatory = True),
        "out": attr.output(mandatory = True),
    },
    toolchains = [":toolchain_type"],
)

