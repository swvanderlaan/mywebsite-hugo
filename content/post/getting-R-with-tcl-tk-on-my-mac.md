+++
date = 2018-02-06
lastmod = 2018-02-06
draft = false
tags = ["macOS", "coding", "html", "mac", "homebrew", "R", "Rstudio", "tcl-tk"]
title = "How I got R with tcl-tk on my Mac"
math = true
highlight = true
summary = """
Setting up macOS El Capitan+ with R with tcl-tk using homebrew. 
"""

[header]
image = "headers/computer_code_broad.png"
caption = "Image credit: [**vintagetone**](https://www.shutterstock.com/g/vintagetone)"

+++

## Background

Sometimes data is very skewed and contains a lot of 'zeros' (or very small numbers approaching 'zero'). Before analyses such data need normalisation to meet the assumptions of a statistical test ([you can find more on transformation and normalisation here](https://stats.stackexchange.com/questions/35591/normalization-vs-scaling)). Usually people log-transform (_e.g._ natural log, or log<sub>2</sub>), the disadvantage is that you loose the 'zeros'. 
In my case that is an issue, because the measurements made were properly done (no technical issues), so 'zero' really represents 'zero'. In other words: I _don't_ want to loose them. Some years back a colleague of mine pointed me to *'Box-Cox' transformation** ([you can find more on that here](http://blog.minitab.com/blog/applying-statistics-in-quality-projects/how-could-you-benefit-from-a-box-cox-transformation)), and this method is available in `R` via the `geoR` package. Hence, the reason for this post.

The thing is: I use `brew` to install `R` and many other packages/libraries lacking on macOS, _e.g._ `wget`. For reasons I still don't get - but I also realize it's beyond my coding capabilities - `brew` does _not_ normally install `R` _with_ the `tcl-tk` package. And let _that_ be the critical part you need for `geoR` and by extension the function `boxccoxfit` to work. After some googling I got some hints that led me to a (on the face of it) permanent solution; [the discussion on the `brew` website were critical](https://discourse.brew.sh/t/r-installs-on-high-sierra-without-tcl-tk-support/1190/15).

### Step-by-step

1. I made sure I have tcl-tk installed via `brew`.
   * `brew install tcl-tk`
   * I made sure `tcl-tk` was in my path: `echo 'export PATH="/usr/local/opt/tcl-tk/bin:$PATH"' >> ~/.bash_profile`.
   * The command `wish` also confirmed this.
2. I also made sure I had installed Command Line Tools properly - there were some updates to High Sierra in the last week, and based on the discussions above I feared it might had to re-installed. I didn't have to, but here's how I checked that. The command `brew config` shows:

   > HOMEBREW_VERSION: 1.5.2
   > ORIGIN: https://github.com/Homebrew/brew
   > HEAD: 60a30e966b7cece5bd4823dae3fb981ab85106ea
   > Last commit: 13 days ago
   > Core tap ORIGIN: https://github.com/Homebrew/homebrew-core
   > Core tap HEAD: 8c1c4f86a269cb23d9d92008abf1a37eabb297b6
   > Core tap last commit: 2 days ago
   > HOMEBREW_PREFIX: /usr/local
   > CPU: quad-core 64-bit skylake
   > Homebrew Ruby: 2.3.3 => /System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby
   > Clang: 9.0 build 900
   > Git: 2.16.1 => /usr/local/bin/git
   > Curl: 7.54.0 => /usr/bin/curl
   > Perl: /usr/bin/perl
   > Python: /usr/local/opt/python/libexec/bin/python => /usr/local/Cellar/python/2.7.14_2/Frameworks/Python.framework/Versions/2.7/bin/python2.7
   > Ruby: /usr/bin/ruby => /System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby
   > Java: 9.0.1
   > macOS: 10.13.3-x86_64
   > Xcode: N/A
   **> CLT: 9.2.0.0.1.1510905681**
   > X11: 2.7.11 => /opt/X11
   
   The bold printed line suggests that Command Line Tools should be installed.
   
3. I than double checked if the path was really set, using the command `xcode-select -p`, which shows:
   > /Library/Developer/CommandLineTools
4. Also `gcc` is properly set. I checked this using `gcc --version`, which shows:
   > Configured with: --prefix=/Library/Developer/CommandLineTools/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
   > Apple LLVM version 9.0.0 (clang-900.0.39.2)
   > Target: x86_64-apple-darwin17.4.0
   > Thread model: posix
   > InstalledDir: /Library/Developer/CommandLineTools/usr/bin
5. Now that I had confirmed the basics are present, I proceeded by re-installing `Xquartz`, `R` and `RStudio`. To make sure I get the `R` _with_ `tcl-tk` I used the R version of @srfore. These are the subsequent commands.
   `brew cask reinstall xquartz`, re-instal `Xquartz`
   `brew reinstall -s sethrfore/homebrew-r-srf/r`, installed a edited version of `R`.
   `brew cask reinstall rstudio`, re-installe `Rstudio`.
6. All seemed well, I double checked with `brew doctor`.
   > Your system is ready to brew.
7. Of course, for me, this all started with the need to use the function `boxcoxfit` from the `R` package `geoR` which is dependent on `tcl-tk`. So, now it was showtime and I started R:
   > install.packages("geoR")
   > Installing package into ‘/usr/local/lib/R/3.4/site-library’
   > (as ‘lib’ is unspecified)
   > --- Please select a CRAN mirror for use in this session ---
   > Secure CRAN mirrors
   > 
   >  1: 0-Cloud [https]                   2: Algeria [https]
   >  3: Australia (Canberra) [https]      4: Australia (Melbourne 1) [https]
   >  5: Australia (Melbourne 2) [https]   6: Australia (Perth) [https]
   >  7: Austria [https]                   8: Belgium (Ghent) [https]
   >  9: Brazil (PR) [https]              10: Brazil (RJ) [https]
   > 11: Brazil (SP 1) [https]            12: Brazil (SP 2) [https]
   > 13: Bulgaria [https]                 14: Chile 1 [https]
   > 15: Chile 2 [https]                  16: China (Guangzhou) [https]
   > 17: China (Lanzhou) [https]          18: China (Shanghai) [https]
   > 19: Colombia (Cali) [https]          20: Czech Republic [https]
   > 21: Denmark [https]                  22: East Asia [https]
   > 23: Ecuador (Cuenca) [https]         24: Estonia [https]
   > 25: France (Lyon 1) [https]          26: France (Lyon 2) [https]
   > 27: France (Marseille) [https]       28: France (Montpellier) [https]
   > 29: France (Paris 2) [https]         30: Germany (Erlangen) [https]
   > 31: Germany (Göttingen) [https]      32: Germany (Münster) [https]
   > 33: Greece [https]                   34: Iceland [https]
   > 35: Indonesia (Jakarta) [https]      36: Ireland [https]
   > 37: Italy (Padua) [https]            38: Japan (Tokyo) [https]
   > 39: Japan (Yonezawa) [https]         40: Malaysia [https]
   > 41: Mexico (Mexico City) [https]     42: Norway [https]
   > 43: Philippines [https]              44: Serbia [https]
   > 45: Spain (A Coruña) [https]         46: Spain (Madrid) [https]
   > 47: Sweden [https]                   48: Switzerland [https]
   > 49: Turkey (Denizli) [https]         50: Turkey (Mersin) [https]
   > 51: UK (Bristol) [https]             52: UK (Cambridge) [https]
   > 53: UK (London 1) [https]            54: USA (CA 1) [https]
   > 55: USA (IA) [https]                 56: USA (KS) [https]
   > 57: USA (MI 1) [https]               58: USA (NY) [https]
   > 59: USA (OR) [https]                 60: USA (TN) [https]
   > 61: USA (TX 1) [https]               62: Vietnam [https]
   > 63: (other mirrors)
   > 
   > Selection: 1
   > trying URL 'https://cloud.r-project.org/src/contrib/geoR_1.7-5.2.tar.gz'
   > Content type 'application/x-gzip' length 421612 bytes (411 KB)
   > ==================================================
   > downloaded 411 KB
   > 
   > \* installing *source* package ‘geoR’ ...
   > \** package ‘geoR’ successfully unpacked and MD5 sums checked
   > \** libs
   > clang -I/usr/local/Cellar/r/3.4.3_1/lib/R/include -DNDEBUG   -I/usr/local/opt/gettext/include -I/usr/local/opt/readline/include -I/usr/local/include   -fPIC  -g -O2  -c geoR.c -o geoR.o
   > clang -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/usr/local/Cellar/r/3.4.3_1/lib/R/lib -L/usr/local/opt/gettext/lib -L/usr/local/opt/readline/lib -L/usr/local/lib -o geoR.so geoR.o -L/usr/local/Cellar/r/3.4.3_1/lib/R/lib -lR -lintl -Wl,-framework -Wl,CoreFoundation
   > installing to /usr/local/lib/R/3.4/site-library/geoR/libs
   > \** R
   > \** data
   > \*** moving datasets to lazyload DB
   > \** inst
   > \** preparing package for lazy loading
   > \** help
   > \*** installing help indices
   > \** building package indices
   > \** testing if installed package can be loaded
   > \* DONE (geoR)
   > 
   > The downloaded source packages are in
   > 	‘/private/var/folders/kh/0s66cjl5487fg_fhwgxqd2340000gn/T/RtmpHJHtGf/downloaded_packages’
   
   And loading `geoR` was not an issue:

   > library("geoR")
   > --------------------------------------------------------------
   >  Analysis of Geostatistical Data
   >  For an Introduction to geoR go to http://www.leg.ufpr.br/geoR
   >  geoR version 1.7-5.2 (built on 2016-05-02) is now loaded
   > --------------------------------------------------------------
   
   And now `boxcoxfit()` is available. I'm all set to normalise my data using `Box-Cox` transformations


</br></br>

----- 
<sub><sup>&copy; Copyright. 1979-2018 Sander W. van der Laan. Released under [the MIT license](http://opensource.org/licenses/MIT).</sup></sub>

