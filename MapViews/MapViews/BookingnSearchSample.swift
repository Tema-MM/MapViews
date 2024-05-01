import SwiftUI

// Define Doctor and Hospital models
struct Doctor {
    let name: String
    let specialization: String
    let location: String
    let acceptsMedicalAid: Bool
}

struct Hospital {
    let name: String
    let location: String
    let hasEmergencyRoom: Bool
    let acceptsMedicalAid: Bool
}

// Define Medical Aid Plan
enum MedicalAidPlan {
    case planA
    case planB
}

// Sample Data
let doctors: [Doctor] = [
    Doctor(name: "Dr. Smith", specialization: "Cardiologist", location: "City Hospital", acceptsMedicalAid: true),
    Doctor(name: "Dr. Johnson", specialization: "Pediatrician", location: "Suburb Clinic", acceptsMedicalAid: false),
    // Add more sample doctors
]

let hospitals: [Hospital] = [
    Hospital(name: "City Hospital", location: "City Center", hasEmergencyRoom: true, acceptsMedicalAid: true),
    Hospital(name: "Suburb Clinic", location: "Suburb Area", hasEmergencyRoom: true, acceptsMedicalAid: false),
    // Add more sample hospitals
]

// Main ContentView
struct BookingnSearchSample: View {
    @State private var searchQuery: String = ""
    @State private var selectedMedicalAidPlan: MedicalAidPlan = .planA
    
    var body: some View {
        VStack {
            TextField("Search for doctors or hospitals", text: $searchQuery)
                .padding()
            
//            Picker("Select Medical Aid Plan", selection: $selectedMedicalAidPlan) {
//                Text("Plan A").tag(MedicalAidPlan.planA)
//                Text("Plan B").tag(MedicalAidPlan.planB)
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .padding()
            
            List {
                Section(header: Text("Doctors")) {
                    ForEach(filteredDoctors, id: \.name) { doctor in
                        DoctorRow(doctor: doctor)
                    }
                }
                
                Section(header: Text("Hospitals")) {
                    ForEach(filteredHospitals, id: \.name) { hospital in
                        HospitalRow(hospital: hospital)
                    }
                }
            }
        }
    }
    
    var filteredDoctors: [Doctor] {
        if searchQuery.isEmpty {
            return doctors.filter { $0.acceptsMedicalAid == (selectedMedicalAidPlan == .planA) }
        } else {
            return doctors.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) && $0.acceptsMedicalAid == (selectedMedicalAidPlan == .planA) }
        }
    }
    
    var filteredHospitals: [Hospital] {
        if searchQuery.isEmpty {
            return hospitals.filter { $0.acceptsMedicalAid == (selectedMedicalAidPlan == .planA) }
        } else {
            return hospitals.filter { $0.name.localizedCaseInsensitiveContains(searchQuery) && $0.acceptsMedicalAid == (selectedMedicalAidPlan == .planA) }
        }
    }
}

// Doctor Row View
struct DoctorRow: View {
    let doctor: Doctor
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(doctor.name)
                .font(.headline)
            Text(doctor.specialization)
                .font(.subheadline)
            Text(doctor.location)
                .font(.subheadline)
        }
    }
}

// Hospital Row View
struct HospitalRow: View {
    let hospital: Hospital
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(hospital.name)
                .font(.headline)
            Text(hospital.location)
                .font(.subheadline)
            if hospital.hasEmergencyRoom {
                Text("Emergency Room Available")
                    .font(.subheadline)
                    .foregroundColor(.red)
            } else {
                Text("No Emergency Room")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    BookingnSearchSample()
}
