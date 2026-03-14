import ast
import json

from flask import current_app
from openai import OpenAI

from app.models.cv_models import *


def get_openai_client():
    import os
    from openai import OpenAI
    
    # Read from environment variables with defaults for InceptionLabs AI
    api_key = os.environ.get("LLM_API_KEY", os.environ.get("OPENAI_API_KEY"))
    base_url = os.environ.get("LLM_BASE_URL", "https://api.inceptionlabs.ai/v1")
    model = os.environ.get("LLM_MODEL", "mercury-2")
    
    if not api_key:
        # Fallback to current app config if env vars are missing
        config = current_app.config
        provider = config.get('LLM_PROVIDER', 'openai').lower()

        if provider == 'deepseek':
            return OpenAI(
                api_key=config['DEEPSEEK_API_KEY'],
                base_url="https://api.deepseek.com"
            ), "deepseek-chat"
        else:
            return OpenAI(api_key=config['OPENAI_API_KEY']), "gpt-4o"
        
    client = OpenAI(
        api_key=api_key,
        base_url=base_url
    )
    return client, model

def chat_with_model(messages) -> str:
    """Helper function to create a conversation and get AI-generated responses."""
    client, model = get_openai_client()

    response = client.chat.completions.create(
        model=model,
        messages=messages
    )

    return response.choices[0].message.content


def safe_parse_ai_response(response_str):
    try:
        return ast.literal_eval(response_str)
    except Exception:
        try:
            return json.loads(response_str)
        except Exception as e:
            print(f"Failed to parse AI response:\n{response_str}\nError: {e}")
            return None


def cv_transformer(cv_txt: str) -> str:
    """Transform and enhance CV content using AI."""
    
    # Initialize AI's Personality
    conversation = [
        {"role": "system", "content": """Your job is to rewrite and transform CVs. You will be passed raw text of a CV, your main responsibility is reformulating CVs to maintain the integrity of the original content while making strategic enhancements based on the following requests and return transformed raw text. When adapting Work Experience, Leadership Experience and Projects sections, ensure each contains a minimum of 3 bullet points if there are 3 or more experiences listed. If there are fewer experiences, expand each to at most 5 bullet points to make the CV appear more comprehensive. Your adaptations should prioritize keywords and skills that enhance job market success, emphasizing areas likely to capture an employer's interest. Specifically, for the Skills and Additional Training, mention any skills that are implicitly mentioned, and explicitly state them if they are relevant and can add to the strength of the CV.

        Maintain sections like Career Objective, Education, Work Experience, Leadership Experience, Projects ,Skills and Additional Training and Languages, carefully avoiding the addition of unrequested sections. Your goal is to achieve zero error in formatting and content adaptation, showcasing the user's achievements and skills effectively. Request more information if details are insufficient and ensure the CV is professional and aligned with the template. Your communication should remain formal, focused on precision and adherence to the provided template.

        If you see any leadership-worthy details as you're transforming, mention this under LEADERSHIP EXPERIENCE with the position of leadership, company of leadership, the date, location, and between 3 and 5 details about it. Look for keywords such as "president", "head", "lead", "captain", "manager", "director", "chief", "coordinator", "supervisor", "organizer", "founder", "chair", "representative". 
        
        If you see any project-worthy details as you're transforming, mention this under PROJECTS with the title of the project, the position held, the date, location, and between 3 and 5 details about it. Look for keywords such as "project", "developed", "created", "built", "designed", "implemented", "launched", "initiated", "established", "organized", "managed".

        Remember, feel free to be creative and make the CV as professional as possible.
        
        You must correct any grammatical, spelling, spacing and capitalization mistakes in small details. For example for location, if the raw text says ALAIN or ABUDHABI, you must change this to Al Ain, Abu Dhabi, and so on and so forth. For larger details, if the raw text is unprofessional, upgrade it to a more presentable and professional format.
        """},
    ]

    conversation.append({"role": "assistant", "content": "Certainly! Please provide the CV you'd like me to transform and I'll augment it to a very professional and high standard."})
    
    # Feed it the Entire CV as Raw Text and Let it Understand the Entire CV
    conversation.append({"role": "user", "content": cv_txt})

    # Get Upgraded CV Back and Feed it to CV Formatter
    formatted_cv_text = chat_with_model(conversation)
    print(formatted_cv_text)
    return formatted_cv_text

