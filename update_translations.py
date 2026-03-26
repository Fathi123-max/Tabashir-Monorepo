import json
import os

translations = {
    "en": {
        "Resume Generated Successfully!": "Resume Generated Successfully!",
        "Your professional CV has been created and saved to your vault.": "Your professional CV has been created and saved to your vault.",
        "Download PDF": "Download PDF",
        "Share Word File": "Share Word File",
        "Go to Vault": "Go to Vault",
        "Back to Home": "Back to Home",
        "Check out my professional resume:": "Check out my professional resume:",
        "My Resume": "My Resume",
        "PDF download link is not available.": "PDF download link is not available.",
        "Word file link is not available.": "Word file link is not available.",
        "Could not open download link.": "Could not open download link."
    },
    "ar": {
        "Resume Generated Successfully!": "تم إنشاء السيرة الذاتية بنجاح!",
        "Your professional CV has been created and saved to your vault.": "تم إنشاء سيرتك الذاتية الاحترافية وحفظها في محفظتك.",
        "Download PDF": "تحميل PDF",
        "Share Word File": "مشاركة ملف Word",
        "Go to Vault": "انتقل إلى المحفظة",
        "Back to Home": "العودة إلى الرئيسية",
        "Check out my professional resume:": "شاهد سيرتي الذاتية الاحترافية:",
        "My Resume": "سيرتي الذاتية",
        "PDF download link is not available.": "رابط تحميل PDF غير متوفر.",
        "Word file link is not available.": "رابط ملف Word غير متوفر.",
        "Could not open download link.": "تعذر فتح رابط التحميل."
    },
    "es": {
        "Resume Generated Successfully!": "¡Currículum generado con éxito!",
        "Your professional CV has been created and saved to your vault.": "Tu CV profesional ha sido creado y guardado en tu bóveda.",
        "Download PDF": "Descargar PDF",
        "Share Word File": "Compartir archivo Word",
        "Go to Vault": "Ir a la bóveda",
        "Back to Home": "Volver al inicio",
        "Check out my professional resume:": "Mira mi currículum profesional:",
        "My Resume": "Mi currículum",
        "PDF download link is not available.": "El enlace de descarga de PDF no está disponible.",
        "Word file link is not available.": "El enlace del archivo Word no está disponible.",
        "Could not open download link.": "No se pudo abrir el enlace de descarga."
    }
}

base_path = "/Users/Apple/Documents/tabashir/tabashir-mobile/assets/translations"

for lang, new_strings in translations.items():
    file_path = os.path.join(base_path, f"{lang}.json")
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        data.update(new_strings)
        
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        print(f"Updated {lang}.json")
    else:
        print(f"File {file_path} not found")
