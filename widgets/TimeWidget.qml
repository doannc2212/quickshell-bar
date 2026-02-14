import QtQuick
import "../services"

Rectangle {
  height: 24
  width: timeDate.width + 16
  radius: 12
  color: Theme.bgSurface

  Row {
    id: timeDate
    anchors.centerIn: parent
    spacing: 8

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: ""
      color: Theme.accentPrimary
      font.pixelSize: 14
      font.family: "Hack Nerd Font"
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: Time.timeString
      color: Theme.textPrimary
      font.pixelSize: 12
      font.family: "Hack Nerd Font"
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: Time.dateString
      color: Theme.textSecondary
      font.pixelSize: 12
      font.family: "Hack Nerd Font"
    }
  }
}
