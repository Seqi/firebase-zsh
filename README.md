# Zsh-firebase

Zsh-firebase is a plugin for Zsh to display the current working project when in a Firebase project directory. 

## Installation

Clone the repository into your oh-my-zsh plugin folder:

`git clone https://github.com/seqi/zsh-firebase ~/.oh-my-zsh/custom/plugins/firebase`

Then add it to your list of plugins in your `~/.zshrc`

`plugins=(git firebase)`

Finally, add the plugin output to your prompt, by opening your theme and adding the firebase status.

For example, 

`PROMPT='%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[yellow]%}%M:%{$fg[green]%}%/%{$reset_color%}$(git_prompt_info) %(!.#.$) '`

becomes

`PROMPT='%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[yellow]%}%M:%{$fg[green]%}%/%{$reset_color%}$(git_prompt_info) $(firebase_status) %(!.#.$) '`