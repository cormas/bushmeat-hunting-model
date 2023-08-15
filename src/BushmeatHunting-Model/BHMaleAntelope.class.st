Class {
	#name : #BHMaleAntelope,
	#superclass : #BHAntelope,
	#category : #'BushmeatHunting-Model'
}

{ #category : #converting }
BHMaleAntelope class >> asGetterForEntityClass [

	^ #maleAntelopes
]

{ #category : #accessing }
BHMaleAntelope class >> minAgeLimit [

	^ 95
]

{ #category : #'population dynamics' }
BHMaleAntelope >> findPartner [
	" Answer a <BHFemaleAntelope> matching partnership for the receiver or nil if not found "
	| found |

	patch ifNil: [ ^ nil ].
	patch neighbourhood 
		select: [ :bushmeatCell | bushmeatCell hasOccupantType: BHFemaleAntelope ]
		thenDo: [ :bushmeatCell |
			found := (bushmeatCell occupants: BHFemaleAntelope)
				detect: [ :femaleAntelope | self matchPartnerConditions: femaleAntelope ]
				ifNone: [ nil ] ].
	^ found
]

{ #category : #accessing }
BHMaleAntelope >> matchPartnerConditions: femaleAntelope [

	^ femaleAntelope hasNoPartner & femaleAntelope isAlive & femaleAntelope isAdult
]

{ #category : #pov }
BHMaleAntelope >> povColor [

	^ Color blue
]

{ #category : #printing }
BHMaleAntelope >> sexString [

	^ 'Male'
]
