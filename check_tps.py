import io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
lines = open(r'E:\PracticeProjec\dsalgofrog\src\pages\index.astro', encoding='utf-8').readlines()
for i, l in enumerate(lines):
    if 'id="tp' in l:
        print(i+1, l.strip()[:80])
