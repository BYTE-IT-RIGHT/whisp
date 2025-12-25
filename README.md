# Whisp

# Deployment
add build manually to google play console

# Merge main into production
git checkout production
git pull origin production
git merge --no-ff staging -m "Deploy production <DD.MM.YYYY>"
git push origin production
