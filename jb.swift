import SwiftUI

// Declare the C function
@_silgen_name("run_exploit") func run_exploit()

struct ContentView: View {
    @State private var logText: String = "Ready to run exploit..."
    @State private var isRunning: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                Text(logText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .border(Color.gray)
            .frame(height: 300)

            Button(action: {
                runExploit()
            }) {
                Text(isRunning ? "Running..." : "Run Exploit")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .disabled(isRunning)
        }
        .padding()
    }

    func runExploit() {
        isRunning = true
        logText += "\nStarting exploit...\n"
        DispatchQueue.global(qos: .background).async {
            // Call the C function
            run_exploit()
            DispatchQueue.main.async {
                logText += "Exploit finished.\n"
                isRunning = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
