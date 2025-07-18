import sys
sys.path.insert(0, "/home/xbian/.local/lib/python3.11/site-packages")

import debugpy

try:
    debugpy.listen(("0.0.0.0", 5678))
except RuntimeError:
    pass

print("Waiting for debugger attach...")
debugpy.wait_for_client()
