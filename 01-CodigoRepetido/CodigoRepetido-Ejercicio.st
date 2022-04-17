!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'measureTime' stamp: 'LDM 4/12/2022 10:30:49'!
measureTimeOfClosure: aClosure in: timeUnit
	"Execute a closure and measure its running time using certain time unit (e.g. milliseconds)."

	| beginTime endTime |
	
	beginTime := Time millisecondClockValue * timeUnit .
	aClosure value.
	endTime := Time millisecondClockValue * timeUnit .
	
	^(endTime  - beginTime )! !

!CustomerBookTest methodsFor: 'measureTime' stamp: 'LDM 4/12/2022 10:34:55'!
measureTimeOfClosure: aClosure in: timeUnit tookLessThan: timeThreshold
	"Execute a closure and measure its running time using certain time unit (e.g. milliseconds)."

	| beginTime endTime |
	
	beginTime := Time millisecondClockValue * timeUnit .
	aClosure value.
	endTime := Time millisecondClockValue * timeUnit .
	
	^(endTime  - beginTime) < (timeThreshold * timeUnit)! !


!CustomerBookTest methodsFor: 'testing' stamp: 'LDM 4/17/2022 17:27:36'!
runClosureAndFail: aClosure withError: error andCheckThis: closureToCheckAfterError
	[aClosure value. self fail] on: error do: closureToCheckAfterError .! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LDM 4/12/2022 10:37:24'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: (self measureTimeOfClosure: [customerBook addCustomerNamed: 'John Lennon'] in: millisecond tookLessThan: 50).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LDM 4/12/2022 10:39:42'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	self assert: (self measureTimeOfClosure: [customerBook removeCustomerNamed: 'Paul McCartney'] in: millisecond tookLessThan: 100).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LDM 4/17/2022 17:27:55'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self runClosureAndFail: [ customerBook addCustomerNamed: ''.] withError: Error andCheckThis: [:anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty
		].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LDM 4/17/2022 17:28:57'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self runClosureAndFail: [customerBook removeCustomerNamed: 'Paul McCartney'.] withError: NotFound andCheckThis: [:anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)
		].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LDM 4/17/2022 17:33:38'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney amountOfCustomersByCategory|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	amountOfCustomersByCategory := {
		(customerBook numberOfActiveCustomers ). 
		(customerBook numberOfSuspendedCustomers). 
		(customerBook numberOfCustomers)
	}.
	
	self assert: #(0 1 1) equals: amountOfCustomersByCategory.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LDM 4/15/2022 13:22:14'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook paulMcCartney amountOfCustomersByCategory |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	amountOfCustomersByCategory := {
		customerBook numberOfActiveCustomers.
		customerBook numberOfSuspendedCustomers.
		customerBook numberOfCustomers.
	}.
	
	self assert: #(0 0 0) equals: amountOfCustomersByCategory.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).



	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LDM 4/17/2022 17:29:08'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self runClosureAndFail: [customerBook suspendCustomerNamed: 'George Harrison'] withError: CantSuspend andCheckThis: [:anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert:  (customerBook includesCustomerNamed: johnLennon).
		].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LDM 4/17/2022 17:29:15'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self runClosureAndFail: [customerBook suspendCustomerNamed: johnLennon.] withError: CantSuspend andCheckThis: [ :anError | 
			self assert: customerBook numberOfCustomers = 1. 
			self assert: (customerBook includesCustomerNamed: johnLennon)
		]. 
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'LDM 4/15/2022 13:40:39'!
initialize

	active := OrderedCollection new.
	suspended := OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'LDM 4/17/2022 17:39:21'!
addCustomerNamed: aName

	self checkUsernameIsNotEmpty: aName.
	self checkUsernameAlreadyInCustomerBook: aName.
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'LDM 4/17/2022 17:40:27'!
checkUsernameAlreadyInCustomerBook: aName

	^ (self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'LDM 4/17/2022 17:38:38'!
checkUsernameIsNotEmpty: aName

	^ aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LDM 4/15/2022 14:14:11'!
numberOfCustomers
	
	^(self numberOfActiveCustomers + self numberOfSuspendedCustomers) ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LDM 4/15/2022 14:40:50'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [
		suspended remove: aName ifAbsent: [
				NotFound signal
			]
		].
	^aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
