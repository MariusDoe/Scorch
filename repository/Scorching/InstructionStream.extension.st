Extension { #name : #InstructionStream }

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 14:54'
}
InstructionStream >> interpret [
	"Interpret / evaluate the current method in the current context until the end.
	Use the context as client of the interpretation as well as the decoder of instructions.
	The context is a client that evaluates instructions"
	self interpretWithClient: self
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 14:54'
}
InstructionStream >> interpretWithClient: aClient [
	| endPC |
	endPC := self method endPC.
	[pc > endPC] whileFalse: [self interpretNextInstructionFor: aClient]
]
