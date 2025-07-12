local util = require "typescript-tools.utils"

local M = {}

function M.check()
  local health = vim.health

  health.start "typescript-tools.nvim"

  local version_ok, version_msg = util.check_minimum_nvim_version()
  if version_ok then
    health.ok(version_msg)
  else
    health.error(version_msg, {
      "Please upgrade to Neovim 0.11.2 or later",
      "Visit https://github.com/neovim/neovim/releases",
    })
  end

  if vim.fn.executable "node" == 1 then
    local node_version = vim.fn.system("node --version"):gsub("^v", ""):gsub("%s+$", "")
    health.ok(string.format("Node.js %s found", node_version))
  else
    health.warn("Node.js not found in PATH", {
      "TypeScript language server requires Node.js",
      "Install Node.js from https://nodejs.org",
    })
  end

  if vim.fn.executable "npm" == 1 then
    health.ok "npm found"
  else
    health.warn("npm not found in PATH", {
      "npm is recommended for managing TypeScript packages",
    })
  end
end

return M
