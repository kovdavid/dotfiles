init_all: init_root init_user init_configs

init_root:
	echo "Init root"
	sudo ./init/01-init-root.sh

init_user:
	echo "Init user"
	./init/02-init-user.sh

init_configs:
	echo "Init configs"
	./init/03-init-configs.sh
