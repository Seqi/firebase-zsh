function firebase_project() {
	if [[ $(is_firebase_project) ]]
	then		
		# Check the global firebase config file as priority
		local config_project_id=$(get_firebase_config_project_id)
		if [[ -n $config_project_id ]]
		then
			echo "$config_project_id "

		# If nothing in the firebase config file, use the default value set in .firebaserc
		else
			local firebaserc_project_id=$(get_firebaserc_project_id "default")
			echo "$firebaserc_project_id "
		fi
	fi	
}

function is_firebase_project() {
	if [[ -e firebase.json ]]
	then
		echo 1
	fi
}

########## Config File ##########
function get_firebase_config_project_id() {
	if [[ $(firebase_config_exists) ]]
	then
		local config_project_id=$(get_firebase_config_project)
		echo "$config_project_id"
	fi
}

function firebase_config_exists() {
	if [[ -e ~/.config/configstore/firebase-tools.json ]]
	then
		echo 1
	fi	
}

# May be either the project id itself or an alias (which lives in .firebaserc)
function get_firebase_config_project() {
	echo $(grep -s $(git rev-parse --show-toplevel) ~/.config/configstore/firebase-tools.json | cut -d'"' -f 4)
}

########## Firebaserc ##########
function get_firebaserc_project_id() {
	echo $(grep $1 .firebaserc | cut -d'"' -f 4)
}