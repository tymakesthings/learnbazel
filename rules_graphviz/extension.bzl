load(":repo.bzl", "graphviz_repo")

print("graphviz extension file loaded")
def _graphviz_extension_impl(ctx):
    print("graphviz module extension implementation")
    graphviz_repo(name = "the_graphviz_repo")
    

graphviz = module_extension(implementation = _graphviz_extension_impl, tag_classes = {})
