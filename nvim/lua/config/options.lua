-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Keep editorconfig enabled but override the charset property
-- to prevent adding BOM to files (charset = utf-8-bom in .editorconfig)
require("editorconfig").properties.charset = function() end
