# Neovim configuration

## Requirements

- Requirements for Telescope and language servers: `brew install fzf ripgrep fd node`
- Requirements for Xcode plugin: `brew install xcode-build-server xcbeautify` and `gem install xcodeproj --user-install`

In `~/.zshrc` file write a method so we can press Ctrl-n to open the config switcher and some alias pointing directly are created.

```
# NeoVim configuration
#
alias nvim-minimal="NVIM_APPNAME=nvim/distros/minimal nvim"
alias nvim-lazy="NVIM_APPNAME=nvim/distros/lazy nvim"
alias nvim-chad="NVIM_APPNAME=nvim/distros/chad nvim"

function nvim-config() {
    items=("minimal" "lazy" "chad")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    fi

    NVIM_APPNAME=nvim/distros/$config nvim $@
}

bindkey -s ^n "nvim-config\n"
```

In `init.lua` there is a minimal configuration when `nvim` command is used.
