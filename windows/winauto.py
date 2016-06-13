from __future__ import print_function, division

import logging
import re
import os
import shutil
from itertools import chain
from collections import defaultdict
from collections import namedtuple

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

    nsf = list(_yield_netservice_files_to_remove())
    i2f = list(_yield_installer2_files_to_remove())

    print("{} {:.2f} MB space.".format(
        "Would free" if dry else "Freed",
        sum(
            _rm(
                path,
                dry
            ) for path in chain(nsf, i2f)
        ) / (1024*1024)
    ))


def _yield_installer2_files_to_remove():
    Installer2Subfolder = namedtuple(
        'Installer2Subfolder',
        ['path', 'mtime']
    )

    path = os.path.join("C:\\", "Program Files", "NVIDIA Corporation",
                        "Installer2")
    fdict = defaultdict(list)
    for fn in os.listdir(path):
        fpath = os.path.join(path, fn)
        if os.path.isdir(fpath):
            fn_l = fn.split(".")
            if len(fn_l) == 1:
                logging.info("{} has no version; ignoring.".format(fn))
                continue
            item_name = ".".join(fn_l[:-1])
            item_version = fn_l[-1]
            if not re.match(r"^{\w+-\w+-\w+-\w+-\w+}$", item_version):
                logging.info("{} is not a recognized version string; "
                             "ignoring {}.".format(item_version, fn))
                continue
            fdict[item_name].append(
                Installer2Subfolder(
                    path=fpath,
                    mtime=os.path.getmtime(fpath)
                )
            )
    for k, v in fdict.items():
        sorted_v = sorted(v, key=lambda x: x.mtime, reverse=True)
        for i2sf in sorted_v[1:]:
            yield i2sf.path


def _yield_netservice_files_to_remove():
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
    for filename in uuid_folders + uuid_xml_docs:
        yield os.path.join(path, filename)


if __name__ == "__main__":
    logging.basicConfig()
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    cli()
