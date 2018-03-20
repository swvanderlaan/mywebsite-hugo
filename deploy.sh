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
echo "                                    version 1.2"
echo ""
echoitalic "* Written by  : Sander W. van der Laan"
echoitalic "* E-mail      : s.w.vanderlaan-2@umcutrecht.nl"
echoitalic "* Last update : 2017-10-04"
echoitalic "* Version     : v1.2"
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

# Macbook Pro
USERROOT="/Users/swvanderlaan"

# ROOT
ROOT="${USERROOT}/website"

WEBSITE="${ROOT}/mywebsite-hugo"
WEBSITEPUBLIC="${ROOT}/swvanderlaan.github.io"

echo "Root directory____________ ${ROOT}"
echo "Website root directory____ ${WEBSITE}"
echo "Public website____________ ${WEBSITEPUBLIC}"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echobold "Deploying updates to GitHub."
echo ""
echo "-----------------------------"`
echo "* Building the project..."
cd ${WEBSITE}
rm -rvf ${WEBSITEPUBLIC}

git status
git add -A
git commit -m "Committing the (updated) source files."
git push origin master

# if using a theme, replace by `hugo -t <yourtheme>`
hugo 

### Depending on your needs, you can create a LICENSE file and README.md. You can use
### these as an example 
cp -v ${ROOT}/focus_stuff/LICENSE.md ${WEBSITEPUBLIC}/LICENSE.md
cp -v ${ROOT}/focus_stuff/README.md ${WEBSITEPUBLIC}/README.md
### If you want to re-direct your GitHub page to another domain, you'll have to make a
### 'CNAME' file.
# echo "http://www.waldamargroup.com" > ${WEBSITEPUBLIC}/CNAME

echo ""
echo "-----------------------------"
echo "* Going to 'public' folder..."

cd ${ROOT}/swvanderlaan.github.io

cp -afv ${ROOT}/mywebsite-hugo/public/* .

echo ""
echo "-----------------------------"``
echo "* Add changes to git..."

git status
git add -A

echo ""
echo "-----------------------------"`
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

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echobold "Wow. We're all done. Let's have a 🍺 !"
