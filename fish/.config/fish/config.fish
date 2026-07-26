if status is-interactive
    # Commands to run in interactive sessions can go here
end

export PATH="$HOME/.cargo/bin:$PATH"

# run starship
starship init fish | source
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

fish_add_path /home/bongo/.spicetify

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end
