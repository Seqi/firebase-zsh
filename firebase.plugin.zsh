function firebase_project() {
	local project_id=$(get_firebase_project)

	if [[ -n $project_id ]]
	then
		## Set color
		[[ "$FIREBASE_ZSH_TEXT" = "bold" ]] && color=$fg_bold[yellow] || color=$fg[yellow]

		local fire="\U1F525"
		if [[ "$FIREBASE_ZSH_ICON" == "true" ]]
		then
			project_id="$fire $project_id"
		fi

		project_id=$(decorate_str "$project_id" "$FIREBASE_ZSH_STYLE")
		
		### Set Prompt  ###
		project_id="%{$color%}"$project_id"%{$reset_color%}"

		# Add trailing space
		if [[ "$FIREBASE_ZSH_TRAILING_SPACE" == "true" ]]
		then
			echo "$project_id "
		elif [[ "$FIREBASE_ZSH_LEADING_SPACE" == "true" ]]
		then
			echo " $project_id"
		else
			echo $project_id
		fi
	fi
}

function decorate_str() {
	local project_id=$1
	local style=$2

	if [[ $style == 'plain' ]]
	then
		echo "$project_id"

	# [project]
	elif [[ $style == 'square' ]]
	then
		echo "[$project_id]"

	# fb:project
	elif [[ $style == 'prefix' ]]
	then
		echo "fb:$project_id"

	# fb:(project)
	elif [[ $style == 'prefix-round' ]]
	then
		echo "fb:($project_id)"

	# fb:[project]
	elif [[ $style == 'prefix-square' ]]
	then
		echo "fb:[$project_id]"

	# (project)
	else 			
		echo "($project_id)"
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
				dir=$(dirname ${dir:A})
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