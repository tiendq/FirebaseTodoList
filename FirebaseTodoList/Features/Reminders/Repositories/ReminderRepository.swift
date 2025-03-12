import Foundation
import FirebaseFirestore
import Factory

class ReminderRepository: ObservableObject {
  @Injected(\.firestore) var firestore

  @Published var reminders: [Reminder] = []

  private var listenerRegistration: ListenerRegistration?

  init() {
    subscribe()
  }

  deinit {
    unsubscribe()
  }

  func subscribe() {
    guard listenerRegistration == nil else {
      return
    }

    let query = firestore.collection(Reminder.collectionName)

    listenerRegistration = query.addSnapshotListener { [weak self] (snapshot, error) in
      guard let documents = snapshot?.documents else {
        return
      }

      self?.reminders = documents.compactMap { document in
        do {
          return try document.data(as: Reminder.self)
        } catch {
          print(error.localizedDescription)
          return nil
        }
      }
    }
  }

  private func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }

  func addReminder(_ reminder: Reminder) throws {
    try firestore
      .collection(Reminder.collectionName)
      .addDocument(from: reminder)
  }

  func updateReminder(_ reminder: Reminder) throws {
    guard let documentId = reminder.id else {
      fatalError("Reminder \(reminder.title) has no document ID.")
    }

    try firestore
      .collection(Reminder.collectionName)
      .document(documentId)
      .setData(from: reminder, merge: true)
  }

  func removeReminder(_ reminder: Reminder) {
    guard let documentId = reminder.id else {
      fatalError("Reminder \(reminder.title) has no document ID.")
    }

    firestore
      .collection(Reminder.collectionName)
      .document(documentId)
      .delete()
  }
}
