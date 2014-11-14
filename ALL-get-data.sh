#!/usr/bin/env bash

set -e

#
# ENCYCLOPEDIA
#

DBPEDIA_LABELS=labels_en.nt.bz2
DBPEDIA_LABELS_NT=`basename "$DBPEDIA_LABELS" .bz2`
DBPEDIA_LABELS_JSON=`basename "$DBPEDIA_LABELS" .nt.bz2`.json

DBPEDIA_ABSTRACTS=long_abstracts_en.nt.bz2
DBPEDIA_ABSTRACTS_NT=`basename "$DBPEDIA_ABSTRACTS" .bz2`
DBPEDIA_ABSTRACTS_JSON=`basename "$DBPEDIA_ABSTRACTS" .nt.bz2`.json

# Download parts of DBpedia:
wget http://data.dws.informatik.uni-mannheim.de/dbpedia/2014/en/$DBPEDIA_LABELS
wget http://data.dws.informatik.uni-mannheim.de/dbpedia/2014/en/$DBPEDIA_ABSTRACTS

# Extract N-Triple archives:
bunzip2 $DBPEDIA_LABELS
bunzip2 $DBPEDIA_ABSTRACTS

# Turn N-Triples into JSON-LD:
rdf2json -i $DBPEDIA_LABELS_NT -o $DBPEDIA_LABELS_JSON
rdf2json -i $DBPEDIA_ABSTRACTS_NT -o $DBPEDIA_ABSTRACTS_JSON

# Get rid of N-Triples:
rm -f $DBPEDIA_LABELS_NT
rm -f $DBPEDIA_ABSTRACTS_NT

#
# GENOMICS
#

MGP_VARIATION=mgp.v4.indels.dbSNP.vcf.gz
MGP_VARIATION_TTL=`basename "$MGP_VARIATION" .vcf.gz`.ttl
MGP_VARIATION_VCF=`basename "$MGP_VARIATION" .gz`

# Mouse genome variations:
wget ftp://ftp-mouse.sanger.ac.uk/REL-1410-SNPs_Indels/$MGP_VARIATION

# Extract VCF file; convert to Turtle:
gunzip $MGP_VARIATION
biointerchange -i biointerchange.vcf -r rdf.biointerchange.gfvo -f $MGP_VARIATION_VCF -o $MGP_VARIATION_TTL

#
# CHEMISTRY
#

PUBCHEM_COMPOUND=pc_comp_00000001_00100000.ttl.gz
PUBCHEM_COMPOUND_TTL=`basename "$PUBCHEM_COMPOUND" .gz`
PUBCHEM_COMPOUND_NT=`basename "$PUBCHEM_COMPOUND" .ttl.gz`.nt
PUBCHEM_COMPOUND_JSON=`basename "$PUBCHEM_COMPOUND" .ttl.gz`.json

PUBCHEM_COMPOUND_DESCR=pc_comp_descr_00000001_00100000.ttl.gz
PUBCHEM_COMPOUND_DESCR_TTL=`basename "$PUBCHEM_COMPOUND_DESCR" .gz`
PUBCHEM_COMPOUND_DESCR_NT=`basename "$PUBCHEM_COMPOUND_DESCR" .ttl.gz`.nt
PUBCHEM_COMPOUND_DESCR_JSON=`basename "$PUBCHEM_COMPOUND_DESCR" .ttl.gz`.json

# Download data and convert Turtle to N-Triples:
wget ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/compound/general/$PUBCHEM_COMPOUND
wget ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/descriptor/compound/$PUBCHEM_COMPOUND_DESCR
gunzip $PUBCHEM_COMPOUND
gunzip $PUBCHEM_COMPOUND_DESCR
any23 rover -f ntriples $PUBCHEM_COMPOUND_TTL | sort | uniq > $PUBCHEM_COMPOUND_NT
any23 rover -f ntriples $PUBCHEM_COMPOUND_DESCR_TTL | sort | uniq > $PUBCHEM_COMPOUND_DESCR_NT
rdf2json -i $PUBCHEM_COMPOUND_NT -o $PUBCHEM_COMPOUND_JSON
rdf2json -i $PUBCHEM_COMPOUND_DESCR_NT -o $PUBCHEM_COMPOUND_DESCR_JSON

# Remove Turtle/N-Triple files:
rm -f $PUBCHEM_COMPOUND_TTL $PUBCHEM_COMPOUND_NT $PUBCHEM_COMPOUND_DESCR_TTL $PUBCHEM_COMPOUND_DESCR_NT

