Class {
	#name : #BHHuntingFamily,
	#superclass : #CMGroup,
	#instVars : [
		'traps',
		'space',
		'trapLocationStrategy',
		'familyColor'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #converting }
BHHuntingFamily class >> asGetterForEntityClass [

	^ #huntingFamilies
]

{ #category : #'instance creation' }
BHHuntingFamily class >> newWithId: anInteger forSpace: aCMSpaceModel [ 

	^ self basicNew
		id: anInteger; 
		space: aCMSpaceModel;
		initialize;
		yourself
	
]

{ #category : #testing }
BHHuntingFamily >> allowedToAddTraps [
	" Answer <true> if the receiver is allowed to add traps "

	^ self currentTrapNumber <= self maximumAllowedTrapsPerCell and: [ 
		self currentTrapNumber <= self maximumNumberAllowedGlobalTraps ] 
]

{ #category : #accessing }
BHHuntingFamily >> chooseTrapLocation [
	" Answer a <Point> which is a coordinate in the range of the receiver's space model "
	
	^ self trapLocationStrategy chooseTrapLocation
]

{ #category : #accessing }
BHHuntingFamily >> currentTrapNumber [

	^ self traps size
]

{ #category : #accessing }
BHHuntingFamily >> defaultTrapLocationStrategy [

	^ BHRandomTrapLocationStategy 
]

{ #category : #accessing }
BHHuntingFamily >> familyColor [

	^ familyColor
]

{ #category : #accessing }
BHHuntingFamily >> familyColor: anObject [

	familyColor := anObject
]

{ #category : #testing }
BHHuntingFamily >> hasTrap [
	" Answer <true> if the receiver contains at least one trap "

	^ traps notNil and: [ traps notEmpty ]
]

{ #category : #initialization }
BHHuntingFamily >> initialize [

	super initialize.
	self familyColor: Color random.
]

{ #category : #private }
BHHuntingFamily >> maximumAllowedTrapsPerCell [

	^ BHModel maximumAllowedTrapsPerCell
]

{ #category : #private }
BHHuntingFamily >> maximumNumberAllowedGlobalTraps [

	^ BHModel maximumNumberAllowedGlobalTraps
]

{ #category : #accessing }
BHHuntingFamily >> removeTraps [

	self traps do: #removeTrap
]

{ #category : #initialization }
BHHuntingFamily >> setupFamilyTraps [

	self traps add: (BHTrap forFamily: self location: self chooseTrapLocation)
]

{ #category : #initialization }
BHHuntingFamily >> setupTraps [
	" Add or update the receiver's traps verifying conditions "

	[ self allowedToAddTraps ] 
		whileTrue: [ self setupFamilyTraps ].
"	self shouldUpdateTrapLocations
		ifTrue: [ self updateFamilyTrapLocations ]"
]

{ #category : #accessing }
BHHuntingFamily >> space [

	^ space
]

{ #category : #accessing }
BHHuntingFamily >> space: aCMSpaceModel [ 
	space := aCMSpaceModel
]

{ #category : #accessing }
BHHuntingFamily >> trapLocationStrategy [

	^ trapLocationStrategy
		ifNil: [ trapLocationStrategy := self defaultTrapLocationStrategy newFor: self ]
]

{ #category : #accessing }
BHHuntingFamily >> trapLocationStrategy: anObject [

	trapLocationStrategy := anObject
]

{ #category : #accessing }
BHHuntingFamily >> traps [

	^ traps
		ifNil: [ traps := OrderedCollection new ]
]

{ #category : #accessing }
BHHuntingFamily >> traps: arg1 [

	traps := arg1
]
