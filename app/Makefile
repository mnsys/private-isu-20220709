APPNAME=app
APPDIR=/home/isucon/private_isu/webapp/golang/

build:
	go build -o $(APPNAME)

deploy-app: build
	ssh $(TARGET) sudo systemctl stop isu-go
	scp $(APPNAME) $(TARGET):$(APPDIR)/$(APPNAME)
	ssh $(TARGET) sudo tee /etc/systemd/system/isu-go.service >/dev/null <isu-go.service
	ssh $(TARGET) sudo systemctl daemon-reload
	ssh $(TARGET) sudo systemctl start isu-go
