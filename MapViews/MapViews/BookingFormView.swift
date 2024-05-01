import SwiftUI

struct Appointment: Identifiable {
    let id = UUID()
    let name: String
    let date: Date
    let description: String
}

struct BookingFormView: View {
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var name = ""
    @State private var description = ""

    @State private var appointments: [Appointment] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Information")) {
                    TextField("Your Name", text: $name)
                    TextField("Reason for Appointment", text: $description)
                }
                
                Section(header: Text("Select Date and Time")) {
                    DatePicker("Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                    DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                }

                Button(action: {
                    let appointment = Appointment(name: self.name, date: self.combineDateAndTime(date: self.selectedDate, time: self.selectedTime), description: self.description)
                    self.appointments.append(appointment)
                    self.name = ""
                    self.description = ""
                }) {
                    Text("Book Appointment")
                }

                Section(header: Text("Appointments")) {
                    ForEach(appointments) { appointment in
                        VStack(alignment: .leading) {
                            Text("Name: \(appointment.name)")
                            Text("Date & Time: \(appointment.date, formatter: dateFormatter)")
                            Text("Reason: \(appointment.description)")
                        }
                    }
                }
            }
            .navigationTitle("Appointment Booking")
        }
    }

    private func combineDateAndTime(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        let mergedComponents = DateComponents(year: dateComponents.year, month: dateComponents.month, day: dateComponents.day, hour: timeComponents.hour, minute: timeComponents.minute)
        return calendar.date(from: mergedComponents)!
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

struct BookingFormView_Previews: PreviewProvider {
    static var previews: some View {
        BookingFormView()
    }
}


#Preview {
    BookingFormView()
}
