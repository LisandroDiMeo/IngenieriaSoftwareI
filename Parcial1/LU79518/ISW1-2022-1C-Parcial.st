!classDefinition: #FormulaOneTest category: 'ISW1-2022-1C-Parcial-1'!
TestCase subclass: #FormulaOneTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 4/30/2022 18:38:56'!
test01SectorLengthMustBePositive

	self 
		should: [ Sector withTurboOf: 0 * kilometer.]
		raise: Error
		withMessageText: Sector lengthMustBePositiveErrorDescription! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:07'!
test02ACarCanNotBePlacedInAKilometerGreaterThanSectorLength

	| sector  outside car |
	
	sector _ Sector withTurboOf: 10 * kilometer.
	outside _ sector length + (1 * millimeter).
	car _ FormulaOneCar drivenBy: #Schumacher.
	
	self 
		should: [ sector put: car at: outside ] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Sector cannotPlacedCarErrorDescription equals: error messageText.
			self deny: (sector includes: car) ]	
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:52:15'!
test03CarCannotActivateTurboInNonTurboSector

	| car sector |

	sector _ self sectorOf10KmWithTurbo.
	car _ FormulaOneCar drivenBy: #Schumacher.
	
	sector atStartPut: car.
	
	self should: [ car activateTurbo ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: Sector turboNotAllowedErrorDescription equals: error messageText.
			self deny: car isTurboActivated]
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:20'!
test04CarCannotActivateTurboWhenNoCarAhead

	| schumacher hamilton sector |
	
	sector _ Sector withTurboOf: 20 * kilometer.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	sector put: schumacher at: 12 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	self 
		should: [ hamilton activateTurbo]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:exception |
			self assert: Sector cannotActivateTurboWhenNoCarAheadErrorDescription equals: exception messageText. 
			self deny: hamilton isTurboActivated ]! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:52:44'!
test05CarCanActivateTurboWhenLessThanASecondBehindAnotherCar

	| schumacher hamilton sector |
	
	sector _ self sectorWithTurboOf24Km.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 300 * kilometer / hour.
	hamilton speed: 300 * kilometer / hour.
	
	sector put: schumacher at: 12.95 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	schumacher activateTurbo.
	
	self assert: schumacher isTurboActivated
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:52:44'!
test06CarCannotActivateTurboWhenMoreThanASecondBehindAnotherCar

	| schumacher hamilton sector |
	
	sector _ self sectorWithTurboOf24Km.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.
	
	schumacher speed: 300 * kilometer / hour.
	hamilton speed: 300 * kilometer / hour.
	
	sector put: schumacher at: 12.9 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	self should: [schumacher activateTurbo]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self 
				assert: Sector cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription 
				equals: error messageText.
			self deny: schumacher isTurboActivated]
			! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:40'!
test07TrackMustHaveSectors

	self
		should: [ Track withSectors: #() ]
		raise: Error
		withMessageText: Track mustHaveSectorsErrorDescription! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:51:47'!
test08TheLengthOfATrackShouldBeTheSumOfItsSectors

	| sectors track |
	
	sectors _ self sectorsWithLength10AndTurboAnd20AndTurbo.
	track _ Track withSectors: sectors.
	
	self assert: 30 * kilometer equals: 	track length! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:51:47'!
test09ACarCanNotBePlacedInAKilometerGreaterThanTrackLength

	| sectors track car outside |
	
	sectors _ self sectorsWithLength10AndTurboAnd20AndTurbo.
	
	track _ Track withSectors: sectors.
	outside _ track length + (1 * millimeter).
	car _ FormulaOneCar drivenBy: #Schumacher.
	
	self should: [ track put: car at: outside ] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Track cannotPlacedCarErrorDescription equals: error messageText.
			self deny: (track includes: car) ]	
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:51:47'!
test10TrackShouldPlaceCarInKilometerWithinSector

	| sectors track car positionInTrack positionInSector2 |
	
	sectors _ self sectorsWithLength10AndTurboAnd20AndTurbo.
		
	positionInSector2 _ 5 * kilometer.
	positionInTrack _ sectors first length + positionInSector2.
	
	track _ Track withSectors: sectors.
	car _ FormulaOneCar drivenBy: #Schumacher.

	track put: car at: positionInTrack.
	
	self assert: sectors second equals: (track sectorOf: car).
	self assert: positionInTrack equals: (track positionOf: car).
	
	self deny: (sectors first includes: car).
	self assert: (sectors second includes: car).

! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:51:47'!
test11TrackShouldKnowCarsInRunning

	| sectors track car1 car2 |
	
	sectors _ self sectorsWithLength10AndTurboAnd20AndTurbo.
		
	track _ Track withSectors: sectors.
	car1 _ FormulaOneCar drivenBy: #Schumacher.
	car2 _ FormulaOneCar drivenBy: #Verstappen.

	track put: car1 at: 10 * kilometer.
	track put: car2 at: 30 * kilometer.
	
	self assert: (track includes: car1).
	self assert: (track includes: car2).
		
	self assert: (sectors first includes: car1).
	self assert: (sectors second includes: car2).

! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:51:47'!
test12CarCannotBeInMoreThanOneSectorAtATime

	| sectors track car |
	
	sectors _ self sectorsWithLength10AndTurboAnd20AndTurbo.
	
	track _ Track withSectors: sectors.
	car _ FormulaOneCar drivenBy: #Schumacher.

	track put: car at: 5 * kilometer.
	track put: car at: 15 * kilometer.
	
	self assert: sectors second equals: (track sectorOf: car).
	self deny: (sectors first includes: car).
	self assert: (sectors second includes: car)
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:51:47'!
test13GrandPrixLengthShouldBeTrackLengthTimesNumberOfLaps

	| track grandPrix numberOfLaps |
	
	track _ Track withSectors: (self sectorsWithLength10AndTurboAnd20AndTurbo).
	numberOfLaps _ 100.
	
	grandPrix _ GrandPrix on: track running: numberOfLaps.
	
	self assert: track length * numberOfLaps	 equals: grandPrix length
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 20:13:58'!
test14TwoCarsCanBeAtTheSameDistanceFromStart

	| grandPrix hamilton verstappen |
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: (OrderedCollection with: (Sector withTurboOf: 10 * kilometer)))
		running: 100.
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	hamilton _ FormulaOneCar drivenBy: #Hamilton.	
	
	grandPrix put: verstappen at: 5 * kilometer.
	grandPrix put: hamilton at: 5 * kilometer.
	
	self assertInGrandPrix: grandPrix thatDriver: verstappen isAt: 5 * kilometer. 
	self assert:  5 * kilometer equals: (grandPrix locationOf: hamilton). 
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 20:17:13'!
test15ACarStoppedShouldNotMoveAfterSomeTime

	| grandPrix verstappen |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	verstappen speed: 0 * kilometer / hour.
	
	grandPrix _ 
		self grandPrixOf100LapsWithSectors: (OrderedCollection with: (Sector withTurboOf: 10 * kilometer)) withDriver: verstappen.
	
	grandPrix put: verstappen at: 5 * kilometer.
	grandPrix advance: 10 * minute.
	
	self assertInGrandPrix: grandPrix thatDriver: verstappen isAt: 5 * kilometer.
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 20:17:13'!
test16ACarSpeedingShouldMoveAfterSomeTime

	| grandPrix verstappen sectors |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	verstappen speed: 0* kilometer / hour.
	
	sectors _ self sectorsWithLength10AndTurboAnd20AndTurbo.
	
	grandPrix _ self grandPrixOf100LapsWithSectors: sectors withDriver: verstappen.
	
	grandPrix put: verstappen at: 0 * kilometer.
	verstappen speed: 300 * kilometer / hour.
	grandPrix advance: 1 * hour.
	
	self assert: 300 * kilometer equals: (grandPrix locationOf: verstappen). 
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 20:17:13'!
test17GrandPrixKnowsSectorOfCar

	| grandPrix verstappen sectors |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	
	sectors _ self sectorsWithLength10AndTurboAnd20AndTurbo.
	
	grandPrix _ self grandPrixOf100LapsWithSectors: sectors withDriver: verstappen.
		
	grandPrix put: verstappen at: 5 * kilometer.
	
	self assertInGrandPrix: grandPrix thatDriver: verstappen isAt: 5 * kilometer.
	self assert: sectors first equals: (grandPrix sectorOf: verstappen).
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 20:17:13'!
test18GrandPrixKnowsSectorOfCarAfterSomeTime

	| grandPrix verstappen sectors |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	
	sectors _ self sectorsWithLength10AndTurboAnd20AndTurbo.
	
	grandPrix _ self grandPrixOf100LapsWithSectors: sectors withDriver: verstappen.
		
	grandPrix put: verstappen at: 0 * kilometer.
	
	verstappen speed: 5 * kilometer / hour. ":)"
	grandPrix advance: 1 * hour.
	
	self assertInGrandPrix: grandPrix thatDriver: verstappen isAt: 5 * kilometer.
	self assert: sectors first equals: (grandPrix sectorOf: verstappen).
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 20:17:13'!
test19GrandPrixMovesCarsBetweenSectors

	| grandPrix verstappen sectorA sectorB |
	
	verstappen _ FormulaOneCar drivenBy: #Verstappen.
	sectorA _ Sector withTurboOf: 10 * kilometer.
	sectorB _ Sector withTurboOf: 30 * kilometer.
	
	grandPrix _ 
		self grandPrixOf100LapsWithSectors: (OrderedCollection with:sectorA with: sectorB) withDriver: verstappen.
		
	grandPrix put: verstappen at: 5 * kilometer.

	self assertInGrandPrix: grandPrix thatDriver: verstappen isAt: 5 * kilometer. 
	self assert: sectorA equals: (grandPrix sectorOf: verstappen).
	
	verstappen speed: 15 * kilometer / hour.
	grandPrix advance: 1 * hour.
	
	self assert: 20 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert: sectorB equals: (grandPrix sectorOf: verstappen).
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:41:36'!
test20FirstTurboIncrementsSpeedByTwentyPercent

	| schumacher |
	
	schumacher _ self createDriverInATurboSectorOf: 24 * kilometer withSpeed: 100 * kilometer / hour against: [:sector |
			sector put: self driverWith100Speed at: 13 * kilometer.
		] at: 12.99 * kilometer.
	
	schumacher activateTurbo.
	
	self assert: schumacher isTurboActivated.
	self assert: 120 * kilometer / hour equals: schumacher speed.! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:42:14'!
