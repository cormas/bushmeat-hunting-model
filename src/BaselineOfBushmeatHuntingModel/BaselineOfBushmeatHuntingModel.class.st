Class {
	#name : #BaselineOfBushmeatHuntingModel,
	#superclass : #BaselineOf,
	#category : #BaselineOfBushmeatHuntingModel
}

{ #category : #baselines }
BaselineOfBushmeatHuntingModel >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"Dependencies"
		self loadCormas: spec.

		"Packages"
		spec
			package: 'BushmeatHunting-Model' with: [ spec requires: #(Cormas) ];
			package: 'BushmeatHunting-Model-Tests' with: [ spec requires: #( 'BushmeatHunting-Model' ) ] ]
]

{ #category : #dependencies }
BaselineOfBushmeatHuntingModel >> loadCormas: spec [

	spec
		baseline: 'Cormas'
		with: [ spec loads: #(Core); repository: 'github://cormas/cormas' ]
]
