msg="${1:-update}"

git add -A && git commit -m $msg && git push