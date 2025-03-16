require 'nvim-web-devicons'.setup {
    -- globally enable different highlight colors per icon (default to true)
    -- if set to false all icons will have the default icon's color
    color_icons = true,
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
    -- globally enable "strict" selection of icons - icon will be looked up in
    -- different tables, first by filename, and if not found by extension; this
    -- prevents cases when file doesn't have any extension but still gets some icon
    -- because its name happened to match some extension (default to false)
    strict = true,
    -- set the light or dark variant manually, instead of relying on `background`
    -- (default to nil)
    variant = "light|dark",
    override_by_filename = {
        ["azure-pipelines.yml"] = {
            icon = "",
            color = "#1976d2",
            name = "AzurePipeline"
        },
        ["azure-pipelines.yaml"] = {
            icon = "",
            color = "#1976d2",
            name = "AzurePipeline"
        },
        ["README"] = {
            icon = "󰋼",
            color = "#1976d2",
            name = "ReadMe"
        },
        ["README.md"] = {
            icon = "󰋼",
            color = "#1976d2",
            name = "ReadMe"
        }
    },
    -- same as `override` but specifically for overrides by extension
    -- takes effect when `strict` is true
    override_by_extension = {
        ["router.tsx"] = {
            icon = "󰑪",
            color = "#81e043",
            name = "RouterTsx"
        },
        ["code-workspace"] = {
            icon = "",
            color = "#1976d2",
            name = "CodeWorkspace"
        }
    },
}
