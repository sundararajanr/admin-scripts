“#!/bin/bash
TOKEN=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
ORG="sundararajanr"
RESULTS_FILE="repo_list.txt"
page=1
per_page=100
total_pages=5
repo_list=""
while [[ $page -le $total_pages ]]; do
    response=$(curl -s -H "Authorization: token $TOKEN" https://api.github.com/orgs/$ORG/repos?per_page=$per_page&page=$page&type=private)
    repos=$(echo "$response" | jq -r '.[].name')
    repo_list+="$repos"$'\n'
    total_repos=$(echo "$response" | jq -r '. | length')
    if [[ $total_repos -lt $per_page ]]; then
        break
    fi
    ((page++))
done
echo "$repo_list" > "$RESULTS_FILE"
cat repo_list.txt”
