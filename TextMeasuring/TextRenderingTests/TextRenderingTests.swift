import XCTest
@testable import TextRendering


class TextRenderingTests: XCTestCase {

    // MARK: - Frame Calculation

    func testFrameCalculation() {
        // Simple 1-Liner Lines
        do {
            let frames = self.calculateFramesWithBothMethods(for: "Hello WWDC")
            XCTAssertEqual(frames.coreTextRect, frames.nsLayoutManagerRect)
        }

        // Simple 1-Liner width Emoji (fails different height)
        do {
            let frames = self.calculateFramesWithBothMethods(for: "Hello Bug 🐛")
            XCTAssertEqual(frames.coreTextRect, frames.nsLayoutManagerRect)
        }

        // Multiple Lines
        do {
            let frames = self.calculateFramesWithBothMethods(for: "Hello\n\nWorld\nFinalLine")
            XCTAssertEqual(frames.coreTextRect, frames.nsLayoutManagerRect)
        }

        // Multiple Lines With trailing newline (fails - different width and height)
        do {
            let frames = self.calculateFramesWithBothMethods(for: "Hello\n\nWorld\nFinalLine\n")
            XCTAssertEqual(frames.coreTextRect, frames.nsLayoutManagerRect)
        }
    }

    // MARK: - Performance Comparison

    func testPerformanceOfNSLayoutManagerApproach() {
        let layoutCalculator = NSLayoutManagerLayoutCalculator()
        // ~ 0.108 sec
        self.measure {
            self.calculateTextFramesForPerformanceMeasurement(layoutCalculator.calculateFrame)
        }
    }

    func testPerformanceOfCoreTextApproach() {
        let layoutCalculator = CoreTextLayoutCalculator()
        // ~ 0.010 sec
        self.measure {
            self.calculateTextFramesForPerformanceMeasurement(layoutCalculator.calculateFrame)
        }
    }
}

// MARK: - Private

private extension TextRenderingTests {

    func calculateFramesWithBothMethods(for string: String) -> (nsLayoutManagerRect: CGRect, coreTextRect: CGRect) {
        let attributedString = NSAttributedString(string: string)
        return (NSLayoutManagerLayoutCalculator().calculateFrame(for: attributedString),
                CoreTextLayoutCalculator().calculateFrame(for: attributedString))
    }

    func calculateTextFramesForPerformanceMeasurement(_ calculationBlock: (NSAttributedString) -> CGRect) {
        let sampleString = NSAttributedString(string: "Hello WWDC")
        for _ in 0..<1000 {
            _ = calculationBlock(sampleString)
        }
    }
}
