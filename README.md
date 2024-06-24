**Genestrip-DB** - a selection of databases for [Genestrip](https://github.com/pfeiferd/genestrip)
===============================================

This little project contains some configuration files and a few scripts in order to 
generate so-called "databases" for metagenomic analysis via [Genestrip]([Genestrip](https://github.com/pfeiferd/genestrip).).

## License

[Genestrip-DB is free for any kind of use.](./LICENSE.txt). However, [Genestrip](https://github.com/pfeiferd/genestrip) itself has a [more restrictive License]([Genestrip](https://github.com/pfeiferd/genestrip#license).). Please contact [daniel.pfeifer@progotec.de](mailto:daniel.pfeifer@progotec.de) if you are interested in a commercial license.

## Building and installing

Genestrip-DB requires [Maven 2 or 3](https://maven.apache.org/) and the [JRE](https://jdk.java.net/) 1.8 or higher.

To build the databases, `cd` to the installation directory `genestrip-db`. Given a matching Maven and JDK installation, `sh bin/makedbs.sh` 
will generate 8 database of different sizes. The generation process is resource intensive and may take several day for all database.
The bacterial database are particularly time consuming.

Your machine should have:
* 650 GB of disk space - mainly for downloading genomes from [NCBI](https://www.ncbi.nlm.nih.gov/),
* at least 8 cores - the more the better (some phases of the database generation can keep 32 cores 100% busy),
* 32 GB of Ram,
* a high bandwidth internet connection.

## The databases

| Name        | Category |Description | Disk Size   | Sources and references |
| ----------- | -----|------ | ----------- | ---------------------- |
| `babesia`     | `protozoa` | Babesia species from the RefSeq and Genbank which are potentially pathogenic for humans | | General knowledge |
| `borrelia`   | `bacteria` | Borrelia species from the RefSeq which are potentially pathogenic for humans  | | General knowledge |
| `borrelia_plasmid`    | `plasmid`  | Borrelia species from the RefSeq which are potentially pathogenic for humans  | | General knowledge |
| `chronicb`    | `bacteria`  | Potentially tick-borne infections, potentially pathogenic for humans, may potentially lead to chronic diseases. | | Collected from [Armin Labs](https://arminlabs.com/en/services) |
| `human_virus2`    | `viral`  | Viruses from the RefSeq and Genbank which are potentially pathogenic for humans. | | Extracted from the [Viral Zone](https://viralzone.expasy.org/678) |
| `parasites` | `invertebrate` | Parasitic animals which are potentially pathogenic for humans. || Collected from the book ["Die Parasiten des Menschen"](https://link.springer.com/book/10.1007/978-3-662-65315-9) by Heinz Mehlhorn |
| `protozoa` | `protozoa` | Protozoan parasites which are potentially pathogenic for humans. || Collected from the German book ["Die Parasiten des Menschen"](https://link.springer.com/book/10.1007/978-3-662-65315-9) by Heinz Mehlhorn |
| `vineyard` | `fungi` | Fungal infections of vines. || Collected from the German book ["Rebschutz"](https://books.google.de/books/about/Rebschutz_Taschenbuch.html?id=ov1JAAAAYAAJ&redir_esc=y) by Walter Hildebrand, Dieter Lorenz and Friedrich Louis |

## Testing via `borrelia`, `borrelia_plasmid` and `chronicb`

TODO




