<h1 align="center">term.nvim</h1>

<div>
  <h4 align="center">
    <a href="#dependencies">Dependencies</a> ·
    <a href="#installation">Installation</a> ·
    <a href="#usage">Usage</a> ·
    <a href="#keybindings">Keybindings</a>
  </h4>
</div>

<div align="center">
  <a href="https://github.com/marco-souza/term.nvim/releases/latest"
    ><img
      alt="Latest release"
      src="https://img.shields.io/github/v/release/marco-souza/term.nvim?style=for-the-badge&logo=starship&logoColor=D9E0EE&labelColor=302D41&&color=d9b3ff&include_prerelease&sort=semver"
  /></a>
  <a href="https://github.com/marco-souza/term.nvim/pulse"
    ><img
      alt="Last commit"
      src="https://img.shields.io/github/last-commit/marco-souza/term.nvim?style=for-the-badge&logo=github&logoColor=D9E0EE&labelColor=302D41&color=9fdf9f"
  /></a>
  <a href="https://github.com/neovim/neovim/releases/latest"
    ><img
      alt="Latest Neovim"
      src="https://img.shields.io/github/v/release/neovim/neovim?style=for-the-badge&logo=neovim&logoColor=D9E0EE&label=Neovim&labelColor=302D41&color=99d6ff&sort=semver"
  /></a>
  <a href="http://www.lua.org/"
    ><img
      alt="Made with Lua"
      src="https://img.shields.io/badge/Built%20with%20Lua-grey?style=for-the-badge&logo=lua&logoColor=D9E0EE&label=Lua&labelColor=302D41&color=b3b3ff"
  /></a>
</div>
<hr />

A Neovim plugin for managing multiple terminal sessions with an interactive dashboard. Run, monitor, and control multiple terminal instances directly from your editor.

## Features

- Manage multiple terminal sessions simultaneously
- Interactive dashboard with dual-pane layout
  - Left panel: Terminal session list with status indicator (20% width)
  - Right panel: Active terminal display with full terminal emulation (80% width)
- Commands: `:Term <cmd>`, `:Term`, `:Term list`, `:Term open`
- Create, switch, and close terminal sessions
- Rename sessions and navigate between them
- Sessions persist after dashboard closure
- Seamless integration with `nui.nvim` and `plenary.nvim`

## Dependencies

- [nui.nvim](https://github.com/MunifTanjim/nui.nvim) - UI components
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - Lua utilities

## Installation

Install with your preferred package manager:

### Using lazy.nvim

```lua
{
  "marco-souza/term.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require("term").setup()
  end,
}
```

## Usage

### Commands

The plugin provides the following commands:

- `:Term <cmd>` - Create and open a terminal with the specified command
- `:Term` - Open the dashboard with all active sessions
- `:Term open` - Open the dashboard with the last active session
- `:Term list` - List all active terminal sessions in a notification

### Examples

```vim
:Term npm start           " Creates and displays a new terminal running npm start
:Term python script.py    " Creates a terminal running a Python script
:Term                     " Opens the dashboard with all active sessions
:Term open                " Opens the dashboard with the last active session
:Term list                " Shows list of all active terminals
```

## Dashboard Navigation

Once the dashboard is open, you have a dual-pane interface:

**Left Panel - Session List**
- Shows all active terminal sessions
- `*` marker indicates the currently active session
- Displays useful keybindings reference

**Right Panel - Terminal**
- Full terminal emulation
- All keyboard input is forwarded to the terminal
- Terminal persists when dashboard is closed

### Keybindings

#### Global (both panels)
| Key | Action |
|-----|--------|
| `q` | Close dashboard (sessions continue running) |

#### Session Navigation (all modes)
| Key | Action |
|-----|--------|
| `<S-j>` | Switch to next session |
| `<S-k>` | Switch to previous session |
| `<S-c>` | Create a new terminal session |
| `<S-r>` | Rename current session |
| `<S-x>` | Delete current session |

#### Terminal Mode
- All keys are forwarded to the active terminal
- Navigation shortcuts still work while in terminal

## Configuration

Setup with default options:

```lua
require("term").setup({
  margin = 2  -- Margin around the dashboard (default: 2)
})
```

## Architecture

The plugin is organized as follows:

```
lua/term/
├── init.lua           # Plugin entry point
├── cmd.lua            # Command definitions and routing
├── types.lua          # Type definitions
├── ui/
│   └── dashboard.lua  # Dashboard UI (nui.nvim layout)
└── utils/
    └── terminal.lua   # Terminal session management
```

### Session Lifecycle

1. **Create**: Use `:Term <cmd>` to spawn a new session
2. **Manage**: Sessions are tracked independently and can be switched via dashboard
3. **Persist**: Sessions continue running even after dashboard is closed with `q`
4. **Close**: Delete sessions with `<S-x>` or by exiting the terminal

All sessions are stored in memory and persist for the current Neovim session.

## License

MIT License. See [LICENSE](LICENSE) for details.
