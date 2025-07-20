Extension { #name : #Context }

{ #category : #'*Scorching' }
Context >> aboutToReturn: result through: firstUnwindContext [ 
	"Called from VM when an unwindBlock is found between self and its home.
	 Return to home's sender, executing unwind blocks on the way."
	<noRuntimeOptimizations>
	"It could be that the outer is deoptimized and the NLR
	would fail whereas it should succeed."
	closureOrNil ifNotNil: [ 
		(Scorch isDeoptimizedContext: self home) ifTrue: [ 
				| ctxt |
				ctxt := self.
				[ ctxt outerContext == self home ] whileFalse: [ ctxt := ctxt outerContext ].
				Scorch actualOuterContext: ctxt closureOrNil.
				^ self return: result from: self methodReturnContext ] ].
	self methodReturnContext return: result through: firstUnwindContext
]

{
	#category : #'*Scorching',
	#'squeak_changestamp' : 'ct 7/16/2025 21:37'
}
Context >> callInlinePrimitive: index [

	| arg1 |
	self push:
		(index
			caseOf:
				{[2000] -> [arg1 := self pop. self pop + arg1].
				[2033] -> [arg1 := self pop. self pop < arg1]}
			otherwise: [self halt]).
]

{ #category : #'*Scorching' }
Context >> callInlinedPrimitive: primNumber [
	"inlined primitive simulation.
	Inlined binary tree."

	| prim marker res |
	FileStream stdout << primNumber printString << '   '.
	prim := primNumber bitAnd: 1 << 15 - 1.
	marker := Object new.
	(res := self value: prim marker: marker) == marker 
		ifTrue: [self error: 'simulation not supported for' , prim printString]
		ifFalse: [ self push: res ]
	
]

{
	#category : #'*Scorching',
	#'squeak_changestamp' : 'ct 6/10/2025 16:35'
}
Context >> cannotReturn: result [
	<noRuntimeOptimizations>
	closureOrNil ifNotNil: [ 
		"It could be that the NLR failed because the outerContext was deoptimized.
		In that case remap the outerContext to the deoptimized version and
		retry the NLR."
		(Scorch isDeoptimizedContext: self home) ifTrue: [ 
			| ctxt |
			ctxt := self.
			[ ctxt outerContext == self home ] whileFalse: [ ctxt := ctxt outerContext ].
			Scorch actualOuterContext: ctxt closureOrNil.
			^ self return: result from: self methodReturnContext ].
		^self cannotReturn: result to: self home sender].
	self error: 'Computation has been terminated!'
]

{ #category : #'*Scorching' }
Context >> closureOrNil [
	^ closureOrNil 
]

{
	#category : #'*Scorching',
	#'squeak_changestamp' : 'ct 6/10/2025 23:05'
}
Context >> conditionalBranchCounterTrippedOn: boolean [
	"Triggered by the Sista JIT. Here you need to manage the adaptive recompilation. When this method is triggered #conditionalBranchCounterTrippedOn: is removed from the specialObjectsArray"
	
	[ Scorch optimizeContext: self ] ensure: [ 
		self skipBackBeforeJump.
		self method resetCounters.
		"Smalltalk vmParameterAt: 17 put: 0.5." "Move back the tide"
		Smalltalk specialObjectsArray at: 59 put: #conditionalBranchCounterTrippedOn: ].
	^ boolean 
]

{ #category : #'*Scorching' }
Context >> deoptimize [
	<noRuntimeOptimizations>
	^ Scorch deoptimizeContext: self
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 14:53'
}
Context >> isBlockContext [
	"Is this executing a block versus a method?  In the new closure
	 implemetation this is true if closureOrNil is not nil, in which case
	 it should be holding a BlockClosure."

	^closureOrNil isClosure
]

{ #category : #'*Scorching' }
Context >> method: x [
	method := x
]

{ #category : #'*Scorching' }
Context >> respondsToUnknownBytecode [
	"This method is triggered by the VM when the interpreter tries to execute an unknown bytecode"
	
	"Falls back on the in-image interpreter for byte code not implemented in the VM"
	^ self interpretNextInstructionFor: self
	

]

{
	#category : #'*Scorching',
	#'squeak_changestamp' : 'ct 6/20/2025 23:04'
}
Context >> trapTripped [
	"Triggered by the Sista JIT. Here you need to manage the dynamic deoptimization."
	<noRuntimeOptimizations>
	| deoptCtxt currentProcess |
	deoptCtxt := self deoptimize.
	currentProcess := Processor activeProcess.
	[ currentProcess suspendedContext: deoptCtxt ] fork.
	Processor yield.
	"Should not reach here already..."
	thisContext privSender: deoptCtxt.
	thisContext jump.
	self error: 'should not be reached'.
]

{
	#category : #'*Scorching',
	#'squeak_changestamp' : 'ct 7/10/2025 20:26'
}
Context >> trapTrippedFromSimulation [
	"Triggered by the Sista JIT. Here you need to manage the dynamic deoptimization."
	<noRuntimeOptimizations>
	| deoptCtxt |
	deoptCtxt := self deoptimize.
	^ deoptCtxt
]

{
	#category : #'*Scorching-system primitives(-pseudo)-override',
	#'squeak_changestamp' : 'ct 6/23/2025 03:09'
}
Context >> unusedBytecode [
	| result |
	self error: 'unused bytecode encountered'.
	
	result := self step.
	^ result == self
		ifTrue:
			[self stackPtr > 0 ifFalse: [self error: 'cannot represent this bytecode as a message send'].
			self pop]
		ifFalse:
			[result jump]
]

{ #category : #'*Scorching' }
Context >> value: prim marker: marker [
	"inlined primitive simulation.
	Inlined binary tree."

	| rcvr arg1 arg2 |
	prim < 1000  
		ifTrue: [ 	
			rcvr := self pop.
			(prim between: 1 and: 3) ifTrue: [ ^ rcvr basicSize ] ]
		ifFalse: [ 
			arg1 := self pop.
			rcvr := self pop.
			prim < 2000 
			ifTrue: [ 
				prim = 1000 ifTrue: [ ^ rcvr + arg1 ].
				prim = 1036 ifTrue: [ ^ rcvr = arg1 ].
				prim = 1035 ifTrue: [ ^ rcvr <= arg1 ].
				prim = 1033 ifTrue: [ ^ rcvr < arg1 ].
				prim = 1037 ifTrue: [ ^ rcvr ~= arg1 ].
				(prim between: 1064 and: 1065) ifTrue: [ ^ rcvr basicAt: arg1 ] ]
			ifFalse: [ 
				arg2 := self pop.
				arg1 := self pop.
				rcvr := self pop.
				prim < 2002 
					ifTrue: [ ^ rcvr basicAt: arg2 put: arg2 ] ] ].
	^ marker
]
