package golo.tools;

import fr.insalyon.citi.golo.compiler.GoloClassLoader;
import fr.insalyon.citi.golo.compiler.GoloCompilationException;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;


public class ScriptsLoader {
    public HashMap<String,Class<?>> modules;

    private String pathToParse = null;
    private String extension = ".golo";
    private GoloClassLoader classLoader = new GoloClassLoader();

    private void findGoloScripts(String path) throws Exception {

        File root = new File( path );

        File[] list = root.listFiles(); //filter how to ?

        for ( File f : list ) {
            if ( f.isDirectory() ) {
                findGoloScripts(f.getAbsolutePath());
            }
            else {
                if(f.getAbsoluteFile().getName().endsWith(this.extension) && !f.getName().startsWith("ext.")) {

                    System.out.println( "Loading : " + f.getAbsoluteFile() );

                    try {
                        Class<?> module = module = classLoader.load(
                                f.getName(),
                                new FileInputStream(f.getAbsoluteFile())
                        );
                        this.modules.put(f.getAbsoluteFile().toString().replaceAll("\\\\", "/").split(this.pathToParse.replaceAll("\\\\", "/"))[1], module);
                    } catch(GoloCompilationException e) {

                        System.out.println("ERROR IN  : " + f.getAbsoluteFile());
                        System.out.println(e.getProblems());
                        throw new Exception("OUCH");

                    } finally {

                    }

                }
            }
        }

    }


    public Module module(String modulePathName) {
        return new Module(this.modules.get(modulePathName));
    }

    public void loadGoloResource(String resourcePath, String goloScript) {
        InputStream is = ClassLoader.getSystemResourceAsStream(resourcePath+goloScript);

        Class<?> module = classLoader.load(
                goloScript,
                is
        );
        this.modules.put(goloScript, module);
    }

    public void loadAll() throws Exception {
        this.findGoloScripts(this.pathToParse);
    }

    public ScriptsLoader(String pathToParse) {
        this.modules = new HashMap<String, Class<?>>();
        this.pathToParse = pathToParse;
    }
}
