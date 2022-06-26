!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'as yet unclassified' stamp: 'ldm 6/26/2022 16:16:48'!
addressRecordBeforeCustomerRecord

	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs
C,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'ldm 6/26/2022 16:05:04'!
addressRecordWithWrongAmountOfCells

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,9999,999'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/16/2022 21:04:22'!
assert: aCustomer names: aName lastName: aLastName idType: anIdType idNumber: anIdNumber
	
	self assert: aName equals: aCustomer firstName.
	self assert: aLastName equals: aCustomer lastName.
	self assert: anIdType equals: aCustomer identificationType.
	self assert: anIdNumber equals: aCustomer identificationNumber.
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/16/2022 21:12:08'!
assertAddressOf: aCustomer streetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode province: aProvince
	|address|
	
	address _ aCustomer addressAt: aStreetName.
	
	self assert: aStreetName equals: address streetName.
	self assert: aStreetNumber equals: address streetNumber.
	self assert: aTown equals: address town.
	self assert: aZipCode equals: address zipCode.
	self assert: aProvince equals: address province.! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/16/2022 21:24:27'!
assertJuanPerezWasImportedCorrectly: importedCustomer

	self assert: importedCustomer names: 'Juan' lastName: 'Perez' idType: 'C' idNumber: '23-25666777-9'. 
	self assertAddressOf: importedCustomer streetName: 'Alem' streetNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/16/2022 21:23:32'!
assertPepeSanchezWasImportedCorrectly: importedCustomer

	self assert: importedCustomer names: 'Pepe' lastName: 'Sanchez' idType: 'D' idNumber: '22333444'. 	
	self assertAddressOf: importedCustomer streetName: 'San Martin' streetNumber: 3322 town: 'Olivos' zipCode: 1636 province:'BsAs'.
	self assertAddressOf: importedCustomer streetName: 'Maipu' streetNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:21:09'!
customerIdentifiedAs: idType withNumber: idNumber 

	^ (session select: [:aCustomer | aCustomer identificationType = idType and: [aCustomer identificationNumber = idNumber]]
			ofType: ConcreteCustomer) anyOne! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'ldm 6/26/2022 16:06:41'!
customerRecordWithWrongAmountOfCells
	^ ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/23/2022 19:31:16'!
invalidAddressRecord

	^ ReadStream on: 'AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/23/2022 19:03:36'!
invalidCustomerRecord

	^ ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'ldm 6/26/2022 15:59:20'!
invalidRecordStartsWithBlankCell
	^ ReadStream on: ' ,C,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/23/2022 20:50:55'!
invalidRecordStartsWithComma

	^ ReadStream on: ',C,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/23/2022 20:17:34'!
invalidRecordWithBlankCells

	^ ReadStream on: 'C, ,Pepe, ,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/23/2022 20:17:27'!
invalidRecordWithCommasTogether

	^ ReadStream on: 'C,,Pepe,Sanchez,D,,22333444'! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:21:09'!
setUp

	session := DataBaseSession for: (Array with: Address with: ConcreteCustomer).
	session beginTransaction! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'IG 6/16/2022 19:43:06'!
tearDown

	session commit.
	session close! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:21:09'!
test01Import
	
	(CustomerImporter from: (self validData) into: session) value.	
	self assert: 2 equals: (session selectAllOfType: ConcreteCustomer) size.
	self assertPepeSanchezWasImportedCorrectly: (self customerIdentifiedAs: 'D' withNumber: '22333444').
	self assertJuanPerezWasImportedCorrectly: (self customerIdentifiedAs: 'C' withNumber: '23-25666777-9').! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:21:09'!
test02CustomerRecordMustBeCOnly
	
	self 
	should: [	(CustomerImporter from: self invalidCustomerRecord into: session) value.	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: CustomerImporter invalidRecordTypeErrorDecription equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: ConcreteCustomer) size]! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/23/2022 19:59:17'!
