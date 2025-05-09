//go:build gofuzz

package forward2

import (
	"github.com/coredns/coredns/plugin/pkg/dnstest"
	"github.com/coredns/coredns/plugin/pkg/fuzz"
	"github.com/coredns/coredns/plugin/pkg/proxy"

	"github.com/miekg/dns"
)

var f *Forward

// abuse init to setup an environment to test against. This start another server to that will
// reflect responses.
func init() {
	f = New()
	s := dnstest.NewServer(r{}.reflectHandler)
	f.SetProxy(proxy.NewProxy("FuzzForwardPlugin1", s.Addr, "tcp"))
	f.SetProxy(proxy.NewProxy("FuzzForwardPlugin2", s.Addr, "udp"))
}

// Fuzz fuzzes forward.
func Fuzz(data []byte) int {
	return fuzz.Do(f, data)
}

type r struct{}

func (r r) reflectHandler(w dns.ResponseWriter, req *dns.Msg) {
	m := new(dns.Msg)
	m.SetReply(req)
	w.WriteMsg(m)
}
