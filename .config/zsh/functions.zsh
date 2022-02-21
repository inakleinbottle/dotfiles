

function mkd() {
	mkdir -p "$@" && cd "$_";
}

function pyenv() {
    local envs=("${(@f)$(fdfind activate --exec dirname {//} | uniq)}");
    print ${envs}
    print ${#envs}
    print ${envs[1]}
    if [[ ${#envs} -eq 0 ]]; then {
        python3.10 -m venv venv && source venv/bin/activate
    } elif [[ ${#envs} -eq 1 ]]; then {
        source "${envs[1]}/bin/activate"
    } else
        # TODO: Replace this with a menu selection followed by activation
        source "${envs[1]}/bin/activate"
    fi
}
