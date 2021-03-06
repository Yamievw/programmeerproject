# Design Document

Bij het beginscherm heeft de gebruiker de kans om naar een Login viewcontroller te navigeren, of naar een Register viewcontroller. Bij beide  viewcontrollers moet Firebase gebruikt worden. Bij Login zal FirebaseAuth nodig zijn om de gegevens van de gebruiker te controleren. Bij Register is Firebase nodig om alle ingevulde gegevens op te slaan in FirebaseDatabase. Hierin zal er waarschijnlijk per user een  boomstam ontstaan met daarbinnen de gegevens die worden ingevuld (naam, duikbrevet type, aantal jaar ervaring, en aantal duiken).  Ook zal de gebruiker bij register een profielfoto kunnen instellen door deze uit de Photos op de iPhone te kiezen. Deze foto wordt dan opgeslagen in de FirebaseDatabase. En wordt op deze manier telkens weer opgehaald.

Na het registreren zal de gebruiker nog een pop-up krijgen met de vraag voor toestemming om van de Location Services binnen de Settings van de iPhone de huidige locatie te gebruiken.  Hiervoor gebruik ik de klasse CLLocationManager. Vervolgens ga ik een object moeten koppelen aan het CLLocationManagerDelegate protocol.  Met de huidige locatie kan de gebruiker dan aangeven dat een bepaalde huidige locatie als standaard moet worden gezien, en als hij deze zou willen veranderen dat alleen dan de CLLocationManager een update doet van de locatie. Op deze manier wordt de locatie van de gebruiker niet constant getraceerd. Deze locatie wordt vervolgens opgeslagen met FirebaseDatabase bij de current userID.

Zodra een gebruiker zich heeft geregistreerd wordt hij verwezen naar de Login viewcontroller. Na het invullen van de gegevens zal de gebruiker vervolgens naar de Find Divers tableviewcontroller genavigeerd worden. In de zoekbalk kan de gebruiker een locatie invoeren. De resultaten worden dan opgehaald uit de FirebaseDatabase. Gebruikers met locaties die zich binnen een bepaalde straal van de zoek-locatie bevinden, worden dan per tableviewcell uitgelicht met hun eigen profielfoto en naam. De profielfoto en naam worden vanuit de FirebaseDatabase opgehaald. Als de gebruiker op de tableviewcell van Find Divers klikt, navigeert deze naar de User Profile viewcontroller met een bepaalde user ID. Hier ziet de gebruiker alle informatie over een andere gebruiker. Deze informatie wordt ingeladen vanuit de FirebaseDatabase.

Onderaan de Find Divers tableviewcontroller is er een knop met een icoon voor my profile. Deze knop navigeert meteen naar de My Profile viewcontroller. De informatie hier wordt ook opgehaald vanuit FirebaseDatabase. Dit zal waarschijnlijk gaan door middel van een ‘current user’ element. Hier vanuit kan de gebruiker uitloggen of met een knop naar de My Chats tableviewcontroller genavigeerd worden. De individuele chats worden opgeslagen in FirebaseDatabase. Ik denk dat bij de My Chats tableviewcontroller deze hele database wordt opgehaald van alle chats met gebruikers. Hier ziet de gebruiker dan de profielfoto en de naam.

Ook vanuit de User Profile viewcontroller is er een knop met Send Message. Er wordt hier dan een nieuwe chat aangemaakt. Dit gebeurt dan ook binnen FirebaseDatabase. Binnen een boomstam met die gebruiker komen er dan takken met elke keer een bericht.

Er zal een klasse "UserInfo" gemaakt worden met de elementen:
Name, profile picture, diving certificate type, years experience, amount of dives en location.
Daarnaast zal er ook nog een klasse zijn waarin alle gebruikers in voorkomen.

Een uitgebreidere sketch is onderaan te vinden. Hierin is er te zien hoe ik denk het er uiteindelijk uit te willen laten zien. En hoe elke knop navigeert naar een volgende viewcontroller.

## Sketch
![screenshot](doc/screenshot2.png "Screenshot")
