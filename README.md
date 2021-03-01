Xuan's dotfiles
===============

I maintained this for my personal use, but you're welcome to borrow any part of it ;)

My personal setup instructions for a [💻 new mac](./NEW_MAC.md) or [☁️  new server](./NEW_SERVER.md).



🎨 Screenshots
--------------

> Each theme can be toggled between its light and dark variants via `:Light` and `:Dark` commands.
> 
> Personally, I prefer the light mode of the _PaperColor_ and the dark mode of the _One_.

The _One_ theme (only works on 24-bit *true color* terminal and *true color* vim):
![screenshot](./scrshot-one.png)

The _Solarized_ theme (only works on 8-bit 256 colors terminal, e.g. MacOS's `Terminal.app`):
![screenshot](./scrshot-sol.png)

The _PaperColor_ theme. (works on both)
![screenshot](./scrshot-paper.png)

### Check is your terminal support *true color*

```
printf "\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
```

Read more at <https://gist.github.com/XVilka/8346728#terminal-colors>


### Check if your vim support *true color* 

`vim --version` will print if `termguicolors` is included (+) or not (-):

```
# macOS built-in is pre-built with true color turned off:
λ /usr/bin/vim --version | grep 'termguicolors'
+autocmd           +find_in_path      +mouse_xterm       -termguicolors

# brew install vim
λ /usr/local/bin/vim --version | grep 'termguicolors'
-autoservername    +folding           +multi_byte        +termguicolors
```

Neovim is usually built with `termguicolors` turned on.


⚠️ For Whoever Not Me Reading/Using This
---------------------------------------

### Amend the Git configuration!

Although git auth users by their github username/password, the commits are tracked by the email recorded on your local `git config`. Please follow [Why are my commits linked to the wrong user?
](https://help.github.com/en/github/committing-changes-to-your-project/why-are-my-commits-linked-to-the-wrong-user) to change the email:

```sh
$ git config --global user.email "email@example.com"
```

### VSCode Auto Settings Sync

If you forked and used an older version of this setup where `~/Library/Application\ Support/Code/User/settings.json` is linked to `path/to/dotfiles/vscode/settings.json`. You will need to first `rm ~/Library/Application\ Support/Code/User/settings.json` to remove the link so the VSCode Auto Setting can synchronize correctly.


References
----------

This dotfiles (especially the older version) shamelessly borrow a lot from the web. (Thx, the internet!)

* <https://dotfiles.github.io/>
* <https://github.com/nicksp/dotfiles>
* <https://github.com/necolas/dotfiles>
* <https://github.com/paulirish/dotfiles>
