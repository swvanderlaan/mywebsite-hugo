+++
date = 2018-02-06
lastmod = 2018-02-06
draft = false
tags = ["macOS", "coding", "html", "mac", "homebrew", "R", "Rstudio"]
title = "How I setup my Mac to do Science in 2018"
math = true
highlight = true
summary = """
Setting up macOS El Capitan+ with homebrew, R, and Rstudio. 
"""

[header]
image = "headers/computer_code_broad.png"
caption = "Image credit: [**vintagetone**](https://www.shutterstock.com/g/vintagetone)"

+++

## Background

I prefer to use `brew` to install the 'missing' libraries on macOS that come in handy, like `weget`, or `imagemagick`, or `rename`. In addition, I work on the analyses of histological slides, and for that I use [**slideToolkit**](https://swvanderlaan.github.io/slideToolkit/) which also requires `brew` on macOS. 

So, I thought, "might as well go full monty" and install `R` and `RStudio` using `brew`. This provides me with a powerful method to control many packages/libraries that are needed for macOS and at the same time creates a very clean `R` environment on my Mac.

Again, Google was my friend, and I found many websites that helped. Below the sites that inspired my workflow.

   * http://www.benjack.io/2016/01/02/el-capitan-biocomputing.html
   * http://www.r-bloggers.com/installing-r-on-os-x-100-homebrew-edition/ 
   * https://coolestguidesontheplanet.com/installing-homebrew-on-os-x-el-capitan-10-11-package-manager-for-unix-apps/ 
   * https://www.biostarhandbook.com/setup/setup-macos.html

### Step-by-step

First, I make some directories I need: `.ssh` and `bin` directory.
   
   * `mkdir -v .ssh` -- the `-v`-flag make the `mkdir` command verbose; it's not strictly needed.
   * `chmod -vR 0700 ~/.ssh`
   * `mkdir -v bin`
   * `chmod -vR 0777 ~/bin`
   
Second, we will proceed with installing `brew`, `Command Line Tools`, `XQuartz`, `Python`, some `Perl` modules, and finally `R` with `RStudio`. Again, here `Python` is probably not strictly needed. 

   * Install **`Command Line Tools`** for macOS El Capitan+ using the instructions here: [http://railsapps.github.io/xcode-command-line-tools.html](http://railsapps.github.io/xcode-command-line-tools.html).
   * Install **Perl** modules:
   
       * `sudo cpan YAML Getopt::Long Statistics::Distributions` - I needed this to work get proper p-values calculated in our [MetaGWASToolKit](https://github.com/swvanderlaan/MetaGWASToolKit).
   
   * Installation of `brew`, check out [http://www.brew.sh](http://www.brew.sh) or [https://github.com/homebrew](https://github.com/homebrew).
   
       * `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
   
   * Now were are ready to brew, and install the following packages:
       * `brew install coreutils gnu-sed wget rename git gd libharu git imagemagick lzo hdf5 bison`, these are needed for [**slideToolkit**](https://swvanderlaan.github.io/slideToolkit/), but also contain some general very useful libraries.
       * `brew install mariadb-connector-c`, for some R packages that require `RMySQL` to work.
       * `brew install findutils --with-default-names`.
   * For **[FastQTL](http://fastqtl.sourceforge.net)** and **[fastQTLToolKit](https://github.com/swvanderlaan/fastQTLToolKit)** to work we need to install `GNU scientific libraries`.
        * `brew install zlib boost gsl `
   * We need `cask` to install `Xquartz`. 
       * `brew tap caskroom/cask && brew install cask`
       * `brew cask install xquartz && brew cask install java`
        {{% alert note %}}
        Use “brew doctor” to diagnose in-between installations; if there is a problem with ownership use “chown -vR MYUSERNAME A_FOLDER_NAME” to get ownership back recursively (‘R').
        {{% /alert %}}
   * Install the following **Python**:
       * `brew install python`
       * `brew install llvm` — for **[LDSTORE](http://www.christianbenner.com)** to work. To get LDSTORE working on my Mac I also had to jump through some hoops - I'll tell you all about that later.
       * `pip2 install argparse numpy scipy scikit-learn pandas openpyxl xlrd` — the latter two are needed for **[slideToolkitTools](https://github.com/swvanderlaan/slideToolkitTools)**, which is a private repository I use for [**slideToolkit**](https://swvanderlaan.github.io/slideToolkit/).
   * Yeah, so now, finally you're ready to install `R`. 
       * `brew tap homebrew/science`
       * `brew install r` - I needed `R` installed *with* `tcl-tk`, so I figured out how to do that in [an other post]({{< ref "post/getting-R-with-tcl-tk-on-my-mac.md" >}}). You might not need that.
       * `brew cask install rstudio` - because I dislike the terminal `R`.

Wow, now I'm all set to use `R` for science. Finally, as you know, I'm all into genetics, analyses of methylation data, etc. I've written a couple of R scripts that might be useful for you to. They help install some commonly (interdependent) packages in R, almost automatically. You can find them in the [HerculesToolKit](https://github.com/swvanderlaan/HerculesToolKit), alongside some other useful scripts.


</br></br>

----- 
<sub><sup>&copy; Copyright. 1979-2017 Sander W. van der Laan. Released under [the MIT license](http://opensource.org/licenses/MIT).</sup></sub>

