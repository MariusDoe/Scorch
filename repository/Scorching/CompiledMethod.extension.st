Extension { #name : #CompiledMethod }

{ #category : #'*Scorching' }
CompiledMethod >> hasNoRuntimeOptimizationsPragma [
	^ self pragmas anySatisfy: [ :pragma | pragma keyword = #noRuntimeOptimizations ] 
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 14:04'
}
CompiledMethod >> isDoIt [
	^self selector isDoIt
]
