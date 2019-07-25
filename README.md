# Zsh-firebase :fire:

Zsh-firebase is a configurable plugin for Zsh to display the current working project or project alias when in a Firebase project directory or subdirectory. Never push to production accidentally again! 

![](https://i.imgur.com/nsFsCjS.jpg)

![](https://i.imgur.com/cjyNV56.jpg)

![](https://i.imgur.com/mdMWsRk.jpg)

## Installation

Clone the repository into your oh-my-zsh plugin folder:

`git clone https://github.com/seqi/zsh-firebase ~/.oh-my-zsh/custom/plugins/firebase`

Then add it to your list of plugins in your `~/.zshrc`

`plugins=(git firebase)`

Finally, add the plugin output to your prompt, by opening your theme and adding the firebase project.

For example, 

`PROMPT='%{$fg[cyan]%}%n%{$reset_color%}:$(git_prompt_info) %(!.#.$) '`

becomes

`PROMPT='%{$fg[cyan]%}%n%{$reset_color%}:$(git_prompt_info) $(firebase_project)%(!.#.$) '`

The output has a trailing space, so position the output accordingly. 

## Themeing

Zsh-firebase can take in 2 parameters to account for all kinds of terminal themes you may use. The first parameters specifies the format of the display of the project id. The second parameter controls the text itself.

For example:

`$(firebase_project)`
`$(firebase_project round bold)`
`$(firebase_project square)`

### Formats
The supported formats are:

#### round (default)
![](https://i.imgur.com/iTb74H6.jpg)

#### plain 
![](https://i.imgur.com/xnYmpE1.jpg)

#### square 
![](https://i.imgur.com/lW8uN2T.jpg)

#### prefix 
![](https://i.imgur.com/cYRVdmP.jpg)

#### prefix-round
![](https://i.imgur.com/6GxbMwX.jpg)

#### prefix-square 
![](https://i.imgur.com/YmhNGi9.jpg)

### Text

The output can either be in standard text, or can be made bold by passing in the `bold` value for the second parameter.

####`$(firebase_project round)` 

![](https://i.imgur.com/iTb74H6.jpg)

####`$(firebase_project round bold)` 

![](https://i.imgur.com/dbeNDSf.jpg)

## Contributing

Changes are welcomed. If you have an issue, please feel free to raise it in the issues section. If you wish to make a contribution, please create a corresponding issue. 

## License 
[MIT](https://choosealicense.com/licenses/mit/)