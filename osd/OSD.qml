import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

Scope {
  id: root
  property var theme: DefaultTheme {}

  property bool showVolume: false
  property bool showBrightness: false
  property real volumeValue: 0
  property bool volumeMuted: false
  property real brightnessValue: 0
  property real maxBrightness: 1

  // Track PipeWire default sink
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio ?? null

    function onVolumeChanged() {
      root.volumeValue = Pipewire.defaultAudioSink.audio.volume;
      root.showVolume = true;
      root.showBrightness = false;
      hideTimer.restart();
    }

    function onMutedChanged() {
      root.volumeMuted = Pipewire.defaultAudioSink.audio.muted;
      root.showVolume = true;
      root.showBrightness = false;
      hideTimer.restart();
    }
  }

  // Brightness monitoring — use Process to read fresh value (FileView.text() is stale on sysfs)
  FileView {
    id: brightnessFile
    path: ""
    watchChanges: true
    onFileChanged: brightnessReadProc.running = true
  }

  Process {
    id: brightnessReadProc
    command: ["brightnessctl", "get"]
    running: false
    stdout: StdioCollector {
      onStreamFinished: {
        const val = parseInt(text.trim());
        if (!isNaN(val) && root.maxBrightness > 0) {
          root.brightnessValue = val / root.maxBrightness;
          root.showBrightness = true;
          root.showVolume = false;
          hideTimer.restart();
        }
      }
    }
  }

  // Discover backlight path and max brightness
  Process {
    id: backlightDiscovery
    command: ["sh", "-c", "path=$(ls -d /sys/class/backlight/*/brightness 2>/dev/null | head -1); if [ -n \"$path\" ]; then echo \"$path\"; cat \"${path%brightness}max_brightness\"; fi"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const raw = text;
        if (!raw) return;
        const lines = raw.trim().split("\n");
        if (lines.length >= 2) {
          const max = parseInt(lines[1]);
          if (!isNaN(max) && max > 0) root.maxBrightness = max;
          brightnessFile.path = lines[0];
          brightnessReadProc.running = true;
        }
      }
    }
  }

  // Auto-hide timer
  Timer {
    id: hideTimer
    interval: 1500
    onTriggered: {
      root.showVolume = false;
      root.showBrightness = false;
    }
  }

  property bool osdVisible: showVolume || showBrightness

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: osdWindow
      required property var modelData
      screen: modelData

      visible: root.osdVisible
      focusable: false
      color: "transparent"

      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
      WlrLayershell.namespace: "quickshell-osd"

      exclusionMode: ExclusionMode.Ignore

      mask: Region {}

      anchors {
        bottom: true
        left: true
        right: true
      }

      implicitHeight: 80

      // OSD pill
      Rectangle {
        id: osdPill
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        width: 300
        height: 40
        radius: 20
        color: root.theme.bgBase
        border.color: root.theme.bgBorder
        border.width: 1
        opacity: root.osdVisible ? 1 : 0

        Behavior on opacity {
          NumberAnimation { duration: 150 }
        }

        Accessible.role: Accessible.ProgressBar
        Accessible.name: {
          if (root.showVolume) {
            if (root.volumeMuted) return "Volume: muted";
            return "Volume: " + Math.round(root.volumeValue * 100) + "%";
          }
          return "Brightness: " + Math.round(root.brightnessValue * 100) + "%";
        }

        RowLayout {
          anchors.fill: parent
          anchors.leftMargin: 16
          anchors.rightMargin: 16
          spacing: 12

          // Icon
          Text {
            text: {
              if (root.showVolume) {
                if (root.volumeMuted) return "󰖁";
                if (root.volumeValue <= 0) return "󰖁";
                if (root.volumeValue < 0.33) return "󰕿";
                if (root.volumeValue < 0.66) return "󰖀";
                return "󰕾";
              }
              return "󰃠";
            }
            color: root.showVolume ? root.theme.accentPrimary : root.theme.accentOrange
            font.pixelSize: 18
            font.family: "Hack Nerd Font"
            Layout.alignment: Qt.AlignVCenter
          }

          // Progress bar
          Rectangle {
            Layout.fillWidth: true
            height: 6
            radius: 3
            color: root.theme.bgSurface
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
              width: {
                const val = root.showVolume ? root.volumeValue : root.brightnessValue;
                return parent.width * Math.max(0, Math.min(1, val));
              }
              height: parent.height
              radius: 3
              color: root.showVolume
                ? (root.volumeMuted ? root.theme.textMuted : root.theme.accentPrimary)
                : root.theme.accentOrange

              Behavior on width {
                NumberAnimation { duration: 100 }
              }
            }
          }

          // Percentage text
          Text {
            text: {
              if (root.showVolume) {
                if (root.volumeMuted) return "Mute";
                return Math.round(root.volumeValue * 100) + "%";
              }
              return Math.round(root.brightnessValue * 100) + "%";
            }
            color: root.theme.textSecondary
            font.pixelSize: 12
            font.family: "Hack Nerd Font"
            Layout.preferredWidth: 40
            horizontalAlignment: Text.AlignRight
            Layout.alignment: Qt.AlignVCenter
          }
        }
      }
    }
  }
}
