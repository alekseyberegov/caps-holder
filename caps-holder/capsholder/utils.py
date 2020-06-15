import importlib


def new_instance(fq_class_name):
    module_name, class_name = fq_class_name.rsplit(".", 1)
    cls = getattr(importlib.import_module(module_name), class_name)
    return cls()