test03AddressRecordsMustBeAOnly
	
	self 
	should: [	(CustomerImporter from: self invalidAddressRecord into: session) value.	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: CustomerImporter invalidRecordTypeErrorDecription equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Address) size]! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:21:09'!
test04RecordsShouldNotHaveTwoCommasTogether
	
	self 
	should: [	(CustomerImporter from: self invalidRecordWithCommasTogether into: session) value.	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: CustomerImporter invalidRecordHasCommasTogether equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: ConcreteCustomer) size]! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:21:09'!
test05RecordsShouldNotHaveBlankCells
	
	self 
	should: [	(CustomerImporter from: self invalidRecordWithBlankCells into: session) value.	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: CustomerImporter invalidRecordWithBlankSpaces equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: ConcreteCustomer) size]! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:21:09'!
test06RecordShouldNotStartWithComma
	
	self 
	should: [	(CustomerImporter from: self invalidRecordStartsWithComma into: session) value.	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: CustomerImporter invalidRecordStartsWithComma equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: ConcreteCustomer) size]! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:21:09'!
test07CustomerRecordShouldHaveFiveCells
	
	self 
	should: [	(CustomerImporter from: self customerRecordWithWrongAmountOfCells into: session) value.	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: CustomerImporter invalidCustomerRecordWithIncorrectSize equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: ConcreteCustomer) size].! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'ldm 6/26/2022 16:23:42'!
test08AddressRecordShouldHaveSixCells
	
	self 
	should: [	(CustomerImporter from: self addressRecordWithWrongAmountOfCells into: session) value.	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: CustomerImporter invalidAddressRecordWithIncorrectSize equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Address) size].! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:34:20'!
test09ImportAddressBeforeItsCustomerRecordShouldThrowError
	
	self 
	should: [	(CustomerImporter from: self addressRecordBeforeCustomerRecord into: session) value.	]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError | 
		self assert: NullCustomer imANullCustomer equals: anError messageText.
		self assert: 0 equals: (session selectAllOfType: Address) size].! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/16/2022 20:54:04'!
validData

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'is at' stamp: 'IG 6/16/2022 19:59:25'!
isAt: aStreetName
 
	^streetName = aStreetName! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses addAddressBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'LDMAF 6/26/2022 17:25:49'!
addAddress: anAddress

	self subclassResponsibility ! !

!Customer methodsFor: 'addresses' stamp: 'LDMAF 6/26/2022 17:25:59'!
addressAt: aStreetName 

	self subclassResponsibility ! !

!Customer methodsFor: 'addresses' stamp: 'LDMAF 6/26/2022 17:26:05'!
addresses

	self subclassResponsibility ! !


!Customer methodsFor: 'name' stamp: 'LDMAF 6/26/2022 17:26:14'!
firstName

	self subclassResponsibility  ! !

!Customer methodsFor: 'name' stamp: 'LDMAF 6/26/2022 17:26:21'!
firstName: aName

	self subclassResponsibility ! !

!Customer methodsFor: 'name' stamp: 'LDMAF 6/26/2022 17:26:31'!
lastName

	self subclassResponsibility  ! !

!Customer methodsFor: 'name' stamp: 'LDMAF 6/26/2022 17:26:40'!
lastName: aLastName

	self subclassResponsibility 
! !


!Customer methodsFor: 'identification' stamp: 'LDMAF 6/26/2022 17:26:48'!
identificationNumber

	self subclassResponsibility ! !

!Customer methodsFor: 'identification' stamp: 'LDMAF 6/26/2022 17:26:53'!
identificationNumber: anIdentificationNumber

	self subclassResponsibility ! !

!Customer methodsFor: 'identification' stamp: 'LDMAF 6/26/2022 17:26:58'!
identificationType

	self subclassResponsibility ! !

!Customer methodsFor: 'identification' stamp: 'LDMAF 6/26/2022 17:27:06'!
identificationType: anIdentificationType

	self subclassResponsibility ! !


