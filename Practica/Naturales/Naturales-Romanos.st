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

!I class methodsFor: 'operations' stamp: 'LDMAF 4/4/2022 20:39:46'!
* multiplicando
    ^multiplicando! !
!I class methodsFor: 'operations' stamp: 'ARM 3/31/2022 21:19:14'!
+ aNatural
    ^aNatural next! !
!I class methodsFor: 'operations' stamp: 'LDMAF 4/4/2022 20:46:44'!
/ divisor
    self = divisor ifTrue: [^self].
    self error: 'Uno no se puede dividir por un numero mayor'.! !
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
!II class methodsFor: 'operaciones' stamp: 'LDMAF 4/4/2022 21:27:55'!
+ unNatural
    ^self next + unNatural previous.! !
!II class methodsFor: 'operaciones' stamp: 'ARM 3/31/2022 21:51:58'!
- unNatural
    unNatural = I ifTrue:[^previous].
    ^previous - unNatural previous! !
!II class methodsFor: 'operaciones' stamp: 'LDMAF 4/4/2022 21:01:04'!
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

!II class methodsFor: 'next & previous' stamp: 'LDMAF 4/4/2022 21:41:11'!
nameOfNext
    (self name endsWith: 'XXXIX') ifTrue: [^(self name withoutSuffix: 'XXXIX') , 'XL'].
    (self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX') , 'X'].
    (self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII') , 'IX'].
    (self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III') , 'IV'].
    (self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV') , 'V'].
    ^ self name , 'I'.! !
!II class methodsFor: 'next & previous' stamp: 'LDMAF 4/4/2022 20:52:56'!
next
    next ifNotNil:[^next].
    next _ II createChildNamed: (self nameOfNext).
    next previous: self.
    ^next! !
!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:26:45'!
previous
    ^previous! !
!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:20:55'!
previous: unNatural 
    
    previous _ unNatural! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
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
!III class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := IV.
    previous := II.! !
 
!classDefinition: #IV category: 'Numeros-Naturales'!
II subclass: #IV
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'IV class' category: 'Numeros-Naturales'!
IV class
    instanceVariableNames: ''!
!IV class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := V.
    previous := III.! !
 
!classDefinition: #IX category: 'Numeros-Naturales'!
II subclass: #IX
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'IX class' category: 'Numeros-Naturales'!
IX class
    instanceVariableNames: ''!
!IX class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := X.
    previous := VIII.! !
 
!classDefinition: #V category: 'Numeros-Naturales'!
II subclass: #V
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'V class' category: 'Numeros-Naturales'!
V class
    instanceVariableNames: ''!
!V class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := VI.
    previous := IV.! !
 
!classDefinition: #VI category: 'Numeros-Naturales'!
II subclass: #VI
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'VI class' category: 'Numeros-Naturales'!
VI class
    instanceVariableNames: ''!
!VI class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := VII.
    previous := V.! !
 
!classDefinition: #VII category: 'Numeros-Naturales'!
II subclass: #VII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'VII class' category: 'Numeros-Naturales'!
VII class
    instanceVariableNames: ''!
!VII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := VIII.
    previous := VI.! !
 
!classDefinition: #VIII category: 'Numeros-Naturales'!
II subclass: #VIII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'VIII class' category: 'Numeros-Naturales'!
VIII class
    instanceVariableNames: ''!
!VIII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := IX.
    previous := VII.! !
 
!classDefinition: #X category: 'Numeros-Naturales'!
II subclass: #X
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'X class' category: 'Numeros-Naturales'!
X class
    instanceVariableNames: ''!
!X class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XI.
    previous := IX.! !
 
!classDefinition: #XI category: 'Numeros-Naturales'!
II subclass: #XI
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XI class' category: 'Numeros-Naturales'!
XI class
    instanceVariableNames: ''!
!XI class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XII.
    previous := X.! !
 
!classDefinition: #XII category: 'Numeros-Naturales'!
II subclass: #XII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XII class' category: 'Numeros-Naturales'!
XII class
    instanceVariableNames: ''!
!XII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XIII.
    previous := XI.! !
 
!classDefinition: #XIII category: 'Numeros-Naturales'!
II subclass: #XIII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XIII class' category: 'Numeros-Naturales'!
XIII class
    instanceVariableNames: ''!
!XIII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XIV.
    previous := XII.! !
 
!classDefinition: #XIV category: 'Numeros-Naturales'!
II subclass: #XIV
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XIV class' category: 'Numeros-Naturales'!
XIV class
    instanceVariableNames: ''!
!XIV class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XV.
    previous := XIII.! !
 
!classDefinition: #XIX category: 'Numeros-Naturales'!
II subclass: #XIX
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XIX class' category: 'Numeros-Naturales'!
XIX class
    instanceVariableNames: ''!
!XIX class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XX.
    previous := XVIII.! !
 
!classDefinition: #XL category: 'Numeros-Naturales'!
II subclass: #XL
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XL class' category: 'Numeros-Naturales'!
XL class
    instanceVariableNames: ''!
!XL class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := nil.
    previous := XXXIX.! !
 
!classDefinition: #XV category: 'Numeros-Naturales'!
II subclass: #XV
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XV class' category: 'Numeros-Naturales'!
XV class
    instanceVariableNames: ''!
!XV class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XVI.
    previous := XIV.! !
 
!classDefinition: #XVI category: 'Numeros-Naturales'!
II subclass: #XVI
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XVI class' category: 'Numeros-Naturales'!
XVI class
    instanceVariableNames: ''!
!XVI class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XVII.
    previous := XV.! !
 
!classDefinition: #XVII category: 'Numeros-Naturales'!
II subclass: #XVII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XVII class' category: 'Numeros-Naturales'!
XVII class
    instanceVariableNames: ''!
!XVII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XVIII.
    previous := XVI.! !
 
!classDefinition: #XVIII category: 'Numeros-Naturales'!
II subclass: #XVIII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XVIII class' category: 'Numeros-Naturales'!
XVIII class
    instanceVariableNames: ''!
!XVIII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XIX.
    previous := XVII.! !
 
!classDefinition: #XX category: 'Numeros-Naturales'!
II subclass: #XX
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XX class' category: 'Numeros-Naturales'!
XX class
    instanceVariableNames: ''!
!XX class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXI.
    previous := XIX.! !
 
!classDefinition: #XXI category: 'Numeros-Naturales'!
II subclass: #XXI
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXI class' category: 'Numeros-Naturales'!
XXI class
    instanceVariableNames: ''!
!XXI class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXII.
    previous := XX.! !
 
!classDefinition: #XXII category: 'Numeros-Naturales'!
II subclass: #XXII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXII class' category: 'Numeros-Naturales'!
XXII class
    instanceVariableNames: ''!
!XXII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXIII.
    previous := XXI.! !
 
!classDefinition: #XXIII category: 'Numeros-Naturales'!
II subclass: #XXIII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXIII class' category: 'Numeros-Naturales'!
XXIII class
    instanceVariableNames: ''!
!XXIII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXIV.
    previous := XXII.! !
 
!classDefinition: #XXIV category: 'Numeros-Naturales'!
II subclass: #XXIV
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXIV class' category: 'Numeros-Naturales'!
XXIV class
    instanceVariableNames: ''!
!XXIV class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXV.
    previous := XXIII.! !
 
!classDefinition: #XXIX category: 'Numeros-Naturales'!
II subclass: #XXIX
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXIX class' category: 'Numeros-Naturales'!
XXIX class
    instanceVariableNames: ''!
!XXIX class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXX.
    previous := XXVIII.! !
 
!classDefinition: #XXV category: 'Numeros-Naturales'!
II subclass: #XXV
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXV class' category: 'Numeros-Naturales'!
XXV class
    instanceVariableNames: ''!
!XXV class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXVI.
    previous := XXIV.! !
 
!classDefinition: #XXVI category: 'Numeros-Naturales'!
II subclass: #XXVI
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXVI class' category: 'Numeros-Naturales'!
XXVI class
    instanceVariableNames: ''!
!XXVI class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXVII.
    previous := XXV.! !
 
!classDefinition: #XXVII category: 'Numeros-Naturales'!
II subclass: #XXVII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXVII class' category: 'Numeros-Naturales'!
XXVII class
    instanceVariableNames: ''!
!XXVII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXVIII.
    previous := XXVI.! !
 
!classDefinition: #XXVIII category: 'Numeros-Naturales'!
II subclass: #XXVIII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXVIII class' category: 'Numeros-Naturales'!
XXVIII class
    instanceVariableNames: ''!
!XXVIII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXIX.
    previous := XXVII.! !
 
!classDefinition: #XXX category: 'Numeros-Naturales'!
II subclass: #XXX
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXX class' category: 'Numeros-Naturales'!
XXX class
    instanceVariableNames: ''!
!XXX class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXXI.
    previous := XXIX.! !
 
!classDefinition: #XXXI category: 'Numeros-Naturales'!
II subclass: #XXXI
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXXI class' category: 'Numeros-Naturales'!
XXXI class
    instanceVariableNames: ''!
!XXXI class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXXII.
    previous := XXX.! !
 
!classDefinition: #XXXII category: 'Numeros-Naturales'!
II subclass: #XXXII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXXII class' category: 'Numeros-Naturales'!
XXXII class
    instanceVariableNames: ''!
!XXXII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXXIII.
    previous := XXXI.! !
 
!classDefinition: #XXXIII category: 'Numeros-Naturales'!
II subclass: #XXXIII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXXIII class' category: 'Numeros-Naturales'!
XXXIII class
    instanceVariableNames: ''!
!XXXIII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXXIV.
    previous := XXXII.! !
 
!classDefinition: #XXXIV category: 'Numeros-Naturales'!
II subclass: #XXXIV
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXXIV class' category: 'Numeros-Naturales'!
XXXIV class
    instanceVariableNames: ''!
!XXXIV class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXXV.
    previous := XXXIII.! !
 
!classDefinition: #XXXIX category: 'Numeros-Naturales'!
II subclass: #XXXIX
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXXIX class' category: 'Numeros-Naturales'!
XXXIX class
    instanceVariableNames: ''!
!XXXIX class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XL.
    previous := XXXVIII.! !
 
!classDefinition: #XXXV category: 'Numeros-Naturales'!
II subclass: #XXXV
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXXV class' category: 'Numeros-Naturales'!
XXXV class
    instanceVariableNames: ''!
!XXXV class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXXVI.
    previous := XXXIV.! !
 
!classDefinition: #XXXVI category: 'Numeros-Naturales'!
II subclass: #XXXVI
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXXVI class' category: 'Numeros-Naturales'!
XXXVI class
    instanceVariableNames: ''!
!XXXVI class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXXVII.
    previous := XXXV.! !
 
!classDefinition: #XXXVII category: 'Numeros-Naturales'!
II subclass: #XXXVII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXXVII class' category: 'Numeros-Naturales'!
XXXVII class
    instanceVariableNames: ''!
!XXXVII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXXVIII.
    previous := XXXVI.! !
 
!classDefinition: #XXXVIII category: 'Numeros-Naturales'!
II subclass: #XXXVIII
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'Numeros-Naturales'!
"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!
!classDefinition: 'XXXVIII class' category: 'Numeros-Naturales'!
XXXVIII class
    instanceVariableNames: ''!
!XXXVIII class methodsFor: '--** private fileout/in **--' stamp: 'LDMAF 4/4/2022 21:44:58'!
initializeCollaboratorsFromFile
    "Auto generated method for loading purposes - Do not modify it"
    next := XXXIX.
    previous := XXXVII.! !
II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!
IX initializeAfterFileIn!
V initializeAfterFileIn!
VI initializeAfterFileIn!
VII initializeAfterFileIn!
VIII initializeAfterFileIn!
X initializeAfterFileIn!
XI initializeAfterFileIn!
XII initializeAfterFileIn!
XIII initializeAfterFileIn!
XIV initializeAfterFileIn!
XIX initializeAfterFileIn!
XL initializeAfterFileIn!
XV initializeAfterFileIn!
XVI initializeAfterFileIn!
XVII initializeAfterFileIn!
XVIII initializeAfterFileIn!
XX initializeAfterFileIn!
XXI initializeAfterFileIn!
XXII initializeAfterFileIn!
XXIII initializeAfterFileIn!
XXIV initializeAfterFileIn!
XXIX initializeAfterFileIn!
XXV initializeAfterFileIn!
XXVI initializeAfterFileIn!
XXVII initializeAfterFileIn!
XXVIII initializeAfterFileIn!
XXX initializeAfterFileIn!
XXXI initializeAfterFileIn!
XXXII initializeAfterFileIn!
XXXIII initializeAfterFileIn!
XXXIV initializeAfterFileIn!
XXXIX initializeAfterFileIn!
XXXV initializeAfterFileIn!
XXXVI initializeAfterFileIn!
XXXVII initializeAfterFileIn!
XXXVIII initializeAfterFileIn!
