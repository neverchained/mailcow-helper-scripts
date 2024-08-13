#!/bin/bash
 
# Set the API endpoint URL and key
ENDPOINT="https://mailcow.server/api/v1/add/mailbox"
API_KEY="******-******-******-******-******"
 
# Read the CSV file line by line and create mailbox users
while IFS=',' read -r active domain local_part name password password2 quota force_pw_update tls_enforce_in tls_enforce_out; do
 
    # Build the API request JSON
        data=$(cat <<EOF
{
        "local_part": $local_part,
        "domain": $domain,
        "name": $name,
        "quota": $quota,
        "password": $password,
        "password2": $password2,
        "active": $active,
        "force_pw_update": $force_pw_update,
        "tls_enforce_in": $tls_enforce_in,
        "tls_enforce_out": $tls_enforce_out
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
