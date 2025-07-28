def _system_dot_impl(ctx):
    ctx.actions.run_shell(
        inputs = [ctx.file.src],
        outputs = [ctx.outputs.out],
        command = "/opt/homebrew/bin/dot -Tpng {input} -o {output}".format(
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
)