from docx import Document
from docx.shared import Pt, Inches
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

def add_horizontal_line(paragraph):
    p = paragraph._p
    pPr = p.get_or_add_pPr()
    pBdr = OxmlElement('w:pBdr')
    pPr.insert_element_before(pBdr,
        'w:shd', 'w:tabs', 'w:suppressAutoHyphens', 'w:kinsoku', 'w:wordWrap',
        'w:overflowPunct', 'w:topLinePunct', 'w:autoSpaceDE', 'w:autoSpaceDN',
        'w:bidi', 'w:adjustRightInd', 'w:snapToGrid', 'w:spacing', 'w:ind',
        'w:contextualSpacing', 'w:mirrorIndents', 'w:suppressOverlap', 'w:jc',
        'w:textDirection', 'w:textAlignment', 'w:textboxTightWrap',
        'w:outlineLvl', 'w:divId', 'w:cnfStyle', 'w:rPr', 'w:sectPr',
        'w:pPrChange'
    )
    bottom = OxmlElement('w:bottom')
    bottom.set(qn('w:val'), 'single')
    bottom.set(qn('w:sz'), '6')
    bottom.set(qn('w:space'), '1')
    bottom.set(qn('w:color'), '000000')
    pBdr.append(bottom)

def make_rtl(paragraph):
    p = paragraph._p
    pPr = p.get_or_add_pPr()
    bidi = OxmlElement('w:bidi')
    bidi.set(qn('w:val'), '1')
    pPr.append(bidi)
    paragraph.alignment = WD_ALIGN_PARAGRAPH.RIGHT

doc = Document()

# Set Margins (0.75 inch ATS friendly)
sections = doc.sections
for section in sections:
    section.top_margin = Inches(0.75)
    section.bottom_margin = Inches(0.75)
    section.left_margin = Inches(0.75)
    section.right_margin = Inches(0.75)

# Set Default Font
style = doc.styles['Normal']
font = style.font
font.name = 'Arial'
font.size = Pt(11)

# --- HEADER ---
name_p = doc.add_paragraph()
name_p.alignment = WD_ALIGN_PARAGRAPH.CENTER
make_rtl(name_p)
name_p.alignment = WD_ALIGN_PARAGRAPH.CENTER # Re-center after make_rtl
name_run = name_p.add_run("{{ header.name }}")
name_run.bold = True
name_run.font.size = Pt(16)

contact_p = doc.add_paragraph()
contact_p.alignment = WD_ALIGN_PARAGRAPH.CENTER
make_rtl(contact_p)
contact_p.alignment = WD_ALIGN_PARAGRAPH.CENTER # Re-center after make_rtl
contact_run = contact_p.add_run("{{ contact_info }}")
contact_run.font.size = Pt(10)

# --- SUMMARY ---
doc.add_paragraph("{% if objective %}")
p = doc.add_paragraph("الملخص المهني")
p.style.font.bold = True
p.style.font.size = Pt(12)
make_rtl(p)
add_horizontal_line(p)
obj_p = doc.add_paragraph("{{ objective }}")
make_rtl(obj_p)
doc.add_paragraph("{% endif %}")

# --- WORK EXPERIENCE ---
doc.add_paragraph("{% if work_list %}")
p = doc.add_paragraph("الخبرة المهنية")
p.style.font.bold = True
p.style.font.size = Pt(12)
make_rtl(p)
add_horizontal_line(p)

doc.add_paragraph("{% for work in work_list %}")
work_p = doc.add_paragraph()
make_rtl(work_p)
work_p.add_run("{{ work.position }}").bold = True
work_p.add_run("{% if work.company %} | {{ work.company }}{% endif %}").italic = True
work_p.add_run("{% if work.location %} | {{ work.location }}{% endif %}{% if work.date %} | {{ work.date }}{% endif %}")

doc.add_paragraph("{% for detail in work.details %}")
detail_p = doc.add_paragraph("{{ detail }}", style='List Bullet')
make_rtl(detail_p)
doc.add_paragraph("{% endfor %}")
doc.add_paragraph("{% endfor %}")
doc.add_paragraph("{% endif %}")

# --- LEADERSHIP EXPERIENCE ---
doc.add_paragraph("{% if lship_list %}")
p = doc.add_paragraph("الخبرة القيادية")
p.style.font.bold = True
p.style.font.size = Pt(12)
make_rtl(p)
add_horizontal_line(p)

