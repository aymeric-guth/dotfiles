import sys

# Patching builtins
import _sys
sys.modules['sys'] = _sys

from pathlib import Path


# __all__ = []
# Mangling namespace to fit machine.main() behavior
path: Path = Path(__file__).parent
__package__ = 'app'
sys.path[0] = str(path / __package__)

with open(path / 'app' / 'boot.py', 'r') as f:
    _boot = f.read()
exec(_boot, globals())

with open(path / 'app' / 'main.py', 'r') as f:
    _main = f.read()

exec(_main, globals())

# print(globals()['sys'])