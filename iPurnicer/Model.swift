import Foundation
import SwiftUI
import RealityKit
import Combine

class Model {
    var modelName: String
    var image: Image
    var modelEntity: Entity?
    
    private var cancelable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = Image(modelName)
        
        let filename = modelName + ".usdz"
        self.cancelable = Entity.loadAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                // Handle error
                print("DEBUG: unable to laod entity: \(filename)")
            }, receiveValue: { modelEntity in
                // Get the model
                self.modelEntity = modelEntity
            })
    }
}
