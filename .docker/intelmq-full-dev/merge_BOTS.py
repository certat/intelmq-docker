import json
from jsonmerge import merge
import argparse
from collections import OrderedDict

parser = argparse.ArgumentParser(description='Merge two json.')
parser.add_argument('input_file_1', type=str, help='input_file_1')
parser.add_argument('input_file_2', type=str, help='input_file_2')
parser.add_argument('output_file', type=str, help='output_file')

args = parser.parse_args()

with open(args.input_file_1, 'r') as f:
    j1 = json.load(f)
with open(args.input_file_2, 'r') as f:
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

# add other keys
reordered_dict.update({k: merged[k] for k in merged.keys() - desired_order_list})

with open(args.output_file, 'w') as f:
    json.dump(reordered_dict, f, indent=4)
   