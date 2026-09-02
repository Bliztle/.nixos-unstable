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
  deferred so Hyprland, hy3, Hyprpaper, and hyprlauncher retain their upstream
  default styling.
- Screenshot and recording use the same `grimshot copy area` and
  `sway-record-region` commands as Sway. Those paths are compositor-neutral;
  HyprCapture is not used because its current source is incompatible with the
  Hyprland version required by hy3.
- Hyprpaper directory rotation and timeouts remain disabled until explicitly
  configured later.
