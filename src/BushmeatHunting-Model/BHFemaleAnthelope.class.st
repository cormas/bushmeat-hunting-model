Class {
	#name : #BHFemaleAnthelope,
	#superclass : #BHAnthelope,
	#instVars : [
		'gestationLength',
		'newBorns'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #converting }
BHFemaleAnthelope class >> asGetterForEntityClass [

	^ #femaleAnthelopes
]

{ #category : #accessing }
BHFemaleAnthelope class >> minAgeLimit [

	^ 72
]

{ #category : #'population dynamics' }
BHFemaleAnthelope >> addNewborn [

	| newAnthelope |			

	newAnthelope := self class new init0.
	newAnthelope patch: patch.
	self newBorns add: newAnthelope

]

{ #category : #accessing }
BHFemaleAnthelope >> detailsOfPOV [

	^ String << [ : stream | 
		stream 
			<< super detailsOfPOV; cr;
			<< self offspringDetails ]
]

{ #category : #'population dynamics' }
BHFemaleAnthelope >> findPartner [
	" do nothing "
	
	^ nil
]

{ #category : #accessing }
BHFemaleAnthelope >> gestationLength [

	^ gestationLength
		  ifNil: [ gestationLength := 0 ]
		  ifNotNil: [ gestationLength ]
]

{ #category : #accessing }
BHFemaleAnthelope >> gestationLength: arg1 [

	gestationLength := arg1
]

{ #category : #'initialize - release' }
BHFemaleAnthelope >> init0 [

	super init0.
	gestationLength := 0
]

{ #category : #testing }
BHFemaleAnthelope >> isFemale [ 

	^ true
]

{ #category : #accessing }
BHFemaleAnthelope >> isPatchingWithAdultMale [

	^ ((patch occupantsType: BHMaleAnthelope) anySatisfy: [ :arg1 | 
		   arg1 age < 21 ]) not
]

{ #category : #accessing }
BHFemaleAnthelope >> newBorns [

	^ newBorns
		ifNil: [ newBorns := OrderedCollection new ]
]

{ #category : #printing }
BHFemaleAnthelope >> offspringDetails [
	" Answer a <String> with offspring details of the receiver "
	
	^ String << [ : stream | 
		stream
			space;
			<< ' - ';
			<< 'Gest(';
			<< self gestationLength asString;
			<< ')';
			space;
			<< 'New borns: [';
			<< self newBorns size asString;
			<< ']' ]
]

{ #category : #pov }
BHFemaleAnthelope >> povColor [

	^ Color pink
]

{ #category : #accessing }
BHFemaleAnthelope >> pregnancyTime [

	^ 30
]

{ #category : #printing }
BHFemaleAnthelope >> printOn: aStream [
	" Private - See superimplementor's comment "

	super printOn: aStream.
	aStream << self offspringDetails
]

{ #category : #printing }
BHFemaleAnthelope >> sexString [

	^ 'Female'
]

{ #category : #'population dynamics' }
BHFemaleAnthelope >> updateBehavior [

	super updateBehavior.
	self isDead not
		ifTrue: [ self updateGestationBehavior ]
]

{ #category : #'population dynamics' }
BHFemaleAnthelope >> updateGestationBehavior [

	self gestationLength > 0 ifTrue: [ 
		gestationLength := gestationLength + 1 ].
	gestationLength = self pregnancyTime
		ifTrue: [ 
			gestationLength := 0.
			self addNewborn ]
		ifFalse: [ 
			(self hasPartner and: [ gestationLength = 0 and: [ self isPatchingWithAdultMale ] ]) 
				ifTrue: [ gestationLength := 1 ] ]
]
