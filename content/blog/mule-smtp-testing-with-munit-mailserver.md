title=Mule SMTP Testing with Munit MailServer Mock
date=2017-05-26T19:00:00-04:00
author=Manik Magar
type=post
tags=assertj,munit,smtp,mailserver
status=published
summary=Very often we use Mule SMTP connector in flows. 
~~~~~~

We often use Mule SMTP connector in flows. But how to make sure that emails gets sent as expected?

MUnit provides MailServer that we can use to mock real SMTP server and verify the mails sent by SMTP connector. Lets see how we can write munit test case for below subflow:

```xml
<context:property-placeholder location="munit-mailserver-demo.properties" />

    <sub-flow name="subflow-mail-sender">
        <set-variable variableName="emailSubject" value="#['Welcome to UT']" doc:name="Set Subject"/>
        <smtp:outbound-endpoint host="${email.host}" port="${email.port}" to="${email.to.addr}" subject="#[flowVars.emailSubject]" cc="${email.cc.addr}" responseTimeout="10000" doc:name="SMTP" password="${email.password}" user="${email.user}"/>
    </sub-flow>
```



## Testing Simple outbound SMTP

### Step 1: MUnit MailServer dependency

Add below maven dependencies to maven project:

```xml
<dependency>
  <groupId>com.mulesoft.munit.utils</groupId>
  <artifactId>munit-mailserver-module</artifactId>
  <version>1.1.0</version>
  <scope>test</scope>
</dependency>

<!-- We will be using assertj for assertions -->
<dependency>
  <groupId>org.assertj</groupId>
  <artifactId>assertj-core</artifactId>
  <!-- use 2.8.0 for Java 7 projects -->
  <version>3.8.0</version>
  <scope>test</scope>
</dependency>

```



### Step 2: Initialising MailServer in Test Case

Add a class level property of mailServer. We will use JUnit's `@Before` and `@After` methods to start and stop the mail server.

```java
	private MailServer mailServer = new MailServer();

	@Override
	protected String getConfigResources() {
		return "munit-mailserver-demo.xml";
	}

	@Before
	public void setUp(){
		mailServer.start();
	}

	@After
	public void tearDown(){
		mailServer.stop();
	}

```



### Step 3: Update Properties files for local SMTP settings

Our actual flow uses an external properties file to load the placeholders like `email.host`, `email.port`, `email.to.addr` and `email.cc.addr`. Make a copy of `munit-mailserver-demo.properties` under src\test\resource.

