e-golo (wip)
======

embedded golo template project

##Why / What ?


##How to ?

###"install(copy) it"

    git clone --q --depth 0 git@github.com:k33g/e-golo.git <your project app directory>

or

    git clone --q --depth 0 https://github.com/k33g/e-golo.git <your project app directory>

###Compile (single jar)

    mvn compile assembly:single

###Add framework dependencies to be embedded in the jar (examples)

####Redis

In `<dependencies></dependencies>`

    <dependency>
        <groupId>redis.clients</groupId>
        <artifactId>jedis</artifactId>
        <version>2.1.0</version>
        <type>jar</type>
        <scope>compile</scope>
    </dependency>

####Spark java

    <repositories>
        <repository>
            <id>Spark repository</id>
            <url>https://oss.sonatype.org/content/repositories/snapshots/</url>
        </repository>
        <repository>
            <id>codehaus-snapshots</id>
            <url>http://snapshots.repository.codehaus.org</url>
        </repository>
    </repositories>

And in `<dependencies></dependencies>`

    <dependency>
        <groupId>com.sparkjava</groupId>
        <artifactId>spark-core</artifactId>
        <version>0.9.9.7-SNAPSHOT</version>
    </dependency>
