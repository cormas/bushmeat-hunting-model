Class {
	#name : #BHSubadultStage,
	#superclass : #BHStage,
	#category : #'BushmeatHunting-Model'
}

{ #category : #accessing }
BHSubadultStage class >> maxAgeLimit [

	^ 95
]

{ #category : #accessing }
BHSubadultStage class >> minAgeLimit [

	^ 40
]

{ #category : #accessing }
BHSubadultStage >> dyingProbability [

	^ 1 - (0.7 raisedTo: 1 / 40)
]

{ #category : #accessing }
BHSubadultStage >> friendlyName [

	^ 'Subadult'
]

{ #category : #accessing }
BHSubadultStage >> sizeOfPOV [

	^ 15
]
