# Hello

This is a web service that exposes an API for computing a horoscope.

The service exposes HTTP routes for creating a new horoscope process, updating a horoscope process with an answer, and getting the current state of a horoscope process.

```
~/code/shipworthy/hello $ mix phx.routes
api_path  POST  /api/horoscopes                             HelloWeb.ApiController :create
api_path  GET   /api/horoscopes/:horoscope_id               HelloWeb.ApiController :get
api_path  POST  /api/horoscopes/:horoscope_id/:question_id  HelloWeb.ApiController :record_answer
````

You can run a basic test (against service running locally, at http://localhost:4000) by executing `make run-quick-api-test`.

Here is a step-by-step example:

1. Create a new horoscope process, get its ID:
```bash
$ export horoscope_id=$(curl -X POST http://localhost:4000/api/horoscopes | jq -r -M .horoscope_id)
```


2. Take a peek at the state of the new horoscope process:

```
$ curl -s -X GET http://localhost:4000/api/horoscopes/${horoscope_id} | jq .
{
  "horoscope": null,
  "horoscope_id": "v3bs3nawjn",
  "next_question_id": "first_name",
  "status": "ready"
}
```


2. Update the horoscope process with the answer to the question `"first_name"`:
```bash
$ curl -s -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/${horoscope_id}/first_name --data '{"answer":"Pickles"}' | jq .
```


3. Update horoscope with the answer to the question `"birth_month"`:
```bash
$ curl -s -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/${horoscope_id}/birth_month --data '{"answer":4}' | jq .
```


4. Update horoscope with the answer to the question `"birth_day"`:
```bash
$ curl -s -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/${horoscope_id}/birth_day --data '{"answer":26}' | jq .
```


5. Now that all the questions have been answered, let horoscope process compute the actual horoscope (sleep and/or polling):
```bash
$ sleep 1
```


6. Get the horoscope:

```bash
$ curl -s -X GET http://localhost:4000/api/horoscopes/${horoscope_id} | jq .
```

```
{
  "horoscope": "Pickles! You are a righteous taurus! Now is the perfect week to smash the racist patriarchy. PS Tauruses are awesome.",
  "horoscope_id": "v3bs3nawjn",
  "next_question_id": null,
  "status": "ready"
}
```