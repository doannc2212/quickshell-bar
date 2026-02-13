import QtQuick
import Quickshell.Hyprland

Row {
  spacing: 4

  Repeater {
    model: Hyprland.workspaces

    Rectangle {
      required property var modelData
      width: modelData.focused ? 32 : 24
      height: 24
      radius: 12
      color: modelData.focused ? "#7aa2f7" : "#24283b"

      Text {
        anchors.centerIn: parent
        text: modelData.id
        color: modelData.focused ? "#1a1b26" : "#c0caf5"
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
