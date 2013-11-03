package fast.store;

import java.util.HashMap;

public class MemoryStore {

    private static HashMap<String,Object> memory = new HashMap<>();

    public static void set(String key, Object objectToStore) {
        memory.put(key, objectToStore);
    }

    public static Object get(String key) {
        return memory.get(key);
    }

    public static void delete(String key) {
        memory.remove(key);
    }

}