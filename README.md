# Divers App
Gemaakt door: Yamie van Wijnbergen

Deze app is bedoeld voor mensen die duiken. De app maakt het mogelijk om duikers met elkaar in contact te brengen. Een gebruiker kan een duiker opzoeken per locatie en vervolgens hem of haar een berichtje sturen via de chatfunctie om op die manier een afspraak te regelen om samen te kunnen duiken.

[![BCH compliance](https://bettercodehub.com/edge/badge/Yamievw/programmeerproject?branch=master)](https://bettercodehub.com/)

## Project Proposal

### Het doel: 
Deze app is gericht op mensen die duiken. Een belangrijke regel bij het duiken is dat dit altijd samen moet gebeuren; duikers moeten een buddy hebben om samen mee te duiken ter veiligheid. Het doel van deze app is om duikers met elkaar in contact te brengen, zodat ze op die manier een buddy kunnen vinden om mee te duiken. Deze app is een oplossing voor mensen die duiken, die geen andere duikers kennen. Hetzij omdat je bijvoorbeeld de enige in je vriendenkring bent met een duikbrevet, of omdat je op vakantie bent en graag wilt duiken maar niemand kent.

### Features: 
De gebruiker kan zich registreren en vervolgens inloggen. Bij het registreren kan hij een profiel opzetten met zijn naam, profielfoto, hoeveel jaar ervaring hij heeft, hoeveel duiken hij ongeveer heeft gedaan en welk type duikbrevet hij bezit. Na het registeren of inloggen wordt de gebruiker doorverwezen naar een kaart met pinnetjes op de locatie van de geregistreerde gebruikers. Er zal ook een chatfunctie zijn zodat gebruikers onderling berichten naar elkaar kunnen sturen om een afspraak te maken om samen te duiken. Ook kan de gebruiker later zijn profiel nog aanpassen.

### De werking: 
Op het beginscherm zijn de knoppen Login en Register. Deze twee knoppen verwijzen naar aparte viewcontrollers. Als een gebruiker zich registreert wordt hij verwezen naar de register viewcontroller. Als de gegevens zijn ingevoerd dan wordt de gebruiker automatisch ingelogd en verwezen naar de Map-functie. Hier ziet de gebruiker alle andere gebruikers/duikers over de hele wereld met een pinnetje op de kaart verschijnen. Op deze manier kan de gebruiker een duiker zoeken gebaseerd op de locatie waar hij of zij wilt duiken. Als de gebruiker op het pinnetje klikt komt hij op het profiel van de gebruiker. Hier heeft de gebruiker de optie om op de knop "send message" te klikken om met diegene in contact te komen. Vanuit de mapview kan de gebruiker navigeren naar zijn eigen profiel of naar de chats door op een van de knoppen in de onderste balk te klikken. De gebruiker komt dan uit op zijn eigen profiel met de gegevens die hij/zij bij "Register" heeft ingevuld. Ook vanuit hier kan de gebruiker middels de onderste balk navigeren naar de "My Chats" of naar de mapView. Ook heeft de gebruiker de mogelijkheid om uit te loggen of om het profiel te wijzigen. De "My Chats" tableviewcontroller laat alle gesprekken zien die hij met andere gebruikers heeft gehad. Als er op één van deze gesprekken wordt geklikt dan opent er een nieuwe viewcontroller met het gesprek. Als de gebruiker ervoor kiest om uit te loggen dan opent het beginscherm weer.

### Externe componenten: 
Om een database te creëren van alle gebruikers is er gebruik gemaakt van Firebase. De cocoapods die gebruikt zijn, zijn FirebaseAuth voor de authenticatie van de login en register, FirebaseDatabase om gegevens op te slaan en FirebaseStorage om de afbeeldingen op te slaan. Daarnaast zal ik de framework CoreLocation gebruiken zodat de huidige locatie van de gebruiker opgezocht kan worden. Ook voor de chatfunctie zal Firebase gebruikt worden om de chatberichten op te slaan en vervolgens ook weer op te halen. UIImagePicker wordt gebruikt om afbeeldingen vanuit de telefoon op te halen.

### Mogelijke problemen: 
Er zijn meerdere valkuilen. Ik denk dat de chatfunctie wel een grote valkuil kan zijn. Hier zijn echter wel meerdere tutorials voor te vinden, dus ik ga dat proberen aan te houden. Daarnaast is het opzoeken van gebruikers gebaseerd op locatie ook een mogelijke valkuil. Ik denk dat ik hier te werk moet gaan met coördinaten en deze van elkaar aftrekken en gebruikers binnen een bepaalde straal dan laten zien in de viewcontroller. 

### Review: 
Er bestaat nog geen soortgelijke duikapp. Er bestaan apps waarmee de gebruiker hun duik kunnen noteren in een logboek, of apps om duik-locaties te vinden. DiveAdvisor heeft de functie dat de gebruiker artikelen kan opzoeken gebaseerd op locatie. Ze hebben een lijst met alle landen die vervolgens refereren naar een nieuw scherm. Dit wil ik niet. Ik wil dat zo’n lijst van landen in de backend is en dat het land herkent wordt zodra deze in de zoekbalk ingetypt wordt. De visualisatie van de Facebook Messenger app wil ik aanhouden als layout voor de chatfunctie; simpel en duidelijk welk bericht van wie is. De extra features van Facebook Messenger zoals bellen, videobellen, foto’s of documenten sturen laat ik buiten beschouwing.

### Minimum viable product: 
De app moet sowieso gebruikers kunnen opzoeken en de optie hebben om diegene een bericht te sturen. Optioneel kan zijn om ook nog reviews toe te voegen hoe het was om met diegene te duiken. Of om groepchats te maken als je met meerdere mensen wilt duiken. Misschien ook nog de optie bij het profiel om te laten zien op welke plekken de gebruiker al allemaal heeft gedoken. Profiel aanpassen wil ik ook nog toevoegen, en eventueel ook nog een "reset password" functie.

### Sketch
![screenshot](doc/proposalsketch.jpg "Screenshot")


