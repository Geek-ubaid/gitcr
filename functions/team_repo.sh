add_repo(){

    # team_id = $1

    # TODO: Add repo wise permission requirement to update accordingly
	# Validation
	repo_count=`wc -w < repos.txt`
	if [ $repo_count -gt $GITHUB_MAX_REQUESTS ]
	then
		echo "You are only allowed 5000 repos. See rate limitations https://developer.github.com/v3/#rate-limiting"
		exit 1
	fi

	echo "Executing \"add_repo\""
	CREATION_STATUS=""

	# Keeps array index in check
	curr=1

	# Keeps total count
	count=0

	# Main JSON object array
	result=("[")

	success_count=0
	failure_count=0

	# Read repos.txt line by line
	while p= read -r repo_name; do
		
		echo "Repo: $repo_name"

		# Making the API call and store the first line of info in res
		res=` curl -i -s -XPUT -d "{\"permission\": \"$\"}" https://api.github.com/orgs/$org_name/teams/$team_id/repos/$org_name/$repo_name -H "Accept: application/vnd.github.baptiste-preview+json" -H "Authorization: token $TOKEN" | head -1`

		# Fetch HTTP status code
		code=`echo $res | cut -d" " -f2`

		# Checking if request succeeded
		if [[ $code -eq 204 ]]
		then
			CREATION_STATUS=SUCCESS
			let "success_count++"
		else 
			CREATION_STATUS=FAILURE
			let "failure_count++"
		fi

		# Store the JSON for the countrent iteration
		result[$curr]='echo { \"repo_name\": \"$line\", \"status\": \"$CREATION_STATUS\", \"order_of_execution\": $count } | jq'

		# Increment count, add a comma in the end
		# Then increment it again for capturing the next object
		let "curr++"
		result[$curr]=","
		let "curr++"

		# Increment total count
		let "count++"

	done < ./repos.txt

	# Add trailing ']' to complete JSON array
	result[$curr]="]"

	# Remove the ',' from the last iteration 
	let "curr=curr-1"
	result[$curr]=""

	# Support "write to file" 
	if [[ $2 == "--out=json"  ]]
	then
		echo ${result[@]} > ./output/added_repo_out.json
	else
		echo ${result[@]}
	fi

	echo Success Count: $success_count
	echo Failure Count: $failure_count
	echo Total Count: $count

}


##  TODO: Get slug name from the team name

# team_add(){

# org_name=$GITHUB_ORGANIZATION_OWNER
# res = `curl -i -s -XGET https://api.github.com/orgs/$org_name/teams -H "Accept: application/vnd.github.baptiste-preview+json" -H "Authorization: token $TOKEN" | head -1`

# code=`echo $res | cut -d" " -f2`

# # Checking if request succeeded
# if [[ $code -eq 200 ]]
# then
#     echo "Fetched all the teams. Checking for slug name of the team"
# else 
#     echo "Error occured in fetching slug name"
# fi
  
# }
