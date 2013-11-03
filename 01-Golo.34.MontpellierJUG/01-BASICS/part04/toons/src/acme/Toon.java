package acme;

public class Toon implements iToon {

	private String name = "";

	public String name() {
		return this.name;
	}

	public void name(String value) {
		this.name = value;
	}

    public String hello() {
        return "hello from toon";
    }

    @Override
    public String scream() {
        return "screaming ...";
    }


}
