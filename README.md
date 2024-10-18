# Flash_filters

## This application gives users ability to add filters onto their selected pictures which mimic the polaroid effect. 

### Overview 

Used Core Image to apply the grain and scratch effects by taking advantage of filters like CIRandomGenerator for randomness, along with CIColorMatrix to adjust colors and intensities. Randomness was the prime factor in making the effects look natural as required, especially for grain and scratch patterns, and performance optimization implemented by handling image processing on background threads.

### Built using:- 

#### User Interface
• UIKit (Programmtic interface) and dark mode support

#### Filters 
• Filters were made using Apple's CoreImage

#### Randomness 
• Utilized CoreImage's CIRandomGenerator to achieve desired randomness in achieving noise. 

#### Core Image Filter Flow:-  
1. Grain Effect:

- CIRandomGenerator generates random noise.
- CIColorMatrix transforms the noise into white specks (grain).
- CISourceOverCompositing blends the grain on top of the original image.


2. Scratch Effect:

- CIRandomGenerator generates random noise.
- CGAffineTransform stretches the noise vertically to create long, scratch-like lines.
- CIColorMatrix darkens the noise to make the scratches visible.
- CIMinimumComponent converts the darkened scratches to grayscale.
- CIMultiplyCompositing composites the scratches on top of the original image.


#### Challenges observed 

Initially, the scratch effect wasn’t visible due to improper scaling and darkening. Thus, tweaking the noise transformation and adjusting the color matrix resolved this. Also ensured the randomness looked authentic without performance lags was another hurdle, but the implementation of using background processing for respective background processing solved the issue.

#### References:- 
https://developer.apple.com/documentation/coreimage/simulating_scratchy_analog_film






 




