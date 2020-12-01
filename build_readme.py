import os
import traceback
current_dir =os.path.dirname(os.path.realpath(__file__))

def underscore_to_camelcase(value):
    def camelcase(): 
        yield str.lower
        while True:
            yield str.capitalize

    c = camelcase()
    return "".join(c.__next__()(x) if x else '_' for x in value.split("_"))

def get_lcd_count(search_path):
    count = 0
    for dirpath, dirnames, filenames in os.walk(search_path):
        for index in range(0,10):
            if "LCD%d"%index in dirnames:
                count = index
    return count
            

rows = ""
for directory in os.listdir(os.path.join(current_dir,"coverage_determinations")):
    name = underscore_to_camelcase(directory)
    try:
        for sub_dir in os.listdir(os.path.join(current_dir,"coverage_determinations",directory)):
            if sub_dir not in [".DS_Store"]:
                sub_dir_name = underscore_to_camelcase(sub_dir)
                count = get_lcd_count(os.path.join(current_dir,"coverage_determinations",directory,sub_dir))
                rows += name+"|"+sub_dir_name+"||"+str(count)+"\n"
    except Exception as e:
        print(e)
        traceback.print_exc()
readme_content = """
# Medical Necessity determination.
# NCDs and LCDs

This repository will continue to evolve. We are actively developing various coverage determinations. This repository contains CQL files for prepopulation of questionnaire and also the rules to extract data from FHIR server, data requirements, questionnaires in the form of resources, libraries, associated valuesets, 

You can find CQL logic for decision making too.

We are looking for active contributors, verifiers and testers for this effort.

If interested, please reach out to us. 

Coverage Determinations folder contains the artifacts which will be based on LCD or NCD.

Category|Use Case|NCD|No of LCDs
--------|--------|---|----------
%s

Samples folder contains just examples which can be used as reference only.
"""%(rows)
# print(readme_content)
readme = open(os.path.join(current_dir+"/README.md"), "w")
readme.write(readme_content)
readme.close()
