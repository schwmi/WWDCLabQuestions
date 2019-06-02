# Drag and Drop from Notes.app

Dragging text from Notes app into a UITextView leads to a exception when loading objects of class NSAttributedString (although `itemProvider.canLoadObjectOfClass:[NSAttributedString class]` returns `YES`). 

## Issue

Steps to Reproduce:
Drag content from the Notes app into a UITextView outside of Notes.

Expected Results:
App should be able to load objects of NSAttributedString

Actual Results:
Produces exception and NSAttributedString == nil:

Could not instantiate class NSAttributedString. Error: Error Domain=NSCocoaErrorDomain Code=1024 "*** -[NSKeyedUnarchiver decodeObjectForKey:]: cannot decode object of class (TTParagraphStyle) for key (NS.objects); the class may be defined in source code or a library that is not linked" UserInfo={NSLocalizedDescription=*** -[NSKeyedUnarchiver decodeObjectForKey:]: cannot decode object of class (TTParagraphStyle) for key (NS.objects); the class may be defined in source code or a library that is not linked}

## Radar

filed with: 36729079