!Customer methodsFor: 'initialization' stamp: 'LDMAF 6/26/2022 17:27:17'!
initialize

	"super initialize."
	self subclassResponsibility! !


!classDefinition: #ConcreteCustomer category: 'CustomerImporter'!
Customer subclass: #ConcreteCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ConcreteCustomer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!ConcreteCustomer methodsFor: 'addresses' stamp: 'IG 6/16/2022 19:58:53'!
addressAt: aStreetName 

	^addresses detect: [:anAddress | anAddress isAt: aStreetName].! !

!ConcreteCustomer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!ConcreteCustomer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!ConcreteCustomer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!ConcreteCustomer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!ConcreteCustomer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!ConcreteCustomer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!ConcreteCustomer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!ConcreteCustomer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!ConcreteCustomer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!ConcreteCustomer methodsFor: 'initialization' stamp: 'ldm 6/26/2022 16:28:39'!
initialize

	"super initialize."
	addresses := OrderedCollection new.! !


!classDefinition: #NullCustomer category: 'CustomerImporter'!
Customer subclass: #NullCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!NullCustomer methodsFor: 'addresses' stamp: 'LDMAF 6/26/2022 17:30:50'!
addAddress: anAddress

	self error: self class imANullCustomer ! !

!NullCustomer methodsFor: 'addresses' stamp: 'LDMAF 6/26/2022 17:31:00'!
addressAt: aStreetName 

	self error: self class imANullCustomer ! !

!NullCustomer methodsFor: 'addresses' stamp: 'LDMAF 6/26/2022 17:31:06'!
addresses

	self error: self class imANullCustomer ! !


!NullCustomer methodsFor: 'name' stamp: 'LDMAF 6/26/2022 17:31:13'!
firstName

	self error: self class imANullCustomer ! !

!NullCustomer methodsFor: 'name' stamp: 'LDMAF 6/26/2022 17:31:21'!
firstName: aName

	self error: self class imANullCustomer ! !

!NullCustomer methodsFor: 'name' stamp: 'LDMAF 6/26/2022 17:31:27'!
lastName

	self error: self class imANullCustomer  ! !

!NullCustomer methodsFor: 'name' stamp: 'LDMAF 6/26/2022 17:31:34'!
lastName: aLastName

	self error: self class imANullCustomer 
! !


!NullCustomer methodsFor: 'identification' stamp: 'LDMAF 6/26/2022 17:31:44'!
identificationNumber

	self error: self class imANullCustomer  ! !

!NullCustomer methodsFor: 'identification' stamp: 'LDMAF 6/26/2022 17:31:51'!
identificationNumber: anIdentificationNumber

	self error: self class imANullCustomer ! !

!NullCustomer methodsFor: 'identification' stamp: 'LDMAF 6/26/2022 17:31:57'!
identificationType

	self error: self class imANullCustomer ! !

!NullCustomer methodsFor: 'identification' stamp: 'LDMAF 6/26/2022 17:32:02'!
identificationType: anIdentificationType

	self error: self class imANullCustomer ! !


!NullCustomer methodsFor: 'initialization' stamp: 'LDMAF 6/26/2022 17:23:33'!
initialize

	"super initialize."
	addresses := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NullCustomer class' category: 'CustomerImporter'!
NullCustomer class
	instanceVariableNames: ''!

!NullCustomer class methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/26/2022 17:30:29'!
imANullCustomer
	^ 'I am a null customer.'! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session stream newCustomer line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'LDMAF 6/26/2022 17:33:37'!
initializeFrom: aStream into: aSession
	
	session := aSession.
	stream := aStream.
	newCustomer := NullCustomer new.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 20:35:04'!
createRecord
	
	record := line findTokens: $,.
	self ensureRecordHasNotBlankCells.
	^record.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 21:23:24'!
ensureAddressRecordHasCorrectSize
	(record size = 6) ifFalse: [self error: self class invalidAddressRecordWithIncorrectSize ].! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 21:14:33'!
