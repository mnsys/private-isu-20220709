include .env

TIMEID := $(shell date +%Y%m%d-%H%M%S)

.PHONY: host0 host1 host2 host3

build:
	$(MAKE) -C app build

deploy-app-1:
	$(MAKE) -C app deploy-app TARGET=$(HOST1)

deploy-app-2:
	$(MAKE) -C app deploy-app TARGET=$(HOST2)

fetch-app-files:
	$(MAKE) -C app fetch-app-files TARGET=$(HOST1)

fetch-app-files2:
	$(MAKE) -C app fetch-app-files TARGET=$(HOST2)

host0:
	ssh $(HOST0)

host1:
	ssh $(HOST1)

host2:
	ssh $(HOST2)

host3:
	ssh $(HOST3)

perf-log-viewer:
	go tool pprof -http="127.0.0.1:8081" logs/latest/cpu-web1.pprof

collect-logs:
	mkdir -p logs/$(TIMEID)
	rm -f logs/latest
	ln -sf $(TIMEID) logs/latest
	scp $(HOST1):/tmp/cpu.pprof logs/latest/cpu-web1.pprof
	ssh $(HOST1) sudo chmod 644 /var/log/nginx/access.log
	scp $(HOST1):/var/log/nginx/access.log logs/latest/access-web1.log
	scp $(HOST1):/tmp/sql.log logs/latest/sql-web1.log
	ssh $(HOST1) sudo truncate -c -s 0 /var/log/nginx/access.log
	ssh $(HOST1) sudo truncate -c -s 0 /tmp/sql.log

truncate-logs:
	ssh $(HOST1) sudo truncate -c -s 0 /var/log/nginx/access.log
	ssh $(HOST1) sudo truncate -c -s 0 /tmp/sql.log

collect-logs2:
	mkdir -p logs/$(TIMEID)
	rm -f logs/latest
	ln -sf $(TIMEID) logs/latest
	scp $(HOST2):/tmp/cpu.pprof logs/latest/cpu-web1.pprof
	ssh $(HOST2) sudo chmod 644 /var/log/nginx/access.log
	scp $(HOST2):/var/log/nginx/access.log logs/latest/access-web1.log
	scp $(HOST2):/tmp/sql.log logs/latest/sql-web1.log
	ssh $(HOST2) sudo truncate -c -s 0 /var/log/nginx/access.log
	ssh $(HOST2) sudo truncate -c -s 0 /tmp/sql.log

truncate-logs2:
	ssh $(HOST2) sudo truncate -c -s 0 /var/log/nginx/access.log
	ssh $(HOST2) sudo truncate -c -s 0 /tmp/sql.log