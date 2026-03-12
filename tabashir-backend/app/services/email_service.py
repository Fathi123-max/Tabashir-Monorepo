import os
import smtplib
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from docx2pdf import convert
from flask import current_app

def send_email(client_email: str, attachment_path: str, name: str, convert_to_pdf: bool = True):
    """Send email to client with formatted CV attachment."""
    
    # Create the email
    msg = MIMEMultipart()
    tabashir_email = current_app.config['EMAIL_USERNAME']
    tabashir_pass = current_app.config['EMAIL_PASSWORD']
    
    body = f"""Dear {name.title()},

    شكرا لثقتكم في شركة تباشير لاستشارات الموارد البشرية. يرجى الاطلاع على سيرتك الذاتية المنسقة المرفقة بهذا البريد الإلكتروني.

    ملحوظة: مرفق بهذا البريد الإلكتروني سيرتك الذاتية بتنسيق مستند وتنسيق مايكروسوفت وورد (قابل للتعديل) حتى تتمكن من إجراء أي تغييرات قد ترغب فيها على سيرتك الذاتية بتنسيق تباشير

    مع تحياتي،
    تباشير لاستشارات الموارد البشرية

    Invest in your future with Tabashir's services! We offer you the highest quality, ATS-compatible resumes, LinkedIn profile upgrades, interview training and more to help land you the job of your dreams! If you or anyone you know is interested in securing their future, please share the illustration in this email with them! Thank You!

    Thank you for trust in Tabashir HR Consulting. Please find your formatted CV attached to this email.

    Note: attached to this email is your CV in .pdf and .docx (editable) format so you can make any changes you may wish to your Tabashir Formatted CV.

    With regards,
    Tabashir HR Consulting
    """

    msg['From'] = tabashir_email
    msg['To'] = client_email
    msg['Subject'] = "Your Tabashir Formatted CV"

    # Attach the body with the msg instance
    msg.attach(MIMEText(body, 'plain'))

    # Open the file to be sent
    if os.path.exists(attachment_path):
        attach_file(msg, attachment_path)

        # If conversion to PDF is required
        if convert_to_pdf and attachment_path.endswith(".docx"):
            print("Converting file to PDF")
            pdf_path = attachment_path.replace(".docx", ".pdf")
            convert(attachment_path, pdf_path)
            print("File converted")
            attach_file(msg, pdf_path)
    else:
        raise FileNotFoundError(f"File not found: {attachment_path}")

    print("Sending email")

    # Server Creation
    server = smtplib.SMTP_SSL(current_app.config['EMAIL_HOST'], current_app.config['EMAIL_PORT'])
    server.login(tabashir_email, tabashir_pass)
    text = msg.as_string()
    
    # Mail send
    server.sendmail(tabashir_email, client_email, text)
    
    # SMTP session end
    server.quit()
    print(f"Email sent to {client_email} successfully")


def attach_file(msg, filepath):  
    """Attach file to email message."""
    print("Attaching file")
    with open(filepath, "rb") as attachment:
        # Instance of MIMEBase and named as part
        part = MIMEBase('application', 'octet-stream')
        part.set_payload(attachment.read())
        print("Attachment loaded successfully")
    
    # base64 encoding
    encoders.encode_base64(part)
    
    part.add_header(
        'Content-Disposition',
        f'attachment; filename="{os.path.basename(filepath)}"',
    )
    
    msg.attach(part)
