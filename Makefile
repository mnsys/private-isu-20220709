include .env

.PHONY: host0 host1 host2 host3

build:
	$(MAKE) -C app build

deploy-app-1:
	$(MAKE) -C app deploy-app TARGET=$(HOST1)

deploy-app-2:
	$(MAKE) -C app deploy-app TARGET=$(HOST2)

host0:
	ssh $(HOST0)

host1:
	ssh $(HOST1)

host2:
	ssh $(HOST2)

host3:
	ssh $(HOST3)

