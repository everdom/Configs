set -e fish_greeting

# emacs ansi-term support
if test -n "$EMACS"
  set -x TERM eterm-color
end

# this function may be required
function fish_title
  true
end


test -s /home/everdom/.nvm/nvm.fish; and source /home/everdom/.nvm/nvm.fish
