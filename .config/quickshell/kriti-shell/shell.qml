// shell.qml
//@ pragma UseQApplication

import Quickshell
import "Bar"
import "SettingsWindow"
import "Widgets"

Scope {
  Bar {}
  //SettingsWindow {}
  PowerMenu {}
  MediaMenu {}
  AppMenu {}
  Activate {}
}
