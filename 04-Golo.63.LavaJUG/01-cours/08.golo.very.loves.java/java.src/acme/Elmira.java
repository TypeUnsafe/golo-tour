package acme;


public class Elmira {

    public static void whoAreYou(iSimpleToon toon) {
      System.out.println("Elmira : Eh! Toon who are you ?");
      toon.myNameIs();
    }

    public static void love(iToon toon) {
      System.out.println("Elmira loves toons");
      toon.scream();
    }

    public static void talk(iToon toon) { 
      toon.sayHello();
    }

}
