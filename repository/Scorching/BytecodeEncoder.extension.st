Extension { #name : #BytecodeEncoder }

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 15:24'
}
BytecodeEncoder >> bytecodes [
	^ stream contents
]

{
	#category : #'*Scorching-Pharo-Compatibility',
	#'squeak_changestamp' : 'mad 6/5/2025 15:04'
}
BytecodeEncoder >> stream: s [
	stream := s
]
