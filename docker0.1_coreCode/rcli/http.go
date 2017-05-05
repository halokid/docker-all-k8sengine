package rcli

import (
	"fmt"
	"net/http"
	"net/url"
	"path"
)

// Use this key to encode an RPC call into an URL,
// eg. domain.tld/path/to/method?q=get_user&q=gordon
const ARG_URL_KEY = "q"

func URLToCall(u *url.URL) (method string, args []string) {
	return path.Base(u.Path), u.Query()[ARG_URL_KEY]
}


//FIXME: docker 服务端的 处理接收到的 http 请求的逻辑代码
func ListenAndServeHTTP(addr string, service Service) error {
	return http.ListenAndServe(addr, http.HandlerFunc(
		func(w http.ResponseWriter, r *http.Request) {
			cmd, args := URLToCall(r.URL)			// 取得 URL 里面的  ?q=%s  ， q参数的值
			if err := call(service, r.Body, &AutoFlush{w}, append([]string{cmd}, args...)...); err != nil {
				fmt.Fprintf(w, "Error: "+err.Error()+"\n")
			}
		}))
}

type AutoFlush struct {
	http.ResponseWriter
}

func (w *AutoFlush) Write(data []byte) (int, error) {
	ret, err := w.ResponseWriter.Write(data)
	if flusher, ok := w.ResponseWriter.(http.Flusher); ok {
		flusher.Flush()
	}
	return ret, err
}
