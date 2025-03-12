import Combine
import Foundation
import Factory

class ReminderListViewModel: ObservableObject {
  @Published var reminders: [Reminder] = []

  @Injected(\.reminderRepository)
  private var repository

  init() {
    // Need to use old ObservableObject way to be able to use Combine's assign method here.
    repository.$reminders.assign(to: &$reminders)
  }

  func addReminder(_ reminder: Reminder) {
    do {
      try repository.addReminder(reminder)
    } catch {
      print(error.localizedDescription)
    }
  }

  func updateReminder(_ reminder: Reminder) {
    do {
      try repository.updateReminder(reminder)
    } catch {
      print(error.localizedDescription)
    }
  }

  func setCompleted(_ reminder: Reminder, isCompleted: Bool) {
    var editedReminder = reminder
    editedReminder.isCompleted = isCompleted
    updateReminder(editedReminder)
  }

  func deleteReminder(_ reminder: Reminder) {
    repository.removeReminder(reminder)
  }
}
