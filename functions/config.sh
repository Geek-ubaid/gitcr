read_var(){
    VAR=$(grep $1 $2 | xargs)
    IFS="=" read -ra VAR <<< "$VAR"
    echo ${VAR[1]}
}

MY_VAR=$(read_var PERMISSION .env)

#template_name=$GITHUB_TEMPLATE_NAME
#template_owner=$GITHUB_TEMPLATE_OWNER
#owner_name=$GITHUB_ORGANIZATION_OWNER
#token=$GITHUB_PERSONAL_ACCESS_TOKEN
#repo_permission=$PERMISSION
#team_id=$GITHUB_TEAM_SLUG_NAME
#GITHUB_MAX_REQUESTS=5000
