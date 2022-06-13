!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosInterfaceTest category: 'TusLibros'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'usersDicc today debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:46:10'!
test01CreateCartWithValidCredentialsReturnsAnEmptyCart
	|clientId clientPassword service cartId|
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (clientId->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ (service createCartWith: clientId and: clientPassword at: DateAndTime now). 
	self assert: ((service listCart: cartId) isEmpty).! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:46:09'!
test02CreateCartWithInvalidCredentialsShouldNotCreateCart
	|clientId clientPassword service |
	usersDicc _ Dictionary new.
	clientId _ 2.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	self should: [service createCartWith: clientId and: clientPassword at: DateAndTime now] raise: Error withMessageText: 'Invalid Credentials.'! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:48:44'!
test03CreateManyCartsWithValidCredentialsShouldCreateManyCarts
	| clientId clientPassword clientId2 clientPassword2 service cartId cartId2 |
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	clientId2 _ 2.
	clientPassword2 _ '54321bb'.
	usersDicc add: (clientId->clientPassword).
	usersDicc add: (clientId2->clientPassword2).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	cartId2 _ service createCartWith: clientId2 and: clientPassword2 at: DateAndTime now.
	self assert: ((service listCart: cartId) isEmpty).
	self assert: ((service listCart: cartId2) isEmpty).
	self assert: ((cartId = cartId2) not)	
! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:48:38'!
test04AddingManyBooksToACartAndThenListingItShouldReturnAllOccurrencesOfIt
	|clientId clientPassword service cartId |
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	service add: 3 of: '9780764548345' to: cartId.
	self assert: (((service listCart: cartId) at: '9780764548345') = 3).! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:48:32'!
test05ListingANonExistingCartIdThrowsAnError
	|clientId clientPassword service cartId fakeCartId|
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	fakeCartId _ 999.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	service add: 3 of: '9780764548345' to: cartId.
	self should: [service listCart: fakeCartId] raise: Error withMessageText: 'Non Existing Cart Id.'! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:48:27'!
test06AddingToANonExistingCartIdThrowsAnError
	|clientId clientPassword service fakeCartId|
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	fakeCartId _ 666.
	service _ TusLibrosService with: usersDicc.
	service createCartWith: clientId and: clientPassword at: DateAndTime now.
	self should: [service add: 3 of: '9780764548345' to: fakeCartId.] raise: Error withMessageText: 'Non Existing Cart Id.'! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:48:21'!
test07AddingAnInvalidAmountOfBooksToACartThrowsAnError
	|clientId clientPassword service cartId|
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	self should: [service add: -1 of: '9780764548345' to: cartId.] raise: Error withMessageText: 'Invalid number of items'! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:48:15'!
test08AddingAnInvalidANonExistingBookToACartThrowsAnError
	|clientId clientPassword service cartId|
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	self should: [service add: 2 of: '123' to: cartId.] raise: Error withMessageText: 'Item is not in catalog'! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:48:09'!
test09ListingCartReturnsAllBooksInside
	| clientId clientPassword service cartId listOfBooks |
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	service add: 3 of: '9780764548345' to: cartId.
	service add: 12 of: '9789871497522' to: cartId.
	service add: 7 of: '9788495070524' to: cartId.
	listOfBooks _ service listCart: cartId.
	self assert: ((listOfBooks at: '9780764548345') = 3).
	self assert: ((listOfBooks at: '9789871497522') = 12).
	self assert: ((listOfBooks at: '9788495070524') = 7).! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:48:00'!
test10CartShouldExistForThirtyMinutes
	| clientId clientPassword service cartId creationTimeInThePast |
	creationTimeInThePast _ (DateAndTime now) subtractDuration: (Duration minutes: 30).
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: creationTimeInThePast.
	self should: [service add: 3 of: '9780764548345' to: cartId]  raise: Error  withMessageText: 'Cart Expired.' .
! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:47:53'!
test11CheckoutWithAValidCreditCardCreatesACorrectSaleAndRemovesTheCartFromTheService
	| clientId clientPassword service cartIdticket creditCard cartId ticket|  
	creditCard _ CreditCard expiringOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1) 
						withNumber: 1234123412341234 
						andOwner: 'Mickey Mouse'.
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	service add: 10 of: '9780764548345' to: cartId.
	ticket _ service checkoutOf: cartId with: creditCard.
	self assert: ((service transactionAmountOf: (ticket id)) = (ticket total)).
	self assert: ((service hasCart: cartId) not).
	self assert: ((ticket quantityOf: '9780764548345') = 10).
! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:47:46'!
test12CheckoutWithAnInvalidCreditCardThrowsAnExpiredCardErrorAndKeepsTheCartInTheService
	| clientId clientPassword service creditCard cartId|  
	creditCard _ CreditCard expiringOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber - 1) 
						withNumber: 1234123412341234 
						andOwner: 'Mickey Mouse'.
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	service add: 10 of: '9780764548345' to: cartId.

	self should: [service checkoutOf: cartId with: creditCard] raise: Error withMessageText: 'Can not charge an expired credit card'.
	self assert: ((service hasCart: cartId)).
! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:49:20'!
test13CheckoutWithAnExpiredCartShouldThrowAnError
	| clientId clientPassword service creditCard cartId creationTimeInThePast futureDate|
	creationTimeInThePast _ (DateAndTime now) subtractDuration: (Duration minutes: 29).
	futureDate _ (DateAndTime tomorrow).
	creditCard _ CreditCard expiringOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1) 
						withNumber: 1234123412341234 
						andOwner: 'Mickey Mouse'.
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: creationTimeInThePast.
	service add: 10 of: '9780764548345' to: cartId.
	self should: [service checkoutOf: cartId with: creditCard at: futureDate] raise: Error  withMessageText: 'Cart Expired.'.
! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:47:34'!
test14ListPurchasesBeforeDoingAnyCheckoutReturnsAnEmptyListOfPurchases
	| clientId clientPassword service cartId |  
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	service add: 10 of: '9780764548345' to: cartId.
	
	self assert: ((service listPurchasesOf: clientId with: clientPassword) isEmpty).
! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:47:26'!
test15ListPurchasesAfterDoingOneCheckoutReturnsAListWithOnePurchase
	| clientId clientPassword service cartId creditCard purchases|
	creditCard _ CreditCard expiringOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1) 
						withNumber: 1234123412341234 
						andOwner: 'Mickey Mouse'.  
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	service add: 10 of: '9780764548345' to: cartId.
	service checkoutOf: cartId with: creditCard.
	purchases _ service listPurchasesOf: clientId with: clientPassword.
	self assert: (purchases isEmpty not).
	self assert: ((purchases first quantityOf: '9780764548345') = 10).
! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:47:21'!
test16ListPurchasesAfterDoingManyCheckoutsReturnsAListWithManyPurchases
	| clientId clientPassword service cartId creditCard purchases|
	creditCard _ CreditCard expiringOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1) 
						withNumber: 1234123412341234 
						andOwner: 'Mickey Mouse'.  
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (1->clientPassword).
	service _ TusLibrosService with: usersDicc.
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	service add: 10 of: '9780764548345' to: cartId.
	service checkoutOf: cartId with: creditCard.
	
	cartId _ service createCartWith: clientId and: clientPassword at: DateAndTime now.
	service add: 5 of: '9789871497522' to: cartId.
	service checkoutOf: cartId with: creditCard.
	purchases _ service listPurchasesOf: clientId with: clientPassword.
	self assert: (purchases isEmpty not).
	self assert: ((purchases first quantityOf: '9780764548345') = 10).
	self assert: ((purchases second quantityOf: '9789871497522') = 5).! !

!TusLibrosInterfaceTest methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/13/2022 00:47:14'!
test17ListPurchasesWithAnInvalidUserThrowsAnError
	| clientId clientPassword service|
	usersDicc _ Dictionary new.
	clientId _ 1.
	clientPassword _ '12345aa'.
	usersDicc add: (clientId->clientPassword).
	service _ TusLibrosService with: usersDicc.
	self should: [service listPurchasesOf: 999 with: clientPassword.] raise: Error withMessageText: 'Invalid Credentials.'.
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'listing' stamp: 'ldmaf 6/12/2022 16:53:39'!
items
	^ items copy.! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ldmaf 6/12/2022 22:55:10'!
