
.PHONY: all

all:
	if [ $$(uname) = "Linux" ] ; then make linux ; else make windows ; fi

.PHONY: linux

linux: sshdog

sshdog: *.go
	echo "Building Linux target..."
	go get
	GOOS=linux GOARCH=amd64 go build -o sshdog

.PHONY: windows

windows: sshdog.exe

sshdog.exe: *.go
	echo "Building Windows target..."
	go get
	GOOS=windows GOARCH=amd64 go build -o sshdog.exe

.PHONY: upx

upx:
	if [ $$(uname) = "Linux" ] ; then upx -9 sshdog ; else upx -9 sshdog.exe ; fi

.PHONY: run

run:
	if [ $$(uname) = "Linux" ] ; then ./sshdog ; else ./sshdog.exe ; fi

.PHONY: clean

clean:
	rm -f *.bak sshdog sshdog.exe 2> /dev/null
