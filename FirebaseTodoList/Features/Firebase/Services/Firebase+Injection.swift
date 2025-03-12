import Foundation
import Factory
import FirebaseAuth
import FirebaseFirestore

extension Container {
  /// Determines whether to use the Firebase Local Emulator Suite.
  /// To use the local emulator, go to the active scheme, and add `-useEmulator YES`
  /// to the _Arguments Passed On Launch_ section.
  var useEmulator: Factory<Bool> {
    Factory(self) {
      let value =  UserDefaults.standard.bool(forKey: "useEmulator")
      print("Using the emulator: \(value == true ? "YES" : "NO")")
      return value
    }.singleton
  }

  var firestore: Factory<Firestore> {
    Factory(self) {
      if Container.shared.useEmulator() {
        let settings = Firestore.firestore().settings
        settings.host = "localhost:8080"
        settings.cacheSettings = MemoryCacheSettings()
        settings.isSSLEnabled = false

        print("to use the local emulator on \(settings.host)")

        Firestore.firestore().settings = settings
        Auth.auth().useEmulator(withHost: "localhost", port: 9099)
      }
      else {
        print("to use the Firebase backend")
      }

      return Firestore.firestore()
    }.singleton
  }
}
