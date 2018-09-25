+++
# Date this page was created.
date = "2018-07-10"

# Project title.
title = "Mendelian randomisation"

# Project summary to display on homepage.
summary = "Causal inference through the use of genomics to identify putative druggable candidates."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "dna_drugs_squared.png"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["causal-inference", "mendelian-randomisation", "genetics", "rare-variant", "common-variant"]

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = "headers/dna_drugs_shutterstock_432561187_broad.png"
caption = "Image credit: [**Isak55**](https://www.shutterstock.com/g/isak55)"

+++

[**Mendel's Second Law**](https://en.wikipedia.org/wiki/Mendelian_inheritance), the law of _independent assortment_, underlies the principle of Mendelian randomisation (MR) which make use of the inherent properties of the human genome to enable causal inference for a [biomarker](https://www.bmj.com/content/330/7499/1076). The invariant nature of the genome, and the random distribution of alleles from parents to offspring at the time of conception (Mendel's Second Law), imply that the genetic information is not influenced by disease status or the presence of risk factors (reverse causality), therefore it should be free from confounding. Thus leveraging genetic variation that regulates biomarker levels may aid in assessing the causal role of diseases, independent of confounders. 

In essence MR studies are analogous to double-blind [randomised clinical trials (RCTs)](https://www.bmj.com/content/330/7499/1076), in which the subjects are randomly assigned to an experiment or placebo group. In the last decade [genome-wide association studies (GWAS)](https://jamanetwork.com/journals/jama/article-abstract/181647) have robustly associated thousands of variants to [hundreds of traits and diseases](http://www.pnas.org/content/106/23/9362), facilitating the design of powerful MR studies. Whereas RCTs require extensive and costly administration, using genetic information obtained through publicly available GWAS to perform MR studies, highlights the main advantages of MR studies: cost-effective causal inference. In the end RCTs will have to be executed, but MR studies are an important in-between stop to validate the potential of putative druggable targets.

In a [recent study](http://www.onlinejacc.org/content/68/9/934?_ga=2.188460961.804184816.1531233557-184207684.1531233557) we investigated the causal role of Cystatin C in cardiovascular diseases (CVD), showing it to be [unlikely](http://www.acc.org/latest-in-cardiology/journal-scans/2016/08/22/15/37/cystatin-c-and-cardiovascular-disease) that Cystatin C plays such a role. Currently we are investigating the role of various potential biomarkers in causing CVD, as well as integrating genetic information with expression and methylation data to infer causal relations and reveal genes and gene-networks that are pivotal to the mechanisms leading to CVD.

