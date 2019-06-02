import Cocoa


/// Calculates the frame of an AttributedString (currently used in MindNode)
final class NSLayoutManagerLayoutCalculator {

    func calculateFrame(for attributedString: NSAttributedString) -> CGRect {
        let textStorage = NSTextStorage()
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer()
        textContainer.lineFragmentPadding = 0

        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)

        textStorage.setAttributedString(attributedString)

        textContainer.size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        layoutManager.ensureLayout(for: textContainer)
        return layoutManager.usedRect(for: textContainer)
    }
}
