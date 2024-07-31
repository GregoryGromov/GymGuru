import SwiftUI

struct TestView: View {
    
    @State var show = false
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button("Show it") {
                show = true
            }
        }
        .onAppear {
            print("Появилось главное вью")
        }
//        .sheet(isPresented: $show) {
//            
//        }
        
        .sheet(isPresented: $show) {
            print("Убралось")
        } content: {
            Text("Второе Вью")
                .onAppear {
                    print("Появилось второе вью")
                }
        }

        
    }
}

