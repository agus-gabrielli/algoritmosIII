!classDefinition: #AlejandroElEncargado category: 'PrimerClase'!
DenotativeObject subclass: #AlejandroElEncargado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PrimerClase'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AlejandroElEncargado class' category: 'PrimerClase'!
AlejandroElEncargado class
	instanceVariableNames: ''!

!AlejandroElEncargado class methodsFor: 'as yet unclassified' stamp: 'SF 10/1/2020 21:28:46'!
saludoCon: unSaludo

	^unSaludo, ' Sergio'! !


!classDefinition: #GuardiaDeSkyrim category: 'PrimerClase'!
DenotativeObject subclass: #GuardiaDeSkyrim
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PrimerClase'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GuardiaDeSkyrim class' category: 'PrimerClase'!
GuardiaDeSkyrim class
	instanceVariableNames: 'cantidadDeVecesQueHablaronConmigo frasesDeConversacion'!

!GuardiaDeSkyrim class methodsFor: 'as yet unclassified' stamp: 'AG 10/5/2020 16:50:10'!
contestar
	
	^frasesDeConversacion at: (cantidadDeVecesQueHablaronConmigo min: 4).! !

!GuardiaDeSkyrim class methodsFor: 'as yet unclassified' stamp: 'SF 10/1/2020 21:42:04'!
conversar

	self recordarQueConversaronConmigo.
	^self contestar! !

!GuardiaDeSkyrim class methodsFor: 'as yet unclassified' stamp: 'AG 10/5/2020 16:57:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	cantidadDeVecesQueHablaronConmigo := 0.
	frasesDeConversacion := #('Hola forastero, qu� haces por aqu�?' 'Si quieres coimearme, ni lo pienses' 'No deber�as estar hablando mucho con un guardia' 'No molestes m�s, vete de aqu�' ).! !

!GuardiaDeSkyrim class methodsFor: 'as yet unclassified' stamp: 'SF 10/1/2020 21:51:16'!
recordarQueConversaronConmigo

	cantidadDeVecesQueHablaronConmigo := cantidadDeVecesQueHablaronConmigo + 1.
! !

GuardiaDeSkyrim initializeAfterFileIn!