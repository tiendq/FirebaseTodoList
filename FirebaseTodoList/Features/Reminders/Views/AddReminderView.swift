import SwiftUI

struct AddReminderView: View {
  @Environment(\.dismiss) var dismiss
  @State var reminder = Reminder()

  var onSubmit: (_ reminder: Reminder) -> Void

  var body: some View {
    NavigationStack {
      Form {
        TextField("Title", text: $reminder.title)
          .onSubmit {
            onSubmit(reminder)
            dismiss()
          }
      }
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Add") {
            onSubmit(reminder)
            dismiss()
          }
        }
      }
    }
  }
}

#Preview {
  AddReminderView { reminder in
    print(reminder.title)
  }
}
