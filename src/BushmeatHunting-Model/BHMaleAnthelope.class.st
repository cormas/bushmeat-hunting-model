Class {
	#name : #BHMaleAnthelope,
	#superclass : #BHAnthelope,
	#category : #'BushmeatHunting-Model'
}

{ #category : #converting }
BHMaleAnthelope class >> asGetterForEntityClass [

	^ #maleAnthelopes
]

{ #category : #accessing }
BHMaleAnthelope class >> minAgeLimit [

	^ 95
]

{ #category : #'population dynamics' }
BHMaleAnthelope >> findPartner [
	" Answer a <CMBushmeatFemaleAnthelope> matching partnership for the receiver or nil if not found "
	| found |

	patch ifNil: [ ^ nil ].
	patch neighbourhood 
		select: [: bushmeatCell | bushmeatCell hasOccupantType: BHFemaleAnthelope ]
		thenDo: [ : bushmeatCell |
			found := (bushmeatCell occupants: BHFemaleAnthelope)
				detect: [ : femaleAnthelope | self matchPartnerConditions: femaleAnthelope ]
				ifNone: [ nil ] ].
	^ found
]

{ #category : #accessing }
BHMaleAnthelope >> matchPartnerConditions: femaleAnthelope [

	^ femaleAnthelope hasNoPartner & femaleAnthelope isAlive & femaleAnthelope isAdult
]

{ #category : #pov }
BHMaleAnthelope >> povColor [

	^ Color blue
]

{ #category : #printing }
BHMaleAnthelope >> sexString [

	^ 'Male'
]
