#!/usr/bin/env python3

import os
import sys
import argparse
import re
import math
from PIL import Image


parser = argparse.ArgumentParser(
    description='merges animation sprites that ends with frame numbers')
parser.add_argument('-d', '--directory', required=True,
                    help='directory where animation sprites are located')
parser.add_argument('-o', '--output', required=True,
                    help='directory to output merged animation sprites')
parser.add_argument('-c', '--columns', type=int, default=-1,
                    help='max number of columns')

args = parser.parse_args()

def get_sprite_num(sprite_name):
    result = re.findall('[0-9]+', sprite_name)
    if len(result) == 0:
        return sys.maxsize
    return int(result[-1])

def group_sprites(dir):
    groups = {}
    for entry in os.scandir(dir):
        if entry.name.endswith('.png'):
            pattern = re.compile(r"(-)?\d+\.png$")
            prefix = pattern.split(entry.name)[0]
            if prefix.endswith('_'):
                prefix = prefix[:-1]

            if groups.get(prefix) is None:
                groups[prefix] = []

            groups[prefix].append(entry.path)

            groups[prefix] = sorted(groups[prefix], key=lambda e: (get_sprite_num(e), e))
    return groups

def merge_images(images, max_columns=-1, use_max_sizes=False, gap=0):
    imgs = [Image.open(i) for i in images if i.endswith('.png')]
    if len(imgs) == 0: return None

    widths, heights = zip(*(i.size for i in imgs))

    width = max(widths)
    height = max(heights)

    if not use_max_sizes:
        for w in widths:
            if w != width:
                print('Width of one image is not the same', widths)
                exit()

        for h in heights:
            if h != height:
                print('Height of one image is not the same', heights)
                exit()

    rows = 1
    col_count = len(imgs) if max_columns == -1 else min(max_columns, len(imgs))
    total_width = (col_count * width) + ((col_count-1) * gap)

    if max_columns != -1:
        rows = math.ceil(len(images) / max_columns)

    max_height = (rows * height) + ((rows-1) * gap)
    new_im = Image.new('RGBA', (total_width, max_height))

    print(str(width) + 'x' + str(height) + ', ' +
          str(total_width) + 'x' + str(max_height) + ', Gap: ' + str(gap))

    x_offset = 0
    y_offset = 0
    for im in imgs:
        missing_width = width - im.size[0]
        left_width = math.floor(missing_width / 2)
        new_im.paste(im, (x_offset + left_width, y_offset))
        x_offset += width + gap
        if x_offset >= total_width:
            x_offset = 0
            y_offset += im.size[1] + gap

    return new_im



DIR = args.directory
OUTPUT = args.output
GROUPS = group_sprites(DIR)

for key in GROUPS:
    new_img = merge_images(GROUPS[key], args.columns)
    
    file_name= key
    if not file_name.endswith('.png'):
        file_name = f'{file_name}.png'
    new_img.save(OUTPUT + '/' + file_name)

