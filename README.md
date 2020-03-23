# Подготовка самоподписанных сертификатов для Nginx HTTP/2

sudo cp /etc/pki/tls/openssl.cnf /etc/ssl/http2test.cnf

sudo vim /etc/ssl/http2test.cnf

...
[ req ]
req_extensions = v3_req # The extensions to add to a certificate request

[ v3_req ]

# Extensions to add to a certificate request

basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names


[ alt_names ]                # И здесь
DNS.0 = http2test-bigip-test.apps.ocp-dgx.sbercloud.store     # указать список доменов
DNS.1 = *.apps.ocp-dgx.sbercloud.store          # для которых выписываем сертификат
...

# генерация сертификатов

sudo openssl req -x509 -newkey rsa:2048 -keyout http2test-key.pem -out http2test.pem -days 365 -nodes -extensions v3_req -config /etc/ssl/http2test.cnf


