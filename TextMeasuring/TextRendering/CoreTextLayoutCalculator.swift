import Foundation


/// Calculates the frame of an AttributedString (faster approach than the NSLayoutManager variant)
final class CoreTextLayoutCalculator {

    func calculateFrame(for attributedString: NSAttributedString) -> CGRect {
        let path = CGPath(rect: CGRect(x: 0.0, y: 0.0, width: .greatestFiniteMagnitude, height: .greatestFiniteMagnitude), transform: nil)
        var fullHeight: CGFloat = 0.0
        var fullWidth: CGFloat = 0.0
        let frameSetter = CTFramesetterCreateWithAttributedString(attributedString as CFAttributedString)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        let lines = CTFrameGetLines(frame) as NSArray
        for line in lines {
            var ascent: CGFloat = 0
            var descent: CGFloat = 0
            var leading: CGFloat = 0
            let width = CTLineGetTypographicBounds(line as! CTLine, &ascent, &descent, &leading)
            fullWidth = max(fullWidth, CGFloat(width))
            leading = floor (leading + 0.5);

            let lineHeight = floor (ascent + 0.5) + floor (descent + 0.5) + leading
            let ascenderDelta = floor (0.2 * lineHeight + 0.5)
            fullHeight += lineHeight + ascenderDelta
        }

        return CGRect(x: 0.0, y: 0.0, width: fullWidth, height: fullHeight)    }
}
