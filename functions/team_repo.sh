# TODO: Get slug name from the team name

team_add(){

  org_name=$GITHUB_ORGANIZATION_OWNER
  res = `curl -i -s -XGET https://api.github.com/orgs/$org_name/teams -H "Accept: application/vnd.github.baptiste-preview+json" -H "Authorization: token $TOKEN" | head -1`
  code=`echo $res | cut -d" " -f2`
# Checking if request succeeded
  if [[ $code -eq 200 ]]
  then
    echo "Fetched all the teams. Checking for slug name of the team"
  else 
    echo "Error occured in fetching slug name"
  fi 
}
