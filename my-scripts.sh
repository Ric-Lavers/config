alias myip="PROMPT_EOL_MARK='' curl 'https://api.ipify.org?format=text'" 
alias teamsfx="/Users/riclavers/.yarn/bin/teamsfx"
alias teamfx="/Users/riclavers/.yarn/bin/teamsfx"
nvm use 18

gct_last(){
  last="$(git log -1 --pretty=%B)"
  git reset HEAD~1

  git add ':!*.test.[ts,js,tsx,jsx]'
  git commit -m  $last
  
  git add '*.test.[ts,js,tsx,jsx]'
  git commit -m "${last/feat/test}"
}

web(){
  open -n -a "Google Chrome" "$1" 
}

alias gcom="git checkout main"
alias teamfx=teamsfx

gct(){
  while getopts ":m:msg:" opt; do
    case $opt in
      m)
        msg=$OPTARG
        echo $msg
        ;;
      \?)
      ;;
    esac
  done 
 # git add *.test.[tj][s,sx]
}

create_branch(){
  echo -e "select PR type.\n"
  select type in ${types[@]}
    do
    t=$type
    break
    done
  echo "${type}/{id}--{scope}"
  echo -e "Enter ticket id. (or leave blank)"
  read;
  id=$REPLY
  if [ -n "$id" ]; then
    id=$(echo "$id" | tr '[:lower:]' '[:upper:]' | sed 's/$/--/')
  fi
  echo "${type}/${id}{scope}"
  echo -e "Enter the scope?"
  read;
  scope=$REPLY
  

  echo "${type}/${id}${scope}"
  git checkout -b "${type}/${id}${scope}"
}

# select from  the last 5 used branches to git checkout 
gcor(){

  arr=()
  while read -r line; do
    arr+=("$line")
  done <<< $(git for-each-ref --format='%(refname:short)' refs/heads --sort=committerdate | tail -5)

  list=()
  for i in "${arr[@]}"
  do
    list=("$i" "${list[@]}")
  done

  select x in $list;
    do
      branch=$x
      break
    done

  if [ -n "$branch" ]; then
    git checkout $branch
  else
    gcor
  fi
}
gname(){
 name="$(git log -1 --pretty=%B)"
}
_squashlast() {
  last="$(git log -1 --pretty=%B)"
  git reset HEAD~1
  git add .
  git commit -m $last
}

squash_previous() {
	if [[ "$#" == 1 ]]; then
  	  hash="$1"
	fi
echo "$1" 
	if [[ "$#" == 0 ]]; then
	  read -p "Enter commit hash: " hash;
	fi

	
	c_msg=$(git log --format=%B -n 1 $hash)
	
	git reset $hash
	git add .
	git commit --amend -m "$c_msg"
}

prodSubscription=''
stgSubscription=''
devSubscription=''
localSubscription=''

ms_az_login(){
  teamsfx account login m365 ;
  teamsfx account login azure ;
}

teamsfx_login(){
  devDomain="7jqq62"
  prodDomain="hybridhealthy"
  y=$(echo $(teamsfx account show) | head -n 1)

  if [[ "$y" == *"$prodDomain"* ]]; then
    isProdTenant=true
  else 
    isProdTenant=false
  fi

  if [ "$1" = "prod" ]; then
    if [ "$isProdTenant" != true ]; then
      ms_az_login
    fi
    teamsfx account set --subscription $prodSubscription
  elif [ "$1" = "stg" ]; then
    if [ "$isProdTenant" != true ]; then
      ms_az_login
    fi
    teamsfx account set --subscription $stgSubscription
  elif [ "$1" = "dev" ]; then
   if [ "$isProdTenant" != true ]; then
      ms_az_login
    fi
    teamsfx account set --subscription $devSubscription
  elif [ "$1" = "local" ]; then
    if [ "$isProdTenant" == true ]; then
      ms_az_login
    fi
    teamsfx account set --subscription $localSubscription
  elif [ "$1" = "olddev" ]; then
    if [ "$isProdTenant" == true ]; then
      ms_az_login
    fi
    teamsfx account set --subscription $localSubscription
  else
    echo "Invalid argument. Please provide 'prod', 'dev', 'stg' or 'local'."
  fi
}
