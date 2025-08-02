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
        "dot_path": attr.label(allow_single_file = True, mandatory = True),
        #"dot_path": attr.string()
    },
)

def _system_dot_impl(ctx):
    graphviz_info = ctx.toolchains[":toolchain_type"].graphviz_info
    dot_path_target = graphviz_info.dot_path
    dot_path_depset = dot_path_target.files.to_list()[0].path
    dot_path_file = ""
    print(dir(dot_path_depset))
    ctx.actions.run_shell(
        inputs = [ctx.file.src],
        outputs = [ctx.outputs.out],
        command = "{dot_path} -Tpng {input} -o {output}".format(
            dot_path = dot_path_depset,
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

