title=How to create a certificate for ios development on windows?
date=2012-06-13
author=Manik Magar
type=post
guid=http://manikmagar.wordpress.com/?p=74
permalink=/how-to-create-a-certificate-for-ios-development-on-windows/
tags=Adobe,iOS Development
status=published
summary=How to create a certificate for ios development on windows?
~~~~~~
I was browsing through adobe sites and forums to find out how can I create a certificate for iOS development on windows. I tried OpenSSL on widnows but it always failed to find the config file.

So here is what I did &#8211;

1. Install Cygwin &#8211; http://cygwin.com/install.html

Cygwin doesnt by default install OpenSSL so during installation, select the OpenSSL package for installation under &#8216;Net&#8217; packages.

2. After installation, run Cygwin Terminal.

on Terminal type &#8216;openssl&#8217; and enter, prompt should change to OpenSSL &#8211;

Manik@Milkyway ~
  
$ openssl
  
OpenSSL>

3.  Type in below command to create CSR file. After entering that command, it shall ask you to enter some information and a password at the end. Remember that password, you would need it.  At then you should have a key and csr file in c:/test folder.

Manik@Milkyway ~
  
$ openssl
  
OpenSSL> **req -nodes -newkey rsa:2048 -keyout /cygdrive/C/test/mms.key -out /cygdrive/C/test/mms.csr**
  
Generating a 2048 bit RSA private key
  
&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;.+++
  
&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;&#8230;..+++
  
writing new private key to &#8216;/cygdrive/C/mms.key&#8217;
  
&#8212;&#8211;
  
You are about to be asked to enter information that will be incorporated
  
into your certificate request.
  
What you are about to enter is what is called a Distinguished Name or a DN.
  
There are quite a few fields but you can leave some blank
  
For some fields there will be a default value,
  
If you enter &#8216;.&#8217;, the field will be left blank.
  
&#8212;&#8211;
  
Country Name (2 letter code) [AU]:US
  
State or Province Name (full name) [Some-State]:State
  
Locality Name (eg, city) []:City
  
Organization Name (eg, company) [Internet Widgits Pty Ltd]:My Company
  
Organizational Unit Name (eg, section) []:Org
  
Common Name (e.g. server FQDN or YOUR name) []:CN
  
Email Address []:me@me.com

Please enter the following &#8216;extra&#8217; attributes
  
to be sent with your certificate request
  
A challenge password []:test
  
An optional company name []:anything
  
OpenSSL>

4. Upload the .csr file to iOS provisioning portal>Certificates &#8211; https://developer.apple.com/ios/manage/certificates/team/

5. Once you get have the certificate approved and available for download, get it. Copy that .cer file to c:/test folder.

6. Go to Cygwin>OpenSSL prompt and enter below command &#8211;

**x509 -in /cygdrive/C/test/ios\_development.cer -inform DER -out /cygdrive/C/test/ios\_development.pem -outform PEM**

7. To create .p12 file run below command on OpenSSL prompt &#8211;

**openssl pkcs12 -export -inkey /cygdrive/C/test/mms.key -in /cygdrive/C/test/ios_development.pem -out /cygdrive/C/test/mms.p12**

8. Check your c:/test folder, you should have your certificate ready for use.

&nbsp;