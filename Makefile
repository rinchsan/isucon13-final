deploy-mysql:
	cd ansible && ansible-playbook -i inventory.yaml deploy_mysql_conf.yaml

deploy-nginx:
	cd ansible && ansible-playbook -i inventory.yaml deploy_nginx_conf.yaml

deploy-webapp:
	cd ansible && ansible-playbook -i inventory.yaml deploy_webapp.yaml
