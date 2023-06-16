Class {
	#name : #BHTrapLocationStategy,
	#superclass : #Object,
	#instVars : [
		'families',
		'space'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #'instance creation' }
BHTrapLocationStategy class >> newFor: aFamily [

	^ self new
		addFamily: aFamily;
		space: aFamily space;
		yourself
]

{ #category : #'instance creation' }
BHTrapLocationStategy class >> newFor: aFamily in: aSpaceModel [

	^ self new
		addFamily: aFamily;
		space: aSpaceModel;
		yourself
]

{ #category : #adding }
BHTrapLocationStategy >> addFamily: aFamily [

	self families add: aFamily
]

{ #category : #accessing }
BHTrapLocationStategy >> chooseTrapLocation [ 

	self subclassResponsibility 
]

{ #category : #accessing }
BHTrapLocationStategy >> families [

	^ families
		ifNil: [ families := OrderedCollection new ]
]

{ #category : #accessing }
BHTrapLocationStategy >> families: anObject [

	families := anObject
]

{ #category : #accessing }
BHTrapLocationStategy >> space [

	^ space
]

{ #category : #accessing }
BHTrapLocationStategy >> space: anObject [

	space := anObject
]
