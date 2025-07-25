#!/bin/bash
set -euo pipefail # strict mode

# Check if the DATABASE_URL environment variable is set
if [ -z "${DATABASE_URL}" ]; then
	echo "Error: DATABASE_URL environment variable for groups microservice, is not set."
	exit 1
fi

# Wait for the database to be ready
echo "Waiting for the database to be ready..."
sleep 10

# Run database migrations
echo "Running migrations..."
migrate -path db/migrations -database ${DATABASE_URL} -verbose up

echo "[[[Groups MS API]]] Running the Groups MS API now!"
./main
