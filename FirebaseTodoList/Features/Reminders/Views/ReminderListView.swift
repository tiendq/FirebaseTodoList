import SwiftUI

struct ReminderListView: View {
  @State var isAddingReminder = false
  @State var editableReminder: Reminder?
  @StateObject var viewModel = ReminderListViewModel()

  var body: some View {
    NavigationStack {
      List($viewModel.reminders) { $reminder in
        ReminderListItemView(reminder: $reminder)
          .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: {
              viewModel.deleteReminder(reminder)
            }) {
              Image(systemName: "trash")
            }
            .tint(.red)
          }
          .onChange(of: reminder.isCompleted) { oldValue, newValue in
            viewModel.setCompleted(reminder, isCompleted: newValue)
          }
          .onTapGesture {
            editableReminder = reminder
          }
      }
      .navigationTitle("Reminders")
      .toolbar {
        ToolbarItemGroup(placement: .bottomBar) {
          Button(action: {
            isAddingReminder.toggle()
          }) {
            // Label("New Reminder", systemImage: "plus.circle.fill") why doesn't work?
            HStack {
              Image(systemName: "plus.circle.fill")
              Text("New Reminder")
            }
          }
          Spacer()
        }
      }
      .sheet(isPresented: $isAddingReminder) {
        AddReminderView { reminder in
          viewModel.addReminder(reminder)
        }
      }
      .sheet(item: $editableReminder) { reminder in
        Text(reminder.title)
      }
      .tint(.red)
    }
  }
}

#Preview {
  ReminderListView()
}
