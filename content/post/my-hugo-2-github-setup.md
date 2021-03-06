+++
date = 2016-10-03
lastmod = 2017-10-03
draft = false
tags = ["hugo", "github", "coding", "html"]
title = "How I maintain my Hugo-based website on GitHub"
math = true
highlight = true
summary = """
Understanding hugo 2 github static site building. 
"""

[header]
image = "headers/computer_code_broad.png"
caption = "Image credit: [**vintagetone**](https://www.shutterstock.com/g/vintagetone)"

+++

## Background

I wanted to create this website and make it fast and easy for me to update it. I learned of `jekyll` via [GitHub](https://jekyllrb.com/docs/github-pages/), but also learned that [hugo](https://gohugo.io) works much faster to enhance my personal website. With `hugo` I would still be able to use Github Pages to host the generated html files (in the `Public` folder). Googling I discovered [several](http://codethejason.github.io/blog/setupghpages/) [methods](https://hjdskes.github.io/blog/deploying-hugo-on-personal-gh-pages/index.html) (the [`hugo`-method](https://gohugo.io/hosting-and-deployment/hosting-on-github/#deployment-via-gh-pages-branch) wasn't working for me either) which were not directly intuitive to me; in the end I found this [post](https://chengjunwang.com/en/post/hugo2github/) by Cheng-Jun Wang to be most helpful and best match my needs. 

The trick is, that you have to move the files in the `Public` folder as generated by the `hugo` command, to the local folder of your GitHub folder - or whichever folder you've chosen to synchronise with GitHub and to maintain your website locally.

## Step-by-step

1. First you will have to create two repositories *without* a README.
   * Create on GitHub a repository named `mywebsite-hugo` (or any other name you like) *via the GitHub* website using the '+'-sign at the right-top. This repository will host `hugo` 'source' content.
   * Create on GitHub a repository named `<your-username>.github.io` *via the GitHub* website using the '+'-sign at the right-top. This repository will host the public folder: the static website. 
   {{% alert note %}}
   It is vital you name the repository using your `<your-username>` like so `<your-username>.github.io`. GitHub will automatically know this is a *personal* website.
   {{% /alert %}}
2. Second, you'll want to clone both repositories to whichever folder you want to maintain them locally.
   * `cd "/Users/<username>/website/"` (or the folder you have it in).
   * `git clone https://github.com/<your-username>/mywebsite-hugo.git`
   * `cd "/Users/<username>/website/"` (or the folder you have it in).
   * `git clone https://github.com/<your-username>/mywebsite-hugo.git`
3. Third you'll want to make an empty `hugo` website in your 'source', i.e. the `mywebsite-hugo` repository.
   * `cd "/Users/<username>/website/"`
   * `hugo new site mywebsite-hugo --force`
   * `cd mywebsite-hugo`
4. You'll want to download the [Academic](https://github.com/gcushen/hugo-academic/archive/master.zip) theme, extract it into a themes/academic folder within your Hugo website, and create some new content.
   * You best follow these instructions [here](https://georgecushen.com/create-your-website-with-hugo/) *up to the point that you're ready to deploy, i.e. upload, your site!* At which point you should return here. 
   {{% alert note %}}
   I always forget all those `markdown` codes, so you can find them [here](https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf) for instance.
   {{% /alert %}}
5. You're ready to deploy. Great. 
   * You can take a last look at your site locally: `hugo server --watch` and opening it in your browser `http://localhost:1313/`.
   * If you are happy with the results kill the local server: `Ctrl+C`.
   * You're almost done: add the `deploy.sh` script to help you (see the following script).
   * and make it executable: `chmod +x deploy.sh`.
   * `bash deploy.sh "Your optional commit message"` to send changes to both `mywebsite-hugo` and `<username>.github.io`.

The following script is content of the deploy.sh.

```bash
#!/bin/bash

### Creating some function
function echobold { #'echobold' is the function name
    echo -e "\033[1m${1}\033[0m" # this is whatever the function needs to execute.
}
function echobold { #'echobold' is the function name
    echo -e "${BOLD}${1}${NONE}" # this is whatever the function needs to execute, note ${1} is the text for echo
}
function echoitalic { #'echobold' is the function name
    echo -e "\033[3m${1}\033[0m" # this is whatever the function needs to execute.
}

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echobold "                              UPDATING WEBSITE"
echo "                                    version 1.0"
echo ""
echoitalic "* Written by  : <YOUR-NAME>"
echoitalic "* E-mail      : your@email.com"
echoitalic "* Last update : <fill-in-a-date>"
echoitalic "* Version     : v1.0"
echo ""
echoitalic "* Description : This script will set some directories, execute some things, "
echoitalic "                and will then update the website."
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "Today's: "$(date)
TODAY=$(date +"%Y%m%d")
echo ""
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echobold "The following directories are set."

ROOT="/Users/<username>/website"
WEBSITE="${ROOT}/mywebsite-hugo"
WEBSITEPUBLIC="${WEBSITE}/public"

echo "Root directory____________ ${ROOT}"
echo "Website root directory____ ${WEBSITE}"
echo "Public website____________ ${WEBSITEPUBLIC}"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echobold "Deploying updates to GitHub."

echo "* Building the project..."
cd ${WEBSITE}
rm -rvf ${WEBSITEPUBLIC}
rm -rvf ${WEBSITEPUBLIC}

git status
git add -A
git commit -m "Committing the (updated) source files."
git push origin master

hugo # if using a theme, replace by `hugo -t <yourtheme>`

### Depending on your needs, you can create a LICENSE file and README.md. You can use
### these as an example 
cp -v ${ROOT}/LICENSE ${WEBSITEPUBLIC}/LICENSE
cp -v ${ROOT}/README.md ${WEBSITEPUBLIC}/README.md
### If you want to re-direct your GitHub page to another domain, you'll have to make a
### 'CNAME' file.
echo "http://www.<some-domain>.com" > ${WEBSITEPUBLIC}/CNAME

echo "* Going to 'public' folder..."

cd ${ROOT}/<user-name>.github.io

cp -afv ${ROOT}/mywebsite-hugo/public/* .

echo "* Add changes to git..."

git status
git add -A

echo "* Commit changes..."
msg="> Rebuilding site $(date)."
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg."

# Push source and build repos.
git push origin master

# Come Back
cd ${ROOT}
```

I use my favorite text-editor, BBEdit, to make the new markdown files or update old ones. I can inspect my work by running `hugo server --watch` again, and opening it in your browser `http://localhost:1313/`. 

## Deploying the html files

After I make some changes, I can conveniently run the following code to deploy the html files to github pages. The script will also upload the source files to the repository. You can provide a message for committing as well; actually that would be good practice.

{{% alert note %}}
`bash deploy.sh "Your optional commit message"`
{{% /alert %}}

</br></br>

----- 
<sub><sup>&copy; Copyright. 1979-2017 Sander W. van der Laan. Released under [the MIT license](http://opensource.org/licenses/MIT).</sup></sub>

