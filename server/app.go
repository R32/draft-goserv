package main

import (
	"expvar"
	"fmt"
	"net"
	"net/http"
	"net/http/fcgi"
	"os"
	"strings"
)

const app_prefix = "/app" // defined by ningx-go.conf
const app_prefix_len = len(app_prefix)

func app_prefix_trip(path string) string {
	if path[0:app_prefix_len] == app_prefix {
		path = path[app_prefix_len:]
	}
	if path == "" {
		path = "/"
	}
	return path
}

func path2Args(path string) []string {
	return strings.Split(path[1:], "/")
}

var exph = expvar.Handler()

func dispatch(w http.ResponseWriter, r *http.Request) {
	var path = app_prefix_trip(r.URL.Path)
	var args = path2Args(path)
	switch args[0] {
	case "": // Home
		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "Home - method: %s, path: \"%s\"", r.Method, path)
	case "debug":
		exph.ServeHTTP(w, r)
	default:
		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "Default - method: %s, path: \"%s\"", r.Method, path)
		//http.NotFound(w, r)
	}
}

func main() {
	var cmd = ""
	if len(os.Args) > 1 {
		cmd = os.Args[1]
	}
	switch cmd {
	case "fcgi":
		if listen, err := net.Listen("tcp4", "127.0.0.1:8082"); err == nil {
			fmt.Println("Start fcgi...")
			fcgi.Serve(listen, http.HandlerFunc(dispatch))
		} else {
			fmt.Println(err)
		}
	default:
		fmt.Println("...")
	}
}
