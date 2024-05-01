import SwiftUI

struct Message: Identifiable {
    var id = UUID()
    var text: String
    var isUser: Bool // Indicates if the message is sent by the user
    var timestamp: Date
}

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    func sendMessage(text: String) {
        let message = Message(text: text, isUser: true, timestamp: Date())
        messages.append(message)
        
        // Simulate receiving a response after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let response = Message(text: "This is a response.", isUser: false, timestamp: Date())
            self.messages.append(response)
        }
    }
}

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    @State private var newMessage = ""
    
    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                MessageView(message: message)
            }
            .padding()
            
            HStack {
                TextField("Type a message", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: sendMessage) {
                    Text("Send")
                }
                .padding()
            }
        }
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        viewModel.sendMessage(text: newMessage)
        newMessage = ""
    }
}

struct MessageView: View {
    var message: Message
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            VStack(alignment: message.isUser ? .trailing : .leading) {
                Text(message.text)
                    .padding(10)
                    .background(message.isUser ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                
                Text(message.timestamp, style: .time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            if !message.isUser {
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}


#Preview {
    ChatView()
}
