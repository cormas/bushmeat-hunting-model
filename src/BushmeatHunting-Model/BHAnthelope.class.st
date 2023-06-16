Class {
	#name : #BHAnthelope,
	#superclass : #CMAgent,
	#traits : 'TCMLocated',
	#classTraits : 'TCMLocated classTrait',
	#instVars : [
		'age',
		'partner',
		'stage'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #converting }
BHAnthelope class >> asGetterForEntityClass [

	self subclassResponsibility 
]

{ #category : #accessing }
BHAnthelope class >> maxAgeLimit [

	^ SmallInteger maxVal
]

{ #category : #accessing }
BHAnthelope >> age [

	^ age
]

{ #category : #accessing }
BHAnthelope >> age: arg1 [

	age := arg1
]

{ #category : #testing }
BHAnthelope >> customShapeSelector [

	^ #ellipse "self hasPartner
		  ifTrue: [ 
			  self halt.
			  #bitmap ]
		  ifFalse: [ #ellipse ]"
]

{ #category : #moving }
BHAnthelope >> delete [

	self cormasModel removeAnthelope: self.
	super delete.

]

{ #category : #accessing }
BHAnthelope >> detailsOfPOV [
	" Answer a <String> to visually distinguish the receiver in a space "

	^ String << [ : stream |
		stream 
			<< 'Sex: '; << self sexString; cr; 
			<< 'Stage: '; << self stage friendlyName; cr;
			<< 'Age: '; << self age asString; cr;
			<< 'Location: '; << self coordinates asString.
		self hasPartner 
			ifTrue: [ 
				stream cr; << 'Partner: ';
					<< self partner asString ] ]
]

{ #category : #'population dynamics' }
BHAnthelope >> findPartner [

	self subclassResponsibility
]

{ #category : #testing }
BHAnthelope >> hasCustomShape [

	^ self hasPartner
]

{ #category : #testing }
BHAnthelope >> hasNoPartner [

	^ partner isNil
]

{ #category : #testing }
BHAnthelope >> hasPartner [

	^ partner notNil
]

{ #category : #'initialize-release' }
BHAnthelope >> init [

	self
		dead: false;
		age: (0 to: 200) atRandom;
		stage: (BHStage updateStageFrom: self)
]

{ #category : #'initialize-release' }
BHAnthelope >> init0 [

	super init.
	self
		dead: false;
		age: 0
]

{ #category : #testing }
BHAnthelope >> isAdult [

	^ self stage isAdult
]

{ #category : #testing }
BHAnthelope >> isAlive [

	^ self isDead not
]

{ #category : #testing }
BHAnthelope >> isFemale [ 

	^ false
]

{ #category : #testing }
BHAnthelope >> isNewborn [

	^ self stage isNewborn
]

{ #category : #accessing }
BHAnthelope >> labelOfPOV [
	" Answer a <String> to visually distinguish the receiver in a space "

	^ String << [ : stream |
		stream 
			<< self sexString first;
			space; 
			<< self age asString ]
]

{ #category : #accessing }
BHAnthelope >> maxAgeLimit [

	^ self class maxAgeLimit
]

{ #category : #accessing }
BHAnthelope >> minAgeLimit [

	^ self class minAgeLimit
]

{ #category : #'population dynamics' }
BHAnthelope >> move [

	self findPartner
		ifNil: [ self moveToEmptyPlace ]
		ifNotNil: [ : candidateAnthelope |
			partner := candidateAnthelope.
			self moveTo: candidateAnthelope patch.
			partner partner: self ]
]

{ #category : #moving }
BHAnthelope >> moveTo: nearestEmptyLoc [

	super moveTo: nearestEmptyLoc.
	nearestEmptyLoc hasTrap ifFalse: [ ^ self ].
	self cormasModel increaseCatchesNumber.
	nearestEmptyLoc increaseTrapCatches.
	self delete
]

{ #category : #'population dynamics' }
BHAnthelope >> moveToEmptyPlace [

	 self nearestEmptyLocation
		ifNil: [ ('No empty location for: ' , self id asString) traceCr ]
		ifNotNil: [ : nearestEmptyLoc | self moveTo: nearestEmptyLoc ]
]

{ #category : #accessing }
BHAnthelope >> partner [

	^ partner
]

{ #category : #accessing }
BHAnthelope >> partner: arg1 [

	partner := arg1
]

{ #category : #pov }
BHAnthelope >> pov [

	^ self isDead
		  ifTrue: [ Color black ]
		  ifFalse: [ 
				self hasPartner
				  ifTrue: [ Color red ]
				  ifFalse: [ 
						self isNewborn
							ifTrue: [ Color white ]
							ifFalse: [ self povColor ] ] ]
]

{ #category : #printing }
BHAnthelope >> printOn: aStream [

	aStream
		<< 'Id: ';
		<< self id asString;
		space;
		<< 'Stage: ';
		<< self stage asString;
		space;
		<< 'Sex: ';
		<< self sexString
]

{ #category : #printing }
BHAnthelope >> sexString [

	self subclassResponsibility
]

{ #category : #accessing }
BHAnthelope >> sizeOfPOV [
	" Answer a <Number> to visually distinguish the receiver in a space "

	^ self stage sizeOfPOV
]

{ #category : #accessing }
BHAnthelope >> stage [

	^ stage
]

{ #category : #accessing }
BHAnthelope >> stage: aCMBushmeatStage [

	stage := aCMBushmeatStage
]

{ #category : #control }
BHAnthelope >> step [

	self
		age: self age + 1;
		updateStage;
		updateLivingStatus;
		updateBehavior
]

{ #category : #'population dynamics' }
BHAnthelope >> updateBehavior [

	(self isDead not and: [ self isAdult and: [ self hasPartner not ] ])
		ifTrue: [ self move ]
]

{ #category : #'population dynamics' }
BHAnthelope >> updateLivingStatus [
	" Update the receiver's dead or alive status using a random probability according to its stage "
	
	self stage updateLivingStatus
	
]

{ #category : #'population dynamics' }
BHAnthelope >> updateStage [
	" Update the receiver's stage "
	
	self stage: (BHStage updateStageFrom: self)
]
