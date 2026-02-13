import QtQuick
import "../services"

Rectangle {
  height: 24
  width: timeDate.width + 16
  radius: 12
  color: "#24283b"

  Row {
    id: timeDate
    anchors.centerIn: parent
    spacing: 8

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: ""
      color: "#7aa2f7"
      font.pixelSize: 14
      font.family: "Hack Nerd Font"
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: Time.timeString
      color: "#c0caf5"
      font.pixelSize: 12
      font.family: "Hack Nerd Font"
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: Time.dateString
      color: "#a9b1d6"
      font.pixelSize: 12
      font.family: "Hack Nerd Font"
    }
  }
}
