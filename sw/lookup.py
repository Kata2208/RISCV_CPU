import sys, bisect

def load(path):
    funcs = []
    for line in open(path):
        p = line.split()
        if len(p) == 4 and p[2] in "Tt":
            funcs.append((int(p[0], 16), int(p[1], 16), p[3]))
    return sorted(funcs)

def lookup(funcs, pc):
    starts = [f[0] for f in funcs]
    i = bisect.bisect_right(starts, pc) - 1
    if i >= 0 and pc < funcs[i][0] + funcs[i][1]:
        return funcs[i][2]
    return None

funcs = load(sys.argv[1])
with open("funcs.txt", "w") as out:
    for a, s, n in funcs:
        out.write(f"{a:08x} {s:08x} {n}\n")

for pc in (0x24, 0x68, 0x7c, 0xb8, 0xd0):
    print(f"{pc:#06x} -> {lookup(funcs, pc)}")
