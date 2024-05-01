import SwiftUI

struct HoldingView: View {
    var body: some View {
        NavigationView {
                    VStack {
                        Spacer()
                        
                        NavigationLink(destination: ContentView()) {
                            Text("Show Map View")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        NavigationLink(destination: ChatView()) {
                            Text("Show Booking View")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        NavigationLink(destination: ChatView()) {
                            Text("Show Chat View")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        NavigationLink(destination: BookingnSearchSample()) {
                            Text("Show Search logs View")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    .navigationBarTitle("Main View")
                }
    }
}

#Preview {
    HoldingView()
}
