!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:26:51'!
* aMultiplier 
	^aMultiplier multiplyToAnInteger: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:10:11'!
+ anAdder 
	^anAdder sumToAnInteger: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:52:35'!
- aSubtrahend 
	^aSubtrahend substractToAnInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 20:35:26'!
/ aDivisor 
	^aDivisor divideToAnInteger: self. ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 20:17:18'!
divideToAFraction: aFraction
	^Fraccion with: (aFraction numerator) over: (self * (aFraction denominator)).
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 20:41:14'!
divideToAnInteger: anInteger
	^Fraccion with: anInteger over: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/23/2022 16:47:46'!
fibonacci
	self subclassResponsibility.
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:27:08'!
multiplyToAFraction: aFraction
	^Fraccion with: ((self class with: self integerValue) * aFraction numerator) over: (aFraction denominator)
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:23:18'!
multiplyToAnInteger: anInteger
	^self class with: value * anInteger integerValue
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 20:02:00'!
substractToAFraction: aFraction
	|newNumerator|
	newNumerator := (aFraction numerator) - (self * (aFraction denominator)).
	^newNumerator / (aFraction denominator)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:51:09'!
substractToAnInteger: anInteger
	^ self class with: (anInteger integerValue - value) ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:11:08'!
sumToAFraction: aFraction
	|newNumerator|
	newNumerator := (self * (aFraction denominator)) + (aFraction numerator).
	^newNumerator / (aFraction denominator).
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:03:08'!
sumToAnInteger: anInteger
	^self class with: (value + anInteger integerValue)
! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'LDM 4/24/2022 00:53:15'!
isNegative
	self subclassResponsibility.	! !

!Entero methodsFor: 'testing' stamp: 'LDM 4/24/2022 00:53:00'!
isOne
	self subclassResponsibility.! !

!Entero methodsFor: 'testing' stamp: 'LDM 4/24/2022 00:53:07'!
isZero
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'LDM 4/24/2022 00:41:58'!
canInitializeWith: anIntegerValue
	self subclassResponsibility.! !

!Entero class methodsFor: 'instance creation' stamp: 'LDM 4/24/2022 01:08:57'!
forbiddenValueForIntegerInstantiation
	^'El valor para instanciar debe ser anInteger.'! !

!Entero class methodsFor: 'instance creation' stamp: 'LDM 4/24/2022 01:09:07'!
negativeFibonacciErrorDescription
	^ 'Fibonacci no está definido aquí para Enteros Negativos.'! !

!Entero class methodsFor: 'instance creation' stamp: 'LDM 4/24/2022 01:04:46'!
unableToInitializeWithCurrentValueErrorDescription
	^'No se puede inicializar un entero con ese valor.'! !

!Entero class methodsFor: 'instance creation' stamp: 'LDM 4/24/2022 01:10:02'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: Entero forbiddenValueForIntegerInstantiation ].
	^(Entero subclasses 
		detect: [ :enteroSubclass | enteroSubclass canInitializeWith: aValue ]
		ifNone: [ self error: Entero unableToInitializeWithCurrentValueErrorDescription ]) 
		new initalizeWith: aValue.! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'testing' stamp: 'LDM 4/23/2022 16:41:32'!
isNegative
	^false.! !

!Cero methodsFor: 'testing' stamp: 'LDM 4/23/2022 16:41:28'!
isOne
	^false.! !

!Cero methodsFor: 'testing' stamp: 'LDM 4/23/2022 16:41:20'!
isZero
	^true.! !


!Cero methodsFor: 'arithmetic operations' stamp: 'LDM 4/24/2022 00:50:43'!
fibonacci
	^Entero with: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'as yet unclassified' stamp: 'LDM 4/24/2022 00:44:10'!
canInitializeWith: anIntegerValue
	^anIntegerValue  = 0.! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'testing' stamp: 'LDM 4/23/2022 16:35:28'!
isNegative
	^true.! !

!EnteroNegativo methodsFor: 'testing' stamp: 'LDM 4/23/2022 16:35:53'!
isOne
	^false.! !

!EnteroNegativo methodsFor: 'testing' stamp: 'LDM 4/23/2022 16:35:47'!
isZero
	^false.! !


