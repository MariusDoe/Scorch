"
I am the interface to the optimization infrastructure.

Basically, I take a context as input, and based on it I choose a method to optimise and a class where to install it, I optimise it and install it.


"
Class {
	#name : #SoOptimizer,
	#superclass : #Object,
	#instVars : [
		'origin',
		'codeNode'
	],
	#pools : [
		'SoMagicConstants',
		'SoOptimizationSettingConstants'
	],
	#category : #'Scorching-Pass-FrontEnd'
}

{
	#category : #private,
	#'squeak_changestamp' : 'mad 6/10/2025 19:00'
}
SoOptimizer >> basicOptimizedContext: context [
	"('Attempt to optimize: ' , context method printString , ' with rcvrClass: ' , context receiver class name) logCr."
	^ self uncheckedOptimize: context
]

{ #category : #accessing }
SoOptimizer >> codeNode [
	<generated>
	^ codeNode
]

{ #category : #accessing }
SoOptimizer >> codeNode: aValue [
	<generated>
	codeNode := aValue
]

{
	#category : #private,
	#'squeak_changestamp' : 'mad 6/10/2025 19:03'
}
SoOptimizer >> getFirstCodeNode: ctxtTripping [
	| ctxt |
	ctxt := SoStackSearcher new searchCodeToOptimize: ctxtTripping.
	self assert: ctxt method isCompiledMethod. "We don't support block here right now"
	codeNode := SoMethodDecompiler decompile: ctxt method context: ctxt.
	{SoReorderBasicBlocks . SoFindDominators . SoSimplifyPhis} do: [ :each |
		each new runOn: codeNode ].
	^ codeNode
]

{ #category : #public }
SoOptimizer >> optimizeContext: context [ 
	"FileStream stdout cr.
	FileStream stdout << context method printString << ' tripping '."
	context method isGloballyOptimized ifTrue: [ ^ self ].
	context method hasNoCounterBit ifTrue: [ ^ self ]. 
	Transcript show: 'Counter tripped in ' , context method printString; cr.
	self basicOptimizedContext: context.
]

{ #category : #accessing }
SoOptimizer >> origin [
	<generated>
	^ origin
]

{ #category : #accessing }
SoOptimizer >> origin: aValue [
	<generated>
	origin := aValue
]

{ #category : #private }
SoOptimizer >> passes [
	^ ActiveO
]

{
	#category : #private,
	#'squeak_changestamp' : 'ct 6/10/2025 16:38'
}
SoOptimizer >> postponeOptimization [
	self flag: #TODO.
	Transcript showln: 'TimeOut'.
]

{ #category : #private }
SoOptimizer >> uncheckedOptimize: contextTripping [
	codeNode := self getFirstCodeNode: contextTripping.
	self passes do: [ :pass | 
		pass new runOn: codeNode.
		"Transcript show: '[' , pass name , ';', (DateAndTime now - origin) asMilliSeconds printString , 'ms]'; cr." ].
	codeNode generateAndInstall.
	"Transcript show: 'Opt done in: ' , (DateAndTime now - origin) asMilliSeconds printString , 'ms - '."
	"contextTripping method markOptimizedBit."
	codeNode compiledCode markOptimizedBit.
	
]
