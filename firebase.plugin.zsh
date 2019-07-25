function firebase_project() {
	local project_id=$(get_firebase_project)
	if [[ -n $project_id ]]
	then
		### Set Color ###
		local color=$fg[yellow]
		local style=$2

		if [[ $style == "bold" ]]
		then
			color=$fg_bold[yellow]
		fi

		### Set Prompt  ###
		# project
		if [[ $1 == 'plain' ]]
		then
			local str=%{$color%}"$project_id"%{$reset_color%}
			echo "$str "

		# [project]
		elif [[ $1 == 'square' ]]
		then
			local str=%{$color%}"[$project_id]"%{$reset_color%}			
			echo "$str "

		# fb:project
		elif [[ $1 == 'prefix' ]]
		then
			local str=%{$color%}"fb:$project_id"%{$reset_color%}
			echo "$str "

		# fb:(project)
		elif [[ $1 == 'prefix-round' ]]
		then
			local str=%{$color%}"fb:($project_id)"%{$reset_color%}
			echo "$str "

		# fb:[project]
		elif [[ $1 == 'prefix-square' ]]
		then
			local str=%{$color%}"fb:[$project_id]"%{$reset_color%}
			echo "$str "

		# (project)
		else 			
			local str=%{$color%}"($project_id)"%{$reset_color%}
			echo "$str "
		fi
	fi
}

function get_firebase_project() {
	if [[ $(is_firebase_project) ]]
	then		
		# Check the global firebase config file as priority
		local config_project_id=$(get_config_project_id)
		if [[ -n $config_project_id ]]
		then
			echo "$config_project_id"

		# If nothing in the firebase config file, use the default value set in .firebaserc
		else
			local firebaserc_project_id=$(get_rc_project_id "default")
			echo "$firebaserc_project_id"
		fi
	fi	
}

function is_firebase_project() {
	local firebase_dir=$(get_firebase_dir)
	if [[ -n $firebase_dir ]]
	then
		echo 1
	fi
}

function get_firebase_dir() {
	local dir="$(pwd)"
	
	# Keep checking up, we may be in a subdir
	while [[ $dir != '/' ]]
	do
		local target="$dir/firebase.json"

		if [[ -e $target ]]
		then
				echo $dir
				break
		else
				dir=$(dirname $(realpath $dir))
		fi
	done
}

function get_config_project_id() {
	if [[ -e ~/.config/configstore/firebase-tools.json ]]
	then
		# May be either the project id itself or an alias (which lives in .firebaserc)
		local target=$(get_firebase_dir)
		echo $(grep -s $target ~/.config/configstore/firebase-tools.json | cut -d'"' -f 4)
	fi
}

function get_rc_project_id() {
	local rc_path="$(get_firebase_dir)/.firebaserc"
	echo $(grep $1 $rc_path | cut -d'"' -f 4)
}