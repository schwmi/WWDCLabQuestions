//
//  AppDelegate.swift
//  MNViewLayerPerformanceTest
//
//  Created by Thomas Zoechling on 08.04.19.
//  Copyright © 2019 Peakstep. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var scrollView: NSScrollView!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let containerView = MNCContainerView(frame: CGRect(origin: .zero, size: CGSize(width: 12000.0, height: 12000.0)))
        self.scrollView.wantsLayer = true
        self.scrollView.documentView = containerView
        self.scrollView.allowsMagnification = true
        self.scrollView.minMagnification = 0.1
        self.scrollView.maxMagnification = 4.0
        for _ in 0..<2000 {
            #if USE_LAYERS
            containerView.layer?.addSublayer(MNCBranchLayer())
            #else
            containerView.addSubview(MNCBranchView())
            #endif

            #if USE_INPROCESS_RENDERING
            containerView.layerUsesCoreImageFilters = true
            #else
            containerView.layerUsesCoreImageFilters = false
            #endif
        }
    }
}

class MNCContainerView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        //self.layer = MNCClusteringHostLayer()
        self.wantsLayer = true
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func configure(_ layer: CAShapeLayer, bounds: CGRect) {
    layer.path = CGPath(roundedRect: bounds, cornerWidth: 10.0, cornerHeight: 10.0, transform: nil)
    layer.fillColor = NSColor.random().withAlphaComponent(0.2).cgColor
    layer.lineWidth = 15.0
    layer.allowsEdgeAntialiasing = true
    layer.edgeAntialiasingMask = [.layerBottomEdge, .layerTopEdge, .layerRightEdge, .layerTopEdge]
    layer.strokeColor = NSColor.random().cgColor
    layer.isOpaque = false
}

class MNCBranchView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: CGRect(origin: .makeRandom(within: 0..<10000), size: .makeRandom(within: 200..<200)))
        self.wantsLayer = true
        guard let layer = self.layer as? CAShapeLayer else {
            return
        }
        configure(layer, bounds: self.bounds)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func makeBackingLayer() -> CALayer {
        return CAShapeLayer()
    }
}

class MNCBranchLayer: CAShapeLayer {

    override init() {
        super.init()
        self.position = .makeRandom(within: 0..<10000)
        let bounds = CGRect(origin: .zero, size: .makeRandom(within: 100..<200))
        configure(self, bounds: bounds)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//@objcMembers
//final class MNCClusteringHostLayer: CALayer {
//
//    // MARK: - Properties
//
//    var intermediateLayers: [CALayer] = [CALayer]()
//
//    // MARK: - Lifecycle
//
//    override init() {
//        super.init()
//    }
//
//    override init(layer: Any) {
//        fatalError("Unexpected layer copy, this might be an unwanted implicit animation?")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - CALayer
//
//    override func addSublayer(_ layer: CALayer) {
//        let intermediateLayer = self.intermediateLayer(for: layer)
//        let positionInDestinationSpace = self.convert(layer.position, to: intermediateLayer)
//        layer.position = positionInDestinationSpace
//        intermediateLayer.addSublayer(layer)
//    }
//
//    private func intermediateLayer(for layer: CALayer) -> CALayer {
//        let availableLayers = self.intermediateLayers.filter { ($0.sublayers?.count ?? 0) < 20 }
//        guard let nearbyLayer = availableLayers.first(where: { (candidate) -> Bool in
//            let positionInDestinationSpace = self.convert(layer.position, to: candidate)
//            return candidate.contains(positionInDestinationSpace)
//        }) else {
//            let intermediateLayer = CALayer()
//            intermediateLayer.bounds = CGRect(origin: .zero, size: CGSize(width: 2000.0, height: 2000.0))
//            intermediateLayer.position = layer.position
//            //intermediateLayer.backgroundColor = NSColor.random().withAlphaComponent(0.05).cgColor
//            intermediateLayer.shouldRasterize = true
//
//            intermediateLayer.filters = [CIFilter(name: "CIAffineTransform")!]
//            self.intermediateLayers.append(intermediateLayer)
//            // Using `addSublayer` here would recurse - we are overriding that
//            self.insertSublayer(intermediateLayer, at: 0)
//            return intermediateLayer
//        }
//
//        print(nearbyLayer.frame)
//        return nearbyLayer
//    }
//
//    // TODO: Remove intermediate layers when their last sublayer gets removed
//}

extension CGPoint {
    static func makeRandom(within range: Range<Int>) -> CGPoint {
        return CGPoint(x: .makeRandom(within: range), y: .makeRandom(within: range))
    }
}

extension CGSize {
    static func makeRandom(within range: Range<Int>) -> CGSize {
        return CGSize(width: .makeRandom(within: range), height: .makeRandom(within: range))
    }
}

extension CGFloat {
    static func makeRandom() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }

    static func makeRandom(within range: Range<Int>) -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(range.upperBound)) + UInt32(range.lowerBound))
    }
}

extension NSColor {
    static func random() -> NSColor {
        return NSColor(red:   .makeRandom(),
                       green: .makeRandom(),
                       blue:  .makeRandom(),
                       alpha: 1.0)
    }
}
