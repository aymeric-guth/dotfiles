#!/usr/bin/env python3
import sys
import pathlib


def main() -> int:
    if len(sys.argv) < 2:
        return 1
    p = pathlib.Path(sys.argv[1])
    if p.exists():
        with p.open("r") as f:
            raw = f.read()
    else:
        raw = sys.argv[1]

    l = [i for i in raw.split("\n") if i]
    l.sort()
    sys.stdout.write("\n".join(l))
    return 0


if __name__ == "__main__":
    sys.exit(main())
