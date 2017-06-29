# Process Book
Een gedetailleerde beschrijving van mijn dagelijke vooruitgangen tot het creeren van de uiteindelijke app.

## Week 1
### 6 juni
Ik twijfelde nog wat voor soort duikapp ik wilde maken. Het was of een informatieve app om duikplekken op te zoeken of een sociale app om een duikbuddy te zoeken. Ik heb er vandaag voor gekozen om toch voor de sociale app te gaan. De keuze hierbij viel op het maken van een chatfunctie. Ook heb ik besloten om de locatie op te halen via CoreLocations. Als layout wil ik vooral lijsten in de backend houden (FirebaseDatabase) om het zo strak mogelijk te houden. Proposal gemaakt.

### 7 juni
Vandaag ben ik tot de conclusie gekomen dat ik vooral heel veel met FirebaseDatabase moet gaan werken. Ik wil hier denk ik alles over een gebruiker opslaan; profielfoto en alle informatie die is ingevuld. Ook wil ik hier de huidige locatie opslaan. Ik heb besloten dat ik de gebruiker niet constant wil traceren op locatie, maar dat hij kan aangeven als hij de huidige locatie zou willen wijzigen of niet. Ook heb ik de keuze gemaakt om de chat in FirebaseDatabase op te slaan en deze dan telkens weer op te halen. Ik heb vandaag de schets van de proposal tot werkelijkheid gebracht met een prototype. En heb Design Document geschreven.

### 8 juni
Vandaag heb ik Firebase pods geinstalleerd en de Login, Register en Logout functies gemaakt.

### 9 juni
Ik heb de structuur binnen Firebase werkend gemaakt, zodat elke user ID onder elkaar komt te staan, met binnen elke userID hun eigen informatie.

### 10 juni
Na heel veel tutorials, is het vandaag gelukt om een profiel foto vanuit Photos te selecteren en deze op te slaan in Firebase.

### 11 juni
Vandaag is het gelukt om informatie op te halen vanuit Firebase en deze weer te geven op het profiel van de huidige gebruiker. Ook zit ik te kijken hoe ik zoekresultaten kan ordenenen gebasseerd op locatie.

## Week 2
### 12 juni
Ik had vandaag niet heel veel tijd. Ik ben begonnen met het ophalen van alle gebruikers in FindDivers (niet gebaseerd op locatie). Dit is niet helemaal gelukt.

### 13 juni
Het is vandaag wel gelukt met het ophalen van alle gebruikers. Ook is het gelukt om de UserProfile werkend te krijgen met alle persoonlijke info per profiel te zien. Ik heb vandaag besloten dat ik een Mapview wil gebruiken in plaats van in een lijst zien welke gebruikers in de buurt zijn. Op deze manier zie je handmatig wie er in de buurt is, en kan je ook voor andere gebieden zien waar gebruikers zijn zodat je meer mogelijkheden hebt om ergens anders te duiken in plaats van waar je zelf zit. Ik heb dus vandaag de MapKit geimporteerd en ervoor gezorgd dat de locatie van de huidige gebruiker te zien is.

### 14 juni
Vandaag heb ik gekeken hoe ik alle gebruikers op de map kon krijgen en deze met een pin te zien kon krijgen. Dit is gelukt. Het is nog niet gelukt om een segue te maken vanuit de pin naar het profiel van die gebruiker.

### 15 juni
Het ging vandaag niet zo lekker. Ik was verder gegaan met het uitpuzzelen van een segue vanuit de pin naar de UserProfile, met heel veel hulp van Marijn kwamen we er nogsteeds niet uit. Hierdoor heb ik niet echt meer verder kunnen werken, omdat ik zonder gebruikers ook niet aan mn chatfunctie kan beginnen. Dus toen ben ik vast tutorials gaan zoeken over het implementeren van een chatfunctie.

### 16 juni
Het is gelukt met UserProfile. Ook is het gelukt om chatberichten op te slaan in Firebase

### 17 juni
De MessageLog werkt. Alleen timestamp lukte niet om erbij te zetten.

## Week 3
### 20 juni
Ik ben verder gegaan met de chatfunctie. Ik heb een nieuwe child in Firebase aangemaakt om per gebruiker de bijbehorde chats te zien. Het lukt om nu via userProfile de berichten te zien. Maar nog niet via chatlog. Timestamp moet ook nogsteeds.

### 21 juni
Het is vandaag gelukt met de chatfunctie. De cellen zijn dynamisch gebaseerd op de grootte van de text. De timestamp werkt nu ook.

### 22 juni
Ik heb vandaag LogIn bugs gefixed. En als gebruikers zich registeren met een afbeelding dan wordt deze kleiner gemaakt zodat het laden later niet zo lang duurt.

### 23 juni
Ik ben vandaag bezig geweest met de navigation controller zodat de gebruiker niet back kan gaan naar LogIn. Dit is alleen nog niet gelukt. Ook heb ik een poging gedaan zodat de keyboard niet de inputfield in de chat blokkeerd. Dit is ook niet gelukt.

### 24 juni
Het is gelukt met de navigationcontroller. De gebruiker kan nu alleen nog maar terug naar het vorige scherm vanuit Userprofile en Message.

### 25 juni
Ik ben bezig geweest met de Delete-functie vandaag. Het lukt niet om deze werkend te krijgen.

## Week 4
### 26 juni
Het deleten van chats werkt. Ik heb gefixed dat de gebruiker geen lege berichtjes kan sturen. Ik heb nog een bug gevonden met de navigationcontroller, deze krijg ik er nog niet uit.

### 27 juni
Ik heb vandaag eraan gewerkt dat de app op alle schermformaten werkt. Het aanpassen van je profiel werkt ook. Het is alleen nog niet gelukt om meteen een segue te creeeren die teruggaat naar je profiel met meteen de aanpassingen erin (je moet nu eerst uitloggen en inloggen om de wijzigingen te zien). De navigatie-bug is ook gefixed.

### 28 juni
Vandaag ben ik begonnen aan m'n report. Het nagiveren vanuit logout ging nog niet echt goed. Dit heb ik vandaag gefixed.

### 29 juni
Als laatste dagje heb ik de laatste dingetjes werkend en netjes gemaakt. Ik heb weer ervoor gezorgd dat de app op meerdere schermformaten werkt. En verder GitHub helemaal ordenen en het Report afmaken.


