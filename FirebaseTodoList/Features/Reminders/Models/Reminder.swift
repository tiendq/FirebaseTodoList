import Foundation
import FirebaseFirestore

struct Reminder: Identifiable, Codable {
  @DocumentID var id: String?
  var title = ""
  var isCompleted = false
}

extension Reminder {
  static let collectionName = "reminders"
  
  static let samples = [
    Reminder(title: "Build sample app", isCompleted: true),
    Reminder(title: "Create tutorial"),
    Reminder(title: "Testing"),
    Reminder(title: "Submit to App Store")
  ]
}
