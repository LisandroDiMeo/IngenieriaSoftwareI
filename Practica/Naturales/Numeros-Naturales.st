!classDefinition: #I category: 'Numeros-Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros-Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next' stamp: 'ARM 3/31/2022 21:18:47'!
next

	^II! !


!I class methodsFor: 'operations' stamp: 'ARM 3/31/2022 21:19:14'!
+ aNatural

	^aNatural next! !

!I class methodsFor: 'operations' stamp: 'LDM 4/3/2022 16:22:55'!
> aNatural
	^False! !


!classDefinition: #II category: 'Numeros-Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros-Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operaciones' stamp: 'LDM 4/3/2022 16:02:32'!
* unNatural
	unNatural = I ifTrue: [^self].
	^self +  (self * (unNatural - I))! !

!II class methodsFor: 'operaciones' stamp: 'ARM 3/31/2022 21:27:43'!
+ unNatural

	^previous + unNatural next! !

!II class methodsFor: 'operaciones' stamp: 'ARM 3/31/2022 21:51:58'!
- unNatural

	unNatural = I ifTrue:[^previous].
	^previous - unNatural previous! !

!II class methodsFor: 'operaciones' stamp: 'LDM 4/3/2022 16:37:49'!
/ unNatural
	|continuaDividiendo|
	unNatural = I ifTrue: [^self].
	unNatural = self ifTrue: [^I].
	continuaDividiendo := unNatural > (self - unNatural).
	continuaDividiendo = True ifTrue: [^self + I - self].
	^I +  ((self - unNatural) / unNatural)! !

!II class methodsFor: 'operaciones' stamp: 'LDM 4/3/2022 16:19:59'!
> unNatural
	unNatural = self ifTrue: [^False].
	unNatural = I ifTrue: [^True].
	self = I ifTrue: [^False].
	^self - I > (unNatural - I)! !


!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:20:26'!
next
	next ifNotNil:[^next].
	next _ II createChildNamed: (self name , 'I').
	next previous: self.
	^next! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:26:45'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:20:55'!
previous: unNatural 
	
	previous _ unNatural! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros-Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros-Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros-Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros-Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numeros-Naturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros-Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros-Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	previous := IIIII.! !


!classDefinition: #IIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numeros-Naturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIII.
	previous := IIIIIII.! !


!classDefinition: #IIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIII.
	previous := IIIIIIII.! !


!classDefinition: #IIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIII.
	previous := IIIIIIIII.! !


!classDefinition: #IIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIII.
	previous := IIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIII.
	previous := IIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIII.
	previous := IIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIII category: 'Numeros-Naturales'!
II subclass: #IIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIII class' category: 'Numeros-Naturales'!
IIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LDM 4/3/2022 16:41:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIIIIIIIIIIIIIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
IIIIIIIIII initializeAfterFileIn!
IIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIII initializeAfterFileIn!