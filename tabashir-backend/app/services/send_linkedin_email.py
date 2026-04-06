import smtplib
import os
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

SMTP_SERVER = "smtp.hostinger.com"
SMTP_PORT = 465
EMAIL_ADDRESS = "application@tabashirai.com"
EMAIL_PASSWORD = os.getenv('EMAIL_PASSWORD')

EMAIL_SUBJECT = "Next Step in Your Career Starts Now | خطوتك التالية في المسار المهني تبدأ الآن"
EMAIL_BODY_TEMPLATE = """\
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<p dir="rtl" style="text-align:right;">
عزيزي/عزيزتي {name}،<br><br>

نقدّر وقتكم وثقتكم بنا.<br>
نود إعلامكم بأننا سنبدأ بالتقديم لكم على الوظائف من خلال ثلاث قنوات رئيسية:<br>
1. التقديم عبر البريد الإلكتروني: سنقوم بإرسال ملفكم الشخصي مباشرة إلى الشركات عبر البريد الإلكتروني.<br>
2. التقديم عبر "LinkedIn Easy Apply": هذه الطريقة تتطلب وجود حساب نشط على لينكدإن، وسنحتاج إلى بيانات الدخول الخاصة بكم لنتمكن من التقديم نيابةً عنكم.<br>
3. مواقع الشركات الرسمية: سنقوم أيضًا بالتقديم من خلال النماذج الموجودة على مواقع الشركات باستخدام المعلومات التي زودتمونا بها.<br><br>

من خلال برنامج التقديم عبر "LinkedIn Easy Apply"، سنساعدك في التقديم للوظائف المناسبة مباشرةً عبر LinkedIn، 
مما يساعدك على التميز وتوفير وقتك الثمين.<br><br>

<strong>لبدء التقديم عبر LinkedIn، نرجو تزويدنا بمعلومات تسجيل الدخول إلى حسابك:</strong><br>
• البريد الإلكتروني لـ LinkedIn:<br>
• كلمة المرور لـ LinkedIn:<br><br>

🔒 <strong>تنويه:</strong> سيتم الحفاظ على سرية بياناتك بشكل كامل ولن يتم استخدامها إلا لغرض التقديم للوظائف. 
نوصي بشدة <strong>بتغيير كلمة مرور حسابك على LinkedIn</strong> بمجرد انتهاء الخدمة حفاظاً على أمنك.<br><br>

نظراً لضغط الطلبات من العملاء، قمنا بجدولة مكالمة قصيرة جداً معك لتأكيد الدخول إلى حساب LinkedIn 
وإبلاغك بتاريخ بدء التقديم. لا حاجة لاجتماع طويل، فقط تأكيد سريع لضمان سير الأمور بسلاسة.<br><br>

👉 <a href="https://calendar.app.google/QyujQVwsUXvqJVNW6" target="_blank">أكد وقت الاتصال هنا</a>.<br><br>

نتطلع إلى مساعدتك في اتخاذ الخطوة التالية في مسارك المهني. إذا كانت لديك أي استفسارات، 
لا تتردد في التواصل معنا في أي وقت.<br><br>

أطيب التحيات،<br>
Tabashir HR Consultant
</p>

<hr>

<p>Dear {name},</p>

<p>We truly appreciate your time and trust in us.<br>
We would like to inform you that we will start applying to jobs on your behalf through three main channels:</p>
<ol>
<li>Email applications: We will send your profile directly to companies via email.</li>
<li>LinkedIn Easy Apply: This requires an active LinkedIn account. We’ll need your login credentials to apply on your behalf.</li>
<li>Official company websites: We will also submit applications using company forms and the data you provided.</li>
</ol>

<p>Through LinkedIn Easy Apply program, we assist you in applying for relevant jobs directly via LinkedIn, 
helping you stand out and saving you valuable time.</p>

<p><strong>To begin, we kindly ask you to share your LinkedIn credentials so we can connect your profile:</strong><br>
• LinkedIn Email:<br>
• LinkedIn Password:</p>

<p>🔒 <strong>Please note:</strong> Your information will be kept strictly confidential and used solely for submitting job applications. 
We strongly recommend that you <strong>change your LinkedIn password</strong> once the service is completed for your security.</p>

<p>Due to a high volume of client requests, we have scheduled a very short call with you to confirm LinkedIn access 
and let you know when we’ll begin applying. No full meeting is needed—just a brief confirmation to ensure smooth processing.<br>
👉 <a href="https://calendar.app.google/QyujQVwsUXvqJVNW6" target="_blank">Confirm your call time here</a>.</p>

<p>We look forward to helping you take the next step in your career. If you have any questions, feel free to reach out at any time.</p>

<p>Best regards,<br>
Tabashir HR Consultant</p>

</body>
</html>
"""


def send_email(recipient_email, recipient_name):
    msg = MIMEMultipart()
    msg["From"] = EMAIL_ADDRESS
    msg["To"] = recipient_email
    msg["Subject"] = EMAIL_SUBJECT
    msg['Bcc'] = 'application@tabashirai.com'

    body = EMAIL_BODY_TEMPLATE.format(name=recipient_name.title())
    msg.attach(MIMEText(body, "html", "utf-8"))

    try:
        with smtplib.SMTP_SSL(SMTP_SERVER, SMTP_PORT) as server:
            server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
            server.send_message(msg)
            print(f"✅ Email sent to {recipient_name} <{recipient_email}>")
    except Exception as e:
        print(f"❌ Failed to send email to {recipient_email}: {e}")
        raise e
