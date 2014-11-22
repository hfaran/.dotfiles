from __future__ import print_function, division

import re
import os
import shutil

import click


def _get_size(path):
    if os.path.isdir(path):
        return sum(_get_size(os.path.join(path, name))
                   for name in os.listdir(path))
    elif os.path.isfile(path):
        return os.path.getsize(path)


def _rm(path, dry=True):
    target_size = _get_size(path)
    is_dir = os.path.isdir(path)
    print("{} {} ({})...".format(
        "Would remove" if dry else "Removing",
        path,
        target_size
    ))
    if not dry:
        shutil.rmtree(path) if is_dir else os.remove(path)
    return target_size


@click.group()
def cli():
    pass


@cli.command()
@click.option("--wet", "-w", default=False, is_flag=True)
def clean_geforce(wet):
    dry = not wet

    path = os.path.join("C:\\", "ProgramData", "NVIDIA Corporation",
                        "NetService")
    uuid_folders = [
        name for name in os.listdir(path) if
        os.path.isdir(os.path.join(path, name)) and
        re.match(r"^(\w+)\-(\w+)\-(\w+)\-(\w+)\-(\w+)$", name)
    ]
    uuid_xml_docs = [
        name for name in os.listdir(path) if
        name.endswith(".xml") and
        any(name == "NS_DT_{}.xml".format(uuid) for uuid in uuid_folders)
    ]
    print("{} {:.2f} MB space.".format(
        "Would free" if dry else "Freed",
        sum(
            _rm(
                os.path.join(path, name),
                dry
            ) for name in uuid_folders+uuid_xml_docs
        ) / (1024*1024)
    ))


if __name__ == "__main__":
    cli()
