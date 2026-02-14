import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../services"

Text {
  text: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : ""
  color: Theme.textPrimary
  font.pixelSize: 13
  font.family: "Hack Nerd Font"
  elide: Text.ElideRight
  width: Math.min(implicitWidth, 400)
  clip: true
}
