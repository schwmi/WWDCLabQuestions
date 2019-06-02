import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var result: NSTextField!
    @IBOutlet weak var frameNSLayoutManagerTextField: NSTextField!
    @IBOutlet weak var frameCTTextField: NSTextField!
    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.textView.delegate = self
        self.textView.string = "Hello WWDC"
        self.updateFrameMeasurings()
    }
}

extension AppDelegate: NSTextViewDelegate {

    func textDidChange(_ notification: Notification) {
        self.updateFrameMeasurings()
    }
}

// MARK: - Privat

private extension AppDelegate {

    func updateFrameMeasurings() {
        let string = self.textView.attributedString()
        let ctFrame = CoreTextLayoutCalculator().calculateFrame(for: string)
        let nsLayoutManagerFrame = NSLayoutManagerLayoutCalculator().calculateFrame(for: string)
        self.frameCTTextField.stringValue = "\(ctFrame.debugDescription)"
        self.frameNSLayoutManagerTextField.stringValue = "\(nsLayoutManagerFrame.debugDescription)"
        let matches = ctFrame == nsLayoutManagerFrame
        if matches {
            self.result.textColor = .green
            self.result.stringValue = "Matches"
        } else {
            self.result.textColor = .red
            self.result.stringValue = "Different frames"
        }
    }
}


// MARK: - Test with randomized samples

//    func startSampling() {
//        let calculator1 = CoreTextLayoutCalculator()
//        let calculator2 = NSLayoutManagerLayoutCalculator()
//        let start = Date()
//        for _ in 0...10000 {
//            let string = self.makeSampleString()
//            let rect = calculator1.calculateFrame(for: string)
//            let rect2 = calculator2.calculateFrame(for: string)
//            print("new String: \(string.string)")
//            if rect != rect2 {
//                assertionFailure("Different rect")
//            }
//
//        }
//        print("Used time: \(Date().timeIntervalSince(start))")
//    }
//
//    func makeSampleString() -> NSAttributedString {
//        let bagOfWords = ["Hello", "World", "test", "return", "sample", "\n", "newline", "anotherWord", "12312", "Earth", "Moon", "Sun", "Island", "Sky", "UPC", "\n", "   ", "\n"]
//
//        let usedWords = Int(arc4random_uniform(UInt32(bagOfWords.count / 2))) + 1
//        var string = ""
//        for _ in 0..<usedWords {
//            let index = Int(arc4random_uniform(UInt32(bagOfWords.count - 1)))
//            string.append(bagOfWords[index])
//        }
//        return NSAttributedString(string: string)
//    }

