include .env

.PHONY: host0 host1 host2 host3

build:
	$(MAKE) -C app build

deploy-app-1:
	$(MAKE) -C app deploy-app TARGET=$(HOST1)

deploy-app-2:
	$(MAKE) -C app deploy-app TARGET=$(HOST2)

deploy-web-all:
	@make deploy-web-1
	@make deploy-web-2
	@make deploy-web-3

deploy-web-1:
	cat ./host1/nginx.conf | ssh ${HOST1} sudo tee /etc/nginx/nginx.conf >/dev/null
	ssh ${HOST1} sudo nginx -t
	ssh ${HOST1} sudo systemctl restart nginx

deploy-web-2:
	cat ./host2/nginx.conf | ssh ${HOST2} sudo tee /etc/nginx/nginx.conf >/dev/null
	ssh ${HOST2} sudo nginx -t
	ssh ${HOST2} sudo systemctl restart nginx

deploy-web-3:
	cat ./host3/nginx.conf | ssh ${HOST3} sudo tee /etc/nginx/nginx.conf >/dev/null
	ssh ${HOST3} sudo nginx -t
	ssh ${HOST3} sudo systemctl restart nginx

deploy-db-all:
	@make deploy-db-1
	@make deploy-db-2
	@make deploy-db-3

deploy-db-1:
	cat ./host1/mysqld.cnf | ssh ${HOST1} sudo tee /etc/mysql/mysql.conf.d/mysqld.cnf >/dev/null
	ssh ${HOST1} sudo systemctl restart mysql

deploy-db-2:
	cat ./host2/mysqld.cnf | ssh ${HOST2} sudo tee /etc/mysql/mysql.conf.d/mysqld.cnf >/dev/null
	ssh ${HOST2} sudo systemctl restart mysql

deploy-db-3:
	cat ./host3/mysqld.cnf | ssh ${HOST3} sudo tee /etc/mysql/mysql.conf.d/mysqld.cnf >/dev/null
	ssh ${HOST3} sudo systemctl restart mysql

host0:
	ssh $(HOST0)

host1:
	ssh $(HOST1)

host2:
	ssh $(HOST2)

host3:
	ssh $(HOST3)

