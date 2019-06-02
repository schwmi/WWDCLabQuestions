# Zooming Performance Problem

We experienced severe performance problems when zooming a scrollView containing >1000 sublayer for some macs (depending on GPU type) if out-of-process layer rendering/compositing is active. Especially, macs with nVidia cards show significant slowdowns.
Therefore we implemented a heuristic to opt out from out-of-process rendering for some macs using `layerUsesCoreImageFilters` property on the layer's container.


## Components

A sample app for testing zoom behaviour with `layerUsesCoreImageFilters` enabled and not.

