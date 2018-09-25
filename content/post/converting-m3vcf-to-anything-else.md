+++
date = 2018-07-10
lastmod = 2018-07-10
draft = false
tags = ["macOS", "coding", "mac", "homebrew", "SNPTEST", "QCTOOL", "PLINK", "PLINK2", "VCF", "M3VCF", "Minimac3", "Oxford-format", "PLINK-format"]
title = "Tackling post-Michigan Imputation Server troubles"
math = true
highlight = true
summary = """
Converting VCF-output from the Michigan Imputation Server to any other format. 
"""

[header]
image = "headers/computer_code_broad.png"
caption = "Image credit: [**vintagetone**](https://www.shutterstock.com/g/vintagetone)"

+++

## Background

When meta-analysing many genome-wide association studies a lack of overlap [in terms of variants] between genotyping platforms [lowers power](https://academic-oup-com/hmg/article/17/R2/R122/2527210). However, [imputation](https://www.nature.com/articles/nrg2796) of missing genotypes, i.e. untyped across all individuals or missing in a few, using [HapMap 2](https://www.nature.com/articles/nature02168), [1000G](https://www.nature.com/articles/nature09534), [Haplotype Reference Consortium (HRC)](https://www.nature.com/articles/ng.3643), or [Genome of the Netherlands (GoNL5)](https://www.nature.com/articles/ng.3021) as reference ensures >99% overlap and significantly increases power. 

As cohort sizes increase, the latest development is [cloud-based imputation](https://www.nature.com/articles/ng.3656) using phased data from 1000G phase 3 or HRC as a reference, such as available at the [Michigan Imputation Server](https://www.nature.com/articles/ng.3679). Within a matters of hours - not taking the queuing into account - anyone can easily impute against high quality reference producing community standardised output files. 

The backbone is an updated version of Minimac ([Minimac3](https://www.nature.com/articles/ng.3656)) and the introduction of a new VCF-like file-format which significantly reduces the (zipped) file sizes. While this file-format is in principle VCF-compatible (v4.2+), in reality the user would want to have [Oxford-format](http://www.stats.ox.ac.uk/~marchini/software/gwas/file_format.html) or [PLINK-format](https://www.cog-genomics.org/plink/1.9/input#bed) files, which can be used with [SNPTEST 2.5+](https://mathgen.stats.ox.ac.uk/genetics_software/snptest/snptest.html) or [PLINK v1.9 beta+](https://www.cog-genomics.org/plink/1.9), respectively. <br/>
Many other programs, such [PRSice](https://choishingwan.github.io/PRSice/) or [LDPred](https://github.com/bvilhjal/ldpred), also expect Oxford- or PLINK-formatted files. 

So, you too, might want to convert. :-)

### Step-by-step

1. First thing you need to download is `PLINK 2 alpha` (so _not_ v1.9!), which can be found [here](https://www.cog-genomics.org/plink/2.0/). In my case, being on macOS High Sierra:
   
   ```
   mkdir -v ~/bin
   cd ~/bin
   wget http://s3.amazonaws.com/plink2-assets/plink2_mac_20180709.zip
   unzip plink2_mac_20180709.zip
   ```

   </br>
   
2. The M3VCF is VCF-like, so sligtly different from what you would expect. Here is the `head` of part of one of mine:

   > \##fileformat=VCFv4.2<br/>
   > \##FORMAT=<ID=GT,Type=String,Number=1,Description="Genotype"><br/>
   > \##FORMAT=<ID=DS,Type=Float,Number=1,Description="Estimated Alternate Allele Dosage : [P(0/1)+2*P(1/1)]"><br/>
   > \##FORMAT=<ID=GP,Type=Float,Number=3,Description="Estimated Posterior Probabilities for Genotypes 0/0, 0/1 and 1/1 "><br/>
   > \#CHROM POS ID REF ALT QUAL FILTER INFO FORMAT SAMPLE_1<br/>
   > 6 89961 6:89961,. G A . . . DS:GP:GT 0:1,0,0:0|0<br/>
   > 6 100100 6:100100,. G T . . . DS:GP:GT 0:1,0,0:0|0<br/>
   > 6 100112 6:100112,. C A . . . DS:GP:GT 0:1,0,0:0|0<br/>
   > 6 145579 6:145579,. G A . . . DS:GP:GT 0:1,0,0:0|0<br/>
   > 6 147651 6:147651,. A C . . . DS:GP:GT 0.001:0.999,0.001,0:0|0<br/>

   Because of the slightly different file-format, a datamanagement-program like [QCTOOL](http://www.well.ox.ac.uk/~gav/qctool/) can _read_ and even _merge_ files like this, but converting to another format (be it `.bgen`, `.gen`, or `.vcf`) it will not.
   
   The alternative is to use `PLINK 2 alpha`. In my case processing all 22 autosomal chromosomes would be done with this command:
   
   ```
   for i in $(seq 1 22); do 
   	plink2alpha --vcf cohort1.1kgp3.chr${i}.dose.vcf.gz dosage=GP --export oxford --out cohort1.1kgp3.chr${i}; 
   done
   ```
   
   </br>
   
   To produce `.gen` and accompanying `.sample` files with genotype probabilities (tagged by _GP_) it is critically to include the flag `dosage=GP`.
   

And that's it, after some hours, depending on your system and the size of the cohort, VCF-files are converted to your favourite file-format-flavour. 

</br></br>

----- 
<sub><sup>&copy; Copyright. 1979-2018 Sander W. van der Laan. Released under [the MIT license](http://opensource.org/licenses/MIT).</sup></sub>

