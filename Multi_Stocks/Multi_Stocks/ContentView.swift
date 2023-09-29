import SwiftUI
import shared

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.phrases, id: \.self) { phrase in
            Text(phrase)
        }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var phrases: [String] = ["Loading..."]
        
        init() {
            AppleHelper().repo().test { greeting, error in
                DispatchQueue.main.async {
                    if let greeting = greeting {
                        self.phrases = [greeting]
                    } else {
                        self.phrases = [error?.localizedDescription ?? "error"]
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        ContentView(viewModel: ContentView.ViewModel())
	}
}