doc.add_paragraph("{% for lship in lship_list %}")
lship_p = doc.add_paragraph()
make_rtl(lship_p)
lship_p.add_run("{{ lship.position }}").bold = True
lship_p.add_run("{% if lship.company %} | {{ lship.company }}{% endif %}").italic = True
lship_p.add_run("{% if lship.location %} | {{ lship.location }}{% endif %}{% if lship.date %} | {{ lship.date }}{% endif %}")

doc.add_paragraph("{% for detail in lship.details %}")
detail_p = doc.add_paragraph("{{ detail }}", style='List Bullet')
make_rtl(detail_p)
doc.add_paragraph("{% endfor %}")
doc.add_paragraph("{% endfor %}")
doc.add_paragraph("{% endif %}")

# --- EDUCATION ---
doc.add_paragraph("{% if education_list %}")
p = doc.add_paragraph("التعليم")
p.style.font.bold = True
p.style.font.size = Pt(12)
make_rtl(p)
add_horizontal_line(p)

doc.add_paragraph("{% for edu in education_list %}")
edu_p = doc.add_paragraph()
make_rtl(edu_p)
edu_p.add_run("{{ edu.degree }}{% if edu.major %} في {{ edu.major }}{% endif %}").bold = True
edu_p.add_run("{% if edu.university %} | {{ edu.university }}{% endif %}").italic = True
edu_p.add_run("{% if edu.location %} | {{ edu.location }}{% endif %}{% if edu.date %} | {{ edu.date }}{% endif %}")

doc.add_paragraph("{% if edu.gpa and edu.gpa != 'None' %}")
gpa_p = doc.add_paragraph("المعدل: {{ edu.gpa }}")
make_rtl(gpa_p)
doc.add_paragraph("{% endif %}")

doc.add_paragraph("{% for detail in edu.details %}")
detail_p = doc.add_paragraph("{{ detail }}", style='List Bullet')
make_rtl(detail_p)
doc.add_paragraph("{% endfor %}")

doc.add_paragraph("{% for course in edu.coursework %}")
course_p = doc.add_paragraph("الدورات: {{ course }}", style='List Bullet')
make_rtl(course_p)
doc.add_paragraph("{% endfor %}")

doc.add_paragraph("{% endfor %}")
doc.add_paragraph("{% endif %}")

# --- PROJECTS ---
doc.add_paragraph("{% if project_list %}")
p = doc.add_paragraph("المشاريع")
p.style.font.bold = True
p.style.font.size = Pt(12)
make_rtl(p)
add_horizontal_line(p)

doc.add_paragraph("{% for project in project_list %}")
proj_p = doc.add_paragraph()
make_rtl(proj_p)
proj_p.add_run("{{ project.title }}").bold = True
proj_p.add_run("{% if project.date %} | {{ project.date }}{% endif %}")

doc.add_paragraph("{% for detail in project.details %}")
detail_p = doc.add_paragraph("{{ detail }}", style='List Bullet')
make_rtl(detail_p)
doc.add_paragraph("{% endfor %}")

doc.add_paragraph("{% endfor %}")
doc.add_paragraph("{% endif %}")

# --- SKILLS & LANGUAGES ---
doc.add_paragraph("{% if skills.skillset or skills.softskills or languages %}")
p = doc.add_paragraph("المهارات والكفاءات")
p.style.font.bold = True
p.style.font.size = Pt(12)
make_rtl(p)
add_horizontal_line(p)

doc.add_paragraph("{% if skills.skillset %}")
sk_p = doc.add_paragraph()
make_rtl(sk_p)
sk_p.add_run("المهارات التقنية: ").bold = True
sk_p.add_run("{{ skills.skillset|join('، ') }}")
doc.add_paragraph("{% endif %}")

doc.add_paragraph("{% if skills.softskills %}")
ss_p = doc.add_paragraph()
make_rtl(ss_p)
ss_p.add_run("الكفاءات الأساسية: ").bold = True
ss_p.add_run("{{ skills.softskills|join('، ') }}")
doc.add_paragraph("{% endif %}")

doc.add_paragraph("{% if languages %}")
lang_p = doc.add_paragraph()
make_rtl(lang_p)
lang_p.add_run("اللغات: ").bold = True
lang_p.add_run("{{ languages|join('، ') }}")
doc.add_paragraph("{% endif %}")

doc.add_paragraph("{% if skills.training %}")
tr_p = doc.add_paragraph()
make_rtl(tr_p)
tr_p.add_run("التدريب والشهادات: ").bold = True
tr_p.add_run("{{ skills.training|join('، ') }}")
doc.add_paragraph("{% endif %}")

doc.add_paragraph("{% endif %}")

doc.save('tabashir-backend/templates/Arabic Docxtpl Compatible CV Template.docx')
print("Arabic template generated successfully.")
