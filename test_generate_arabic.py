import sys
import os
sys.path.append(os.path.abspath("tabashir-backend"))

from app.models.cv_models import Resume, Header, CareerObjective, EducationExperience, WorkAndLeadershipExperience, Project, Skills, Languages
from docxtpl import DocxTemplate

header = Header(name="جون دو", email="john@example.com", phone="555-1234", location="دبي, الإمارات", linkedin="linkedin.com/in/johndoe", github="github.com/johndoe", nationality="إماراتي")
objective = CareerObjective("أن أكون أفضل مهندس برمجيات وقيادة فرق تقنية لبناء تطبيقات فعالة.")

edu = EducationExperience(
    degree="بكالوريوس", major="علوم الحاسب", university="جامعة ستانفورد", location="ستانفورد", date="2015 - 2019", GPA="3.8",
    details=["تخرجت بمرتبة الشرف الأولى", "رئيس نادي علوم الحاسب"], coursework=["الخوارزميات", "هياكل البيانات", "الذكاء الاصطناعي"]
)

work = WorkAndLeadershipExperience(
    company="جوجل", position="مهندس برمجيات أول", location="دبي", date="2019 - الحاضر",
    details=["تطوير أنظمة سحابية قابلة للتوسع باستخدام بايثون", "تحسين أداء قواعد البيانات بنسبة 30%", "تدريب المهندسين المبتدئين"]
)

lship = WorkAndLeadershipExperience(
    company="نادي المطورين", position="مؤسس وقائد", location="الجامعة", date="2018 - 2019",
    details=["تنظيم ورش عمل أسبوعية لأكثر من 50 طالب", "استضافة متحدثين من شركات التقنية الكبرى"]
)

proj = Project(
    title="تطبيق إدارة المهام الذكي", location="دبي", position="مطور رئيسي", date="2020",
    details=["بناء تطبيق جوال باستخدام فلاتر", "دمج واجهات برمجة تطبيقات الذكاء الاصطناعي"]
)

skills = Skills(softskills=["القيادة", "حل المشكلات", "التواصل"], skillset=["بايثون", "فلاتر", "جافا سكريبت"], training=["شهادة خبير سحابة AWS", "مدير مشاريع معتمد"])
languages = Languages(["العربية (أصلي)", "الإنجليزية (طلاقة)"])

resume = Resume(
    education=[edu], header=header, objective=objective, skills=skills, languages=languages,
    work=[work], lship=[lship], projects=[proj], keywords=["هندسة البرمجيات", "قيادة"]
)

resume.write_document('tabashir-backend/templates/Arabic Docxtpl Compatible CV Template.docx', 'test_output_arabic_full.docx')
print("Successfully generated test_output_arabic_full.docx")
