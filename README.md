# Kodi Remote Dev Tools

Questo repo contiene:

- Script per patchare `debugpy` dentro gli addon di Kodi.
- Script per montare `.kodi` via SSHFS.
- Config VSCode per debug remoto.
- Makefile per fare tutto in un colpo solo.

## 📂 Struttura

```text
.
├── remote/                # Remote mount folder in locale oppure sparisce
   ├── addons/             # Tutti gli addon remoti montati via SSHFS
├── .vscode/               # Config VSCode (launch.json, tasks.json)
├── patch_debugpy.py       # Script per iniettare debugpy in tutti i default.py
├── mount_and_log.sh       # Script per montare e tail-log
├── Makefile               # Automazioni varie
└── .gitignore             # Git config

```

## ✅ Flusso consigliato

1. Monta la cartella `.kodi`:
   make mount

2. Patcha tutti gli addon con `debugpy`:
   ~~make patch~~
   non più, s'interrompe sulla stessa porta

2. metti `import_patch_debug.py` all'inizio del file `default.py` che vuoi debuggare

      ```python

      import import_patch_debug

      # Resto del tuo addon

      ```

3. Avvia Kodi e l'addon → aspetta `wait_for_client()`

4. Attacca VSCode:
   - Usa `launch.json` con tipo `debugpy`
   - Breakpoint sui file montati

5. Guarda il log in diretta:
   make log

6. Quando hai finito, smonta:
   make unmount

## 🐞 Debug

- `debugpy` ascolta su `0.0.0.0:5678`

## ⚙️ Requisiti

- `sshfs` installato
- VS Code con Python Debugger Extension (`debugpy`)
- Python 3 per eseguire `patch_debugpy.py
