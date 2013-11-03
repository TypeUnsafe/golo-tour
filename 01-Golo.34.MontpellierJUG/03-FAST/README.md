#Fast

##Compiler

Dans le répertoire `04-FAST` : tapez la commande `mvn compile assembly:single` (j'embarque SparkJava, Golo, Jackson, Jedis)

Cela génère `fast.1.0;jar`, les ressources statiques et les scripts golo sont dans le sous-répertoire `/app`.

*PS: si vous ne souhaitez pas compiler, le jar est fourni*

##Lancer

- Dans un terminal : lancez `redis-server`
- Puis lancez : `java -jar fast.1.0.jar`
- Ouvrez votre navigateur sur `http://localhost:9999`
- Enjoy!

**Si vous avez besoin d'infos pour refaire le projet pas à pas, contactez moi sans hésiter. @+**