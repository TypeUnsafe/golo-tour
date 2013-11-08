package acme;

public class Toon implements iSimpleToon, iToon {

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
  public void myNameIs() {
      System.out.println("My Name is " + this.name );
  }

  @Override
  public void scream() {
      System.out.println(this.name + " is screaming ...");
  }

  @Override
  public void sayHello() {
      System.out.println("Hello oh from " + this.name);
  }  


}