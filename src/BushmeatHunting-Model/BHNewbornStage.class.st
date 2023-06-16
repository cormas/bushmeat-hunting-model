Class {
	#name : #BHNewbornStage,
	#superclass : #BHStage,
	#category : #'BushmeatHunting-Model'
}

{ #category : #accessing }
BHNewbornStage class >> maxAgeLimit [

	^ 21
]

{ #category : #accessing }
BHNewbornStage class >> minAgeLimit [

	^ 0
]

{ #category : #accessing }
BHNewbornStage >> dyingProbability [

	^ 1 - (0.99 raisedTo: 1 / 21)
]

{ #category : #accessing }
BHNewbornStage >> friendlyName [

	^ 'Newborn'
]

{ #category : #testing }
BHNewbornStage >> isNewborn [

	^ true
]

{ #category : #accessing }
BHNewbornStage >> sizeOfPOV [

	^ 5
]
