Class {
	#name : #BHTrap,
	#superclass : #Object,
	#instVars : [
		'family',
		'location',
		'totalCatches',
		'seasonCatches'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #'instance creation' }
BHTrap class >> forFamily: aCMBushmeatHuntingFamily location: aPoint [ 

	^ self new
		family: aCMBushmeatHuntingFamily;
		location: aPoint;
		yourself
]

{ #category : #accessing }
BHTrap >> addCatch [
	" The receiver catched a located entity, increment the seasonal catches "
	
	self seasonCatches: self seasonCatches + 1
]

{ #category : #printing }
BHTrap >> asString [

	^ String << [ : stream | 
		stream
			<< 'Trap of family: ';
			<< self family asString;
			cr;
			<< 'Location: ';
			<< self location asString;
			cr;
			<< 'Season catches: ';
			<< self seasonCatches asString;
			cr ]

]

{ #category : #accessing }
BHTrap >> color [

	^ self family familyColor
]

{ #category : #accessing }
BHTrap >> family [

	^ family
]

{ #category : #accessing }
BHTrap >> family: aCMBushmeatHuntingFamily [ 
	family := aCMBushmeatHuntingFamily
]

{ #category : #testing }
BHTrap >> hasLocation [
	" Answer <true> if the receiver is configured with a specific location "

	^ location notNil
]

{ #category : #accessing }
BHTrap >> increaseCatch [ 

	self totalCatches: self totalCatches + 1.
	self seasonCatches: self seasonCatches + 1.
]

{ #category : #initialization }
BHTrap >> initialize [

	super initialize.
	self hasLocation
		ifTrue: [ self seasonCatches: self seasonCatches + 1 ]
]

{ #category : #accessing }
BHTrap >> location [

	^ location
]

{ #category : #accessing }
BHTrap >> location: aPoint [ 
	location := aPoint
]

{ #category : #printing }
BHTrap >> printOn: aStream [

	aStream << self asString
]

{ #category : #accessing }
BHTrap >> removeTrap [
	" Configure the receiver to be removed from its current location "
	
	self totalCatches: self totalCatches + self seasonCatches.
	self seasonCatches: 0.
]

{ #category : #accessing }
BHTrap >> seasonCatches [

	^ seasonCatches
		ifNil: [ seasonCatches := 0 ]
]

{ #category : #accessing }
BHTrap >> seasonCatches: anObject [

	seasonCatches := anObject
]

{ #category : #accessing }
BHTrap >> totalCatches [

	^ totalCatches 
		ifNil: [ totalCatches := 0 ]
]

{ #category : #accessing }
BHTrap >> totalCatches: anObject [

	totalCatches := anObject
]
