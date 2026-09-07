# Hyprland migration notes

The Framework Hyprland session intentionally does not yet reproduce every part
of the Sway/SwayFX configuration. The existing Sway session remains available
as the complete fallback.

- Ordered fallback workspace-to-monitor mappings are not ported. Hyprland
  accepts one monitor per workspace rule and has no built-in equivalent to the
  current list of alternative connected outputs.
- Corne, Glove80, touchscreen, and stylus overrides are deferred until their
  exact names can be collected from `hyprctl devices`. Only global keyboard and
  touchpad settings are included initially.
- The custom LIFO `sway-stack` push/pop behavior is not ported. No special
  workspace approximation is included.
- Sway's stacking layout and `Mod+S` are not ported because hy3 provides tab
  groups but no corresponding stacked-titlebar layout.
- Focused-window working-directory discovery is not ported because Hyprland has
  no built-in equivalent to `swaycwd`. Terminal shortcuts use Kitty's normal
  starting directory.
- SwayFX gaps, borders, rounding, gradients, and colors are intentionally
  deferred so Hyprland, hy3, and Hyprpaper retain their upstream default
  styling. Hyprland reuses the existing Wofi launcher configuration from Sway.
- Screenshot and recording use the same `grimshot copy area` and
  `sway-record-region` commands as Sway. Those paths are compositor-neutral;
  HyprCapture is not used because its current source is incompatible with the
  Hyprland version required by hy3.
- Hyprpaper directory rotation and timeouts remain disabled until explicitly
  configured later.

## Live testing

Lua configuration changes can often be tried in the running session with
`hyprctl eval` before they are made permanent in Nix. For example, the faster
animation timing was tested with:

```sh
hyprctl eval 'hl.animation({ leaf = "global", enabled = true, speed = 5, bezier = "default" })'
hyprctl animations -j
```

Use the same official Lua API call that Home Manager will generate, then query
the relevant state with `hyprctl` to confirm it took effect. Changes made this
way are temporary and disappear after a reload or session restart. Once a value
feels right, add it to `home-manager/hyprland/default.nix` and rebuild normally.
Not every change is safe to apply live; session startup, package, plugin, and
service changes still require a rebuild or a fresh session.
