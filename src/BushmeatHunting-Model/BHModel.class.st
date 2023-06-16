"
How to manage a hunted population of small antelopes through the organization of the hunting activity between villagers ?

In central Africa, bushmeat is the main source of protein and one of the most important sources of income for rural people, but intensive hunting of bushmeat species is also a major concern for conservationists, due to unselective hunting practices. In Djemiong, a forest village of eastern-Cameroon, the main species hunted is a small antelope, the blue duiker (Cephalophus monticola, Thunberg). 
The behaviour and the mortality rate of a blue duiker depends on its stage (newborn; juvenile; subadult and adult) and on its sex. Above the age of sexual maturity (72 weeks for female, 95 weeks for male), individuals become adult and search for a mating partner to establish in a 3ha territory in the forest. From that time, the couple will remain in their territory until one dies.The gestation lasts 30 weeks, and a weaning period (i.e. the time that a female can not conceive after each birth and still very close to the calf) of 21 weeks. Newborns (calves) till age of weaning (21 weeks) are moving together with their mothers. After the weaning and till 40 weeks old, a juvenile is still under parental care but can move randomly within parental territory. From 40 weeks to the age of sexual maturity, subadult individuals freely wander around in the forest.
During the main agricultural season (6 consecutive months), villagers are busy in their crop fields so there is no hunting. Hunting takes place along hunting paths that are known and used by members of kinship networks. Every year, each of the 90 hunters identified in the village changes the location of his traps according to the decision made by the family group he belongs to. 

To what extent the social organization of the hunting activity might influence the viability of the blue duikers population and the hunting efficiency ?

 
Internal Representation and Key Implementation Points.

    Instance Variables
	anthelopes:		<Object>
	catchesNumber:		<Object>
	cells:		<Object>
	huntingFamilies:		<Object>
	isHuntingSeason:		<Object>


    Implementation Points
"
Class {
	#name : #BHModel,
	#superclass : #CMAbstractModel,
	#instVars : [
		'anthelopes',
		'cells',
		'huntingFamilies',
		'catchesNumber',
		'isHuntingSeason'
	],
	#category : #'BushmeatHunting-Model'
}

