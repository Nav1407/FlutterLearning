import os
import sys

if len(sys.argv) != 2:
    print("Usage: python images.py folder_path")
    sys.exit(1)

folder = sys.argv[1]

html_file = open('preview.html', 'w')
html_file.write('<html>\n<body>\n')
html_file.write('<table>\n')

titles = {}
for filename in os.listdir(folder):
    if filename.endswith(".png"):
        file_path = os.path.join(folder, filename)
        title, index, comment = filename.split(" - ")[:3]
        if title not in titles:
            titles[title] = []
        titles[title].append((index, comment, file_path))

for title in sorted(titles.keys()):
    html_file.write(f'<tr><td>{title}</td><table><tr>\n')
    titles[title].sort(key=lambda x: x[0])
    for i, (index, comment, file_path) in enumerate(titles[title]):
        html_file.write(f'<td>{index} - {comment}</td>\n')
    html_file.write('</tr><tr>\n')
    for i, (index, comment, file_path) in enumerate(titles[title]):
        html_file.write(f'<td><img src="{file_path}" alt="{title} - {index} - {comment}.png" /></td>\n')
    html_file.write('</tr></table></tr>\n')

html_file.write('</table>\n')
html_file.write('</body>\n</html>')
html_file.close()