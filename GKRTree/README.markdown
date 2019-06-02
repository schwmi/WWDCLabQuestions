# GKRTree Problem

GKRTree's elements(inBoundingRectMin:rectMax:) currently only returns elements which are fully contained in the bounding rect.
For various R-Tree use cases (like collision detection, lasso selection, nearest neighbour search) it would make sense to have a method elements(overlappingBoundingRectMin:rectMax:) which returns all elements which are fully contained by the boundingRect + all elements which are intersecting the boundingRect.

## Components

A sample playground showing the issue with the currently implementation.

## Radar

Filed with no 32786254 (GKRTree elements(inBoundingRectMin:rectMax:) is broken)
and 33176154 (GKRTRee should provide functionality returning elements which overlap a search rect.)
