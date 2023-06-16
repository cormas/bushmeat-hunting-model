Class {
	#name : #BHCellTest,
	#superclass : #TestCase,
	#instVars : [
		'cell'
	],
	#category : #'BushmeatHunting-Model-Tests'
}

{ #category : #running }
BHCellTest >> setUp [
	super setUp.
	
	cell := BHCell new.
]

{ #category : #tests }
BHCellTest >> testTrapsIsCollection [

	self assert: cell traps isCollection.
]

{ #category : #tests }
BHCellTest >> testTrapsIsInitializedEmpty [

	self assert: cell traps isEmpty.
]
