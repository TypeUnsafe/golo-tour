package acme;

public class Toon implements iToon {

	private String name = "";

	public String name() {
		return this.name;
	}

	public Toon() {}

	public Toon(String name) { 
		this.name = name;
	}

	public Toon name(String value) {
		this.name = value;
		return this;
	}

  @Override
  public void scream() {
      System.out.println(this.name + " is screaming ...");
  }


}