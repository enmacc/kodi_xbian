#!/usr/bin/env python3
import os
import re

BASE_PATH = "/home/emacchia/Private/kodi_xbian/remote/addons"

DEBUGPY_REGEX = re.compile(r"import debugpy[\s\S]*?wait_for_client\(\)\n", re.MULTILINE)

for root, dirs, files in os.walk(BASE_PATH):
    for file in files:
        if file == "default.py":
            file_path = os.path.join(root, file)
            with open(file_path, "r") as f:
                content = f.read()
                if "debugpy" not in content:
                    continue
            new_content = DEBUGPY_REGEX.sub("", content)
            with open(file_path, "w") as f:
                f.write(new_content)
            print(f"[UNPATCH] Rimosso debugpy da: {file_path}")