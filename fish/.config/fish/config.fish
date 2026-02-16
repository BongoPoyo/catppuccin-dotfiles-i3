if status is-interactive
    # Commands to run in interactive sessions can go here
end

export PATH="$HOME/.cargo/bin:$PATH"

# run starship
starship init fish | source
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
