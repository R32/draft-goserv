package main

import (
	"expvar"
	"fmt"
	"net"
	"net/http"
	"net/http/fcgi"
	"strings"
)

var exph = expvar.Handler()

func dispatch(w http.ResponseWriter, r *http.Request) {
	var path = r.URL.Path
	if strings.Index(path, "/app/debug") == 0 {
		exph.ServeHTTP(w, r)
	} else {
		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "path: \"%s\"", path)
	}
}

func main() {
	var listen, err = net.Listen("tcp4", "127.0.0.1:8082")
	if err == nil {
		fmt.Println("staring...")
		fcgi.Serve(listen, http.HandlerFunc(dispatch))
	} else {
		fmt.Println(err)
	}
}