MailServer uses GreenMail library to implement the SMTP server. It uses [GreenMail's ServerSetupTest](http://www.icegreen.com/greenmail/javadocs/com/icegreen/greenmail/util/ServerSetupTest.html) configuration for setting up ports. So we will be using port 3025 for listening to the incoming mails.

override the properties in test file as below -

```properties
email.to.addr=to@example.com
email.cc.addr=cc@example.com

email.host=localhost
email.port=3025
email.user=
email.password=
```



### Step 4: Write a test case

Now let's write a java test case.

```java
@Test
	public void shouldSendEmail() throws Exception{
		String payload = "Welcome to UnitTesters.com";

		MuleEvent muleEvent = testEvent(payload);

		runFlow("subflow-mail-sender", muleEvent);

		List<MimeMessage> mails = mailServer.getReceivedMessages();

		assertThat(mails)
			.isNotEmpty()
			.hasSize(2);

		assertThat(mails)
			.allSatisfy(mimeMessage -> {
						// Let's inspect our message
						try {
							String toAddr = MailUtils.mailAddressesToString(mimeMessage.getRecipients(RecipientType.TO));
							String ccAddr = MailUtils.mailAddressesToString(mimeMessage.getRecipients(RecipientType.CC));

							assertThat(toAddr).as("To Address").isEqualTo("to@example.com");
							assertThat(ccAddr).as("CC Address").isEqualTo("cc@example.com");
							assertThat(mimeMessage.getSubject()).as("Subject").isEqualTo("Welcome to UT");
							assertThat(mimeMessage.getContent().toString().trim()).as("Mail Body").isEqualTo(payload);

						} catch (MessagingException | IOException e) {
							fail("Unable to fetch data from Mail", e);
						}
					}
				);

	}
```



This is what test case does:

1. Call the flow under test with a test event.
2. Get the list of mails received on our test email server. We will receive one email per email address in to and cc addresses. So we should be having 2 emails on the server. We verify that with assertions.
3. Next, using [assertj's fluent assertions](http://joel-costigliola.github.io/assertj/) , we will iterate through each message received and perform assertions to verify recipients, subject, mail body.

This way, now we know what to expect from the SMTP component.

## Testing Mails with Attachment

Using the similar techniques and assertj, we can verify the attachments on outbound emails. Let's consider below flow for testing -

```xml
<sub-flow name="subflow-attachment-mail-sender">
        <set-variable variableName="emailSubject" value="#['Welcome to UT']" doc:name="Set Subject"/>

        <set-attachment attachmentName="test.txt" value="#[payload]" contentType="text/plain" doc:name="Attachment" />

        <smtp:outbound-endpoint host="${email.host}" port="${email.port}" to="${email.to.addr}" subject="#[flowVars.emailSubject]" cc="${email.cc.addr}" responseTimeout="10000" doc:name="SMTP" password="${email.password}" user="${email.user}"/>
    </sub-flow>
```



Test case for this could look like below -

```java
@Test
	public void shouldSendEmailWithAttachment() throws Exception{
		String payload = "Welcome to UnitTesters.com";

		MuleEvent muleEvent = testEvent(payload);

		runFlow("subflow-attachment-mail-sender", muleEvent);

		List<MimeMessage> mails = mailServer.getReceivedMessages();

		assertThat(mails)
			.isNotEmpty()
			.hasSize(2);

		assertThat(mails)
			.allSatisfy(mimeMessage -> {
						// Verify the attachment
						try {

							MimeBodyPart attachment = getAttachments(mimeMessage, "test.txt");
							assertThat(attachment).isNotNull();
							assertThat(attachment.getContentType()).startsWith("text/plain");
							assertThat(attachment.getContent().toString().trim()).isEqualTo(payload);

							//Just to test non-existent attachment.
							MimeBodyPart attachment2 = getAttachments(mimeMessage, "test2.txt");
							assertThat(attachment2).isNull();

						} catch (MessagingException | IOException e) {
							fail("Unable to fetch data from Mail", e);
						}
					}
				);

	}

	public MimeBodyPart getAttachments(MimeMessage msg, String attchmentName) throws MessagingException, IOException{
		Map<String, Part> attachments = new HashMap<String, Part>();
		MailUtils.getAttachments((Multipart)msg.getContent(), attachments);

		return (MimeBodyPart) attachments.get(attchmentName);

	}
```

This is what test case does:

1. Call the flow under test with a test event.
2. Get the list of mails received on our test email server. Again we should recieve two emails on the server.
3. Next, using [assertj's fluent assertions](http://joel-costigliola.github.io/assertj/) , we extract the attachments and verify their presence, content, mime type etc.



That was easy, right! Hope this helps you to test your SMTP flows in Mule.

## Source code

Full source of this demo is available on Github [here](https://github.com/UnitTesters/munit-mailserver-demo). Feel free to download and take a look.

### Refernces:

- [Munit](https://docs.mulesoft.com/munit/v/1.3/)

- [AssertJ - Fluent Java Assertions](http://joel-costigliola.github.io/assertj/)

- [GreenMail](http://www.icegreen.com/greenmail/)

  ​

Feel free to let me know your thoughts in comments and you can follow me on twitter [@manikmagar](https://twitter.com/manikmagar) or [@UnitTesters](https://twitter.com/unittesters).
