import json
from jsonmerge import merge
from collections import OrderedDict

file1="/opt/dev/mybots/BOTS"
file2="/opt/intelmq/intelmq/bots/BOTS"


with open(file1, 'r') as f:
    j1 = json.load(f)
with open(file2, 'r') as f:
    j2 = json.load(f)

def sortOD(od):
    res = OrderedDict()
    for k, v in sorted(od.items()):
        if isinstance(v, dict):
            res[k] = sortOD(v)
        else:
            res[k] = v
    return res


merged = sortOD(merge(j1,j2))

desired_order_list = ['Collector', 'Parser', 'Expert', 'Output']
reordered_dict = {k: merged[k] for k in desired_order_list}

reordered_dict.update({k: merged[k] for k in merged.keys() - desired_order_list})

with open(file2, 'w') as f:
    json.dump(reordered_dict, f, indent=4)

