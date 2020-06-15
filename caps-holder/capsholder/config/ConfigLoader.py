import json
import os
from collections import namedtuple
from pathlib import Path


class ConfigLoader(object):
    @classmethod
    def load(cls, name):
        json_file = Path(os.path.dirname(__file__)) / 'files' / '.'.join([name, 'json'])
        return json2obj(json_file)


def _json_object_hook(d):
    return namedtuple('CapsHolderConfig', d.keys())(*d.values())


def json2obj(json_file):
    with open(json_file) as f:
        return json.load(f, object_hook=_json_object_hook)