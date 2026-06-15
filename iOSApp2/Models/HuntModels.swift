import SwiftUI
import SwiftData
import CoreLocation

@Model
class HuntElement: Identifiable {
    var id: UUID = UUID()
    @Attribute(.externalStorage) var imageData: Data
    
    init(imageData: Data) {
        self.imageData = imageData
    }
}

@Model
class HuntItem: Identifiable {
    var id: UUID = UUID()
    var clue: String
    var businessName: String
    
    // Phase 2: GPS coordinates for the target business
    var targetLatitude: Double
    var targetLongitude: Double
    
    @Attribute(.externalStorage) var photoData: Data? = nil
    @Relationship(deleteRule: .cascade) var elements: [HuntElement] = []
    
    init(clue: String, businessName: String, targetLatitude: Double, targetLongitude: Double) {
        self.clue = clue
        self.businessName = businessName
        self.targetLatitude = targetLatitude
        self.targetLongitude = targetLongitude
    }
    
    var isFound: Bool {
        return photoData != nil
    }
}
