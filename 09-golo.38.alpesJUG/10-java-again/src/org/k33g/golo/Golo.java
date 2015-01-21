package org.k33g.golo;


import fr.insalyon.citi.golo.compiler.GoloClassLoader;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.Method;

public class Golo {
	private static GoloClassLoader classLoader = new GoloClassLoader();

	private Class<?> moduleClass;

	public Golo(String path, String fileName) throws IOException {
		this.moduleClass= classLoader.load(
			fileName,
			new FileInputStream(
				new File(".").getCanonicalPath()+ path +"/" +fileName
			)
		);
	}

	public Method method(String methodName, Class<?> ...parametersTypes) throws NoSuchMethodException {
		return this.moduleClass.getMethod(methodName, parametersTypes);
	}

}