createSale

	^ Sale of: total with: (cart items)
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'ldmaf 6/12/2022 19:37:19'!
initializeExpiringOn: aMonth withNumber: aCreditCardNumber andOwner: anOwner
	
	expiration := aMonth.
	number := aCreditCardNumber.
	owner := anOwner.! !


!CreditCard methodsFor: 'accessing' stamp: 'ldmaf 6/12/2022 19:43:10'!
expirationDate
	^expiration.! !

!CreditCard methodsFor: 'accessing' stamp: 'ldmaf 6/12/2022 19:42:56'!
number
	^number! !

!CreditCard methodsFor: 'accessing' stamp: 'ldmaf 6/12/2022 19:43:18'!
owner
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'ldmaf 6/12/2022 19:36:30'!
expiringOn: aMonth withNumber: aCreditCardNumber andOwner: anOwner 
 	
	^self new initializeExpiringOn: aMonth withNumber: aCreditCardNumber andOwner: anOwner.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total purchasedItems id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

!Sale methodsFor: 'initialization' stamp: 'ldmaf 6/12/2022 20:11:51'!
initializeTotal: aTotal with: aCollectionOfItems

	total := aTotal.
	id := 1.
	purchasedItems := aCollectionOfItems.! !


!Sale methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/12/2022 20:12:53'!
id
	^id ! !

!Sale methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/12/2022 20:13:05'!
items
	^purchasedItems copy.! !

!Sale methodsFor: 'as yet unclassified' stamp: 'ldmaf 6/12/2022 20:23:01'!
quantityOf: anIsbn 
	^(purchasedItems occurrencesOf: anIsbn)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !

!Sale class methodsFor: 'instance creation' stamp: 'ldmaf 6/12/2022 20:11:12'!
of: aTotal with: aCollectionOfItems

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal with: aCollectionOfItems.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibrosService category: 'TusLibros'!
Object subclass: #TusLibrosService
	instanceVariableNames: 'dictionary users carts tusLibrosCatalogue cartsTimestamps debitBehavior salesBook usersActiveCarts clientsCarts clientsPurchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosService methodsFor: 'init' stamp: 'ldmaf 6/12/2022 22:57:32'!
initializeWith: aDictionary 
	users _ aDictionary.
	carts _ Dictionary new.
	tusLibrosCatalogue _ Dictionary new.
	cartsTimestamps _ Dictionary new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	salesBook _ OrderedCollection new.
	clientsCarts _ Dictionary new.
	clientsPurchases _ Dictionary new.
	tusLibrosCatalogue add: ('9780764548345'->100).
	tusLibrosCatalogue add: ('9788495070524' -> 73).
	tusLibrosCatalogue add: ('9780764548345' -> 12).
	tusLibrosCatalogue add: ('9789871497522' -> 59). ! !


!TusLibrosService methodsFor: 'assertions' stamp: 'ldmaf 6/13/2022 00:15:23'!
assertCartIsExpired: aCartId

	^ ((DateAndTime now) - (cartsTimestamps at: aCartId)) totalMinutes >= 30! !

!TusLibrosService methodsFor: 'assertions' stamp: 'ldmaf 6/13/2022 00:35:27'!
assertCartIsExpired: aCartId at: aDateTime

	^ ((aDateTime) - (cartsTimestamps at: aCartId)) totalMinutes >= 30! !

!TusLibrosService methodsFor: 'assertions' stamp: 'ldmaf 6/12/2022 20:21:23'!
hasCart: aCartId 
	^ (carts keys includes: aCartId).! !

!TusLibrosService methodsFor: 'assertions' stamp: 'ldmaf 6/12/2022 23:53:07'!
validateCredentialsOf: aClientId with: aClientPassword 
	^((users at: aClientId ifAbsent: [self error: 'Invalid Credentials.']) = aClientPassword).! !


