import os
import traceback
current_dir =os.path.dirname(os.path.realpath(__file__))

def getTitle(value):
    items = value.split("_")
    res = ""
    for item in items:
        title_str = item.title()
        if title_str.lower() in ["and"]:
            res += title_str.lower()+" "
        else:
            res += title_str+" "


    return res

def get_lcd_count(search_path):
    count = 0
    for dirpath, dirnames, filenames in os.walk(search_path):
        for index in range(0,10):
            if "LCD%d"%index in dirnames:
                count = index
    return count
            

rows = ""
for directory in os.listdir(os.path.join(current_dir,"coverage_determinations")):
    name = getTitle(directory)
    try:
        for sub_dir in os.listdir(os.path.join(current_dir,"coverage_determinations",directory)):
            if sub_dir not in [".DS_Store"]:
                sub_dir_name = getTitle(sub_dir)
                count = get_lcd_count(os.path.join(current_dir,"coverage_determinations",directory,sub_dir))
                rows += name+"|"+sub_dir_name+"||"+str(count)+"\n"
    except Exception as e:
        print(e)
        traceback.print_exc()


# print(readme_content)
readme = open(os.path.join(current_dir+"/README.md"), "r")
data = readme.read()
table_index = data.find("Category|Use Case|NCD|No of LCDs")
readme_content = data[:table_index]
readme.close()
readme_content += """
Category|Use Case|NCD|No of LCDs
--------|--------|---|----------
%s

Samples folder contains just examples which can be used as reference only.
"""%(rows)
print(readme_content)
readme = open(os.path.join(current_dir+"/README.md"), "w")
readme.write(readme_content)
readme.close()
