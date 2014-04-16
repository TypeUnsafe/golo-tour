package acme;

import java.lang.String;
import java.lang.System;

public class Toon {

  public String name;

  public Toon(String name) {
    this.name = name;
  }

  public void hello() {
    System.out.println("Hello, i'm " + this.name);
  }

  public static Toon getInstance(String value) {
    return new Toon(value);
  }

}