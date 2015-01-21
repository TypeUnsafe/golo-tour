package acme;

import java.lang.String;
import java.lang.System;

public class Toon {

  public String name;

  public String getName() {
    return this.name;
  }

  public Toon(String name) {
    this.name = name;
  }

  public Toon() {
    this.name = "John Doe";
  }

  public void hello(String message) {
    System.out.println("[" + this.name + "]:" + message);
  }

  public void yo() {
    System.out.println("yo!!!");
  }

  public static Toon getInstance(String name) {
    return new Toon(name);
  }

  public void hug(Toon toon) {
    System.out.println("I <3 " + toon.getName());
  }

}