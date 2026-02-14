import QtQuick
import Quickshell.Hyprland
import "../services"

Row {
  spacing: 4

  Repeater {
    model: Hyprland.workspaces

    Rectangle {
      required property var modelData
      width: modelData.focused ? 32 : 24
      height: 24
      radius: 12
      color: modelData.focused ? Theme.accentPrimary : Theme.bgSurface

      Text {
        anchors.centerIn: parent
        text: modelData.id
        color: modelData.focused ? Theme.bgBase : Theme.textPrimary
        font.pixelSize: 11
        font.family: "Hack Nerd Font"
        font.bold: modelData.focused
      }

      MouseArea {
        anchors.fill: parent
        onClicked: modelData.activate()
      }

      Behavior on width {
        NumberAnimation { duration: 150 }
      }
    }
  }
}
