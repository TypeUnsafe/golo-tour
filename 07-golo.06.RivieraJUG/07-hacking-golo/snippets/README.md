

java.util.UUID.randomUUID().toString()



import java.util.Random;

public class Toon {
  private static String[] names = {
    "Buster Bunny", "Babs Bunny", "Elmira Duff", "Plucky Duck", "Hamton J. Pig", "Montana Max"
  };

  private static int randInt(int min, int max) {
    Random rand = new Random();
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
  }

  public String name;

  public Toon(String name) {
    this.name = name;
  }

  public Toon() {
    this.name = names[randInt(0, names.length-1)];
  }

}


