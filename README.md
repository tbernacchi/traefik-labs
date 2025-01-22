# traefik-labs

> This project is a study case using Traefik as a reverse proxy and ingress controller.

<div align=>
	<img align="center"  src=/.github/assets/img/traefik-logo.png>
</div> 

## Usage

1. Build the the app `foobar-api` and push to a registry. 
2. Generates the certificates following the `certs` directory instructions.
3. Install Traefik, following the `README.md` in the `install` directory.
4. Deploy the kubernetes resources, following the README.md in the `kubernetes` directory.
5. Deploy the prometheus, following the `prometheus` directory instructions.
6. Install `jaeger` following the `jaeger` directory instructions.

If everything is ok, you should be able to access the `traefik-dashboard` using the `https://traefik.mykubernetes.com/dashboard`;

# Testing 

You can test your app using the following command:

```
curl -k -u user1:secure_password https://traefik.mykubernetes.com/myapp/
IP: 127.0.0.1
IP: ::1
IP: 10.42.2.30
IP: fe80::bc75:a3ff:fe00:8b72
RemoteAddr: 10.42.2.95:41280
GET / HTTP/1.1
Host: traefik.mykubernetes.com
User-Agent: curl/7.84.0
Accept: */*
Accept-Encoding: gzip
Authorization: Basic dXNlcjE6c2VjdXJlX3Bhc3N3b3Jk
Traceparent: 00-7a32e9635f3a7b540c2194f2d0c3d0ee-69302ef2d790ea77-01
X-Forwarded-For: 192.168.1.100
X-Forwarded-Host: traefik.mykubernetes.com
X-Forwarded-Port: 443
X-Forwarded-Prefix: /myapp
X-Forwarded-Proto: https
X-Forwarded-Server: traefik-69cfd56b47-nh6jb
X-Real-Ip: 192.168.1.100
```


