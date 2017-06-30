title=How to configure Mule SMTP connector using iCloud on Mac?
date=2015-10-11
author=Manik Magar
type=post
guid=https://manikmagar.wordpress.com/?p=101
permalink=/how-to-configure-mule-smtp-connector-on-mac-os-x/
tags=Mule ESB
status=published
summary=How to configure Mule SMTP connector using iCloud on Mac?
~~~~~~
If you are working on Mule ESB and wondering how to configure SMTP connector in Mule flow to send emails then below are steps that might help you to do it.

Few Points before we start &#8211;

  1. I am on MAC OS X El Capitan (Latest version as of 10/10/2015)
  2. I am using Mule Anypoint Studio 5.3.1 and Mule Enterprise Runtime 3.7 (current latest)

In my demo application, I have one flow which uses DataWeave to convert XML file into JASON format. I wanted to email thisJASON data using Mule. I have two flows here &#8211;

**Flow 1: Generate JASON file**

  1. Read the XML file using File inbound connector.
  2. Convert it into JASON using DataWeave.
  3. Write JASON file to file system using File Outbound connector.
  4. Write converted JASON string to VM endpoint

[<img class="alignnone size-medium wp-image-103" src="/img/2015/10/mule-demo-flow1.png?resize=300%2C100" alt="mule-demo-flow1" data-recalc-dims="1" />](/img/2015/10/mule-demo-flow1.png)

**Flow 2: Send content via email**

[<img class="alignnone size-medium wp-image-104" src="/img/2015/10/mule-demo-flow2.png?resize=300%2C133" alt="mule-demo-flow2" data-recalc-dims="1" />](/img/2015/10/mule-demo-flow2.png)

  1. Listen to the content on same VM endpoint where it is being written in Flow 1
  2. Configure SMTP to send out email using iCloud SMTP server. Below are the configuration properties

[<img class="alignnone size-medium wp-image-105" src="/img/2015/10/smtp_properties.png?resize=300%2C134" alt="SMTP_Properties" data-recalc-dims="1" />](/img/2015/10/smtp_properties.png)

iCloud SMTP servers as per &#8211; https://support.apple.com/en-us/HT202304

Host: smtp.mail.me.com

Port:587

User: This should be your icloud id without @icloud.com. I tried with @icloud.com and it fails to start.

Password: your iCloud password

To: Recipient&#8217;s email id

From: This has to be your complete iCloud email id. Using any other email id not associated with your iCloud account would result in error &#8211; &#8220;<span class="s1">com.sun.mail.smtp.SMTPSendFailedException</span>: 550 5.7.0 From address is not one of your addresses.&#8221;

After all these settings, If I now start my Mule Server and provide the input file, Flow 1 converts the file to JASON and Flow 2 sends out that data to target recipient using my iCloud account.

Hope this helps!

Happy Coding!