# goto

Command line tool to jump to a project in your workspace using its initials.

```bash
goto vsnb
~/code/vivo-stream-notification-bridge $
```

## Install

This code in the Digital Publishing team's [Homebrew tap](https://github.com/bbc/homebrew-dpub). If you are set up on that (see the documentation on the tap), you can just:

```
brew tap bbc/dpub
brew install bbc/dpub/goto
```

Alternatively, you can clone this repo.

After installing, add your configuration and an alias to your `.bashrc` or `.zshrc`.

```bash
export GOTO_WORKSPACE="$HOME/code"
export GOTO_IGNORE='professor-cam training'
alias goto="source $HOME/scripts/goto/goto.sh"
```

## Use

`goto` can be used to jump to a project in your workspace by its initials (where the folder name is hyphenated).
For example, `goto igm` is equivalent to `cd $GOTO_WORKSPACE/int-gel-matter`.

Providing the full name of a project also works, for example `goto professor-cam`.

Using `goto` with no arguments will take you to the root of your workspace.

## Configure

`goto` uses a couple of environment variables to find your project folders.

`GOTO_WORKSPACE` should be the folder containing your projects.
If not specified, this defaults to your home directory.

`GOTO_IGNORE` should be a space-separated list of folder in your workspace to ignore, in case of clashes.
For example, I'm using `'professor-cam training'` so that `goto pc` will match the `passport-control` project instead of `professor-cam`.
Note that you can still use the full name to bypass ignored projects, e.g. `goto professor-cam`.

## Extend

If you want to include folders not in the root of your workspace you can add these to the case statement in the second half of the script.
I've got one set up already to jump to the `passport-control-activity` package within `passport-control`.
