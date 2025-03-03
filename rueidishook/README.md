# rueidishook

With `rueidishook.WithHook`, users can easily intercept `rueidis.Client` by implementing custom `rueidishook.Hook` handler.

This can be useful to change the behavior of `rueidis.Client` or add other integrations such as observability, APM etc.

## Example

```go
package main

import (
	"context"
	"time"

	"github.com/dannotripp/rueidis"
	"github.com/dannotripp/rueidis/rueidishook"
)

type hook struct{}

func (h *hook) Do(client rueidis.Client, ctx context.Context, cmd rueidis.Completed) (resp rueidis.RedisResult) {
	// do whatever you want before client.Do
	resp = client.Do(ctx, cmd)
	// do whatever you want after client.Do
	return
}

func (h *hook) DoMulti(client rueidis.Client, ctx context.Context, multi ...rueidis.Completed) (resps []rueidis.RedisResult) {
	// do whatever you want before client.DoMulti
	resps = client.DoMulti(ctx, multi...)
	// do whatever you want after client.DoMulti
	return
}

func (h *hook) DoCache(client rueidis.Client, ctx context.Context, cmd rueidis.Cacheable, ttl time.Duration) (resp rueidis.RedisResult) {
	// do whatever you want before client.DoCache
	resp = client.DoCache(ctx, cmd, ttl)
	// do whatever you want after client.DoCache
	return
}

func (h *hook) DoMultiCache(client rueidis.Client, ctx context.Context, multi ...rueidis.CacheableTTL) (resps []rueidis.RedisResult) {
	// do whatever you want before client.DoMultiCache
	resps = client.DoMultiCache(ctx, multi...)
	// do whatever you want after client.DoMultiCache
	return
}

func (h *hook) Receive(client rueidis.Client, ctx context.Context, subscribe rueidis.Completed, fn func(msg rueidis.PubSubMessage)) (err error) {
	// do whatever you want before client.Receive
	err = client.Receive(ctx, subscribe, fn)
	// do whatever you want after client.Receive
	return
}

func main() {
	client, err := rueidis.NewClient(rueidis.ClientOption{InitAddress: []string{"127.0.0.1:6379"}})
	if err != nil {
		panic(err)
	}
	client = rueidishook.WithHook(client, &hook{})
	defer client.Close()
}
```
