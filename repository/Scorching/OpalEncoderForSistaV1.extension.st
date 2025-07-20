Extension { #name : #OpalEncoderForSistaV1 }

{
	#category : #'*Scorching',
	#'squeak_changestamp' : 'mad 6/5/2025 17:04'
}
OpalEncoderForSistaV1 >> genCallPrimitive: primitiveIndex [
	"248	(2)	11111000 	iiiiiiii		mssjjjjj		Call Primitive #iiiiiiii + (jjjjj * 256) 
								m=1 means inlined primitive, no hard return after execution. 
								ss defines the unsafe operation set used to encode the operations. 
								(ss = 0 means sista unsafe operations, ss = 01 means lowcode operations, other numbers are not used)"
	"N.B. We could have made CallPrimitive a 2-byte code taking an extension, but that would
	 complicate the VM's determination of the primitive number and the primitive error code
	 store since the extension, being optional, would make the sequence variable length."
	(primitiveIndex < 1 or: [primitiveIndex > 65535]) ifTrue:
		[self outOfRangeError: 'primitive index' index: primitiveIndex range: 1 to: 65535].
	stream
		nextPut: 248;
		nextPut: (primitiveIndex bitAnd: 255);
		nextPut: (primitiveIndex bitShift: -8)
]

{ #category : #'*Scorching' }
OpalEncoderForSistaV1 >> genEnsureAllocatableSlots: int [
	stream
		nextPut: 236;
		nextPut: int
]

{ #category : #'*Scorching' }
OpalEncoderForSistaV1 >> genStoreFlagExtensionIgnoreStoreCheck: ignoreStoreCheck maybeContext: maybeContext ignoreReadOnlyCheck: ignoreReadOnlyCheck [
	"ignoreStoreCheck: 
	Can be applied to the long form of store and store pop of literal variable, remote inst var, remote temp, receiver inst var.
	If present, the VM does not generate the GC store check. 
	The main reasons the compiler can ignore the store check are one of these two:
	- the mutated object is always young
	- the object stored is immediate
	Currently the store check is for the remembered table, but we may have it for tri color marking later. So the compiler cannot really remove the store check if the object stored is old.

	maybeContext:
	Can be used only with remote instance variable stores and receiver variable stores. If marked, the object can be a context and hence needs specific VM code. Receiver inst var have a separate encoding, temp vectors and literal variable can't be contexts
	
	ignoreReadOnlyCheck:
	no read-only check will be performed by the VM. Normally each store has a read-only check.
	"
	self genUnsignedSingleExtendB: ignoreStoreCheck asBit + (maybeContext asBit << 1) + (ignoreReadOnlyCheck asBit << 2)
]

{ #category : #'*Scorching' }
OpalEncoderForSistaV1 class >> isReturnByte: byte [
	^ byte between: 88 and: 94
]

{ #category : #'*Scorching' }
OpalEncoderForSistaV1 class >> returnSelfByte [
	^ 88
]