ensureCustomerRecordHasCorrectSize
	(record size = 5) ifFalse: [self error: self class invalidCustomerRecordWithIncorrectSize].! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 20:38:40'!
ensureRecordHasNotBlankCells

	^ (record anySatisfy: [:s | s withoutSeparators isEmpty ]) ifTrue: [self error: self class invalidRecordWithBlankSpaces ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 20:44:13'!
hasCommasTogether: aLine
	|prevChar|
	prevChar _ nil.
	aLine isNil ifTrue: [^false].
	aLine do: [ :char |
			( prevChar isNil ) ifTrue: [prevChar _ char]
						   ifFalse: [ (prevChar = $, and: [char = $,]) ifTrue: [^true] ].
			prevChar _ char.
		].
	^false! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 20:50:09'!
hasLineToImport

	line := stream nextLine.
	(self startsWithComma: line) ifTrue: [self error: self class invalidRecordStartsWithComma ].
	(self hasCommasTogether: line) ifTrue: [self error: self class invalidRecordHasCommasTogether ].
	^ line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/26/2022 17:33:18'!
importAddress

	| newAddress |
			newAddress := Address new.
			"newCustomer isNil ifTrue: [self error: self class addressWithoutCustomer]."
			newCustomer addAddress: newAddress.
			newAddress streetName: record second.
			newAddress streetNumber: record third asNumber .
			newAddress town: record fourth.
			newAddress zipCode: record fifth asNumber .
			newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/26/2022 17:21:09'!
importCustomer

	newCustomer := ConcreteCustomer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 21:23:04'!
importRecord

	self isCustomerRecord ifTrue: [ 
		(self ensureCustomerRecordHasCorrectSize).
		^ self importCustomer.
	].
	self isAddressRecord ifTrue: [ 
		(self ensureAddressRecordHasCorrectSize).
		^ self importAddress 
	].
	
	self error: self class invalidRecordTypeErrorDecription! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 19:02:17'!
isAddressRecord
	^ (record first = 'A')! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 21:09:56'!
isCustomerRecord
	^ (record first = 'C').! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 20:54:26'!
startsWithComma: aLine
	aLine isNil ifTrue: [^false].
	^(aLine first = $,).! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'LDMAF 6/23/2022 18:41:28'!
value

	"
	self importCustomers
	"
	[self hasLineToImport] whileTrue: [
		self createRecord.
		self importRecord.
].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'IG 6/16/2022 20:13:31'!
from: aStream into: aSession
	^self new initializeFrom: aStream into: aSession! !

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LDMAF 6/23/2022 21:20:39'!
invalidAddressRecordWithIncorrectSize
	^ 'Invalid amount of cells in address record'! !

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LDMAF 6/23/2022 21:05:37'!
invalidCustomerRecordWithIncorrectSize
	^ 'Invalid amount of cells in customer record'! !

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LDMAF 6/23/2022 20:15:39'!
invalidRecordHasCommasTogether
	^ 'Invalid record, must not have commas together'! !

!CustomerImporter class methodsFor: 'instance creation' stamp: 'ldm 6/26/2022 16:00:51'!
invalidRecordStartsWithBlankCell
	^'Record should not start with blank.'! !

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LDMAF 6/23/2022 20:46:54'!
invalidRecordStartsWithComma
	^ 'Invalid record, must not start with comma'! !

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LDMAF 6/23/2022 18:57:27'!
invalidRecordTypeErrorDecription
	^ 'Invalid Record'! !

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LDMAF 6/23/2022 20:39:14'!
invalidRecordWithBlankSpaces
	^ 'Invalid record, must not have blank cells'! !


!CustomerImporter class methodsFor: 'errors' stamp: 'ldm 6/26/2022 16:22:36'!
addressWithoutCustomer
	^'No customer was found with requested address.'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'LDMAF 6/26/2022 17:21:09'!
commit

	(tables at: ConcreteCustomer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'LDMAF 6/26/2022 17:21:09'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: ConcreteCustomer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
