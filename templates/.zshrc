source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
alias cat='bat --theme=Dracula'
eval "$(starship init zsh)"
export GPG_TTY=$(tty)

ls() {
    # Call lsd and handle output line by line
    command lsd --color=always --icon=always "$@" | while IFS= read -r line; do
        # Extract file/directory name and ignore colors and icons
        dir=$(echo "$line" | sed 's/\x1b\[[0-9;]*m//g' | awk '{print $NF}')

        # Check if it's a directory
        if [ -d "$dir" ]; then
            # Check if it's a git directory
            if [ -d "$dir/.git" ]; then
                # Check if there is some work in the working directory
                (cd "$dir" && git diff --exit-code > /dev/null 2>&1)
                working_dir_status=$?

                # Check if there is some work in the staging area
                (cd "$dir" && git diff --cached --exit-code > /dev/null 2>&1)
                staging_area_status=$?

                # Build output with git status and emojis
                if [ $working_dir_status -eq 0 ] && [ $staging_area_status -eq 0 ]; then
                  echo "$line  ✅ [Nothing to commit, working tree clea]"
                elif [ $working_dir_status -eq 1 ] && [ $staging_area_status -eq 0 ]; then
                  echo "$line  📝 [Changes in working directory]"
                elif [ $working_dir_status -eq 0 ] && [ $staging_area_status -eq 1 ]; then
                  echo "$line  📦 [Changes in staging area]"
                elif [ $working_dir_status -eq 1 ] && [ $staging_area_status -eq 1 ]; then
                  echo "$line  🔄 [Changes in both working directory and staging area]"
                fi
            # It's not a git repository here
            else
                echo "$line ℹ️ [Not a git repository]"
            fi
        # It's not a directory here
        else
            # Show the default output
            echo "$line"
        fi
    done
}
