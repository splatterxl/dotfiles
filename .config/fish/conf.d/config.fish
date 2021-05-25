function is_false
    $argv
    if [ $status = 0 ]
        return 1
    else
        return 0
    end
end
# Defined in /usr/share/fish/functions/fish_prompt.fish @ line 4
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l normal (set_color normal)

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l prefix
    set -l suffix '>'
    if contains -- $USER root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end
    set -l on ""
    set -l vcs (fish_vcs_prompt)
    if is_false [ -z "$vcs" ]
        set on (set_color $fish_color_param)" on """
    else
        set on " "
    end

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus " [" "]" " | " (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    echo -n -s "[" (set_color $fish_color_user) "$USER" $normal ] " " (set_color $color_cwd) (prompt_pwd) $normal $on $vcs $normal $prompt_status $suffix " "
end


"starship" init fish | .
