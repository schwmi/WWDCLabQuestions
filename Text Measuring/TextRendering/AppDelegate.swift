import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
       // self.startSampling()
    }

    func startSampling() {
        let calculator1 = CoreTextLayoutCalculator()
        let calculator2 = NSLayoutManagerLayoutCalculator()
        let start = Date()
        for _ in 0...10000 {
            let string = self.makeSampleString()
            let rect = calculator1.calculateFrame(for: string)
            let rect2 = calculator2.calculateFrame(for: string)
            print("new String: \(string.string)")
            if rect != rect2 {
                assertionFailure("Different rect")
            }

        }
        print("Used time: \(Date().timeIntervalSince(start))")
    }

    func makeSampleString() -> NSAttributedString {
        let bagOfWords = ["Hello", "World", "test", "return", "sample", "\n", "newline", "anotherWord", "12312", "Earth", "Moon", "Sun", "Island", "Sky", "UPC", "\n", "   ", "\n"]

        let usedWords = Int(arc4random_uniform(UInt32(bagOfWords.count / 2))) + 1
        var string = ""
        for _ in 0..<usedWords {
            let index = Int(arc4random_uniform(UInt32(bagOfWords.count - 1)))
            string.append(bagOfWords[index])
        }
        return NSAttributedString(string: string)
    }
}

