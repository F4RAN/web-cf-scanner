npm run build
mv dist/* build
git checkout build
git add .
git commit -m "new build"
git push origin build
