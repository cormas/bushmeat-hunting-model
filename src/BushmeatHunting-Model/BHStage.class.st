Class {
	#name : #BHStage,
	#superclass : #Object,
	#instVars : [
		'anthelope'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #'instance creation' }
BHStage class >> ageDifferenceBetweenSex [

	^ false
]

{ #category : #'instance creation' }
BHStage class >> maxAgeLimit [

	self subclassResponsibility
]

{ #category : #'instance creation' }
BHStage class >> minAgeLimit [

	self subclassResponsibility
]

{ #category : #'instance creation' }
BHStage class >> newFor: anAnthelope [

	^ self new
		initializeWith: anAnthelope;
		yourself
]

{ #category : #'instance creation' }
BHStage class >> stageFor: arg1 [

	^ self ageDifferenceBetweenSex
		  ifTrue: [ 
		  arg1 age between: arg1 minAgeLimit and: arg1 maxAgeLimit ]
		  ifFalse: [ 
		  arg1 age between: self minAgeLimit and: self maxAgeLimit ]
]

{ #category : #'instance creation' }
BHStage class >> updateStageFrom: anAnthelope [
	" Answer a new receiver's instance for anAnthelope "
	
	(self subclasses 
		detect: [ : stageSubclass | stageSubclass stageFor: anAnthelope ]
		ifFound: [ : stageSubclass | 
			^ anAnthelope stage class = stageSubclass
				ifTrue: [ anAnthelope stage ]
				ifFalse: [ stageSubclass newFor: anAnthelope ] ]) 
]

{ #category : #accessing }
BHStage >> anthelope [

	^ anthelope
]

{ #category : #accessing }
BHStage >> anthelope: arg1 [

	anthelope := arg1
]

{ #category : #testing }
BHStage >> dyingProbability [

	self subclassResponsibility
]

{ #category : #accessing }
BHStage >> friendlyName [

	self subclassResponsibility
]

{ #category : #initialization }
BHStage >> initializeWith: anAnthelope [

	self anthelope: anAnthelope
]

{ #category : #testing }
BHStage >> isAdult [

	^ false
]

{ #category : #testing }
BHStage >> isNewborn [ 

	^ false
]

{ #category : #testing }
BHStage >> isProbablyDying [

	^ Cormas random < self dyingProbability
]

{ #category : #printing }
BHStage >> printOn: aStream [

	aStream
		<< '['
		<< self friendlyName;
		<< ']'
]

{ #category : #testing }
BHStage >> sizeOfPOV [

	^ self subclassResponsibility
]

{ #category : #testing }
BHStage >> updateLivingStatus [

	self isProbablyDying 
		ifTrue: [ self anthelope delete ]
]
