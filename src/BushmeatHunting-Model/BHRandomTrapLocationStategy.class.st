Class {
	#name : #BHRandomTrapLocationStategy,
	#superclass : #BHTrapLocationStategy,
	#category : #'BushmeatHunting-Model'
}

{ #category : #accessing }
BHRandomTrapLocationStategy >> chooseTrapLocation [ 

	^ self space randomCell coordinates
]
