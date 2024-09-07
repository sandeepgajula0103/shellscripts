# Script to print the current commit ids of all the repos. Run from code/ .

c_red=tput setaf 1
c_yellow=tput setaf 3
c_blue=tput setaf 4
c_green=tput setaf 2
f_bold=$(tput bold)
reset=tput sgr0
err_begin=${c_red}${f_bold}
warn_begin=${c_yellow}${f_bold}
info_begin=${c_blue}${f_bold}
success_begin=${c_green}${f_bold}

#store the current dir
CUR_DIR=$(pwd)

echo "${info_begin}Commit ids:${reset}"
for i in $(find . -name ".git" | cut -c 3-); do
    # We have to go to the .git parent directory to call the pull command
    cd "$i";
    cd ..;
    dir=$(pwd)
    COMMIT_ID="<Unknown>"
    # finally pull
    COMMIT_ID=$(git log --pretty=format:'{%n%d%n  "CommitId": "%H",%n  "Author": "%an",%n  "AuthorEmail": "%ae",%n  "Date": "%ad",%n  "Message": "%f"%n}')
    printf "${info_begin}%-50s | %s \n" $(basename $dir) ${c_green} "${COMMIT_ID}${reset}" 
    cd $CUR_DIR
done
