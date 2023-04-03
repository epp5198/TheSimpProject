import os
import re

# set the directory containing the files to search
dir_path = r"C:\DIGITs\xmlfiles"

names = ['Homer', 'Marge', 'Bart', 'Lisa', 'Maggie', 'Grandpa', 'Flanders', 'Milhouse', 'Krusty', 'Skinner', 'Moe',
         'Barney', 'Burns', 'Smithers', 'Wiggum', 'Ralph', 'Ned', 'Carl', 'Lenny', 'Apu', 'Sideshow Bob', 'Selma',
         'Patty', 'Nelson', 'Jimbo', 'Kearney', 'Dolph', 'Uter', 'Groundskeeper Willie', 'Dr. Hibbert',
         'Reverend Lovejoy', 'Principal Chalmers', 'Superintendent Chalmers', 'Bumblebee Man', 'Comic Book Guy',
         'Professor Frink', 'Disco Stu', 'Snake', 'Luigi', 'Lou', 'Eddie', 'Mrs. Krabappel', 'Lionel Hutz',
         'Troy McClure', 'Captain McCallister', 'Hans Moleman', 'Judge Snyder', 'Lurleen', 'Maude Flanders', 'Akira',
         'Artie Ziff', 'Brandine', 'Cletus', 'Herman', 'Jasper', 'Kang', 'Kodos', 'Karl', 'Frank Grimes', 'Rex Banner',
         'Ranier Wolfcastle', 'Scratchy', 'Squeaky Voiced Teen', 'Wendell', 'Zelda', 'Jessica Lovejoy',
         'Bleeding Gums Murphy', 'Mona Simpson', 'Herb Powell', 'Dr. Nick', 'Mr. Teeny', 'Gil', 'Fat Tony',
         'Johnny Tightlips', 'The Rich Texan', 'Gabbo', 'Don Brodka', 'Bartman', 'Radioactive Man', 'Itchy', 'Scratchy',
         'Poochie', 'Roy', 'Gerald', 'Fleet-a-Pita guy', 'Gym teacher', 'Crazy Old Man', 'Disgruntled Goat', 'Milhouse']

# construct the regex pattern to match any of the names
pattern = r"\b(" + "|".join(names) + r")\b"

# loop through each file in the directory and replace the names
for filename in os.listdir(dir_path):
    if filename.endswith(".xml"):
        with open(os.path.join(dir_path, filename), "r", encoding="utf8") as file:
            text = file.read()
            replaced_text = re.sub(pattern, r"<person>\g<0></person>", text, flags=re.IGNORECASE)
        with open(os.path.join(dir_path, filename), "w", encoding="utf8") as file:
            file.write(replaced_text)
