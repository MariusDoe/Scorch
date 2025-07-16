Extension { #name : #InstructionPrinter }

{
	#category : #'*Scorching-instruction decoding',
	#'squeak_changestamp' : 'ct 6/23/2025 21:41'
}
InstructionPrinter >> branchIfInstanceOf: behaviorOrArrayOfBehavior distance: distance [
	"If the object on top of stack has the type -or one of the types- present in the literal
	 (the literal is a behavior or an array of behavior), then pop it. Else jumps by the distance."
	self print: 'branchIfInstanceOf: ', behaviorOrArrayOfBehavior printString, ' to: ', (scanner pc + distance) printString.
]

{
	#category : #'*Scorching-instruction decoding',
	#'squeak_changestamp' : 'ct 6/23/2025 21:41'
}
InstructionPrinter >> branchIfNotInstanceOf: behaviorOrArrayOfBehavior distance: distance [
	"If the object on top of stack does not have the type -or one of the types- present in the literal
	 (the literal is a behavior or an array of behavior), then pop it. Else jumps by the distance."
	self print: 'branchIfNotInstanceOf: ', behaviorOrArrayOfBehavior printString, ' to: ', (scanner pc + distance) printString.
]

{
	#category : #'*Scorching-instruction decoding',
	#'squeak_changestamp' : 'mad 6/10/2025 19:40'
}
InstructionPrinter >> trap [
	self print: 'trap'.
]
