import sys
import docx
doc = docx.Document('test_output_premium.docx')
for p in doc.paragraphs:
    print(p.text)