test21SecondTurboSpeedsByTenPercent

	| schumacher |
	
	schumacher _ self createDriverInATurboSectorOf: 24 * kilometer withSpeed: 100 * kilometer / hour against: [:sector |
			sector put: self driverWith100Speed at: 13 * kilometer.
		] at: 12.99 * kilometer.
	
	schumacher activateTurbo; deactivateTurbo; activateTurbo.
	
	self assert: schumacher isTurboActivated.
	self assert: 110 * kilometer / hour equals: schumacher speed.! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:42:27'!
test22ThirdTurboSpeedsByFivePercent

	| schumacher |
	
	schumacher _ self createDriverInATurboSectorOf: 24 * kilometer withSpeed: 100 * kilometer / hour against: [:sector |
			sector put: self driverWith100Speed at: 13 * kilometer.
		] at: 12.99 * kilometer.
	
	schumacher activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo.
	
	self assert: schumacher isTurboActivated.
	self assert: 105 * kilometer / hour equals: schumacher speed.! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:42:51'!
test23AfterThridTurbo_TurboIsExhausted

	| schumacher |
	
	schumacher _ self createDriverInATurboSectorOf: 24 * kilometer withSpeed: 100 * kilometer / hour against: [:sector |
			sector put: self driverWith100Speed at: 13 * kilometer.
		] at: 12.99 * kilometer.
	
	schumacher activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo.	
	
	self assert: schumacher isTurboActivated.
	self assert: 100 * kilometer / hour equals: schumacher speed.! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:43:01'!
test24CanNotActivateTurboWhenTurboIsActivated

	| schumacher |
	
	schumacher _ self createDriverInATurboSectorOf: 24 * kilometer withSpeed: 100 * kilometer / hour against: [:sector |
			sector put: self driverWith100Speed at: 13 * kilometer.
		] at: 12.99 * kilometer.
	
	schumacher activateTurbo.
	
	self 
		should: [ schumacher activateTurbo ]
		raise: Error - MessageNotUnderstood 
		withMessageText: schumacher turboAlreadyActivatedErrorDescription
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'ldm 5/2/2022 19:43:14'!
test25CanNotDeactivateTurboWhenIsDeactivated

	| schumacher |
	
	schumacher _ self createDriverInATurboSectorOf: 24 * kilometer withSpeed: 100 * kilometer / hour against: [:sector |
			sector put: self driverWith100Speed at: 13 * kilometer.
		] at: 12.99 * kilometer.
	
	self 
		should: [ schumacher deactivateTurbo ]
		raise: Error - MessageNotUnderstood 
		withMessageText: schumacher turboAlreadydeActivatedErrorDescription
	
	! !


!FormulaOneTest methodsFor: 'instances' stamp: 'ldm 5/2/2022 19:44:29'!
createDriverInATurboSectorOf: aLength withSpeed: aSpeed against: aBlockWithOtherDrivers at: aDriverPosition 
	| schumacher sector |
	
	sector _ Sector withTurboOf: aLength.
	
	schumacher _ FormulaOneCar drivenBy: #Schumacher.
	
	schumacher speed: aSpeed.
	
	sector put: schumacher at: aDriverPosition.
	
	aBlockWithOtherDrivers value: sector.
	
	^schumacher.! !

