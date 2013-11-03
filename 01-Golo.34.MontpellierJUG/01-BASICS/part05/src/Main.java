import gololang.concurrent.workers.Port;
import gololang.concurrent.workers.WorkerEnvironment;

import static org.fortytwo.H2G2.enHouse;
import static org.fortytwo.H2G2.getWorker;

public class Main {

    public static void main(String[] args) throws Throwable {

        WorkerEnvironment e = (WorkerEnvironment) enHouse();

        Port w1 = (Port) getWorker(new Thing("first"){
            public void run(String message) {
                System.out.println(message);
                for(int i = 0;i<50;i++){
                    System.out.println(id+" "+i);
                }
            }
        }, e);

        Port w2 = (Port) getWorker(new Thing("second"){
            public void run(String message) {
                System.out.println(message);
                for(int i = 0;i<30;i++){
                    System.out.println(id+" "+i);
                }
            }
        }, e);

        Port w3 = (Port) getWorker(new Thing("third"){
            public void run(String message) {
                System.out.println(message);
                for(int i = 0;i<50;i++){
                    System.out.println(id+" "+i);
                }
            }
        }, e);

        w1.send("GO");
        w2.send("GOGO");
        w3.send("GOGOGO");


    }
}
