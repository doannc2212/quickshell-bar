import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

Scope {
  id: root
  property var theme: DefaultTheme {}
  property string font: "Hack Nerd Font"
  property bool active: false
  property bool showBadge: false

  onActiveChanged: {
    showBadge = true;
    hideTimer.restart();
  }

  Timer {
    id: hideTimer
    interval: 2000
    onTriggered: root.showBadge = false
  }

  IpcHandler {
    target: "idle"

    function toggle(): void {
      root.active = !root.active;
    }

    function enable(): void {
      root.active = true;
    }

    function disable(): void {
      root.active = false;
    }
  }

  PanelWindow {
    id: host
    // Always mapped — the Wayland idle inhibitor only holds while this
    // window stays mapped, so this must never be tied to `root.active`.
    visible: true
    focusable: false
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    WlrLayershell.namespace: "quickshell-idle-inhibitor"

    exclusionMode: ExclusionMode.Ignore
    mask: Region { item: badge }

    anchors {
      bottom: true
      right: true
    }
    margins {
      bottom: 8
      right: 8
    }
    implicitWidth: 40
    implicitHeight: 40

    IdleInhibitor {
      enabled: root.active
      window: host
    }

    Rectangle {
      id: badge
      anchors.centerIn: parent
      width: 32
      height: 32
      radius: 16
      color: root.theme.bgBase
      border.color: root.active ? root.theme.accentOrange : root.theme.bgBorder
      border.width: 1
      opacity: root.showBadge ? 1 : 0

      Behavior on border.color { ColorAnimation { duration: 150 } }
      Behavior on opacity { NumberAnimation { duration: 150 } }

      Accessible.role: Accessible.Indicator
      Accessible.name: root.active ? "Idle inhibitor active — screen will not sleep" : "Idle inhibitor inactive — normal sleep behavior"

      Text {
        anchors.centerIn: parent
        text: root.active ? "" : ""
        color: root.active ? root.theme.accentOrange : root.theme.textMuted
        font.pixelSize: 16
        font.family: root.font
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.active = !root.active
      }
    }
  }
}
