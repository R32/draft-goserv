#
GO_DIR := server
GO_EXE := server/app.exe
GO_SRC := $(addprefix $(GO_DIR)/, app.go)

CSSOUT := www/assets/css/style.css
JS_OUT := www/assets/js/main.js

#
test:
	go run $(GO_SRC)

all: go css js

go: $(GO_EXE)

css: $(CSSOUT)

js: always
	haxe js.hxml

clean:
	rm -f $(GO_EXE) $(CSSOUT) www/assets/js/main.js

#
$(GO_EXE): $(GO_SRC)
	go build -o $@ $^

# nodejs: chokidar www/assets/css/style.hss -c "hss www/assets/css/style.hss"
$(CSSOUT): $(CSSOUT:.css=.hss)
	hss $<

always: