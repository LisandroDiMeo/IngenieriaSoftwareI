!classDefinition: #CardTest category: 'TusLibros'!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/8/2022 20:32:45'!
test01AValidNumberCanCreateACard
	|aCard|
	aCard _ Card withNumber: 1234123412341234 goodThru: (Date today) owner: 'Owen Owner'.
	self assert: ((aCard number) = 1234123412341234).! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/8/2022 20:18:52'!
test02AnEmptyCardNumberCantCreateACard
	self should: [Card withNumber: '' goodThru: (Date today) owner: 'Owen Owner'.] raise: Error withMessageText: 'Cant create a card with provided number.'! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/8/2022 20:34:10'!
test03AnIncompleteCardNumberCantCreateACard
	self should: [Card withNumber: 1111 goodThru: (Date today) owner: 'Owen Owner'.] raise: Error withMessageText: 'Cant create a card with provided number.'! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/8/2022 20:34:17'!
test04AnExceededCardNumberCantCreateACard
	self should: [Card withNumber: 11111111111111111111 goodThru: (Date today) owner: 'Owen Owner'.] raise: Error withMessageText: 'Cant create a card with provided number.'! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/8/2022 20:24:21'!
test05ACardWithInvalidNumberCantCreateACard
	self should: [Card withNumber: 'abcd123412341234' goodThru: (Date today) owner: 'Owen Owner'.] raise: Error withMessageText: 'Cant create a card with provided number.'! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/8/2022 20:40:54'!
test06ACardWithBlanksTrimmedNameIfIsBlankCantCreateACard
	self should: [Card withNumber: 1234123412341234 goodThru: (Date today) owner: '          '.] raise: Error withMessageText: 'Cant create a card with provided number.'! !

!CardTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/8/2022 20:42:57'!
test07ACardWithAnInvalidDateCantCreateACard
	self should: [Card withNumber: 1234123412341234 goodThru: '12/28' owner: 'Owen Owner'.] raise: Error withMessageText: 'Cant create a card with provided number.'! !


!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aProduct'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/6/2022 19:58:03'!
test01CartIsEmptyWhenIsCreated
	|aCart|
	
	aCart _ Cart with: (Dictionary new).
	
	self assert: (aCart isEmpty)! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/6/2022 19:59:08'!
test02CartIsNotEmptyWhenAProductIsAdded
	|aCart aCatalogue aBook |
	aCatalogue _ Dictionary new.
	aCatalogue add: '9782253096405'->10.
	aCart _ Cart with: aCatalogue.
	aBook _ '9782253096405'.
	aCart add: aBook.

	self assert: (aCart isEmpty not)! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/6/2022 19:59:27'!
test03CantAddBooksNotEditedByEditorToCart
	|aCart aCatalogue aBook |
	
	aCatalogue _ Dictionary new.
	aCart _ Cart with: aCatalogue.
	aBook _ '9786070776564'.
	
	self should: [aCart add: aBook] raise: Error withMessageText: 'Cannot add a book not registered in our inventory.'.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/6/2022 19:59:57'!
test04CartCanAddMultipleAmountsOfTheSameBook
	|aCart aCatalogue aBook |
	
	aCatalogue _ Dictionary new.
	aCatalogue add: '9789500708517'->2.
	aCart _ Cart with: aCatalogue.
	aBook _ '9789500708517'.
	aCart add: 10 of: aBook.
	
	self assert: (aCart booksQuantity = 10).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/6/2022 20:00:27'!
test05CartThrowsErrorWhenAnInvalidAmountIsRequested
	|aCart aCatalogue aBook |
	
	aCatalogue _ Dictionary new.
	aCatalogue add: '9789500708517'->10.
	aCart _ Cart with: aCatalogue.
	aBook _ '9789500708517'.
	
	self should: [aCart add: 0 of: aBook] raise: Error withMessageText: 'Cannot add an invalid amount of books.'.
	self should: [aCart add: -1 of: aBook] raise: Error withMessageText: 'Cannot add an invalid amount of books.'.
	self should: [aCart add: 'hola' of: aBook] raise: Error withMessageText: 'Cannot add an invalid amount of books.'.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/6/2022 20:01:18'!
test06CartAddedBooksAreCorrect
	|aCart aBook1 aBook2 aCatalogue|
	
	aCatalogue _ Dictionary new.
	aCatalogue add: '9789500708517'-> 20;add: '9781644730942'->10.
	aCart _ Cart with: aCatalogue.
	aBook1 _ '9789500708517'.
	aBook2 _ '9781644730942'.
	
	aCart add: aBook1.
	aCart add: 3 of: aBook2.
	self assert: (aCart doesInclude: 3 of: aBook2).
	self assert: (aCart doesInclude: 1 of: aBook1).
	self assert: (aCart booksQuantity = 4).
	
	
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/6/2022 20:01:46'!
test07CartCanRequestItsContents
	|aCart aBook1 aBook2 aCatalogue cartContents|
	
	aCatalogue _ Dictionary new.
	aCatalogue add: '9788499983196'-> 20;add: '9786070731747'->10.
	aCart _ Cart with: aCatalogue.
	aBook1 _ '9788499983196'.
	aBook2 _ '9786070731747'.
	
	aCart add: aBook1.
	aCart add: 2 of: aBook2.
	cartContents _ aCart contents.
	self assert: (( cartContents occurrencesOf: aBook1 ) = 1).
	self assert: (( cartContents occurrencesOf: aBook2 ) = 2).
	self assert: (cartContents size = 3).
	
	! !


!classDefinition: #CheckoutTest category: 'TusLibros'!
TestCase subclass: #CheckoutTest
	instanceVariableNames: 'aProduct'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:42:16'!
test01CheckoutOfAnEmptyCartShouldFail
	| aCart aCatalogue aCashier aMerchantProcessor aCard aDate|
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber + 5).
	aCard _ Card withNumber: 1234567812345678 goodThru: aDate owner: 'Jorge Messi'. 
	aCatalogue :=  Dictionary new.
	aMerchantProcessor _ FakeMerchantProccesor new.
	aCart := Cart with: aCatalogue.
	aCashier := Cashier with: aCatalogue using: aMerchantProcessor.
	
	self should: [aCashier checkout: aCart with: aCard] raise: Error withMessageText: 'Cannot checkout an empty cart.'.
	self should: [aCashier lastTicket] raise: Error withMessageText: 'this collection is empty'.! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:43:16'!
test02CheckoutOfACartWithOneItemShouldHaveACorrectCheckoutPrice
	| aCart aCatalogue aCashier aMerchantProcessor aCard aDate|
	
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber + 5).
	aCard _ Card withNumber: 1234567812345678 goodThru: aDate owner: 'Jorge Messi'. 
	
	aCatalogue := Dictionary new.
	aCatalogue add: '9789504974567'->10.
	aCart := Cart with: aCatalogue.
	aCart add: '9789504974567'.
	aMerchantProcessor _ FakeMerchantProccesor new.
	aCashier := Cashier with: aCatalogue using: aMerchantProcessor.
	self assert: ((aCashier checkout: aCart with: aCard) lastPurcharse = 10).
! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:46:21'!
test03CheckoutOfACartWithManyTimesOfAnItemCheckoutsCorrectPrice
	| aCart aCatalogue aCashier aCard aDate aMerchantProcessor|
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber + 5).
	aCard _ Card withNumber: 1234567812345678 goodThru: aDate owner: 'Jorge Messi'. 
	aMerchantProcessor _ FakeMerchantProccesor new.
	aCatalogue := Dictionary new.
	aCatalogue add: '9789504974567' -> 10.
	aCart := Cart with: aCatalogue.
	aCart add: 3 of: '9789504974567'.
	aCashier := Cashier with: aCatalogue using: aMerchantProcessor.
	self assert: ((aCashier checkout: aCart with: aCard) lastPurcharse = 30).
! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:48:01'!
test04CheckoutOfACartWithManyTimesOfManyItemsCheckoutsCorrectPrice
	| aCart aCatalogue aCashier aCard aDate aMerchantProcessor|
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber + 5).
	aCard _ Card withNumber: 1234567812345678 goodThru: aDate owner: 'Jorge Messi'. 
	aMerchantProcessor _ FakeMerchantProccesor new.
	aCatalogue := Dictionary new.
	aCatalogue add: '9789504974567' -> 10; add: '9789505157532' -> 50.
	aCart := Cart with: aCatalogue.
	aCart add: 5 of: '9789504974567'.
	aCart add: 3 of: '9789505157532'.
	aCashier := Cashier with: aCatalogue using: aMerchantProcessor.
	self assert: ((aCashier checkout: aCart with: aCard) lastPurcharse = 200).
! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:50:44'!
test05CheckoutOfACartWithManyTimesOfManyItemsCheckoutsCorrectProducts
	| aCart aCatalogue aCashier expectedProducts aCard aDate aMerchantProcessor|
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber + 5).
	aCard _ Card withNumber: 1234567812345678 goodThru: aDate owner: 'Jorge Messi'. 
	aMerchantProcessor _ FakeMerchantProccesor new.
	aCatalogue := Dictionary new.
	aCatalogue add: '9789504974567' -> 10; add: '9789505157532' -> 50.
	
	aCart := Cart with: aCatalogue.
	aCart add: 5 of: '9789504974567'.
	aCart add: 3 of: '9789505157532'.
	
	aCashier := Cashier with: aCatalogue using: aMerchantProcessor.
	
	expectedProducts := Bag new. 
	expectedProducts add: '9789504974567' withOccurrences: 5.
	expectedProducts add: '9789505157532' withOccurrences: 3.
	
	self assert: ((aCashier checkout: aCart with: aCard) products = expectedProducts).
! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:53:09'!
test06CheckoutOfACartWithAValidCardCheckoutsCorrectly
	| aCart aCatalogue aCashier aCard aDate aMerchantProcessor|
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber + 5).
	aCatalogue := Dictionary new.
	aCatalogue add: '9789504974567' -> 10; add: '9789505157532' -> 50.
	aMerchantProcessor _ FakeMerchantProccesor new.
	aCart := Cart with: aCatalogue.
	aCart add: 5 of: '9789504974567'.
	aCart add: 3 of: '9789505157532'.
	
	aCard _ Card withNumber: 1234567812345678 goodThru: aDate owner: 'Jorge Messi'. 
	
	aCashier := Cashier with: aCatalogue using: aMerchantProcessor.
	
	self assert: ( (aCashier checkout: aCart with: aCard) lastTicket = 'Compra por 200 a la tarjeta: 1234567812345678' ).
! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:55:20'!
test07CheckoutOfACardWithAnExpiredCardDoesntCheckout
	| aCart aCatalogue aCashier aCard aDate aMerchantProcessor|
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber - 5).
	aCatalogue := Dictionary new.
	aCatalogue add: '9789504974567' -> 10; add: '9789505157532' -> 50.
	aMerchantProcessor _ FakeMerchantProccesor new.
	aCart := Cart with: aCatalogue.
	aCart add: 5 of: '9789504974567'.
	aCart add: 3 of: '9789505157532'.
	
	aCard _ Card withNumber: 1234567812345678 goodThru: aDate owner: 'Jorge Messi'. 
	
	aCashier := Cashier with: aCatalogue using: aMerchantProcessor.
	
	self should: [(aCashier checkout: aCart with: aCard)] raise: Error withMessageText: 'Cannot checkout with an invalid card.'
! !

!CheckoutTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 01:07:17'!
test08CheckoutOfACardWithAStolenCardDoesntCheckout
	| aCart aCatalogue aCashier aCard aDate aMerchantProcessor|
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber + 5).
	aCatalogue := Dictionary new.
	aCatalogue add: '9789504974567' -> 10; add: '9789505157532' -> 50.
	aMerchantProcessor _ FakeMerchantProccesor new.
	aCart := Cart with: aCatalogue.
	aCart add: 5 of: '9789504974567'.
	aCart add: 3 of: '9789505157532'.
	
	aCard _ Card withNumber: 1234123412341234 goodThru: aDate owner: 'Jorgelino Messi'. 
	
	aCashier := Cashier with: aCatalogue using: aMerchantProcessor.
	
	self should: [(aCashier checkout: aCart with: aCard)] raise: Error withMessageText: 'Cannot checkout with an invalid card.'
! !


!classDefinition: #MerchantProccesorTest category: 'TusLibros'!
TestCase subclass: #MerchantProccesorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProccesorTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/8/2022 19:43:17'!
test01MerchantProccesorChargesAPaymentWithAValidCard
	|fakeMerchantProccesor aDate aCard anAmount resultCode|
	resultCode _ '0|OK'.
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber + 5).
	aCard _ Card withNumber: '1234567812345678' goodThru: aDate owner: 'Jorge Penaldo'.
	fakeMerchantProccesor  _ FakeMerchantProccesor new.
	anAmount _ 200.
	
	self assert: (((fakeMerchantProccesor chargePaymentInto: aCard of: anAmount) code) = resultCode).! !

!MerchantProccesorTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/8/2022 20:02:23'!
test02MerchantProccesorDoesntChargeAPaymentWithAnInvalidCard
	|fakeMerchantProccesor aDate aCard aStolenCard anAmount resultCode|
	resultCode _ '1|ERROR:Invalid Card'.
	aDate _ Date newDay: 12 month: #July year: (Date today yearNumber - 5).
	aCard _ Card withNumber: '1234567812345678' goodThru: aDate owner: 'Jorge Penaldo'.
	aStolenCard _ Card withNumber: '1234123412341234' goodThru: aDate owner: 'Pablo Messinaldo'.
	fakeMerchantProccesor  _ FakeMerchantProccesor new.
	anAmount _ 200.
	
	self assert: (((fakeMerchantProccesor chargePaymentInto: aCard of: anAmount) code) = resultCode).
	self assert: (((fakeMerchantProccesor chargePaymentInto: aStolenCard of: anAmount) code) = resultCode).! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'owner goodThru number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'init' stamp: 'ldmaf 6/8/2022 19:19:33'!
initializeWithCardNumber: aCardNumber goodThru: aMonthAndYear owner: aName 
	number := aCardNumber.
	goodThru := aMonthAndYear. "TODO: Hay que validar que esto este ok!!"
	owner := aName.! !


!Card methodsFor: 'assertions' stamp: 'ldmaf 6/8/2022 19:20:12'!
isValidAt: aDate
	|expiredCard|
	expiredCard _ goodThru > aDate. 
	^expiredCard! !

!Card methodsFor: 'assertions' stamp: 'ldmaf 6/8/2022 19:26:59'!
number
	^number copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'instance creation' stamp: 'ldmaf 6/8/2022 20:43:18'!
withNumber: aCardNumber goodThru: aDate owner: aName
	(aCardNumber isKindOf: Integer) ifFalse: [self error: 'Cant create a card with provided number.'].
	(aCardNumber asString size = 16) ifFalse: [self error: 'Cant create a card with provided number.'].
	(aName withBlanksTrimmed size = 0) ifTrue: [self error: 'Cant create a card with provided number.'].
	(aDate isKindOf: Date) ifFalse: [self error: 'Cant create a card with provided number.'].
	^self new initializeWithCardNumber: aCardNumber goodThru: aDate owner: aName ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'ldmaf 6/4/2022 16:00:54'!
doesInclude: anAmount of: aBook 
	^(items occurrencesOf: aBook) = anAmount.! !

!Cart methodsFor: 'assertions' stamp: 'ldmaf 6/2/2022 20:51:11'!
isEmpty
	^items isEmpty.! !


!Cart methodsFor: 'operations' stamp: 'LDMAF 6/6/2022 17:34:50'!
add: aBook 
	(self catalogueIncludes: aBook) ifFalse: [self error: 'Cannot add a book not registered in our inventory.'].
	items add: aBook.! !

!Cart methodsFor: 'operations' stamp: 'LDMAF 6/6/2022 17:47:39'!
add: anAmount of: aBook 
	(self isAnInvalidQuantity: anAmount) ifTrue: [self error: 'Cannot add an invalid amount of books.'].
	anAmount timesRepeat: [self add: aBook].! !