def cv_formatter(cv_txt: str, translate_to_english=False) -> Resume:
    """Format CV text into structured Resume object."""
    
    # Initialize AI's Personality
    conversation = [
        {"role": "system", "content": """You are a CV-conversion assistant whose job is to take a CV and standardize it in a given format and return it to me in a part-by-part sequential manner. I will pass you an entire CV and you will understand it in whole, then I will pass you the specifics I'd like you to give me which you will professionally paraphrase and return back to me. Don't give me any additional commentary such as "Here is the array", I do not want that, no additional comments as this will break the python script.. Simply pass me the raw array datatype and its contents and I'll handle the rest. Stick to the format I will now specify."""},
    ]
    conversation.append({"role": "assistant", "content": "Certainly! Please provide the CV you'd like me to convert, and let me know the specific format or information you want in each part. Once you've shared the CV, you can also specify how you'd like me to organize and present the information and I will stick to it completely."})
    
    # Feed it the Entire CV as Raw Text and Let it Understand the Entire CV
    conversation.append({"role": "user", "content": cv_transformer(cv_txt)})

    # Translation Layer (if selected to translate the CV from ANY language to English)
    if translate_to_english:
        conversation.append({"role": "assistant", "content": "Would you like me to translate this CV to English?"})
        conversation.append({"role": "user", "content": "Yes, if and only if it is in another language such as Arabic, translate it completely to English and rewrite it such that the grammar, spelling, and capitalization is perfect and remember it as I will pass you more prompts."})

    # Format it Section by Section
    # queries = {
    #     "header": "Return a list of 6 strings that include this person's Name, Email, Phone, Location, LinkedIn, and Github as a list of strings [Name, Email, Phone, Location, LinkedIn, Github]. You will typically find this at the top of the unformatted CV. If any of these fields are empty, return an empty string for that field. Be smart, the CV may not be labelled very well so find the section that matches this. If this entire section is empty, just return one big empty list: []. Make sure to close all parentheses properly.",
    #     "objective": "Extract the career objective or professional summary from the following CV text, dont mention any slashes or hyphens in the string of text. replace any ' with ' and any " or " with double quotation and any \\n with nothing and any '-' with nothing in the text Focus on identifying the section where the candidate describes their career goals, aspirations, or the type of position they are seeking. If no clear career objective is found, summarize any section that outlines the candidate's professional goals. Ensure that the output includes only relevant information, excluding unrelated content normalized_text.",
    #     "education": "For each education experience, return each individual education as a sublist of 8 strings that include this person's University, Location, Date, Major, Degree, GPA as a number in a string format, a sublist of that education Coursework as a list of strings, and a sublist of that education's Details as a list of strings and a sublist as such: [University, Location, Date, Major, Degree, GPA, Coursework, Details]. Absolutely do NOT mention GPA/grade, location, university or date in the details section as these are already mentioned. Try to extract any other relevant details, you must not put GPA or anything else previously mentioned in details. The GPA/grade must be mentioned in the GPA section and don't add any '%' or any labels, you must return the GPA/grade as a number formatted in a string, don't return the GPA as a text grade like good or excellent, it must be a number. For the major section, make sure to mention the major type and major name. For instance,If you can't find a major name, come up with one that is relevant to it, don't leave the 'Major' field empty. For the degree mention High School/Diploma/Bachelors/High School Diploma/Masters/PhD in XYZ without mentioning major just degree Like High School/Diploma/Bachelors/High School Diploma/Masters/PhD. For the coursework section, if you can't explicitly extract any relevant coursework, use the major and your knowledge to list common courses that would definitely be taken. If any of these fields are empty, return an empty string for that field. Be smart, the CV may not be labelled very well so find the section that matches this. If you see anything related to military service, include it here and then university would just become 'Military Service' for instance. Then, put all the sublists in one master list and return them. If this entire section is empty, just return one big empty list: []. For the GPA, just extract the raw number, don't return any text/string data along with it, if the GPA says Very Good/Good/any adjective, just return an empty string. If no location is mentioned, use your knowledge and context clues to come up with city location for the institution. Make sure to close all parentheses properly.",
    #     "work": "For their work experience, return each individual work experience as a sublist of 5 strings that include this person's Company/organization, Position, Date, Location, and a sublist of the Work Experience Details (there absolutely MUST be at least 3 details we can write them as three bullet points to five bullet points not less than three, if you can find more details then mention as many relevant and important ones as you can based on the CV) as a list of strings and a sublist as such: [Company, Position, Date, Location, [Details]]. Absolutely do NOT mention company, position, location or date in the details section as these are already mentioned. Then, put all the sublists in one master list and return them. You will typically find the information needed for this in the Work Experience section of the unformatted CV. Be smart, the CV may not be labelled very well so find the section that matches this. Remember, military service is to be included in education, not in work experience. You might find the Company/Organization name inside of the work position, if so add the Company/Organization name as a Company/Organization name. Remember, there absolutely has to be between 3 and 5 detail entries for each work experience. If this entire section is empty, just return one big empty list: []. If no location is mentioned, use your knowledge and context clues to come up with city/country location for the workplace. Make sure to include any sort of experience such as volunteering here as well as regular work experiences. Make sure to close all parentheses properly.",
    #     "projects": "For their projects, return each individual project as a sublist of 5 strings that include this person's Title, Position, Date, Location, and a sublist of the Details (there absolutely MUST be at least 3 details, if you can find more details then mention as many relevant and important ones as you can based on the CV) as a list of strings and a sublist as such: [Title, Position, Date, Location, [Details]]. Absolutely do NOT mention title, position, location or date in the details section as these are already mentioned. Then, put all the sublists in one master list and return them. You will typically find the information needed for this in the Projects section of the unformatted CV. Be smart, the CV may not be labelled very well so find the section that matches this. If this entire section is empty, just return one big empty list: []. If no location is mentioned, use your knowledge and context clues to come up with city/country location for the project. Make sure to close all parentheses properly.",
    #     "lship": "For their leadership skills/positions, return each leadership position as a sublist of 5 strings that include this person's Company, Position, Date, Location, and a sublist of the Details (there absolutely MUST be at least 3 details, if you can find more details then mention as many relevant and important ones as you can based on the CV) as a list of strings and a sublist as such: [Company, Position, Date, Location, [Details]]. Absolutely do NOT mention company, position, location or date in the details section as these are already mentioned. Do NOT repeat work experience as leadership, make sure there are no identical responses to work experience and leadership experience. Then, put all the sublists in one master list and return them. Look for keywords (specifically in position names) about leadership such as head, chair, leader, lead, manager, president, mentor, coach, etc. Be smart, the CV may not be labelled very well so find the section that matches this. Look for anything related to any degree of leadership from the work experience and education sections as well and extract them here. If this entire section is empty, just return one big empty list: []. If no location is mentioned, use your knowledge and context clues to come up with city/country location for the position. Make sure to close all parentheses properly.",
    #     "skills": "Extract the key skills and training details from the CV's work and educational experiences and organize them into a list with three sublists. The first sublist should contain soft skills, which are general personality traits such as communication, teamwork, or leadership must be at least 5 bullet points. The second sublist should only contain hard and research skills, which are job-specific and academia-specific abilities acquired through education and training must be at least 5 bullet points. Do NOT include soft skills in this sublist. The third sublist should contain training details, including any and all workshops, certifications, and training details you can extract from the CV. Be creative, as training details are essential and you MUST return them. Each sublist should contain the relevant skills or training details as separate string elements, formatted as simple bullet points without additional nesting. If there is no information available for any of the categories (soft skills, hard/research skills, or training), the corresponding sublist should be empty. The main list should never be nested more than two levels deep. If there are no skills or training details available, return an empty list: []. Make sure to close all parentheses properly.",        
    #     "languages": "Extract the languages that the candidate is proficient in from the following CV text. Focus on identifying any section where the candidate mentions language skills, including fluency levels such as native, fluent, intermediate, or beginner. If no specific section exists, identify any mention of languages throughout the text.",
    #     "keywords": "Extract the 25 main keywords from this person's CV related ONLY to hard, working skills, positions, and abilities as a list [Keyword1, Keyword2, Keyword3, ...]. These keywords should be extracted from the Work Experience, Leadership Experience, Projects, and Skills sections of the CV. Examples of keywords/phrases include: Engineer, Doctor, AI, AutoCAD, Matlab, Excel, Microsoft Office, ISO Certifications, etc... Make sure to close all parentheses properly and return 25 Keywords, you can be creative."
    # }
    queries = {
        "header": "Extract ONLY the contact information that is explicitly mentioned in this CV. Return a list of 7 strings: [Name, Email, Phone, Location, LinkedIn, Github, Nationality]. CRITICAL: If LinkedIn or Github URLs are NOT explicitly mentioned in the CV, return empty string "" for those fields. DO NOT create or assume LinkedIn/Github profiles. Only extract what is actually written in the CV text. If any field is missing, return empty string for that position.",
        "objective": "Extract the career objective or professional summary from the following CV text, dont mention any slashes or hyphens in the string of text. replace any ' with ' and any " or " with double quotation and any \\n with nothing and any '-' with nothing in the text Focus on identifying the section where the candidate describes their career goals, aspirations, or the type of position they are seeking. If no clear career objective is found, summarize any section that outlines the candidate's professional goals. Ensure that the output includes only relevant information, excluding unrelated content normalized_text.",
        "education": "For each education experience, return each individual education as a sublist of 8 strings that include this person's University, Location, Date, Major, Degree, GPA as a number in a string format, a sublist of that education Coursework as a list of strings, and a sublist of that education's Details as a list of strings and a sublist as such: [University, Location, Date, Major, Degree, GPA, Coursework, Details]. Absolutely do NOT mention GPA/grade, location, university or date in the details section as these are already mentioned. Try to extract any other relevant details, you must not put GPA or anything else previously mentioned in details. The GPA/grade must be mentioned in the GPA section and don't add any '%' or any labels, you must return the GPA/grade as a number formatted in a string, don't return the GPA as a text grade like good or excellent, it must be a number. For the major section, make sure to mention the major type and major name. For instance,If you can't find a major name, come up with one that is relevant to it, don't leave the 'Major' field empty. For the degree mention High School/Diploma/Bachelors/High School Diploma/Masters/PhD in XYZ without mentioning major just degree Like High School/Diploma/Bachelors/High School Diploma/Masters/PhD. For the coursework section, if you can't explicitly extract any relevant coursework, use the major and your knowledge to list common courses that would definitely be taken. If any of these fields are empty, return an empty string for that field. Be smart, the CV may not be labelled very well so find the section that matches this. If you see anything related to military service, include it here and then university would just become 'Military Service' for instance. Then, put all the sublists in one master list and return them. If this entire section is empty, just return one big empty list: []. For the GPA, just extract the raw number, don't return any text/string data along with it, if the GPA says Very Good/Good/any adjective, just return an empty string. If no location is mentioned, use your knowledge and context clues to come up with city location for the institution. Make sure to close all parentheses properly.",
        "work": "For their work experience, return each individual work experience as a sublist of 5 strings that include this person's Company/organization, Position, Date, Location, and a sublist of the Work Experience Details (there absolutely MUST be at least 3 details we can write them as three bullet points to five bullet points not less than three, if you can find more details then mention as many relevant and important ones as you can based on the CV) as a list of strings and a sublist as such: [Company, Position, Date, Location, [Details]]. Absolutely do NOT mention company, position, location or date in the details section as these are already mentioned. Then, put all the sublists in one master list and return them. You will typically find the information needed for this in the Work Experience section of the unformatted CV. Be smart, the CV may not be labelled very well so find the section that matches this. Remember, military service is to be included in education, not in work experience. You might find the Company/Organization name inside of the work position, if so add the Company/Organization name as a Company/Organization name. Remember, there absolutely has to be between 3 and 5 detail entries for each work experience. If this entire section is empty, just return one big empty list: []. If no location is mentioned, use your knowledge and context clues to come up with city/country location for the workplace. Make sure to include any sort of experience such as volunteering here as well as regular work experiences. Make sure to close all parentheses properly.",
        "projects": "For their projects, return each individual project as a sublist of 5 strings that include this person's Title, Position, Date, Location, and a sublist of the Details (there absolutely MUST be at least 3 details, if you can find more details then mention as many relevant and important ones as you can based on the CV) as a list of strings and a sublist as such: [Title, Position, Date, Location, [Details]]. Absolutely do NOT mention title, position, location or date in the details section as these are already mentioned. Then, put all the sublists in one master list and return them. You will typically find the information needed for this in the Projects section of the unformatted CV. Be smart, the CV may not be labelled very well so find the section that matches this. If this entire section is empty, just return one big empty list: []. If no location is mentioned, use your knowledge and context clues to come up with city/country location for the project. Make sure to close all parentheses properly.",
        "lship": "For their leadership skills/positions, return each leadership position as a sublist of 5 strings that include this person's Company, Position, Date, Location, and a sublist of the Details (there absolutely MUST be at least 3 details, if you can find more details then mention as many relevant and important ones as you can based on the CV) as a list of strings and a sublist as such: [Company, Position, Date, Location, [Details]]. Absolutely do NOT mention company, position, location or date in the details section as these are already mentioned. Do NOT repeat work experience as leadership, make sure there are no identical responses to work experience and leadership experience. Then, put all the sublists in one master list and return them. Look for keywords (specifically in position names) about leadership such as head, chair, leader, lead, manager, president, mentor, coach, etc. Be smart, the CV may not be labelled very well so find the section that matches this. Look for anything related to any degree of leadership from the work experience and education sections as well and extract them here. If this entire section is empty, just return one big empty list: []. If no location is mentioned, use your knowledge and context clues to come up with city/country location for the position. Make sure to close all parentheses properly.",
        "skills": "Extract the key skills and training details from the CV's work and educational experiences and organize them into a list with three sublists. The first sublist should contain soft skills, which are general personality traits such as communication, teamwork, or leadership must be at least 5 bullet points. The second sublist should only contain hard and research skills, which are job-specific and academia-specific abilities acquired through education and training must be at least 5 bullet points. Do NOT include soft skills in this sublist. The third sublist should contain training details, including any and all workshops, certifications, and training details you can extract from the CV. Be creative, as training details are essential and you MUST return them. Each sublist should contain the relevant skills or training details as separate string elements, formatted as simple bullet points without additional nesting. If there is no information available for any of the categories (soft skills, hard/research skills, or training), the corresponding sublist should be empty. The main list should never be nested more than two levels deep. If there are no skills or training details available, return an empty list: []. Make sure to close all parentheses properly.",        
        "languages": "Extract the languages that the candidate is proficient in from the following CV text. Focus on identifying any section where the candidate mentions language skills, including fluency levels such as native, fluent, intermediate, or beginner. If no specific section exists, identify any mention of languages throughout the text.",
        "keywords": "Extract the 25 main keywords from this person's CV related ONLY to hard, working skills, positions, and abilities as a list [Keyword1, Keyword2, Keyword3, ...]. These keywords should be extracted from the Work Experience, Leadership Experience, Projects, and Skills sections of the CV. Examples of keywords/phrases include: Engineer, Doctor, AI, AutoCAD, Matlab, Excel, Microsoft Office, ISO Certifications, etc... Make sure to close all parentheses properly and return 25 Keywords, you can be creative."
    }

    for key in queries:
        conversation.append({"role": "user", "content": queries[key]})
        formatted_query_data = chat_with_model(conversation)
        conversation.append({"role": "assistant", "content": formatted_query_data})
        queries[key] = safe_parse_ai_response(formatted_query_data)
        print(f"{key}: {formatted_query_data}")

    # Create Each Individual Section as an Object
    print("Formulating Header Section") 
    if queries["header"]:
        header = Header(name=queries["header"][0].upper(),
                        email=queries["header"][1],
                        phone=queries["header"][2],
                        location=queries["header"][3],
                        linkedin=queries["header"][4],
                        github=queries["header"][5],
                        nationality=queries["header"][6])
    else:
        header = None

    print("Formulating CareerObjective Section") 
    if queries["objective"]:
        objective = CareerObjective(objective=queries["objective"])
    else:
        objective = None    
        
    print("Formulating Education Section")
    if queries["education"]:
        education = []
        for educ in queries["education"]:
            education.append(EducationExperience(university=educ[0],
                                        location=educ[1],
                                        date=educ[2],
                                        major=educ[3],
                                        degree=educ[4],
                                        GPA=educ[5],
                                        coursework=educ[6],
                                        details=educ[7]))
    else:
        education = None
        
    print("Formulating Work Section")
    if queries["work"]:
        work = []
        for work_exp in queries["work"]:
            work.append(WorkAndLeadershipExperience(company=work_exp[0],
                                            position=work_exp[1],
                                            date=work_exp[2],
                                            location=work_exp[3],
                                            details=work_exp[4]))
    else:
        work = None
        
    print("Formulating Projects Section")
    if queries["projects"]:
        projects = []
        for project in queries["projects"]:
            projects.append(Project(title=project[0],
                                position=project[1],
                                date=project[2],
                                location=project[3],
                                details=project[4]))
    else:
        projects = None
        
    print("Formulating Leadership Section")
    if queries["lship"]:
        lship = []
        for leadership in queries["lship"]:
            lship.append(WorkAndLeadershipExperience(company = leadership[0],
                                            position = leadership[1],
                                            date = leadership[2],
                                            location = leadership[3],
                                            details = leadership[4]))
            
        for work_entry in work: # If lship and work have any "copy/paste" instances, remove them from lship (prioritize work experience over leadership experience)
            for lship_entry in lship:
                if lship_entry == work_entry:
                    lship.remove(lship_entry)
            
        if work == []: # If there are 0 work experiences, leadership experiences become work experiences (as they are technically the same thing)
            work = lship
            lship = None
    else:
        lship = []
    
    print("Formulating Skills Section")
    if queries["skills"]:
        skills = Skills(softskills = queries["skills"][0],
                        skillset  = queries["skills"][1],
                        training  = queries["skills"][2])
    else:
        skills = None
    print("Formulating Languages Section")
    if queries["languages"]:
        languages = Languages(langs = queries["languages"])
    else:
        languages = None     

    print("Formulating Keywords Section")
    if queries["keywords"]:
        keywords = queries["keywords"]
    else:
        keywords = None
    
    print("Returning Resume Object to Function Caller")
    # Arrange all Objects into a Single Formatted Resume Object and reutrn to Caller
    return Resume(header = header, objective = objective, work = work, education = education, skills = skills,languages = languages, lship = lship, projects = projects, keywords = keywords)
