```
echo `htpasswd -nb user1 secure_password` > users.txt
echo `htpasswd -nb user2 senha_segura` >> users.txt

kubectl create secret generic basic-auth-secret --from-file=users=users.txt -n traefik-v2
```
