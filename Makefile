REMOTE_HOST = xbian.local
REMOTE_PATH = /home/xbian/.kodi
LOCAL_PATH  = /home/emacchia/Private/kodi_xbian/remote

SSH_USER = xbian
SSHFS_OPTS = -o reconnect

mount:
	@echo ">>> Montaggio SSHFS"
	sshfs $(SSH_USER)@$(REMOTE_HOST):$(REMOTE_PATH) $(LOCAL_PATH) $(SSHFS_OPTS)

unmount:
	@echo ">>> Smontaggio SSHFS"
	fusermount -u $(LOCAL_PATH)

log:
	@echo ">>> Kodi log tail:"
	ssh $(SSH_USER)@$(REMOTE_HOST) tail -f $(REMOTE_PATH)/temp/kodi.log

patch:
	@echo ">>> Patch debugpy in tutti gli addon"
	python3 patch_debugpy.py

unpatch:
	@echo ">>> Rimuovo debugpy da tutti i default.py"
	python3 unpatch_debugpy.py || echo "Script unpatch non ancora creato."

code:
	code $(LOCAL_PATH)