#!/usr/bin/env bash

set -uex
export horoscope_id=$(curl -X POST http://localhost:4000/api/horoscopes | jq -r -M .horoscope_id)
echo $horoscope_id
curl -s -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/${horoscope_id}/first_name --data '{"answer":"Pickles"}' 
# | jq .
curl -s -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/${horoscope_id}/birth_month --data '{"answer":4}' | jq .
curl -s -X POST -H "Content-Type: application/json" http://localhost:4000/api/horoscopes/${horoscope_id}/birth_day --data '{"answer":26}' | jq .
sleep 1
curl -s -X GET http://localhost:4000/api/horoscopes/${horoscope_id} | jq .
