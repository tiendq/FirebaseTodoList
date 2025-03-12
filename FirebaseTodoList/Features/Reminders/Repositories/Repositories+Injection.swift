import Foundation
import Factory

extension Container {
  var reminderRepository: Factory<ReminderRepository> {
    Factory(self) {
      ReminderRepository()
    }.singleton
  }
}
