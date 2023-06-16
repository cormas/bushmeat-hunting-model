Class {
	#name : #BHJuvenileStage,
	#superclass : #BHStage,
	#category : #'BushmeatHunting-Model'
}

{ #category : #accessing }
BHJuvenileStage class >> maxAgeLimit [

	^ 40
]

{ #category : #testing }
BHJuvenileStage class >> minAgeLimit [

	^ 21
]

{ #category : #accessing }
BHJuvenileStage >> dyingProbability [

	^ 1 - (0.95 raisedTo: 1 / 95)
]

{ #category : #accessing }
BHJuvenileStage >> friendlyName [

	^ 'Juvenile'
]

{ #category : #accessing }
BHJuvenileStage >> sizeOfPOV [

	^ 9
]
