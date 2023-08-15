Class {
	#name : #BHStage,
	#superclass : #Object,
	#instVars : [
		'antelope'
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
BHStage class >> newFor: anAntelope [

	^ self new
		initializeWith: anAntelope;
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
BHStage class >> updateStageFrom: anAntelope [
	" Answer a new receiver's instance for anAntelope "
	
	(self subclasses 
		detect: [ :stageSubclass | stageSubclass stageFor: anAntelope ]
		ifFound: [ :stageSubclass | 
			^ anAntelope stage class = stageSubclass
				ifTrue: [ anAntelope stage ]
				ifFalse: [ stageSubclass newFor: anAntelope ] ]) 
]

{ #category : #accessing }
BHStage >> antelope [

	^ antelope
]

{ #category : #accessing }
BHStage >> antelope: arg1 [

	antelope := arg1
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
BHStage >> initializeWith: anAntelope [

	self antelope: anAntelope
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
		ifTrue: [ self antelope delete ]
]
