Extension { #name : #CompiledBlock }

{ #category : #'*Scorching' }
CompiledBlock >> hasNoRuntimeOptimizationsPragma [
	^ false
]

{ #category : #'*Scorching' }
CompiledBlock >> hasPragmaNamed: x [
	^ false
]

{ #category : #'*Scorching' }
CompiledBlock >> isDoIt [
	^ false
]

{ #category : #'*Scorching' }
CompiledBlock >> printOn: s [
	[ s << ' [] in '.
	  self outerCode printOn: s ] 
		on: Error 
		do: [ s << '...compiledBlock' ]
	
]
