**Genestrip-DB** - a selection of databases for [Genestrip](https://github.com/pfeiferd/genestrip)
===============================================
  
This project contains some configuration files and a two scripts in order to 
generate [databases and indexes](https://github.com/pfeiferd/genestrip/blob/master/README.md#generating-your-own-database) for metagenomic analysis via [Genestrip]([Genestrip](https://github.com/pfeiferd/genestrip).).

## License

[Genestrip-DB is free for any kind of use.](./LICENSE.txt) 
However, the associated software, [Genestrip](https://github.com/pfeiferd/genestrip), has a [more restrictive License](https://github.com/pfeiferd/genestrip#license). 

## Building and installing

Genestrip-DB requires [Maven 2 or 3](https://maven.apache.org/) and the [JRE](https://jdk.java.net/) 1.8 or higher.

To build the databases and indexes, `cd` to the installation directory `genestrip-db`. Given a matching Maven and JDK installation, `sh bin/makedbs.sh` 
will generate 9 databases (and indexes) of different sizes. The generation process is resource intensive and may take several days for all databases.
Generating the bacterial databases is particularly time consuming.

Your machine should have:
* 650 GB of free disk space - mainly for downloading genomes from [NCBI](https://www.ncbi.nlm.nih.gov/),
* at least 8 cores - the more the better (some phases of the database generation keep 32 cores 100% busy),
* 32 GB of main memory,
* a high bandwidth Internet connection.

The databases are based on and compatible with [Genestrip v1.4](https://github.com/pfeiferd/genestrip/releases/tag/v1.4).

## The databases

All databases are purely genomic.

| Name        | Category |Description | Database disk size   | Sources and references |
| ----------- | -----|------ | ----------- | ---------------------- |
| `babesia`     | `protozoa` | Babesia species from the [RefSeq](https://ftp.ncbi.nlm.nih.gov/refseq/release/) and [Genbank](https://ftp.ncbi.nlm.nih.gov/genomes/genbank/) which are potentially pathogenic for humans | 936 MB | General knowledge |
| `borrelia`   | `bacteria` | Borrelia species from the [RefSeq](https://ftp.ncbi.nlm.nih.gov/refseq/release/) which are potentially pathogenic for humans  | 844 MB | General knowledge |
| `borrelia_plasmid`    | `plasmid`  | Borrelia species from the [RefSeq](https://ftp.ncbi.nlm.nih.gov/refseq/release/) which are potentially pathogenic for humans  | 205 MB | General knowledge |
| `chronicb`    | `bacteria`  | Potentially tick-borne infections which are potentially pathogenic for humans and may lead to chronic diseases | 4.34 GB | Collected from [Armin Labs](https://arminlabs.com/en/services) |
| `human_virus2`    | `viral`  | Viruses from the [RefSeq](https://ftp.ncbi.nlm.nih.gov/refseq/release/) and [Genbank](https://ftp.ncbi.nlm.nih.gov/genomes/genbank/) which are potentially pathogenic for humans |89 MB | Extracted from the [Viral Zone](https://viralzone.expasy.org/678) |
| `parasites` | `invertebrate` | Parasitic invertebrate animals from the [RefSeq](https://ftp.ncbi.nlm.nih.gov/refseq/release/) which are potentially pathogenic for humans | 20.26 GB | Collected from the book ["Die Parasiten des Menschen"](https://link.springer.com/book/10.1007/978-3-662-65315-9) by Heinz Mehlhorn |
| `protozoa` | `protozoa` | Protozoan parasites from the [RefSeq](https://ftp.ncbi.nlm.nih.gov/refseq/release/) which are potentially pathogenic for humans | 14.46 GB | Collected from the German book ["Die Parasiten des Menschen"](https://link.springer.com/book/10.1007/978-3-662-65315-9) by Heinz Mehlhorn |
| `vineyard` | `fungi` | Fungal infections of grapevine taken from the [RefSeq](https://ftp.ncbi.nlm.nih.gov/refseq/release/) | 5.6 GB | Collected from the German book ["Rebschutz"](https://books.google.de/books/about/Rebschutz_Taschenbuch.html?id=ov1JAAAAYAAJ&redir_esc=y) by Walter Hildebrand, Dieter Lorenz and Friedrich Louis |
| `plasmopara` | `plant` | Peronosporales as infections of grapevine taken from the [RefSeq](https://ftp.ncbi.nlm.nih.gov/refseq/release/) | 5.7 GB | Collected from the German book ["Rebschutz"](https://books.google.de/books/about/Rebschutz_Taschenbuch.html?id=ov1JAAAAYAAJ&redir_esc=y) by Walter Hildebrand, Dieter Lorenz and Friedrich Louis |


Note that Genestrip's [`updateddb`](https://github.com/pfeiferd/genestrip/blob/master/Goals.md)-phase accounts for unspecific *k*-mers and largely avoids false positive counts during `match`es.
To further reduce false positives, all databases (except for `vineyard`) are built such that *k*-mers also occurring in the [human genome](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.29_GRCh38.p14/GCA_000001405.29_GRCh38.p14_genomic.fna.gz) 
are [pushed to the least common ancestor](https://github.com/pfeiferd/genestrip/blob/master/README.md#manually-adding-fasta-files).

## Testing the databases `borrelia`, `borrelia_plasmid` and `chronicb`

The script `bin/matchticks.sh` [runs the Genestrip goal `matchlr`](https://github.com/pfeiferd/genestrip/blob/master/README.md#usage-and-goals) for 11 fastq files taken from [this publication](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10328957/).
To do so, the fastq files will be [streamed](https://github.com/pfeiferd/genestrip/blob/master/README.md#reading-streaming-and-downloading-fastq-files) from the corresponding [NCBI server](https://www.be-md.ncbi.nlm.nih.gov).
As expected, Genestrip finds DNA from borrelia and other tick-borne infections accordingly.

## Downloading the ready-made databases

If you don't want to generate them yourself, the databases and indexes can also be [downloaded from genestrip.org](https://www.genestrip.org/files/data).
The [Drive folder](https://drive.google.com/drive/folders/1cmMPjHTAs4pEti4eEM-gOngvOn39btdU?usp=sharing) corresponds 
to the [`projects` folder's](https://github.com/pfeiferd/genestrip-db/tree/master/data/projects) state of this project, after the scripts `bin/makedbs.sh` and `bin/matchticks.sh` have run successfully.



