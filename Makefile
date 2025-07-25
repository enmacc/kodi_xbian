 # WIFI network
# REMOTE_HOST = xbian.local
# LAN no spazi alla fine, se no crash
REMOTE_HOST = enmacc.iliadboxos.it
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

find:
	@echo ">>> Cerco i file maggiori di 100MB"
	find . -type f -size +100M
	
find_remove:
	@echo ">>> Cerco e rimuovi i file maggiori di 100MB"	
	k=0; for i in `find . -type f -size +100M` ; do let k=k+1; rm -r -f $i; done; echo 'Removed:' $k;

code:
	code $(LOCAL_PATH)