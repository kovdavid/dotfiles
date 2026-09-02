init_all: init_user init_configs

init_user:
	echo "Init user"
	./init/01-init-user.sh

init_configs:
	echo "Init configs"
	./init/02-init-configs.sh
