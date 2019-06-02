import Foundation
import GameplayKit

extension CGRect {

	var boundingRectMin: vector_float2 {
		return vector_float2(Float(self.minX), Float(self.minY))
	}

	var boundingRectMax: vector_float2 {
		return vector_float2(Float(self.maxX), Float(self.maxY))
	}
}


let tree = GKRTree<NSString>(maxNumberOfChildren: 4)

let node: NSString = "test"
let nodeBoundingBox = CGRect(x: 10.0, y: 10.0, width: 10.0, height: 10.0)
tree.addElement(node, boundingRectMin: nodeBoundingBox.boundingRectMin, boundingRectMax: nodeBoundingBox.boundingRectMax, splitStrategy: .linear)

let queryRect = CGRect(x: 5.0, y: 5.0, width: 10.0, height: 10.0)
let elements = tree.elements(inBoundingRectMin: queryRect.boundingRectMin, rectMax: queryRect.boundingRectMax)

// Elements should contain "test"
print(elements.first ?? "Should print test")

// From GKRTree Documentation:
// An array of objects stored in the tree whose bounding regions overlap the specified region.
// The array is empty if no such objects are found.
