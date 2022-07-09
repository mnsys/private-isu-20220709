include .env

.PHONY: host0 host1 host2 host3

host0:
	ssh $(HOST0)

host1:
	ssh $(HOST1)

host2:
	ssh $(HOST2)

host3:
	ssh $(HOST3)

