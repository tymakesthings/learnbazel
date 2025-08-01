_install = tag_class(attrs = {"version": attr.string(mandatory = True)})
print("graphviz extension file loaded")
def _graphviz_extension_impl(ctx):
    print("graphviz module extension implementation")
    versions = []
    for mod in ctx.modules:
        for install in mod.tags.install:
            versions += [install.version]

    print("need to install %s".format(versions))

graphviz_extension = extension_rule(implementation = _graphviz_extension_impl, tag_classes = {"install": install})
