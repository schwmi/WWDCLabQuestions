# Text Measuring Problems

Text measuring using `CTFramesetter` would have the benefit that it is substantially faster than our currently used `NSLayoutManager` approach (~ 10x faster).

## Components
- A macOS sample app `TextRendering` for abitrary text input and instant measuring results and `TextRenderingTests` which show the performance diffs and failing measuring cases

## Issues
- Trailing newlines are not measured with CTFramesetter approach
- Wrong line width when the last character is a line break with CTFramesetter
- Emoji height is differnt for both approaches
