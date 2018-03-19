#
GO_DIR := server
GO_SRC := $(addprefix $(GO_DIR)/, app.go)

GO_OUT := server/app.exe
CSSOUT := www/assets/css/style.css
JS_OUT := www/assets/js/main.js
IE_OUT := www/assets/js/polyfill.js
#
test:
	go run $(GO_SRC)

all: go css js

go: $(GO_OUT)

css: $(CSSOUT)

js: $(JS_OUT)
	haxe js.hxml

# for ie8
polyfill: $(IE_OUT)

polyfill-curl: fresh
	curl \
	-o polyfill/es6-promise.js "https://cdn.jsdelivr.net/npm/es6-promise/dist/es6-promise.js" \
	-o polyfill/fetch.js "https://raw.githubusercontent.com/camsong/fetch-ie8/master/fetch.js"


clean:
	rm -f $(GO_EXE) $(CSSOUT) $(JS_OUT)

#
$(GO_OUT): $(GO_SRC)
	go build -o $@ $^

# nodejs monitor: chokidar hss/style.hss -c "hss -output www/assets/css/ hss/style.hss"
$(CSSOUT): hss/style.hss
	hss -output $(dir $@) $^

# use google closure
$(IE_OUT): $(addprefix polyfill/, textContext.js event.js classList.js)
	closure --js_output_file $@ --compilation_level WHITESPACE_ONLY --js $^


$(JS_OUT):


fresh: