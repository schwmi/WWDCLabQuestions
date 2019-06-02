import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Tested with iPhone Xs (MT9E2ZD/A)
        let sideLength: CGFloat
        //sideLength = 7000.0 // OK, can allocate
        //sideLength = 8000.0 // CRASHES (memory issue)
        //sideLength = 10000.0 // CRASHES (memory issue)
        sideLength = 10500.0 // Crashes (memory issue)
        //sideLength = 11000.0 // OK, can allocate
        //sideLength = 12000.0 // OK, can allocate
        //sideLength = 14000.0 // OK, cannot allocate - no crash
        let size = CGSize(sideLength: sideLength)

        print("Try to allocate for image with size \(size)")
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()

        self.view.backgroundColor = (context == nil) ? .red : .green
    }
}

// MARK: - Helper

private extension CGSize {

    init(sideLength: CGFloat) {
        self.init(width: sideLength, height: sideLength)
    }
}


// Tested with iPad Pro (model A1584) - similar patterns on other devices (tested with MD795FD/A), but sizes have to be changed
// size = .init(sideLength: 19149.0) //  OK, cannot allocate
// size = .init(sideLength: 18149.0) //  OK, cannot allocate
// size = .init(sideLength: 18060.0) // OK, can allocate
// size = .init(sideLength: 18000.0) // OK, can allocate
// size = .init(sideLength: 17979.0) // CRASHES
// size = .init(sideLength: 17149.0) // CRASHES
// size = .init(sideLength: 16120.0) // CRASHES
// size = .init(sideLength: 14149.0) // CRASHES
// size = .init(sideLength: 14148.0) // OK, can allocate
