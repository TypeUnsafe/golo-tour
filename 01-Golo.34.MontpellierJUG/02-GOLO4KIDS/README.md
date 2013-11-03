#Modifier Golo

Il n'a jamais été aussi facile de modifier un langage. Je vais essayer de vous démontrer que Golo remplit bien le "contrat" de ce pour quoi il a été créé.

##Prérequis :

- Forker Golo

##Ajouter des "objets tous prêts"

Dans le package `gololang`, ajouter les classes suivantes :

**Animal.java**

	package gololang;
	
	public class Animal {
	
	    private String nom = "";
	
	    private int x=0;
	    private int y=0;
	
	    public int x() {
	        return x;
	    }
	
	    public Animal x(int x) {
	        this.x = x;
	        return this;
	    }
	
	    public int y() {
	        return y;
	    }
	
	    public Animal y(int y) {
	        this.y = y;
	        return this;
	    }
	
	    public String nom() {
	        return nom;
	    }
	
	    public Animal nom(String nom) {
	        this.nom = nom;
	        return this;
	    }
	
	    public Animal(String nom) {
	        this.nom = nom;
	    }
	
	    public Animal bouge() {
	        System.out.println(this.nom + " bouge :");
	        return this;
	    }
	
	    public Animal position() {
	        System.out.println("Position de " + this.nom +" : x=" + this.x + " y=" + this.y);
	        return this;
	    }
	
	    public Animal droite(int combien) {
	        System.out.println("mouvement -> droite de "+this.x);
	        this.x = this.x + combien;
	        return this;
	    }
	    public Animal gauche(int combien) {
	        System.out.println("mouvement -> gauche de "+this.x);
	        this.x = this.x - combien;
	        return this;
	    }
	
	    public Animal haut(int combien) {
	        System.out.println("mouvement -> haut de "+this.x);
	        this.y = this.y + combien;
	        return this;
	    }
	    public Animal bas(int combien) {
	        System.out.println("mouvement -> bas de "+this.x);
	        this.y = this.y - combien;
	        return this;
	    }
	
	}


**Lion.java**

	package gololang;
	
	public class Lion extends Animal {
	
	    public Lion(String nom) {
	        super(nom);
	    }
	
	    public Lion rugit() {
	
	        System.out.println(this.nom() + " : Groooooaaaaaarrrr!");
	        return this;
	    }
	}


**Zebre.java**

	package gololang;

	public class Zebre extends Animal {
	    public Zebre(String nom) {
	        super(nom);
	    }
	}

###Compiler

	rake special:bootstrap
	
	#ensuite : rake rebuild


###Exemples Golo

**Exemple 1 :**

	module madagascar
	#Golo4kids-01
	
	function main = |args| {
		
		let marty = Zebre("Marty")
		let alex = Lion("Alex")
	
		alex:x(5):y(8):rugit()
	
		println(alex:x()+" "+alex:y())
	
		alex:bouge():droite(1):haut(5)
	
		alex:position():rugit()
	
		println(marty:nom())
		marty:nom("MARTY")
	
		marty:position()
	}

*Résultat :*

	Alex : Groooooaaaaaarrrr!
	5 8
	Alex bouge :
	mouvement -> droite de 5
	mouvement -> haut de 6
	Position de Alex : x=6 y=13
	Alex : Groooooaaaaaarrrr!
	Marty
	Position de MARTY : x=0 y=0

**Exemple 2 :**

	module madagascar
	#Golo4kids-01
	
	#Augmentation
	augment gololang.Animal {
		
		function mange = |this, aliment| {
			println(this:nom()+" mange "+aliment)
			return this
		}
	} 
	
	function main = |args| {
		
		let marty = Zebre("Marty")
		let alex = Lion("Alex")
	
		marty:mange("feuilles")
	
		alex:mange("steak")
	
	}


*Résultat :*

	Marty mange feuilles
	Alex mange steak

##Utiliser les standard-augmentations

Dans `src/main/golo/standard-augmentations.golo` :

**Ajouter l'augmentation de l'exemple :**

	#Augmentation
	augment gololang.Animal {
		
		function mange = |this, aliment| {
			println(this:nom()+" mange "+aliment)
			return this
		}
	} 

###Compiler

	rake rebuild

###Exemple Golo

**Exemple :**

	module madagascar
	#Golo4kids-02
	
	function main = |args| {
		
		let marty = Zebre("Marty")
		let alex = Lion("Alex")
	
		marty:mange("feuilles")
	
		alex:mange("steak")
	
	}

*Résultat :*

	Marty mange feuilles
	Alex mange steak

##Ajouter des Predefined functions

Dans le package `gololang`, ajouter les méthodes **statiques** dans la classe `Predefined` :


	public static void message(String msg) {
	  System.out.println("=== MESSAGE ===\n"+msg+"\n===============");
	}
	
	public static int additionner(int a, int b) {
	    return a + b;
	}
	
	public static int soustraire(int a, int b) {
	    return a - b;
	}
	
	public static int multiplier(int a, int b) {
	    return a * b;
	}
	
	public static int diviser(int a, int b) {
	    return a / b;
	}

###Compiler

	rake rebuild

###Exemple Golo

**Exemple :**

	module madagascar
	#Golo4kids-03
	
	function main = |args| {
		
		message("operations = " + additionner(
			multiplier(2,4),
			soustraire(10,6)
		))
	
	}

*Résultat :*

	=== MESSAGE ===
	operations = 12
	===============


##Modifier les verbes Golo

Dans `src/main/jjtree/Golo.jjt` 

- chercher `< VAR: "var" >` et modifier comme ceci : `< VAR: "var" | "dire que" >`
- chercher `< IF: "if" >` et modifier comme ceci : `< IF: "if" | "si" >`
- chercher `< ELSE: "else" >` et modifier comme ceci : `< ELSE: "else" | "sinon" >`

###Compiler

	rake rebuild

###Exemple Golo

**Exemple :**

	module madagascar
	#Golo4kids-04
	function main = |args| {
		
		dire que alex = Lion("Alex")
	
		alex
			:x(5):y(8)
			:rugit():mange("steak")
			:bouge()
				:droite(1):haut(5)
	
		alex:position()
	
		si alex:x() > 3 {
			message("x est plus grand que 3")
		} sinon {
			message("x est moins grand que 3")
		}
	
	}

*Résultat :*

	Alex : Groooooaaaaaarrrr!
	Alex mange steak
	Alex bouge :
	mouvement -> droite de 5
	mouvement -> haut de 6
	Position de Alex : x=6 y=13
	=== MESSAGE ===
	x est plus grand que 3
	===============