!FormulaOneTest methodsFor: 'instances' stamp: 'ldm 5/2/2022 19:40:42'!
driverWith100Speed
	^(FormulaOneCar drivenBy: #Hamilton) speed: 100 * kilometer / hour.! !

!FormulaOneTest methodsFor: 'instances' stamp: 'ldm 5/2/2022 20:17:13'!
grandPrixOf100LapsWithSectors: aSectorCollection withDriver: aDriver

	^ GrandPrix 
		on: (Track withSectors: aSectorCollection)
		running: 100
		with: (Set with: aDriver)! !

!FormulaOneTest methodsFor: 'instances' stamp: 'ldm 5/2/2022 19:49:55'!
sectorOf10KmWithTurbo

	^ Sector withoutTurboOf: 10*kilometer! !

!FormulaOneTest methodsFor: 'instances' stamp: 'ldm 5/2/2022 19:52:44'!
sectorWithTurboOf24Km

	^ Sector withTurboOf: 24 * kilometer! !

!FormulaOneTest methodsFor: 'instances' stamp: 'ldm 5/2/2022 19:51:47'!
sectorsWithLength10AndTurboAnd20AndTurbo

	^ OrderedCollection 
		with: (Sector withTurboOf: 10 * kilometer)
		with: (Sector withoutTurboOf: 20 * kilometer)! !


!FormulaOneTest methodsFor: 'assertions' stamp: 'ldm 5/2/2022 20:12:44'!
assertInGrandPrix: aGrandPrix thatDriver: aDriver isAt: aPosition

	^ self assert: aPosition equals: (aGrandPrix locationOf: aDriver)! !


!classDefinition: #FormulaOneCar category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #FormulaOneCar
	instanceVariableNames: 'grandPrix driver speed traveledDistance currentSector turboState turboBoostState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!FormulaOneCar methodsFor: 'initialization' stamp: 'ldm 5/2/2022 18:08:49'!
initializeDrivenBy: aDriver 

	driver _ aDriver.
	turboBoostState _ TurboNoBoost new.
	turboState _ UnactiveTurboState new.
	speed _ 0*kilometer/hour.
	traveledDistance _ 0.
	! !

!FormulaOneCar methodsFor: 'initialization' stamp: 'FRT 5/1/2022 11:26:28'!
runningInGrandPrix: aGrandPrix
	
	grandPrix _ aGrandPrix! !


!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:07'!
advance: aDistance

	traveledDistance _ traveledDistance + aDistance! !

!FormulaOneCar methodsFor: 'moving' stamp: 'FRT 4/30/2022 16:33:07'!
atSector: aSector

	currentSector _ aSector.! !

!FormulaOneCar methodsFor: 'moving' stamp: 'ldm 5/2/2022 18:01:33'!
boostSpeedWithTurbo

	^turboBoostState boostSpeedOf: speed.! !

!FormulaOneCar methodsFor: 'moving' stamp: 'ldm 5/2/2022 20:08:40'!
speed
	^turboState shouldEnableTurboOf: self.
! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 5/1/2022 17:34:26'!
speed: newSpeed

	speed _ newSpeed! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:19'!
traveledDistance

	^ traveledDistance! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:31'!
traveledDistance: aDistance

	traveledDistance _ aDistance! !

!FormulaOneCar methodsFor: 'moving' stamp: 'ldm 5/2/2022 18:01:57'!
useSpeedWithNoTurboBoost
	^speed.! !


!FormulaOneCar methodsFor: 'turbo' stamp: 'ldm 5/2/2022 21:09:41'!
activateTurbo
	turboState canActivateTurboOf: self.
	
	
! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'ldm 5/2/2022 21:10:02'!
activateTurboFromActiveTurboState
	self error: self turboAlreadyActivatedErrorDescription! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'ldm 5/2/2022 21:09:06'!
activateTurboFromAnInactiveTurboState
	currentSector shouldAllowToActivateTurboTo: self.! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'ldm 5/2/2022 21:13:15'!
deactivateTurbo
	turboState canDeactivateTurboOf: self.! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'ldm 5/2/2022 21:12:51'!
deactivateTurboFromActiveTurboState
	turboState _ UnactiveTurboState new.! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'ldm 5/2/2022 21:12:41'!
deactivateTurboFromUnactiveTurboState
	self error: self turboAlreadydeActivatedErrorDescription! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:25:13'!
turboAlreadydeActivatedErrorDescription
	
	^'Turbo is already deactivated'! !


!FormulaOneCar methodsFor: 'testing' stamp: 'ldm 5/2/2022 18:08:29'!
isTurboActivated
	
	^turboState isActive.! !

!FormulaOneCar methodsFor: 'testing' stamp: 'HAW 5/2/2022 14:23:06'!
turboAlreadyActivatedErrorDescription
	
	^'Turbo already activated'! !


!FormulaOneCar methodsFor: 'turbo-private' stamp: 'ldm 5/2/2022 18:09:13'!
activateTurboInSectorWithTurbo

	turboState _ ActiveTurboState new.
	turboBoostState _ turboBoostState nextStageOfTurbo.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FormulaOneCar class' category: 'ISW1-2022-1C-Parcial-1'!
FormulaOneCar class
	instanceVariableNames: ''!

!FormulaOneCar class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 18:44:15'!
drivenBy: aDriver 

	^self new initializeDrivenBy: aDriver ! !


!classDefinition: #GrandPrix category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #GrandPrix
	instanceVariableNames: 'track numberOfLaps'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!GrandPrix methodsFor: 'initialization' stamp: 'FRT 5/1/2022 11:26:39'!
initializeWithTrack: aTrack andNumberOfLaps: aNumberOfLaps andCars: aCollectionOfCars

	track _ aTrack.
	numberOfLaps _ aNumberOfLaps.
	aCollectionOfCars do: [ :car | car runningInGrandPrix: self ].
! !


!GrandPrix methodsFor: 'car position' stamp: 'FRT 4/30/2022 22:23:59'!
locationOf: aCar

	^ aCar traveledDistance.	! !

!GrandPrix methodsFor: 'car position' stamp: 'HAW 4/30/2022 19:15:32'!
put: aCar at: aDistance

	| distanceInTrack |
	
	aCar traveledDistance: aDistance.
	
	distanceInTrack _ aDistance \\ track length.
	track put: aCar at: distanceInTrack.
	! !

!GrandPrix methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:38:16'!
sectorOf: aCar 

	^ track sectorOf: aCar.! !


!GrandPrix methodsFor: 'length' stamp: 'HAW 4/30/2022 18:43:17'!
length

	^ track length * numberOfLaps! !


!GrandPrix methodsFor: 'simulation' stamp: 'FRT 5/1/2022 09:06:07'!
advance: aTimeLapse
	
	| ix cars |
	
	cars _ track cars asOrderedCollection.
	ix _ 1.
	[ix <= cars size] whileTrue: [ | car |
		car _ cars at: ix.
		self relocate: car after: aTimeLapse.
		ix _ ix + 1.
	]
! !

!GrandPrix methodsFor: 'simulation' stamp: 'HAW 5/1/2022 17:35:43'!
relocate: aCar after: aTimeLapse 

	| distanceMoved distanceInTrack |
	
	distanceMoved _ aCar speed * aTimeLapse.
	aCar advance: distanceMoved.
	
	distanceInTrack _ aCar traveledDistance \\ track length.
	track put: aCar at: distanceInTrack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GrandPrix class' category: 'ISW1-2022-1C-Parcial-1'!
GrandPrix class
	instanceVariableNames: ''!

!GrandPrix class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 19:36:05'!
on: aTrack running: aNumberOfLaps 

	^self on: aTrack running: aNumberOfLaps with: #()! !

!GrandPrix class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 19:36:16'!
on: aTrack running: aNumberOfLaps with: aCollectionOfCars

	^self new initializeWithTrack: aTrack andNumberOfLaps: aNumberOfLaps andCars: aCollectionOfCars! !


!GrandPrix class methodsFor: 'error message' stamp: 'ARM 4/28/2022 15:09:05'!
distanceOutSideRaceTrackLengthErrorMessage

	^'Distance outside Race Track length'! !

!GrandPrix class methodsFor: 'error message' stamp: 'FRT 5/1/2022 12:24:57'!
turboNotAllowedWithRainTiresErrorMessage

	^ 'Turbo not allowed with rain tires'! !


!classDefinition: #Sector category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #Sector
	instanceVariableNames: 'cars length'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!Sector methodsFor: 'initialization' stamp: 'FRT 5/1/2022 10:02:21'!
initializeOf: aLength 

	cars _ Dictionary new.
	length _ aLength.! !


!Sector methodsFor: 'car position' stamp: 'FRT 5/1/2022 14:13:55'!
assertValidPosition: aPosition

	length < aPosition ifTrue: [ self error: self class cannotPlacedCarErrorDescription ]! !

!Sector methodsFor: 'car position' stamp: 'HAW 5/1/2022 16:59:05'!
atStartPut: aCar
 
	self put: aCar at: 0*kilometer! !

!Sector methodsFor: 'car position' stamp: 'FRT 4/30/2022 09:23:35'!
positionOf: aCar
 
	^ cars at: aCar.
! !

!Sector methodsFor: 'car position' stamp: 'FRT 5/1/2022 14:13:55'!
put: aCar at: aPosition
 
	self assertValidPosition: aPosition.
	
	cars at: aCar put: aPosition.
	aCar atSector: self.! !

!Sector methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:04:40'!
remove: aCar
 
	cars removeKey: aCar ifAbsent: [].
! !


!Sector methodsFor: 'accessing' stamp: 'FRT 4/30/2022 22:08:51'!
cars
	
	^ cars keys! !

!Sector methodsFor: 'accessing' stamp: 'HAW 5/2/2022 14:26:16'!
length

	^length! !


!Sector methodsFor: 'testing' stamp: 'HAW 5/1/2022 16:54:33'!
includes: aCar

	^ cars includesKey: aCar! !


!Sector methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:07:54'!
assertDriverIsOneSecondOrLess: aCarToActivateTurboTo ofDriverAt: positionOfCarAhead

	| carAhead |
	
	carAhead _ self carAtPosition: positionOfCarAhead.
	
	((positionOfCarAhead / carAhead speed) -
	((cars at: aCarToActivateTurboTo) / aCarToActivateTurboTo speed)) < (1 * second)
		ifFalse: [self error: Sector cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription ].! !

!Sector methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:06:52'!
carAtPosition: positionOfDriver

	^cars keyAtValue: positionOfDriver! !

!Sector methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:08:13'!
positionOfCarAheadOf: aCarToActiveTurboTo ifNone: alternativeClosure

	| sortedPositions carToActivateTurboToPosition |
	
	carToActivateTurboToPosition _ cars at: aCarToActiveTurboTo.
	sortedPositions _ cars asSortedCollection remove: carToActivateTurboToPosition; yourself.
	 
	^ sortedPositions 
		detect: [:aPosition | aPosition > carToActivateTurboToPosition ]
		ifNone: alternativeClosure ! !

!Sector methodsFor: 'turbo' stamp: 'ldm 5/2/2022 20:09:29'!
shouldAllowToActivateTurboTo: aCarToActivateTurboTo

	self subclassResponsibility.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sector class' category: 'ISW1-2022-1C-Parcial-1'!
Sector class
	instanceVariableNames: ''!

!Sector class methodsFor: 'instance creation' stamp: 'ldm 5/2/2022 18:59:52'!
withTurboOf: aLength 

	aLength strictlyPositive ifFalse: [ self error: self lengthMustBePositiveErrorDescription ]	.
	^ SectorWithTurbo new initializeOf: aLength; yourself.! !

!Sector class methodsFor: 'instance creation' stamp: 'ldm 5/2/2022 19:00:17'!
withoutTurboOf: aLength 
	
	aLength strictlyPositive ifFalse: [ self error: self lengthMustBePositiveErrorDescription ]	.
	^ SectorWithoutTurbo new initializeOf: aLength; yourself.! !


!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 20:24:41'!
cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription
	
	^ 'Cannot activate Turbo when opponent is more than 1 second ahead'! !

!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 20:13:07'!
cannotActivateTurboWhenNoCarAheadErrorDescription
	
	^ 'Cannot activate Turbo without opponent ahead'! !

!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 10:08:26'!
cannotPlacedCarErrorDescription

	^ 'Driver can not be placed outside section'! !

!Sector class methodsFor: 'error message' stamp: 'HAW 4/30/2022 17:05:20'!
lengthMustBePositiveErrorDescription

	^ 'Length must be positive'! !

!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 09:54:45'!
turboNotAllowedErrorDescription
	
	^ 'Turbo not allowed in this Sector'! !


!classDefinition: #SectorWithTurbo category: 'ISW1-2022-1C-Parcial-1'!
Sector subclass: #SectorWithTurbo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!SectorWithTurbo methodsFor: 'turbo' stamp: 'ldm 5/2/2022 20:09:29'!
shouldAllowToActivateTurboTo: aCarToActivateTurboTo

	| positionOfCarAhead |
	
	positionOfCarAhead _ self 
		positionOfCarAheadOf: aCarToActivateTurboTo 
		ifNone: [self error: Sector cannotActivateTurboWhenNoCarAheadErrorDescription ].
		
	self 
		assertDriverIsOneSecondOrLess: aCarToActivateTurboTo
		ofDriverAt: positionOfCarAhead.

	aCarToActivateTurboTo activateTurboInSectorWithTurbo
! !


!classDefinition: #SectorWithoutTurbo category: 'ISW1-2022-1C-Parcial-1'!
Sector subclass: #SectorWithoutTurbo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!SectorWithoutTurbo methodsFor: 'turbo' stamp: 'ldm 5/2/2022 20:09:29'!
shouldAllowToActivateTurboTo: aCarToActivateTurboTo

	self error: Sector turboNotAllowedErrorDescription
	! !


!classDefinition: #Track category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #Track
	instanceVariableNames: 'sectors driversDistanceFromBeginning'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!Track methodsFor: 'initialization' stamp: 'HAW 4/30/2022 17:06:50'!
initializeWithSectors: aSectors

	sectors _ aSectors copy.! !


!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:10:18'!
carNotFoundErrorDescription

	^ 'Car not found'! !

!Track methodsFor: 'car position' stamp: 'ldm 5/2/2022 19:09:56'!
positionOf: aCar

	^ sectors inject: (0 * kilometer) into: [:accumulatedLength :sector | (sector includes: aCar)
	   	ifTrue: [accumulatedLength + (sector positionOf: aCar)]
   		ifFalse: [accumulatedLength + sector length.]
	].
! !

!Track methodsFor: 'car position' stamp: 'ldm 5/2/2022 20:56:37'!
put: aCar at: aPosition

	| indexOfSector sector accumulatedLengthUntilPosition |
	
	aPosition > self length ifTrue: [ self error: self class cannotPlacedCarErrorDescription ].

	self remove: aCar.

	indexOfSector _ 1.
	sector _ sectors at: indexOfSector. 
	
	accumulatedLengthUntilPosition _ 0 * kilometer.
	
	"Aca intente utilizar un inject, pero no logre sacar la idea de tambien ir guardando el indice (o por lo menos no me funciono). "
	
	[aPosition > (accumulatedLengthUntilPosition + sector length)] whileTrue: [
		accumulatedLengthUntilPosition _ accumulatedLengthUntilPosition + sector length.
		indexOfSector _ indexOfSector + 1.
		sector _ sectors at: indexOfSector.
	].

	sector put: aCar at: aPosition - accumulatedLengthUntilPosition.! !

!Track methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:15:27'!
remove: aCar
	
	| currentSector |
	
	currentSector _ self sectorOf: aCar ifNone: [ ^ self ].
	currentSector remove: aCar.
	! !

!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:10:18'!
sectorOf: aCar
	
	^self sectorOf: aCar ifNone: [ self error: self carNotFoundErrorDescription ]! !

!Track methodsFor: 'car position' stamp: 'ldm 5/2/2022 18:52:41'!
sectorOf: aCar ifNone: aBlock

	| indexFromSectorWhereTheCarIs | 	
	indexFromSectorWhereTheCarIs _ sectors findFirst: [:sector | sector includes: aCar].
	indexFromSectorWhereTheCarIs > 0 ifTrue: [^sectors at: indexFromSectorWhereTheCarIs].
	^ aBlock value.! !


!Track methodsFor: 'accessing' stamp: 'ldm 5/2/2022 18:24:51'!
cars
	| allCars |
	
	allCars _ Set new.
	
	sectors do: [ :sector | allCars addAll: sector cars. ].

	^ allCars
	! !

!Track methodsFor: 'accessing' stamp: 'ldm 5/2/2022 18:34:34'!
length

	^sectors sum: [:sector | sector length ].

! !


!Track methodsFor: 'testing' stamp: 'ldm 5/2/2022 18:32:08'!
includes: aCar
	"Returns if any of the sectors includes aCar"
	^ sectors anySatisfy: [ :sector |
			sector includes: aCar.
		].
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Track class' category: 'ISW1-2022-1C-Parcial-1'!
Track class
	instanceVariableNames: ''!

!Track class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 17:10:08'!
withSectors: sectors

	sectors isEmpty ifTrue: [ self error: self mustHaveSectorsErrorDescription ].
	
	^ self new initializeWithSectors: sectors! !


!Track class methodsFor: 'error messages' stamp: 'FRT 4/29/2022 18:22:32'!
cannotPlacedCarErrorDescription

	^ 'Car cannot be placed in track'! !

!Track class methodsFor: 'error messages' stamp: 'HAW 4/30/2022 17:09:27'!
mustHaveSectorsErrorDescription

	^'Track must have sectors'! !


!classDefinition: #Turbo category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #Turbo
	instanceVariableNames: 'speedBoostFactor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!Turbo methodsFor: 'turbo stages' stamp: 'ldm 5/2/2022 17:33:28'!
nextStageOfTurbo
	self subclassResponsibility.! !


!Turbo methodsFor: 'turbo' stamp: 'ldm 5/2/2022 17:40:19'!
boostSpeedOf: aSpeed
	^ speedBoostFactor * aSpeed.! !


!classDefinition: #NoTurboLeft category: 'ISW1-2022-1C-Parcial-1'!
Turbo subclass: #NoTurboLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!NoTurboLeft methodsFor: 'turbo stages' stamp: 'ldm 5/2/2022 17:38:03'!
nextStageOfTurbo
	^self class new.! !


!NoTurboLeft methodsFor: 'init' stamp: 'ldm 5/2/2022 17:44:03'!
initialize
	speedBoostFactor _ 1 / 1.
	! !


!classDefinition: #TurboFirstBoost category: 'ISW1-2022-1C-Parcial-1'!
Turbo subclass: #TurboFirstBoost
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboFirstBoost methodsFor: 'turbo stages' stamp: 'ldm 5/2/2022 17:34:29'!
nextStageOfTurbo
	^TurboSecondBoost new.! !


!TurboFirstBoost methodsFor: 'init' stamp: 'ldm 5/2/2022 17:43:05'!
initialize
	speedBoostFactor  _ 12 / 10.
	! !


!classDefinition: #TurboNoBoost category: 'ISW1-2022-1C-Parcial-1'!
Turbo subclass: #TurboNoBoost
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboNoBoost methodsFor: 'turbo stages' stamp: 'ldm 5/2/2022 17:49:14'!
nextStageOfTurbo
	^TurboFirstBoost new.! !


!TurboNoBoost methodsFor: 'init' stamp: 'ldm 5/2/2022 17:49:04'!
initialize
	speedBoostFactor _ 1/1.! !


!classDefinition: #TurboSecondBoost category: 'ISW1-2022-1C-Parcial-1'!
Turbo subclass: #TurboSecondBoost
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboSecondBoost methodsFor: 'turbo stages' stamp: 'ldm 5/2/2022 17:34:57'!
nextStageOfTurbo
	^TurboThirdBoost new.! !


!TurboSecondBoost methodsFor: 'init' stamp: 'ldm 5/2/2022 17:43:19'!
initialize
	speedBoostFactor _ 11 / 10.! !


!classDefinition: #TurboThirdBoost category: 'ISW1-2022-1C-Parcial-1'!
Turbo subclass: #TurboThirdBoost
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboThirdBoost methodsFor: 'turbo stages' stamp: 'ldm 5/2/2022 17:35:11'!
nextStageOfTurbo
	^NoTurboLeft new.! !


!TurboThirdBoost methodsFor: 'init' stamp: 'ldm 5/2/2022 17:43:37'!
initialize
	speedBoostFactor _ 105 / 100.! !


!classDefinition: #TurboState category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #TurboState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!


!classDefinition: #ActiveTurboState category: 'ISW1-2022-1C-Parcial-1'!
TurboState subclass: #ActiveTurboState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!ActiveTurboState methodsFor: 'testing' stamp: 'ldm 5/2/2022 18:06:53'!
isActive
	^true.! !


!ActiveTurboState methodsFor: 'turbo activation' stamp: 'ldm 5/2/2022 21:08:11'!
canActivateTurboOf: aFormulaOneCar
	aFormulaOneCar activateTurboFromActiveTurboState.
	! !

!ActiveTurboState methodsFor: 'turbo activation' stamp: 'ldm 5/2/2022 21:13:27'!
canDeactivateTurboOf: aFormulaOneCar
	aFormulaOneCar deactivateTurboFromActiveTurboState.
	! !

!ActiveTurboState methodsFor: 'turbo activation' stamp: 'ldm 5/2/2022 20:08:40'!
shouldEnableTurboOf: aFormulaOneCar
	^aFormulaOneCar boostSpeedWithTurbo.! !


!classDefinition: #UnactiveTurboState category: 'ISW1-2022-1C-Parcial-1'!
TurboState subclass: #UnactiveTurboState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!UnactiveTurboState methodsFor: 'testing' stamp: 'ldm 5/2/2022 18:07:13'!
isActive
	^false.! !


!UnactiveTurboState methodsFor: 'turbo activation' stamp: 'ldm 5/2/2022 21:10:40'!
canActivateTurboOf: aFormulaOneCar
	aFormulaOneCar activateTurboFromAnInactiveTurboState.! !

!UnactiveTurboState methodsFor: 'turbo activation' stamp: 'ldm 5/2/2022 21:13:37'!
canDeactivateTurboOf: aFormulaOneCar
	aFormulaOneCar deactivateTurboFromUnactiveTurboState.! !

!UnactiveTurboState methodsFor: 'turbo activation' stamp: 'ldm 5/2/2022 20:08:40'!
shouldEnableTurboOf: aFormulaOneCar
	^aFormulaOneCar useSpeedWithNoTurboBoost.! !
