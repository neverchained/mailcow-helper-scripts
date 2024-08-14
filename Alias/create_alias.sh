#!/bin/bash

# Set the API endpoint URL and key
ENDPOINT="https://mailcow.server/api/v1/add/alias"
API_KEY="******-******-******-******-******"

# Read the CSV file line by line and create mailbox users
while IFS=';' read -r address goto active; do

    # Build the API request JSON
        data=$(cat <<EOF
{
        "address": "$address",
        "goto": "$goto",
        "active": "$active"
}
EOF
)


    # Print the generated JSON for debugging
    echo "Generated JSON for $local_part@$domain:"
    echo "$data"

    # Make the API request
    response=$(curl -s -X 'POST' "$ENDPOINT" -H "X-API-Key: $API_KEY" -H "Content-Type: application/json" -d "$data")

    # Print the response
    echo "Response for $local_part@$domain:"
    echo "$response"

done < <(tail -n +2 /path/to/csv)
