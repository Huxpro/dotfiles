# always sourced

# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

# make cd case-INsensitive
set completion-ignore-case
