Class {
	#name : #BHCell,
	#superclass : #CMSpatialEntityElement,
	#instVars : [
		'area',
		'traps'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #converting }
BHCell class >> asGetterForEntityClass [

	^ #cells
]

{ #category : #accessing }
BHCell >> addTrap: aCMTrap [
	" The receiver could contain multiple traps. Add aCMTrap to the receiver's traps "
	
	self traps add: aCMTrap
]

{ #category : #accessing }
BHCell >> area [

	^ area
]

{ #category : #accessing }
BHCell >> area: arg1 [

	area := arg1
]

{ #category : #accessing }
BHCell >> asString [ 
	" Private - See superimplementor's comment "

	^ String streamContents: [ : stream |
		stream 
			<< 'Traps: ';
			<< self trapsCount asString.
		self traps 
			ifEmpty: [ 
				stream 
					cr; << '---'; cr;
					<< 'Location: '; cr;
					<< self coordinates asString ]
			ifNotEmpty: [ 
				stream
					cr; << '---'; cr.
					self traps do: [ : trap | stream << trap asString ].
				stream
					cr; << '---' ] ]
]

{ #category : #accessing }
BHCell >> hasTrap [
	" Answer <true> if the receiver contains at least one trap "

	^ self traps notEmpty
]

{ #category : #accessing }
BHCell >> increaseTrapCatches [
	" For now we increase the trap count of all traps in the receiver "

	self traps do: #increaseCatch
]

{ #category : #pov }
BHCell >> pov [

	^ self hasTrap
		  ifTrue: [ self traps anyOne color ]
		  ifFalse: [ Color fromHexString: '247008' ]
]

{ #category : #pov }
BHCell >> povTraps [

	self halt.
	^ self
		  povAttribute: #traps
		  min: 0
		  max: BHModel maximumAllowedTrapsPerCell
		  color: Color black
]

{ #category : #accessing }
BHCell >> removeTrap: aCMTrap [
	" The receiver could contain multiple traps. Remove aCMTrap from the receiver's traps "
	
	self traps remove: aCMTrap
]

{ #category : #accessing }
BHCell >> sizeOfPOV [

	^ 25
]

{ #category : #accessing }
BHCell >> traps [

	^ traps 
		ifNil: [ traps := OrderedCollection new ]
]

{ #category : #accessing }
BHCell >> traps: arg1 [

	traps := arg1
]

{ #category : #accessing }
BHCell >> trapsCount [

	^ self traps size
]
