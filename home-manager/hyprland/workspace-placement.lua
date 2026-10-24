local M = {}
local SETUP_DELAY_MS = 300
local MANAGED_WORKSPACES = 4

local function contains(value, text)
    return value and value:find(text, 1, true) ~= nil
end

-- Hyprland exposes pixel dimensions, but positions use logical coordinates.
local function logical_dimensions(m)
    local width, height = m.width, m.height
    if m.transform % 2 == 1 then width, height = height, width end
    return width / m.scale, height / m.scale
end

-- Pure mapping: connector names are resolved afresh on every layout change.
function M.destinations(monitors)
    local laptop, portable
    local lenovos = {}
    for _, m in ipairs(monitors) do
        if not m.is_mirror then
            if contains(m.description, "BOE NE135A1M-NY1") then
                if laptop then return {} end
                laptop = m
            elseif contains(m.description, "ASUSTek COMPUTER INC ASUS MB14AHD R2LMTF057922") then
                portable = m
            elseif contains(m.description, "Lenovo Group Limited") then
                lenovos[#lenovos + 1] = m
            end
        end
    end
    if not laptop then return {} end
    if #lenovos == 0 then
        if not portable then return {} end
        -- Workspaces are assigned by a list of monitor names
        return { laptop.name, laptop.name, portable.name, portable.name }
    end
    if #lenovos > 2 then return {} end

    -- Dynamic and too-smart way of assigning for all Inno setups
    -- Laptop gets 4
    -- Monitor above laptop gets 2, 3
    -- Right monitor gets 1
    -- (Untested at the time of writing this comment)
    local laptop_width = logical_dimensions(laptop)
    local above, best_overlap, tied = nil, 0, false
    for _, m in ipairs(lenovos) do
        local width, height = logical_dimensions(m)
        if m.y + height > laptop.y then return {} end
        local overlap = math.min(m.x + width, laptop.x + laptop_width) - math.max(m.x, laptop.x)
        if overlap > best_overlap then
            above, best_overlap, tied = m, overlap, false
        elseif overlap > 0 and overlap == best_overlap then
            tied = true
        end
    end
    if tied or (#lenovos == 2 and not above) then return {} end
    local other
    for _, m in ipairs(lenovos) do
        if m ~= above then other = m end
    end
    return {
        other and other.name or laptop.name, -- W1 to the right
        above and above.name or laptop.name, -- W2 to the top
        above and above.name or laptop.name, -- W3 to the top
        laptop.name,                         -- W4 to the laptop
    }
end

function M.setup(hl)
    local destinations = {}
    local generation, force_pending = 0, false
    local rules = {}

    local function bind_workspace(id, target)
        local rule = rules[id]
        if not target then
            if rule then rule:set_enabled(false) end
            return
        end
        -- Re-enable before updating: 0.56.2 only merges into enabled rules.
        -- Reusing the handle avoids accumulating disabled rules after docking.
        if rule then rule:set_enabled(true) end
        rules[id] = hl.workspace_rule({ workspace = tostring(id), monitor = target })
    end

    local function move_workspace(id, target)
        local ws = hl.get_workspace(tostring(id))
        local monitor = target and hl.get_monitor(target)
        if not ws or not monitor or monitor.is_mirror then return false end
        if ws.monitor and ws.monitor.name == target then return false end
        hl.dispatch(hl.dsp.workspace.move({ workspace = tostring(id), monitor = target }))
        return true
    end

    local function reconcile(force)
        local focused = hl.get_active_window()
        local address = focused and focused.address
        local next_destinations = M.destinations(hl.get_monitors())
        local changed = {}
        -- Bind even nonexistent workspaces before any focus/create operation.
        -- Existing workspaces still need an explicit move when docking.
        for id = 1, MANAGED_WORKSPACES do
            if force or next_destinations[id] ~= destinations[id] then
                bind_workspace(id, next_destinations[id])
                changed[#changed + 1] = id
            end
        end
        local moved = false
        for _, id in ipairs(changed) do
            if next_destinations[id] then
                moved = move_workspace(id, next_destinations[id]) or moved
            end
        end
        destinations = next_destinations
        if moved and address then
            local window = hl.get_window("address:" .. address)
            if window then hl.dispatch(hl.dsp.focus({ window = window })) end
        end
    end

    local function schedule(force)
        force_pending = force_pending or force
        -- Only the last timer in a burst may reconcile; retain forced reloads.
        generation = generation + 1
        local token = generation
        hl.timer(function()
            if token ~= generation then return end
            local force_now = force_pending
            force_pending = false
            reconcile(force_now)
        end, { timeout = SETUP_DELAY_MS, type = "oneshot" })
    end

    hl.on("hyprland.start", function() schedule(true) end)
    hl.on("config.reloaded", function() schedule(true) end)
    hl.on("monitor.layout_changed", function() schedule(false) end)
    -- Hyprland cancels Lua timers and clears event handlers on config reload.
    -- No unload hook is needed (config.unload is absent in Hyprland 0.56.2).
end

return M
