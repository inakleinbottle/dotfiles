zmodload zsh/zutil

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


function new-git-repo() {
    local name=$1
    [[ $name == *.git ]] || name+=.git
    print "Create new git repository $name"
    ssh inakleinbottle-git "git init --bare $name" > /dev/null
#    if [ $? ]
#        print "Failed"
#    fi
}



function new-ssh-key() {
    zparseopts -D -E -F     \
        t:=ktype         \
        || return 1

    if (( $#ktype )); then
        keytype=$ktype[-1]
    else
        keytype=rsa
    fi
    echo "Key type $keytype"

    if [ -z $#@  ]; then
        echo "At least one key name must be provided"
        return 1
    fi

    use_bw=0
    if bw unlock --check 2>&1 > /dev/null; then
        use_bw=1
        bw_folder_id=$(bw get folder ssh | jq .id)
    else
        echo "Bitwarden is not installed or vault is locked"
    fi


    for keyname in $@; do
        filename=$HOME/.ssh/$keyname
        if [ -e $filename ]; then
            echo "key $filename already exists, skipping"
            continue
        fi
        echo "Creating key: $keyname ($filename)"

        opts=(
            -t $keytype
            -f $filename
            -C "$(uname -n)-$keyname"
        )
        

        if [[ $use_bw -eq 1 ]]; then 
            # If bitwarden CLI is installed and unlocked
            # then use it to set the password and save it
            # in the vault
            local npwd=$(bw generate)
            local login_dtls=$(bw get template item.login \
                | jq ".username=null|.totp=null|.password=\"${npwd}\"")
            
            entry=$(bw get template item \
                | jq ".name=\"$(uname -n)-${keyname}\"|.login=${login_dtls}|.folderId=${bw_folder_id}" \
            )

            opts+=(-N $npwd)
        fi

        ssh-keygen ${opts}

        if [[ $usebw -eq 1 ]]; then 
            # If we used bw to generate a password, append the public key to the
            # record in the vault
            echo $entry \
                | jq ".notes=\"$(cat ${filename}.pub)\"" \
                | bw encode \
                | bw create item \
                > /dev/null
        fi


    done

}   




function checksum() {
    if [[ -z "$#" ]] || [[ -z "$1" ]]; then
        echo "checksum <target file> <target_sum> [<bit length> default 256]"
        return 1
    fi

    local target_file="$1"
    local target_sum="$2"
    local bit_length="${3:-256}"

    local computed=$(shasum -a ${bit_length} ${target_file} | cut -d' ' -f1)

    if [[ "$computed" != "$target_sum" ]]; then
        echo "Mismatched checksum for file ${target_file}:"
        echo "Computed: ${computed}"
        echo "Given:    ${target_sum}"
        return 1;
    else
        echo "Checksum match"
        return 0
    fi
}
