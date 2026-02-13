pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property string timeString: {
    Qt.formatDateTime(clock.date, "hh:mm:ss")
  }

  readonly property string dateString: {
    Qt.formatDateTime(clock.date, "ddd MMM d")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
