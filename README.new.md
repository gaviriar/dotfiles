# Ricardo's dotfiles

Personal macOS dotfiles for shell configuration, development tools, and productivity.

## 🚀 Quick Start

```bash
git clone https://github.com/gaviriar/dotfiles.git ~/dotfiles/ricardogaviria
cd ~/dotfiles/ricardogaviria
./symlink-setup.sh
```

**⚠️ Warning:** Review the code before running! Don't blindly use these settings.

---

## 📁 File Organization Guide

### 🎯 Core Shell Files (Load Order)

#### `.bash_profile` — **Login Shell Entry Point**
- **Purpose:** First file loaded when you open a new terminal
- **What to put here:** Nothing! It orchestrates loading of other files
- **Sources:** `.path`, `.bash_prompt`, `.exports`, `.aliases`, `.functions`, `.extrarc`, `.vault`
- **When it runs:** Once per terminal session (login shells)

#### `.bashrc` — **Non-Login Shell Config**
- **Purpose:** Runs for non-login shells (scripts, nested shells)
- **What to put here:** Nothing! It just sources `.bash_profile` for consistency
- **When it runs:** Every time a new shell is spawned

#### `.bashrc_custom` — **Local Overrides**
- **Purpose:** Machine-specific customizations
- **What to put here:** Settings that override defaults but you don't want to commit
- **Example:** Custom PATH additions, local tool configurations

---

### 🔧 Configuration Files (What Goes Where)

#### `.path` — **📍 PATH and Environment Setup**
- **Purpose:** All PATH modifications and environment paths
- **What to put here:**
  - Custom binary directories: `export PATH=$HOME/bin:$PATH`
  - Tool installations: RVM, Heroku, CUDA, dotnet
  - Directory exports: `MY_CELLAR_DIR`, etc.
- **Examples:**
  ```bash
  export PATH=/usr/local/bin:$PATH
  export PATH=$HOME/.rvm/bin:$PATH
  export MY_CELLAR_DIR="~/my_cellar"
  ```

#### `.exports` — **🌍 Environment Variables**
- **Purpose:** Shell behavior and tool configuration variables
- **What to put here:**
  - Editor settings: `VISUAL`, `EDITOR`
  - History configuration: `HISTSIZE`, `HISTCONTROL`, `HISTIGNORE`
  - Tool settings: `LESS_TERMCAP_*`, locale settings
  - Color schemes: `LS_COLORS`, `dircolors`
- **Examples:**
  ```bash
  export EDITOR='vim'
  export HISTSIZE=32768
  export HISTIGNORE="ls:cd:pwd:exit"
  ```

#### `.aliases` — **⚡ Command Shortcuts**
- **Purpose:** Short commands and safer command defaults
- **What to put here:**
  - Command shortcuts: `alias ll='ls -la'`
  - Safety aliases: `alias rm='rm -i'`
  - Navigation shortcuts: `alias ..='cd ..'`
  - Tool-specific aliases: git, docker, etc.
- **Examples:**
  ```bash
  alias gs='git status'
  alias rm='rm -i'
  alias dl='cd ~/Downloads'
  ```

#### `.functions` — **🔨 Custom Shell Functions**
- **Purpose:** Complex commands that need logic
- **What to put here:**
  - Multi-step operations
  - Functions with parameters
  - Conditional logic
- **Examples:**
  ```bash
  function md() { mkdir -p "$@" && cd "$@"; }
  function extract() { # extract any archive }
  function cdf() { # cd to Finder location }
  ```

#### `.bash_prompt` — **🎨 Terminal Prompt Customization**
- **Purpose:** How your command prompt looks
- **What to put here:**
  - PS1 configuration
  - Color definitions
  - Git branch display
  - Prompt symbols and formatting
- **Don't touch unless:** You want to change prompt appearance

#### `.extrarc` — **🔐 Secrets & Third-Party Tools**
- **Purpose:** Sensitive data and auto-generated tool configs
- **What to put here:**
  - API keys and tokens
  - Work-specific configurations (D360, etc.)
  - Auto-generated tool setup (nvm, rbenv, pyenv)
  - Credentials for services
  - PATH additions from package managers
- **⚠️ NEVER COMMIT THIS FILE** (should be in .gitignore)
- **Examples:**
  ```bash
  export D360_APIKEY="..."
  export AWS_ACCESS_KEY="..."
  # NVM auto-generated setup
  export NVM_DIR="$HOME/.nvm"
  eval "$(rbenv init - bash)"
  ```

#### `.vault` — **🔒 Additional Secrets**
- **Purpose:** Alternative location for sensitive data
- **What to put here:** Same as `.extrarc`, personal preference
- **⚠️ NEVER COMMIT THIS FILE**

---

### ⚙️ Tool-Specific Configs

#### `.gitconfig` — **Git Configuration**
- **What to put here:**
  - User name and email
  - Git aliases: `s = status -s`, `co = checkout`
  - Diff/merge tools
  - Push/pull defaults

