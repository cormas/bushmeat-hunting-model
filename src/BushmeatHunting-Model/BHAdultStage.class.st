Class {
	#name : #BHAdultStage,
	#superclass : #BHStage,
	#category : #'BushmeatHunting-Model'
}

{ #category : #testing }
BHAdultStage class >> ageDifferenceBetweenSex [

	^ true
]

{ #category : #accessing }
BHAdultStage class >> maxAgeLimit [

	^ SmallInteger maxVal
]

{ #category : #accessing }
BHAdultStage class >> minAgeLimit [

	^ 95
]

{ #category : #accessing }
BHAdultStage >> dyingProbability [

	^ 1 - (0.01 raisedTo: 1 / 100)
]

{ #category : #accessing }
BHAdultStage >> friendlyName [

	^ 'Adult'
]

{ #category : #testing }
BHAdultStage >> isAdult [

	^ true
]

{ #category : #accessing }
BHAdultStage >> sizeOfPOV [

	^ 25
]
