bh14-notriples
==============

A project looking into storage and retrieval of RDF data outside of triple stores. The project emerged during [BioHackathon 2014](http://2014.biohackathon.org), [Miyagi](http://en.wikipedia.org/wiki/Miyagi_Prefecture), [Japan](http://en.wikipedia.org/wiki/Japan).

### NoTriples? You mean NoSQL?

Not quite. Some solutions, such as [Apache Hive](https://hive.apache.org), are actually making use of SQL.

### No triple stores at all then?

Well, this project also loads RDF data into triple stores for query benchmarking.

### That is a lot of software to configure, isn't it?

Obviously, but for you, it comes for free:

*  [automagic installation, configuration, and start-up scripts](https://github.com/joejimbo/dev-setup)
*  [Dockerfile versions of the scripts](https://github.com/inutano/bh14-docker-recipes)

### Wait -- any23 produces JSON already, right?

Kind of. any23 is useful for transforming Turtle to N-Triple and N-Quad formats though. Both of these data formats can be fed to [rdf2json](http://rubygems.org/gems/rdf2json) which uses Gregg Kellogg's [json-ld](https://rubygems.org/gems/json-ld) gem to produce bona fide JSON-LD.

