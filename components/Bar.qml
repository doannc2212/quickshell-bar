import Quickshell
import QtQuick
import QtQuick.Layouts
import "../widgets"

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 32
      color: "#1a1b26"

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 8

        TimeWidget {}
        WorkspaceIndicator {}

        Item {
          Layout.fillWidth: true
        }

        SystemInfoWidget {}
        SystemTrayWidget {}
      }

      // Center window title independently
      WindowTitle {
        anchors.centerIn: parent
      }
    }
  }
}
