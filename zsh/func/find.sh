#apt-cache search '' | sort | cut --delimiter ' ' --fields 1 | fzf --multi --cycle --reverse --preview 'apt-cache show {1}' | xargs -r sudo apt install -y

finder() {
	formater="formater-$(uname -s)-$(uname -m)"
	[ ! -x "$DOTFILES/bin/$formater" ] && return 1
	rg --color=always --line-number --no-heading --smart-case . "$OBSIDIAN_VAULT/200 Areas/01_CheatSheet" |
		fzf --ansi \
			--color "hl:-1:underline,hl+:-1:underline:reverse" \
			--delimiter : \
			--preview 'bat --color=always {1} --highlight-line {2}' \
			--preview-window 'up,99%,border-bottom,+{2}+3/3,~3' \
			--print0 | "$formater" ':' '2' | xclip -i -selection clipboard
	# pbcopy
}