#### `.vimrc` — **Vim Editor Settings**
- **What to put here:**
  - Editor preferences
  - Key mappings
  - Plugins
  - Color schemes

#### `.inputrc` — **Readline Configuration**
- **What to put here:**
  - Keyboard shortcuts
  - Tab completion behavior
  - History search settings

#### `.screenrc` — **GNU Screen Settings**
- **What to put here:**
  - Screen keybindings
  - Status bar configuration
  - Multi-terminal settings

#### `.pythonrc` — **Python REPL Config**
- **What to put here:**
  - Interactive Python settings
  - Auto-imports for REPL
  - Tab completion

#### `.dircolors` — **Directory Color Scheme**
- **What to put here:**
  - File type colors for `ls` command
  - Usually managed by LS_COLORS

#### `.gitattributes` & `.gitignore` — **Git Repository Settings**
- **What to put here:**
  - Files to ignore in git
  - Line ending preferences
  - Diff/merge strategies

---

### 🛠️ Installation Scripts

#### `symlink-setup.sh` — **Deploy Dotfiles**
- Symlinks all dotfiles to `~` directory
- **Run this:** After cloning repo or changing files

#### `setup-a-new-machine.sh` — **New Machine Setup**
- Complete setup for a fresh macOS install
- Installs tools and configures system

#### `bootstrap.sh` — **Quick Bootstrap**
- Pulls latest changes and copies files

#### `brew.sh` — **Homebrew Packages**
- Installs all Homebrew formulas and casks

#### `install.sh` — **General Installation**
- Master installation script

#### `packages.txt` — **Package List**
- List of packages to install

---

## 🧠 Loading Order Quick Reference

```
Terminal Opens
    ↓
.bash_profile (loads once)
    ↓
Sources in order:
    1. .path          → Add directories to PATH
    2. .bash_prompt   → Set prompt appearance
    3. .exports       → Set environment variables
    4. .aliases       → Load command shortcuts
    5. .functions     → Load custom functions
    6. .extrarc       → Load secrets & 3rd party tools
    7. .vault         → Load additional secrets
    ↓
Then initializes:
    - z (directory jumper)
    - Git completion
    - History settings
```

---

## 🎯 Quick Decision Guide: "Where Should I Put This?"

| What I'm Adding | Where It Goes | Example |
|----------------|---------------|---------|
| API key or secret | `.extrarc` or `.vault` | `export D360_APIKEY="..."` |
| New command shortcut | `.aliases` | `alias gp='git push'` |
| Add directory to PATH | `.path` | `export PATH=$HOME/bin:$PATH` |
| Complex function with logic | `.functions` | `function md() { ... }` |
| Environment variable | `.exports` | `export EDITOR='vim'` |
| Git alias or setting | `.gitconfig` | `co = checkout` |
| Editor preference | `.vimrc` | `set number` |
| Tool auto-generated config | `.extrarc` | NVM, rbenv, pyenv init |
| Change prompt colors | `.bash_prompt` | PS1 customization |
| History settings | `.exports` | `export HISTSIZE=32768` |
| Safety wrapper | `.aliases` | `alias rm='rm -i'` |

---

## 📚 Bash Concepts

### Login vs Non-Login Shells

- **Login Shell** (`.bash_profile`): Opened when you first log in or open terminal
- **Non-Login Shell** (`.bashrc`): Opened for scripts, subshells, or screen sessions

### Why This Setup Matters

1. `.bash_profile` runs once per session → Use for PATH, environment setup
2. `.bashrc` runs for each shell → We make it source `.bash_profile` for consistency
3. This ensures all shells (login and non-login) have the same environment

### Shell Initialization Flow

When Bash starts as an **interactive login shell**:
1. Reads `/etc/profile`
2. Looks for `~/.bash_profile`, `~/.bash_login`, or `~/.profile` (in that order)
3. Reads the first one found

When Bash starts as an **interactive non-login shell**:
1. Reads and executes `~/.bashrc`

Our setup: `.bashrc` sources `.bash_profile`, so both paths work consistently!

---

## 🔍 Common Tasks

### Adding a New Tool to PATH
Edit `.path`:
```bash
export PATH=$HOME/my-tool/bin:$PATH
```

### Creating a New Alias
Edit `.aliases`:
```bash
alias myalias='command --with-flags'
```

### Setting Environment Variable
Edit `.exports`:
```bash
export MY_VAR="value"
```

### Adding Work Credentials
Edit `.extrarc`:
```bash
export WORK_API_KEY="secret123"
```

### Creating a Complex Function
Edit `.functions`:
```bash
function myfunction() {
  # Your logic here
}
```

---

## 🙏 Credits

* [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
* [Paul Irish](https://github.com/paulirish/dotfiles)
* [Balaji S. Srinivasan - Startup Class](https://github.com/startup-class/setup)

---

## 📖 Further Reading

- [Bash Profile vs Bashrc](http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html)
- [Bash Startup Files](https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html)
- [Advanced Bash Scripting Guide](https://tldp.org/LDP/abs/html/)