!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'LDM 4/23/2022 16:38:22'!
fibonacci
	^self error: Entero negativeFibonacciErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numero-Exercise'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'instance creation' stamp: 'LDM 4/24/2022 00:43:38'!
canInitializeWith: anIntegerValue
	^anIntegerValue < 0! !


!classDefinition: #EnteroPositivoMayorAUno category: 'Numero-Exercise'!
Entero subclass: #EnteroPositivoMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivoMayorAUno methodsFor: 'testing' stamp: 'LDM 4/23/2022 16:34:58'!
isNegative
	^false.! !

!EnteroPositivoMayorAUno methodsFor: 'testing' stamp: 'LDM 4/24/2022 00:50:04'!
isOne
	^false.! !

!EnteroPositivoMayorAUno methodsFor: 'testing' stamp: 'LDM 4/23/2022 16:33:25'!
isZero
	^false.! !


!EnteroPositivoMayorAUno methodsFor: 'arithmetic operations' stamp: 'LDM 4/24/2022 00:51:00'!
fibonacci
	|one two|
	one := Entero with: 1.
	two := Entero with: 2.
	^(self - one) fibonacci + (self - two) fibonacci! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroPositivoMayorAUno class' category: 'Numero-Exercise'!
EnteroPositivoMayorAUno class
	instanceVariableNames: ''!

!EnteroPositivoMayorAUno class methodsFor: 'instance creation' stamp: 'LDM 4/24/2022 00:46:04'!
canInitializeWith: anIntegerValue
	^anIntegerValue > 1! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'testing' stamp: 'LDM 4/24/2022 00:45:20'!
isNegative
	^false.! !

!Uno methodsFor: 'testing' stamp: 'LDM 4/24/2022 00:49:52'!
isOne
	^true.! !

!Uno methodsFor: 'testing' stamp: 'LDM 4/24/2022 00:49:56'!
isZero
	^false.! !


!Uno methodsFor: 'arithmetic operations' stamp: 'LDM 4/24/2022 00:50:25'!
fibonacci
	^ self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'as yet unclassified' stamp: 'LDM 4/24/2022 00:46:13'!
canInitializeWith: anIntegerValue
	^anIntegerValue  = 1.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:27:49'!
* aMultiplier 
	^aMultiplier multiplyToAFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:08:28'!
+ anAdder 
	^anAdder sumToAFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:53:57'!
- aSubtrahend 
	^ aSubtrahend substractToAFraction: self.
 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 20:27:29'!
/ aDivisor 
	^aDivisor divideToAFraction: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 20:43:18'!
