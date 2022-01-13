
set fish_greeting
set PATH $PATH /usr/local/go/bin
set PATH $PATH /home/mehran/go/bin
set PATH $PATH /home/mehran/.cargo/bin
set PATH $PATH /home/mehran/.yarn/bin
abbr -a ws 'sudo systemctl start windscribe'
abbr -a wind 'windscribe connect'
set TERMINAL (which nvim)
set EDITOR (which nvim) 
#-----------------------------------------------------
#Aliases
#-------------------------------------------------------
alias nn="nvim"
# alias lf lfrun
alias color "colorscript random"
alias ll "exa --icons -l -g"
alias tlmgr "/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end
#
# Nightfox Color Palette
# Style: nightfox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/nightfox/nightfox_fish.fish
set -l foreground cdcecf
set -l selection 283648
set -l comment 526175
set -l red c94f6d
set -l orange f4a261
set -l yellow dbc074
set -l green 81b29a
set -l purple 9d79d6
set -l cyan 63cdcf
set -l pink d67ad2

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

  
