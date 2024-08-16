#!/bin/bash

# Set the API endpoint URL and key
ENDPOINT="https://mailcow.server/api/v1/edit/mailbox"
API_KEY="******-******-******-******-******"

# Read the CSV file line by line and create mailbox users
while IFS=';' read -r active domain local_part name password password2 quota force_pw_update tls_enforce_in tls_enforce_out; do

    # Build the API request JSON
        data=$(cat <<EOF
{
        "items":[
                "$local_part@$domain"
        ],
        "attr":{
                "quota":"0"
        }
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

done < <(tail -n +2 /root/scripts/users.csv)