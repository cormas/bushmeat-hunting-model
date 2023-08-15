Class {
	#name : #BHAntelope,
	#superclass : #CMAgent,
	#traits : 'TCMLocated @ {#basicMoveTo:->#moveTo:}',
	#classTraits : 'TCMLocated classTrait',
	#instVars : [
		'age',
		'partner',
		'stage'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #converting }
BHAntelope class >> asGetterForEntityClass [

	self subclassResponsibility 
]

{ #category : #accessing }
BHAntelope class >> maxAgeLimit [

	^ SmallInteger maxVal
]

{ #category : #accessing }
BHAntelope >> age [

	^ age
]

{ #category : #accessing }
BHAntelope >> age: arg1 [

	age := arg1
]

{ #category : #testing }
BHAntelope >> customShapeSelector [

	^ #ellipse "self hasPartner
		  ifTrue: [ 
			  self halt.
			  #bitmap ]
		  ifFalse: [ #ellipse ]"
]

{ #category : #moving }
BHAntelope >> delete [

	self cormasModel removeAntelope: self.
	super delete.

]

{ #category : #accessing }
BHAntelope >> detailsOfPOV [
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
BHAntelope >> findPartner [

	self subclassResponsibility
]

{ #category : #testing }
BHAntelope >> hasCustomShape [

	^ self hasPartner
]

{ #category : #testing }
BHAntelope >> hasNoPartner [

	^ partner isNil
]

{ #category : #testing }
BHAntelope >> hasPartner [

	^ partner notNil
]

{ #category : #'initialize-release' }
BHAntelope >> init [

	self
		age: (0 to: 200) atRandom;
		stage: (BHStage updateStageFrom: self)
]

{ #category : #'initialize-release' }
BHAntelope >> init0 [

	super init.
	self age: 0
]

{ #category : #testing }
BHAntelope >> isAdult [

	^ self stage isAdult
]

{ #category : #testing }
BHAntelope >> isFemale [ 

	^ false
]

{ #category : #testing }
BHAntelope >> isNewborn [

	^ self stage isNewborn
]

{ #category : #accessing }
BHAntelope >> labelOfPOV [
	" Answer a <String> to visually distinguish the receiver in a space "

	^ String << [ : stream |
		stream 
			<< self sexString first;
			space; 
			<< self age asString ]
]

{ #category : #accessing }
BHAntelope >> maxAgeLimit [

	^ self class maxAgeLimit
]

{ #category : #accessing }
BHAntelope >> minAgeLimit [

	^ self class minAgeLimit
]

{ #category : #'population dynamics' }
BHAntelope >> move [

	self findPartner
		ifNil: [ self moveToEmptyPlace ]
		ifNotNil: [ :candidateAntelope |
			partner := candidateAntelope.
			self moveTo: candidateAntelope patch.
			partner partner: self ]
]

{ #category : #moving }
BHAntelope >> moveTo: nearestEmptyLoc [

	self basicMoveTo: nearestEmptyLoc.
	nearestEmptyLoc hasTrap ifFalse: [ ^ self ].
	self cormasModel increaseCatchesNumber.
	nearestEmptyLoc increaseTrapCatches.
	self delete
]

{ #category : #'population dynamics' }
BHAntelope >> moveToEmptyPlace [

	 self nearestEmptyLocation
		ifNil: [ ('No empty location for: ' , self id asString) traceCr ]
		ifNotNil: [ : nearestEmptyLoc | self moveTo: nearestEmptyLoc ]
]

{ #category : #accessing }
BHAntelope >> partner [

	^ partner
]

{ #category : #accessing }
BHAntelope >> partner: arg1 [

	partner := arg1
]

{ #category : #pov }
BHAntelope >> pov [

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
BHAntelope >> printOn: aStream [

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
BHAntelope >> sexString [

	self subclassResponsibility
]

{ #category : #accessing }
BHAntelope >> sizeOfPOV [
	" Answer a <Number> to visually distinguish the receiver in a space "

	^ self stage sizeOfPOV
]

{ #category : #accessing }
BHAntelope >> stage [

	^ stage
]

{ #category : #accessing }
BHAntelope >> stage: aCMBushmeatStage [

	stage := aCMBushmeatStage
]

{ #category : #control }
BHAntelope >> step [

	self
		age: self age + 1;
		updateStage;
		updateLivingStatus;
		updateBehavior
]

{ #category : #'population dynamics' }
BHAntelope >> updateBehavior [

	(self isDead not and: [ self isAdult and: [ self hasPartner not ] ])
		ifTrue: [ self move ]
]

{ #category : #'population dynamics' }
BHAntelope >> updateLivingStatus [
	" Update the receiver's dead or alive status using a random probability according to its stage "
	
	self stage isProbablyDying 
		ifTrue: [ self delete ]
	
]

{ #category : #'population dynamics' }
BHAntelope >> updateStage [
	" Update the receiver's stage "
	
	self stage: (BHStage updateStageFrom: self)
]
