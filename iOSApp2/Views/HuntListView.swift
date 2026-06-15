import SwiftUI
import SwiftData

struct HuntListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [HuntItem]
    @State private var showingReward = false
    
    var totalFound: Int { items.filter { $0.isFound }.count }
    
    var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink(destination: HuntDetailView(item: item)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.businessName).font(.headline)
                            Text(item.clue).font(.subheadline).foregroundColor(.gray)
                        }
                        Spacer()
                        if item.isFound {
                            Image(systemName: "checkmark.seal.fill").foregroundColor(.green)
                        } else {
                            Image(systemName: "lock").foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Scavenger Hunt")
            .onAppear(perform: seedData)
            
            Button("Submit Results (\(totalFound)/\(items.count))") { showingReward = true }
            .buttonStyle(.borderedProminent)
            .padding()
            .disabled(totalFound == 0)
            .sheet(isPresented: $showingReward) {
                // Ensure RewardView is updated to accept the totalFound integer rather than the store
                RewardView(totalFound: totalFound)
            }
        }
    }
    
    private func seedData() {
        if items.isEmpty {
            let initialItems = [
                HuntItem(clue: "Find the oldest book in the window display.", businessName: "Main St. Books", targetLatitude: 43.6532, targetLongitude: -79.3832),
                HuntItem(clue: "Take a picture of the giant popcorn bucket.", businessName: "Starlight Cinema", targetLatitude: 43.6510, targetLongitude: -79.3470),
                HuntItem(clue: "Locate the secret menu sign by the register.", businessName: "Joe's Diner", targetLatitude: 43.7182, targetLongitude: -79.7319)
            ]
            for item in initialItems {
                modelContext.insert(item)
            }
        }
    }
}
