#!/usr/bin/env python3
import sys
import json
import re
import os
import pathlib


dev_dir = pathlib.Path(os.getenv("DEV"))
if not dev_dir.exists():
    raise FileNotFoundError("DEV is undefined or not present on disk")
dev = str(dev_dir)
patt = re.compile(f"^{dev_dir}/.*$")


def get_template(cfg):
    return {
        "reference_time": cfg.get("reference_time"),
        "half_life": cfg.get("half_life"),
        "items": [],
    }


# from env to cache
def on_load(cfg):
    projects = get_template(cfg)
    p = projects.get("items")
    for item in cfg.get("items"):
        s = (
            item.get("item")
            .replace("${DEV}", dev)
            .replace("$(DEV)", dev)
            .replace("$DEV", dev)
        )
        it = item.copy()
        it.update({"item": s})
        p.append(it)
    return projects


# from cache to env
def on_save(cfg):
    projects = get_template(cfg)
    p = projects.get("items")
    for item in cfg.get("items"):
        name = item.get("item")
        it = item.copy()
        if patt.match(name):
            it.update({"item": f"$DEV{name[len(str(dev)) :]}"})
        p.append(it)
    return projects


def main(raw: str, mode: str) -> int:
    try:
        cfg = json.loads(raw)
    except json.JSONDecodeError:
        return 1

    if mode == "save":
        projects = on_save(cfg)
    elif mode == "load":
        projects = on_load(cfg)
    else:
        raise SystemExit
    sys.stdout.write(json.dumps(projects))
    return 0


if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise SystemExit
    raw = "".join(sys.stdin.readlines())
    sys.exit(main(raw, sys.argv[1]))
