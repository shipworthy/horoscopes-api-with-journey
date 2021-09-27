# Hello

This is a web service that exposes an API for computing a horoscope.

Usage example (running against service running at http://localhost:4000):

```bash
export horoscope_id=$(curl -X POST http://localhost:4000/api/horoscopes | jq -r -M .horoscope_id)
curl -s -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/${horoscope_id}/first_name --data '{"answer":"Pickles"}' | jq .
curl -s -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/${horoscope_id}/birth_month --data '{"answer":4}' | jq .
curl -s -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/${horoscope_id}/birth_day --data '{"answer":26}' | jq .
sleep 1 # or keep polling -- to give your horoscope a bit of time to get computed.
curl -s -X GET http://localhost:4000/api/horoscopes/${horoscope_id} | jq .
```

(run `make run-quick-api-test` to execute this test, captured in [./quick_api_test.sh](./quick_api_test.sh).)