!TusLibrosService methodsFor: 'private' stamp: 'ldmaf 6/13/2022 00:35:40'!
checkoutOf: aCartId with: aCreditCard at: aDateTime
	|total cashier sale cartOwner purchases|
	(self hasCart: aCartId) ifFalse: [self error: 'Non Existing Cart Id.'].
	((self assertCartIsExpired: aCartId at: aDateTime)) ifTrue: [self error: 'Cart Expired.'].
	
	cashier _ Cashier toCheckout: (carts at: aCartId) 
				     	charging: aCreditCard 
					throught: self 
					on: (DateAndTime now) 
					registeringOn: salesBook.
					
	total _ cashier checkOut.
	sale _ (self generateSaleOf: aCartId withTotal: total).
	
	cartOwner _ (clientsCarts at: aCartId).
	purchases _ (self fetchClientPurchases: cartOwner).
	purchases add: sale.
	
	carts removeKey: aCartId.
	clientsCarts removeKey: aCartId.
	
	^sale.! !

!TusLibrosService methodsFor: 'private' stamp: 'ldmaf 6/13/2022 00:15:59'!
generateRandomId

	^ (Random next * 547) asInteger! !

!TusLibrosService methodsFor: 'private' stamp: 'ldmaf 6/13/2022 00:19:02'!
generateSaleOf: aCartId withTotal: total

	^ Sale of: total with: ((carts at: aCartId) items)! !


!TusLibrosService methodsFor: 'operations' stamp: 'ldmaf 6/13/2022 00:15:23'!
add: anAmount of: anIsbn to: aCartId
	(self hasCart: aCartId) ifFalse: [self error: 'Non Existing Cart Id.']. 
	((self assertCartIsExpired: aCartId)) ifTrue: [self error: 'Cart Expired.'].
	(carts at: aCartId) add: anAmount of: anIsbn.! !

!TusLibrosService methodsFor: 'operations' stamp: 'ldmaf 6/13/2022 00:38:10'!
checkoutOf: aCartId with: aCreditCard
	^ (self checkoutOf: aCartId with: aCreditCard at: DateAndTime now).
	! !

!TusLibrosService methodsFor: 'operations' stamp: 'ldmaf 6/13/2022 00:15:59'!
createCartWith: aClientId and: aPassword at: aDateAndTime
	|id|
	self validateCredentialsOf: aClientId with: aPassword.
	
	id _ self generateRandomId. "Generacion de Ids muy basica, deberia implementarse algo mas sofisticado."
	carts add: (id -> (Cart acceptingItemsOf: tusLibrosCatalogue)).
	cartsTimestamps add: (id -> aDateAndTime).
	clientsCarts add: id -> aClientId.
	^id.! !

!TusLibrosService methodsFor: 'operations' stamp: 'ldmaf 6/13/2022 00:17:54'!
fetchClientPurchases: cartOwner

	^ clientsPurchases at: cartOwner ifAbsent: [(clientsPurchases add: cartOwner->OrderedCollection new) value]! !

!TusLibrosService methodsFor: 'operations' stamp: 'ldmaf 6/13/2022 00:16:21'!
listCart: aCartId 
	| listOfBooks items |
	(self hasCart: aCartId) ifFalse: [self error: 'Non Existing Cart Id.'].
	listOfBooks _ Dictionary new.
	items _ 	(carts at: aCartId) items.
	items do: [:aBook | listOfBooks add: aBook->(items occurrencesOf: aBook)].
	^listOfBooks.
	! !

!TusLibrosService methodsFor: 'operations' stamp: 'ldmaf 6/12/2022 23:56:00'!
listPurchasesOf: aClientId with: aClientPassword 
	self validateCredentialsOf: aClientId with: aClientPassword.
	^clientsPurchases at: aClientId ifAbsent: [OrderedCollection new].! !

!TusLibrosService methodsFor: 'operations' stamp: 'ldmaf 6/12/2022 20:20:54'!
transactionAmountOf: aSaleId 
	^ (salesBook select: [:aSale | (aSale id) = aSaleId ]) first total.! !


!TusLibrosService methodsFor: 'merchant-processor-protocol' stamp: 'ldmaf 6/12/2022 19:58:09'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosService class' category: 'TusLibros'!
TusLibrosService class
	instanceVariableNames: ''!

!TusLibrosService class methodsFor: 'instance creation' stamp: 'ldmaf 6/9/2022 20:31:45'!
with: aDictionary 
	^self new initializeWith: aDictionary ! !
