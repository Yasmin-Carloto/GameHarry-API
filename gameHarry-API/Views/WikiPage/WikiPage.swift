//TODO: chamar ViewModel

import SwiftUI

struct WikiPage<T: Decodable & Identifiable>: View {
    
    var endpoint: Endpoint
    @State private var items:[T] = []
    @State private var searchItem: String = ""
    
    var body: some View {
        //SearchBar
        //SearchBar(text: <#T##Binding<String>#>, placeholder: <#T##String#>)
        
        //ScrollView + LazyVGrid?
        NavigationStack {
            ScrollView{
                
            }
            List(items) { item in
                Text(String(describing: item))
            }
            .navigationTitle("Wiki")
        }
        .task {
            do {
                try await fetchData()
            } catch {
                print("Error fetching data")
            }
        }
        .navigationTitle("") //deve ser definido a partir do endpoint
    }
    private func fetchData() async throws {
        do {
            items = try await ApiServices.shared.fetchData(from: endpoint)
            print(items)
        } catch {
            print("Error fetching data: \(error)")

        }
    }
    
}



//#Preview {
  //  WikiPage()
//}
