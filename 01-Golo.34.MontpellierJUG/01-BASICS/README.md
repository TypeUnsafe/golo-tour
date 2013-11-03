#Démo Golo

##Pour lancer à partir de SublimeText

##Part01

- `01.golo` : Les Strings 
- `02.golo` : Les fonctions
- `03.golo` : import de fonction (lancer en dehors de SublimeText dans un Terminal)
- `04.golo` : if is isnt ...
- `05.golo` : case, match
- `06.golo` : while, for, array, foreach

##Part02

- `01.golo` : Closures / Lambdas
- `02.golo` : andThen
- `03.golo` : HashMap, each, filter
- `04.golo` : LinkedList, map

##Part03

- `01.golo` : pimp (augment)
- `02.golo` : DynamicObject ♥ ♥ ♥
- `03.golo` : DynamicObject like a Class
- `04.golo` : Elvis
- `05.golo` : Thread
- `06.golo` : PI : calcul parallèle
- `07.golo` : Eval
- `08.golo` : sample de @jponge : webapp + templating

##Part04

Faites vos classes java , utilisez les en Golo.
Le code source est dans `/toons`, faire un `mvn compile assembly:single` dans le répertoire pour compiler, cela génère le jar dans `libs/jars`.

pour lancer les scripts : 

- `/g.sh libs 01-toons.golo`
- `/g.sh libs 02-toons.golo`

**!!!  Dans g.sh penser à renseigner correctement JAVA_HOME & GOLO_HOME**

##Part05 

On compile du Golo pour le réutiliser en Java.

le code de la librairie est dans : `42.golo`

Pour compiler :

	golo compile --output classes 42.golo
	cd classes/
	jar -cf 42.jar org/fortytwo/H2G2.class

ou utiliser `compil42.sh`

Ensuite, faire référence à `/classes/42.jar` dans votre projet java, ainsi qu'à `golo-0-preview5-SNAPSHOT`

Vous trouverez les sources du projet dans `src`





