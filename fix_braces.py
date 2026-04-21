# -*- coding: utf-8 -*-
import io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
path = r"E:\PracticeProjec\dsalgofrog\src\pages\index.astro"

with open(path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

in_style = False
in_script = False
fixed_count = 0
out = []

for i, line in enumerate(lines):
    ls = line.lower()

    # Track opening/closing of style and script blocks
    if '<style' in ls:
        in_style = True
    if '</style>' in ls:
        in_style = False
        out.append(line)
        continue
    if '<script' in ls:
        in_script = True
    if '</script>' in ls:
        in_script = False
        out.append(line)
        continue

    if not in_style and not in_script and ('{' in line or '}' in line):
        new_line = line.replace('{', '&#123;').replace('}', '&#125;')
        if new_line != line:
            print('Line', i+1, ':', line.strip()[:80])
            fixed_count += 1
        out.append(new_line)
    else:
        out.append(line)

print('Total lines fixed:', fixed_count)

with open(path, 'w', encoding='utf-8') as f:
    f.writelines(out)

print('Done.')
