//@ pragma UseQApplication
//@ pragma Env QT_QPA_PLATFORMTHEME=gtk3
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import Quickshell
import Quickshell.Io
import QtQuick
import "bar"
import "app-launcher"
import "notifications"
import "theme-switcher"
import "wallpaper"

Scope {
  ThemeSwitcher { id: ts }
  Bar { theme: ts.theme }
  AppLauncher { theme: ts.theme }
  NotificationPopup { theme: ts.theme }
  WallpaperManager { theme: ts.theme }

  // Plugin loader: scans plugins/ directory for .qml files
  property var pluginFiles: []

  Process {
    id: pluginScanner
    command: ["sh", "-c", "find " + Quickshell.env("HOME") + "/.config/quickshell/plugins -maxdepth 2 -name '*.qml' -type f 2>/dev/null"]
    running: true
    stdout: SplitParser {
      onRead: data => {
        const path = data.trim();
        if (path !== "") pluginFiles = [...pluginFiles, path];
      }
    }
  }

  Repeater {
    model: pluginFiles

    Loader {
      required property string modelData
      source: "file://" + modelData
      onLoaded: {
        if (item && item.hasOwnProperty("theme")) {
          item.theme = Qt.binding(() => ts.theme);
        }
      }
    }
  }
}