{ #category : #'- probes' }
BHModel class >> colorOfProbe_anthelopesSize [
  ^ (Color r: 0.6422287390029325 g: 0.3870967741935484 b: 0.14565004887585534 alpha: 1.0)
]

{ #category : #accessing }
BHModel class >> maximumAllowedAnthelopePerFamily [

	^ 30
]

{ #category : #accessing }
BHModel class >> maximumAllowedTrapsPerCell [

	^ 20
]

{ #category : #accessing }
BHModel class >> maximumHuntingFamilies [

	^ 2
]

{ #category : #accessing }
BHModel class >> maximumNumberAllowedGlobalTraps [

	^ 500
]

{ #category : #accessing }
BHModel class >> maximumNumberOffspring [

	^ 10
]

{ #category : #accessing }
BHModel >> addHuntingFamily: famId [ 

	self huntingFamilies add: (BHHuntingFamily newWithId: famId forSpace: self spaceModel)
]

{ #category : #accessing }
BHModel >> anthelopes [

	^ anthelopes
		  ifNil: [ anthelopes := OrderedCollection new ]
		  ifNotNil: [ anthelopes ]
]

{ #category : #accessing }
BHModel >> anthelopes: arg1 [

	anthelopes := arg1
]

{ #category : #probes }
BHModel >> anthelopesSize [
	<probe>

	^ (self allTheEntities: BHAnthelope) size
]

{ #category : #accessing }
BHModel >> catchesNumber [

	^ catchesNumber
]

{ #category : #accessing }
BHModel >> catchesNumber: anObject [

	catchesNumber := anObject
]

{ #category : #accessing }
BHModel >> cells [

	^ cells ifNil: [ cells := OrderedCollection new ] ifNotNil: [ cells ]
]

{ #category : #accessing }
BHModel >> cells: arg1 [

	cells := arg1
]

{ #category : #accessing }
BHModel >> femaleAnthelopes [
	" Answer a <Collection> of the receiver's female anthelopes "
	
	^ self anthelopes select: #isFemale
]

{ #category : #accessing }
BHModel >> huntingFamilies [

	^ huntingFamilies
		  ifNil: [ huntingFamilies := OrderedCollection new ]
]

{ #category : #accessing }
BHModel >> huntingFamilies: arg1 [

	huntingFamilies := arg1
]

{ #category : #accessing }
BHModel >> increaseCatchesNumber [
	" Increase the globals catches number "

	catchesNumber := catchesNumber + 1
]

{ #category : #'initialize-release' }
BHModel >> initAnthelopes: anthNumber [
	" Private - Create anthNumber randomly located anthelopes, with a random sex ratio "

	self anthelopes: (self createN: anthNumber randomlyLocatedEntitiesFrom: BHAnthelope subclasses)
]

{ #category : #'initialize-release' }
BHModel >> initAnthelopes: anthNumber sexRatio: anAssociation [
	" Private - Create anthNumber randomly located anthelopes, with a random sex ratio "

	self shouldBeImplemented.
	self anthelopes: (self createN: anthNumber randomlyLocatedEntitiesFrom: BHAnthelope subclasses)
]

{ #category : #'initialize-release' }
BHModel >> initFamilies [

	1 
		to: self class maximumHuntingFamilies 
		do: [ : famId | self addHuntingFamily: famId ]
]

{ #category : #init }
BHModel >> initScenarioWholeSeason [

	catchesNumber := 0.
	self isHuntingSeason: false.
	self
		initSpace;
		initAnthelopes: 15;
		initFamilies.
	self 
		displayPov: #pov of: BHMaleAnthelope;
		displayPov: #pov of: BHFemaleAnthelope;
		displayPov: #pov of: BHCell
]

{ #category : #init }
BHModel >> initScenarioWith100Anthelopes [

	self
		initSpace;
		initAnthelopes: 100;
		displayPov: #pov of: BHMaleAnthelope;
		displayPov: #pov of: BHFemaleAnthelope
]

{ #category : #init }
BHModel >> initScenarioWith60Anthelopes [

	catchesNumber := 0.
	self
		isHuntingSeason: false;
		initSpace;
		initAnthelopes: 120;
		initFamilies;
		displayPov: #pov of: BHMaleAnthelope;
		displayPov: #pov of: BHFemaleAnthelope;
		displayPov: #pov of: BHCell
]

{ #category : #'initialize-release' }
BHModel >> initSpace [

	self
		createGridLines: 30
		columns: 30
		neighbourhood: 8
		closed: true
]

{ #category : #'initialize-release' }
BHModel >> initTraps [

	self toggleHuntingSeason.
	self isHuntingSeason
		ifFalse: [ 
			self huntingFamilies do: #removeTraps.
			self traps do: [ :trap | 
				(self pickCellAt: trap location) removeTrap: trap ] ]
		ifTrue: [ 
			self huntingFamilies do: #setupTraps.
			self traps do: [ :trap | 
				(self pickCellAt: trap location) addTrap: trap ] ]
]

{ #category : #testing }
BHModel >> isChangingSeason [
	" Answer <true> if time has come for a new season (hunting or growing) "
	
	^ (self timeStep \\ 26) isZero
]

{ #category : #testing }
BHModel >> isHuntingSeason [

	^ isHuntingSeason
		ifNil: [ isHuntingSeason := false ]
]

{ #category : #accessing }
BHModel >> isHuntingSeason: anObject [

	isHuntingSeason := anObject
]

{ #category : #accessing }
BHModel >> maleAnthelopes [
	" Answer a <Collection> of the receiver's female anthelopes "
	
	^ self anthelopes reject: #isFemale
]

{ #category : #private }
BHModel >> maximumNumberOffspring [

	^ self class maximumNumberOffspring
]

{ #category : #init }
BHModel >> noAgent [

	self initSpace
]

{ #category : #accessing }
BHModel >> removeAnthelope: anAnthelope [

	self anthelopes remove: anAnthelope
]

{ #category : #control }
BHModel >> step [

	self isChangingSeason
		ifTrue: [ self initTraps ]
		ifFalse: [ self stepAnthelopes ]
]

{ #category : #control }
BHModel >> stepAnthelopes [

	self stepEntities: BHAnthelope.
	"self updateAllEntities: CMBushmeatAnthelope."
]

{ #category : #accessing }
BHModel >> toggleHuntingSeason [

	self isHuntingSeason: self isHuntingSeason not
]

{ #category : #'initialize-release' }
BHModel >> traps [
	" Answer a <Collection> of <CMTrap> "

	^ self huntingFamilies gather: #traps
]
