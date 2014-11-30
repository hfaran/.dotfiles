import os
import subprocess
import sys

import click


def mklink(target, link_name, symbolic=False, dry_run=True):
    command =  u"ln {symbolic} {target} {link_name}".format(
        symbolic="-s" if symbolic else "",
        target=target,
        link_name=link_name
    )
    if dry_run:
        print(command)
    else:
        return subprocess.call(command)


@click.command()
@click.option("--dry-run", "-D", default=False, is_flag=True,
              help="Print ln commands rather than executing them")
@click.option("--symbolic", "-s", default=False, is_flag=True,
              help="Create symbolic rather than hard links")
@click.argument('package_name')
def main(dry_run, symbolic, package_name):
    """
    A "replacement" for GNU Stow for use on any platforms (i.e., Windows)
    where GNU Stow is not available
    """
    assert package_name in os.listdir("."), (
        "Cannot link non-existent files for package '{}'".format(package_name)
    )

    target_path = os.path.abspath(os.path.join(".", package_name))
    link_path = os.path.abspath("..")

    nodes = os.listdir(target_path)

    if dry_run:
        print("*** This a dry-run, no links will be created. ***")

    for node in nodes:
        target = os.path.join(target_path, node)
        link_name = os.path.join(link_path, node)
        assert not os.path.exists(link_name), (
            "{link} already exists; cannot create link {target} -> {link}"
            .format(link=link_name, target=target)
        )

    for node in nodes:
        target = os.path.join(target_path, node)
        link_name = os.path.join(link_path, node)
        if not dry_run:
            print("Creating symbolic link: {} -> {}".format(target, link_name))
        mklink(target=target, link_name=link_name, dry_run=dry_run,
               symbolic=symbolic)


if __name__ == '__main__':
    try:
        main()
    except AssertionError as e:
        print(e)
