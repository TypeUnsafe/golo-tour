package org.k33g;

import org.k33g.golo.Golo;
import org.k33g.models.Book;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;

import static spark.Spark.get;
import static spark.SparkBase.setPort;

public class Main {

	public static void main(String[] args) throws IOException, NoSuchMethodException, InvocationTargetException, IllegalAccessException {

		setPort(9000);
		get("/hello", (req, res) -> "Hello World");


		Golo sparkeeModule = new Golo("/", "sparkee.golo");

		get("/books", (req, res) -> sparkeeModule.method("view", Object.class).invoke(null, new ArrayList<Book>(){{
			add(new Book("A Princess of Mars"));
			add(new Book("The Gods of Mars"));
			add(new Book("The Chessmen of Mars"));
		}}));

		Golo routesModule = new Golo("/", "routes.golo");

		routesModule.method("router").invoke(null);

	}
}
