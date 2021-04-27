#!/bin/bash

echo 'Server start script initialized'

PORT=4040

echo 'Cleaning port' $PORT '...'
fuser -k 4040/tcp

cd build/web

echo 'Starting server on port' $PORT '...'
python3 -m http.server $PORT

echo 'Server exited'