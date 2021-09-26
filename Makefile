.PHONY: run-simulated-test-sequence

run-simulated-test-sequence:
	curl -X POST http://localhost:4000/api/horoscopes
	curl -X GET http://localhost:4000/api/horoscopes/123
	curl -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/123/1 --data '{"answer":"42"}'
