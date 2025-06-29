# Nemo Actions

This repository contains custom actions that are added to the right-click context menu in Nemo. Also check out my [Linux scripts repository](https://github.com/KobeW50/linux-scripts).

Please open an issue if you found bugs, have questions, or want to contribute. Thanks :)
___

# Setup

To use the actions in the repository, follow these steps:

1. Clone the repository:

```
# git needs to be installed in order to run this command
git clone https://github.com/KobeW50/nemo-actions.git

# If you decide to instead download files individually, remember to make the scripts executable.
```

2. Copy the `actions` directory to `~/.local/share/nemo/` (or `/usr/share/nemo/` if you want them to be system-wide):

```
# If you only want the actions for the current user
cp -r nemo-actions/actions ~/.local/share/nemo/

# If you want the actions for all users
sudo cp -r nemo-actions/actions ~/.local/share/nemo/
```

3. Restart Nemo and ensure that the actions you want are enabled in the Nemo plugin preferences settings.
___

# Actions

### 1. Make Shortcuts

This action is for users who hate that directory symbolic links (symlinks) in Nemo don't "Follow link to original file". Rather, Nemo shows you a mirror of the linked directory, from which you can't navigate to the parent of the linked directory. When you use this action while folders are selected, a script will create an application shortcut (ie: a `.desktop` file) that opens the folder in Nemo when clicked. The application shortcut is created in the directory you are currently in. If the action is used on files (ie: not folders), normal symlinks will be created for them.

**Demo**
<img src="/assets/make-shortcuts.gif" width="1200"/>

> [!NOTE]
>
> **Limitations:**
> - You can't copy/move items into the shortcut.
> - Folder shortcuts will open in a new tab instead of the current tab.
> - Applications don't treat the shortcuts as symlinks. The shortcuts are just meant for navigation within Nemo.
> - This action was only tested on Linux Mint 22 Cinnamon with Nemo 6.2.8.


### 2. Spacify

Trigger warning: This action replaces hyphens (`-`) and underscores (`_`) in filenames with spaces. It does not affect folder names.


### 3. Hyphenify

This action replaces spaces and underscores (`_`) in filenames with hyphens (`-`). It does not affect folder names.
