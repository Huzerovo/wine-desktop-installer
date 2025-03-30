.PHONY: installer
installer:
	@bash updater
	@echo "Run shellcheck..."
	@shellcheck /usr/local/bin/wine-desktop-installer
	@echo "ok"