!Cart methodsFor: 'operations' stamp: 'ldmaf 6/2/2022 21:32:27'!
booksQuantity
	^items size.! !

!Cart methodsFor: 'operations' stamp: 'LDMAF 6/6/2022 19:44:24'!
catalogueIncludes: aBook

	^ (catalogue 		includesKey: aBook) ! !

!Cart methodsFor: 'operations' stamp: 'ldmaf 6/4/2022 16:03:30'!
contents
	^items copy.! !

!Cart methodsFor: 'operations' stamp: 'LDMAF 6/6/2022 17:49:06'!
isAnInvalidQuantity: anAmount

	^ (((anAmount isKindOf: Integer) not) or: [anAmount <= 0]).! !


!Cart methodsFor: 'initialize' stamp: 'LDMAF 6/6/2022 17:37:05'!
initializeWith: aCatalogue 
	items _ OrderedCollection new.
	catalogue _ aCatalogue .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'ldmaf 6/2/2022 21:14:30'!
with: aCatalogue
	^self new initializeWith: aCatalogue! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'catalogue products totalPurchase salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 01:04:20'!
checkout: aCart with: aCard
	totalPurchase  _ 0.
	products _ Bag new. "Preguntar si hace falta tener los productos vendidos historicos".
	(aCart isEmpty) ifTrue: [^self error: 'Cannot checkout an empty cart.'].
	aCart contents do: [:aBook | 
		totalPurchase _ totalPurchase + (catalogue at: aBook).
		products add: aBook		
		].
	merchantProcessor chargePaymentInto: aCard of: totalPurchase.
	self handleMerchantProcessorCode: (merchantProcessor code).
	salesBook add: ('Compra por ', totalPurchase asString, ' a la tarjeta: ', ((aCard number) asString)).! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 01:05:56'!
handleMerchantProcessorCode: aMerchantProcessorCode
	((aMerchantProcessorCode findString: '1') = 1) ifTrue: [self error: 'Cannot checkout with an invalid card.'].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:30:48'!
initializeWith: aCatalogue using: aMerchantProcessor
	catalogue _ aCatalogue.
	products _ Bag new.
	totalPurchase _ 0.
	salesBook _ OrderedCollection new.
	merchantProcessor _ aMerchantProcessor.
	
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:43:16'!
lastPurcharse
	^totalPurchase.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:24:52'!
products
	^products copy.! !


!Cashier methodsFor: 'ticketing' stamp: 'ldmaf 6/9/2022 00:29:06'!
lastTicket
	^salesBook last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'LDMAF 6/6/2022 20:13:30'!
with: aCatalogue
	^self new initializeWith: aCatalogue! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/9/2022 00:21:19'!
with: aCatalogue using: aMerchantProccesor
	^self new initializeWith: aCatalogue using: aMerchantProccesor! !


!classDefinition: #FakeMerchantProccesor category: 'TusLibros'!
Object subclass: #FakeMerchantProccesor
	instanceVariableNames: 'code stolenCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FakeMerchantProccesor methodsFor: 'operations' stamp: 'ldmaf 6/8/2022 20:00:27'!
chargePaymentInto: aCard of: anAmount
	(self validateCard: aCard) ifFalse: [code _ '1|ERROR:Invalid Card'] ifTrue: [code _ '0|OK'.]! !

!FakeMerchantProccesor methodsFor: 'operations' stamp: 'ldmaf 6/8/2022 20:00:36'!
code
	^code copy.! !

!FakeMerchantProccesor methodsFor: 'operations' stamp: 'ldmaf 6/9/2022 01:08:30'!
initialize
	stolenCards _ OrderedCollection with: 1234123412341234.! !

!FakeMerchantProccesor methodsFor: 'operations' stamp: 'ldmaf 6/8/2022 19:57:59'!
isStolen: aCard
	^(stolenCards includes: aCard number)! !

!FakeMerchantProccesor methodsFor: 'operations' stamp: 'ldmaf 6/8/2022 19:57:20'!
validateCard: aCard
	^(aCard isValidAt: (Date today)) and: ((self isStolen: aCard) not).! !
