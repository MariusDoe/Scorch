Extension { #name : #BytecodeEncoder }

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 15:24'
}
BytecodeEncoder >> bytecodes [
	^ stream contents
]

{
	#category : #'*Scorching',
	#'squeak_changestamp' : 'eem 3/22/2017 19:32'
}
BytecodeEncoder >> sizeBranchIfInstanceOf: behaviorOrArrayOfBehaviorLiteralIndex distance: jumpDistance [
	^self sizeOpcodeSelector: #genBranchIfInstanceOf:distance:
			withArguments: {behaviorOrArrayOfBehaviorLiteralIndex. jumpDistance}
]

{
	#category : #'*Scorching',
	#'squeak_changestamp' : 'eem 7/11/2016 13:54'
}
BytecodeEncoder >> sizeBranchIfNotInstanceOf: behaviorOrArrayOfBehaviorLiteralIndex distance: jumpDistance [
	^self sizeOpcodeSelector: #genBranchIfNotInstanceOf:distance:
			withArguments: {behaviorOrArrayOfBehaviorLiteralIndex. jumpDistance}
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 15:04'
}
BytecodeEncoder >> stream: s [
	stream := s
]
