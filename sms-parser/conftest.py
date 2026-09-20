"""
Pytest bridges the package's real import name to what the test suite
expects. The package directory is physically named "sms-parser" (hyphen),
which is not something a normal `import sms_parser` statement can ever
resolve -- `pip install -e .` does not fix this either (there is no
directory literally named `sms_parser` for setuptools to discover). This
means `tests/test_parser.py`'s `from sms_parser import ...` has never been
runnable in this repo without this alias.
"""
import importlib
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
sys.modules.setdefault("sms_parser", importlib.import_module("sms-parser"))
