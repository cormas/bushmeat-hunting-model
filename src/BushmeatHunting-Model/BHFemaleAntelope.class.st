Class {
	#name : #BHFemaleAntelope,
	#superclass : #BHAntelope,
	#instVars : [
		'gestationLength',
		'newBorns'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #converting }
BHFemaleAntelope class >> asGetterForEntityClass [

	^ #femaleAntelopes
]

{ #category : #accessing }
BHFemaleAntelope class >> minAgeLimit [

	^ 72
]

{ #category : #'population dynamics' }
BHFemaleAntelope >> addNewborn [

	| newAntelope |			

	newAntelope := self class new init0.
	newAntelope patch: patch.
	self newBorns add: newAntelope

]

{ #category : #accessing }
BHFemaleAntelope >> detailsOfPOV [

	^ String << [ : stream | 
		stream 
			<< super detailsOfPOV; cr;
			<< self offspringDetails ]
]

{ #category : #'population dynamics' }
BHFemaleAntelope >> findPartner [
	" do nothing "
	
	^ nil
]

{ #category : #accessing }
BHFemaleAntelope >> gestationLength [

	^ gestationLength
		  ifNil: [ gestationLength := 0 ]
		  ifNotNil: [ gestationLength ]
]

{ #category : #accessing }
BHFemaleAntelope >> gestationLength: arg1 [

	gestationLength := arg1
]

{ #category : #'initialize - release' }
BHFemaleAntelope >> init0 [

	super init0.
	gestationLength := 0
]

{ #category : #testing }
BHFemaleAntelope >> isFemale [ 

	^ true
]

{ #category : #accessing }
BHFemaleAntelope >> isPatchingWithAdultMale [

	^ ((patch occupantsType: BHMaleAntelope) anySatisfy: [ :arg1 | 
		   arg1 age < 21 ]) not
]

{ #category : #accessing }
BHFemaleAntelope >> newBorns [

	^ newBorns
		ifNil: [ newBorns := OrderedCollection new ]
]

{ #category : #printing }
BHFemaleAntelope >> offspringDetails [
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
BHFemaleAntelope >> povColor [

	^ Color pink
]

{ #category : #accessing }
BHFemaleAntelope >> pregnancyTime [

	^ 30
]

{ #category : #printing }
BHFemaleAntelope >> printOn: aStream [
	" Private - See superimplementor's comment "

	super printOn: aStream.
	aStream << self offspringDetails
]

{ #category : #printing }
BHFemaleAntelope >> sexString [

	^ 'Female'
]

{ #category : #'population dynamics' }
BHFemaleAntelope >> updateBehavior [

	super updateBehavior.
	self isDead not
		ifTrue: [ self updateGestationBehavior ]
]

{ #category : #'population dynamics' }
BHFemaleAntelope >> updateGestationBehavior [

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
