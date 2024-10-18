# Flash_filters

## This application gives users ability to add filters onto their selected pictures which mimic the polaroid effect. 

### Built using:- 

#### User Interface
• UIKit (no storyboards)

#### Filters 
• Filters were made using Apple's CoreImage

#### Randomness 
• Utilized CoreImage's CIRandomGenerator to achieve desired randomness in achieving noise. 

#### Core Image Filter Flow:-  
1. Grain Effect:
	•	CIRandomGenerator generates random noise.

	•	CIColorMatrix transforms the noise into white specks (grain).

	•	CISourceOverCompositing blends the grain on top of the original image.


2.	Scratch Effect:
	•	CIRandomGenerator generates random noise.

	•	CGAffineTransform stretches the noise vertically to create long, scratch-like lines.

	•	CIColorMatrix darkens the noise to make the scratches visible.

	•	CIMinimumComponent converts the darkened scratches to grayscale.

	•	CIMultiplyCompositing composites the scratches on top of the original image.



#### References:- 
https://developer.apple.com/documentation/coreimage/simulating_scratchy_analog_film







 




