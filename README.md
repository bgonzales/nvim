# Neovim configuration

## Requirements

- brew install fzf
- For telescope: brew install ripgrep fd
- Install language servers: brew install node

In `~/.zshrc` file write a method so we can press Ctrl-n to open the config switcher and some alias pointing directly are created.

```
alias nvim-editor="NVIM_APPNAME=nvim/editor nvim"
alias nvim-lazy="NVIM_APPNAME=nvim/lazy nvim"

function nvim-config() {
    items=("editor" "lazy")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    fi

    NVIM_APPNAME=nvim/$config nvim $@
}

bindkey -s ^n "nvim-config\n"
```

In `init.lua` there is a minimal configuration when `nvim` command is used.
