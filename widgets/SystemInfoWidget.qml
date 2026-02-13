import QtQuick
import "../services"

Row {
  spacing: 4

  // CPU
  Rectangle {
    height: 24
    width: cpuContent.width + 12
    radius: 12
    color: "#24283b"

    Row {
      id: cpuContent
      anchors.centerIn: parent
      spacing: 6

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "󰻠"
        color: "#ff9e64"
        font.pixelSize: 14
        font.family: "Hack Nerd Font"
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: SystemInfo.cpuUsage
        color: "#c0caf5"
        font.pixelSize: 11
        font.family: "Hack Nerd Font"
      }
    }
  }

  // Memory
  Rectangle {
    height: 24
    width: memContent.width + 12
    radius: 12
    color: "#24283b"

    Row {
      id: memContent
      anchors.centerIn: parent
      spacing: 6

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "󰍛"
        color: "#7dcfff"
        font.pixelSize: 14
        font.family: "Hack Nerd Font"
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: SystemInfo.memoryUsage
        color: "#c0caf5"
        font.pixelSize: 11
        font.family: "Hack Nerd Font"
      }
    }
  }

  // Network
  Rectangle {
    height: 24
    width: netContent.width + 12
    radius: 12
    color: "#24283b"

    Row {
      id: netContent
      anchors.centerIn: parent
      spacing: 6

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "󰛳"
        color: "#9ece6a"
        font.pixelSize: 14
        font.family: "Hack Nerd Font"
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: SystemInfo.networkInfo
        color: "#c0caf5"
        font.pixelSize: 11
        font.family: "Hack Nerd Font"
      }
    }
  }

  // Battery
  Rectangle {
    height: 24
    width: battContent.width + 12
    radius: 12
    color: "#24283b"

    Row {
      id: battContent
      anchors.centerIn: parent
      spacing: 6

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: SystemInfo.batteryIcon
        color: SystemInfo.batteryColor
        font.pixelSize: 14
        font.family: "Hack Nerd Font"
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: SystemInfo.batteryLevel
        color: "#c0caf5"
        font.pixelSize: 11
        font.family: "Hack Nerd Font"
      }
    }
  }

  // Temperature
  Rectangle {
    height: 24
    width: tempContent.width + 12
    radius: 12
    color: "#24283b"

    Row {
      id: tempContent
      anchors.centerIn: parent
      spacing: 6

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "󰔏"
        color: "#f7768e"
        font.pixelSize: 14
        font.family: "Hack Nerd Font"
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: SystemInfo.temperature
        color: "#c0caf5"
        font.pixelSize: 11
        font.family: "Hack Nerd Font"
      }
    }
  }
}