divideToAFraction: aFraction 
	^ (denominator * aFraction numerator) / (numerator * aFraction denominator)  
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 20:42:34'!
divideToAnInteger: anInteger
	^Fraccion with: (anInteger * denominator) over: (numerator). 
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:27:22'!
multiplyToAFraction: aFraction
	^(numerator * aFraction numerator) / (denominator * aFraction denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:20:15'!
multiplyToAnInteger: anInteger
	^self class with: (anInteger * self numerator ) over: (self denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:58:16'!
substractToAFraction: aFraction
	|newNumerator newDenominator|
	newNumerator := (denominator * aFraction numerator) - (numerator * aFraction denominator).
	newDenominator := denominator * aFraction denominator.
	^newNumerator / newDenominator		
 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:59:00'!
substractToAnInteger: anInteger
	|newNumerator|
	newNumerator := ((denominator) * anInteger) - (numerator).
	^ newNumerator / denominator 
 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:09:17'!
sumToAFraction: aFraction 
	
	| newNumerator newDenominator |
	newNumerator := (numerator * aFraction denominator) + (denominator * aFraction numerator).
	newDenominator := denominator * aFraction denominator.
	^newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'LDM 4/22/2022 19:09:39'!
sumToAnInteger: anInteger 
	|newNumerator newDenominator|
	newNumerator := (numerator) + ((denominator) * anInteger).
	newDenominator := denominator * (Entero with: 1). 
	^ newNumerator / newDenominator .! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'LDM 4/25/2022 11:52:09'!
with: aDividend over: aDivisor

	^(Fraccion subclasses
	detect: [:aSubclass | aSubclass canInitializeWith: aDividend over: aDivisor]
	ifNone: [self error: 'No se pudo inicializar una Fraccion con esos valores']) with: aDividend over: aDivisor.
	! !


!classDefinition: #FraccionConDenominadorCero category: 'Numero-Exercise'!
Fraccion subclass: #FraccionConDenominadorCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConDenominadorCero class' category: 'Numero-Exercise'!
FraccionConDenominadorCero class
	instanceVariableNames: ''!

!FraccionConDenominadorCero class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 10:56:56'!
canInitializeWith: numerator over: denominator
	^denominator isZero. ! !

!FraccionConDenominadorCero class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:18:28'!
with: aDividend over: aDivisor
	self error: self canNotDivideByZeroErrorDescription.! !


!classDefinition: #FraccionConDenominadorNegativo category: 'Numero-Exercise'!
Fraccion subclass: #FraccionConDenominadorNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConDenominadorNegativo class' category: 'Numero-Exercise'!
FraccionConDenominadorNegativo class
	instanceVariableNames: ''!

!FraccionConDenominadorNegativo class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:01:39'!
canInitializeWith: numerator over: denominator
	^denominator isNegative. ! !

!FraccionConDenominadorNegativo class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:25:03'!
with: aDividend over: aDivisor
	^aDividend negated / aDivisor negated! !


!classDefinition: #FraccionConDenominadorPositivoNumeradorNoCero category: 'Numero-Exercise'!
Fraccion subclass: #FraccionConDenominadorPositivoNumeradorNoCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConDenominadorPositivoNumeradorNoCero class' category: 'Numero-Exercise'!
FraccionConDenominadorPositivoNumeradorNoCero class
	instanceVariableNames: ''!

!FraccionConDenominadorPositivoNumeradorNoCero class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:40:00'!
canInitializeWith: numerator over: denominator
	^(denominator integerValue > 0) or: (numerator isZero not)! !

!FraccionConDenominadorPositivoNumeradorNoCero class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:48:53'!
with: aDividend over: aDivisor
	| denominator greatestCommonDivisor numerator |
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	^(FraccionConDenominadorPositivoNumeradorNoCero subclasses
		detect: [:aSubclass | aSubclass canInitializeWith: denominator]
		ifNone: [self error: 'No se pudo inicializar una Fraccion con esos valores']) with: numerator over: denominator.! !


!classDefinition: #FraccionConNumeradorDiferenteAUno category: 'Numero-Exercise'!
FraccionConDenominadorPositivoNumeradorNoCero subclass: #FraccionConNumeradorDiferenteAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConNumeradorDiferenteAUno class' category: 'Numero-Exercise'!
FraccionConNumeradorDiferenteAUno class
	instanceVariableNames: ''!

!FraccionConNumeradorDiferenteAUno class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:46:57'!
canInitializeWith: denominator
	^ denominator isOne not.! !

!FraccionConNumeradorDiferenteAUno class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:47:52'!
with: aNumerator over: aDenominator
	^ self new initializeWith: aNumerator over: aDenominator.! !


!classDefinition: #FraccionConNumeradorUno category: 'Numero-Exercise'!
FraccionConDenominadorPositivoNumeradorNoCero subclass: #FraccionConNumeradorUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConNumeradorUno class' category: 'Numero-Exercise'!
FraccionConNumeradorUno class
	instanceVariableNames: ''!

!FraccionConNumeradorUno class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:47:15'!
canInitializeWith: denominator
	^ denominator isOne.! !

!FraccionConNumeradorUno class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:47:33'!
with: aNumerator over: aDenominator
	^ aNumerator.! !


!classDefinition: #FraccionConNumeradorCero category: 'Numero-Exercise'!
Fraccion subclass: #FraccionConNumeradorCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FraccionConNumeradorCero class' category: 'Numero-Exercise'!
FraccionConNumeradorCero class
	instanceVariableNames: ''!

!FraccionConNumeradorCero class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:01:18'!
canInitializeWith: numerator over: denominator
	^numerator isZero. ! !

!FraccionConNumeradorCero class methodsFor: 'as yet unclassified' stamp: 'LDM 4/25/2022 11:31:35'!
with: aDividend over: aDivisor
	^aDividend.! !
