package gololang;

public class Animal {

    public String nom = "";

    public int x=0;
    public int y=0;

    public Animal(String nom) {
        this.nom = nom;
    }

    public void afficherPosition() {
        System.out.println(this.nom +" -> x : "+this.x+" y : "+this.y);
    } 

}