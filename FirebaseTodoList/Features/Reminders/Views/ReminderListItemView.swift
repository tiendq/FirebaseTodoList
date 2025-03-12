import SwiftUI

struct ReminderListItemView: View {
  @Binding var reminder: Reminder

  var body: some View {
    HStack {
      Toggle(isOn: $reminder.isCompleted) {
        Text(reminder.title)
      }
      .toggleStyle(.reminder)
      Spacer()
    }
    .contentShape(Rectangle())
  }
}

#Preview {
  @Previewable @State var reminder = Reminder.samples[0]
  return ReminderListItemView(reminder: $reminder)
}
