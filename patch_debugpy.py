#!/usr/bin/env python3
import os

BASE_PATH = "/home/emacchia/Private/kodi_xbian/remote/addons"

DEBUGPY_CODE = """
import debugpy
debugpy.listen(('0.0.0.0', 5678))
debugpy.wait_for_client()
"""

for root, dirs, files in os.walk(BASE_PATH):
    for file in files:
        if file == "default.py":
            file_path = os.path.join(root, file)
            with open(file_path, "r") as f:
                content = f.read()
                if "debugpy" in content:
                    print(f"[SKIP] debugpy già presente: {file_path}")
                    continue
            print(f"[PATCH] Iniettato debugpy in: {file_path}")
            with open(file_path, "w") as f:
                f.write(DEBUGPY_CODE + "\n" + content)