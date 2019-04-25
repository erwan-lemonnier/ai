#!/usr/local/bin/python3

from PIL import Image
import logging
import click


@click.command()
@click.option('--input', nargs=2, type=str, help="Path to 2 images to merge")
@click.option('--output', nargs=1, type=str, help="Path to the image to create")
def main(input, output):
    """Merge two pictures into one"""

    assert len(input) == 2, "You must provide 2 image paths (--help for help)"
    assert output, "You must provide an output path (--help for help)"

    images = [Image.open(i) for i in input]
    widths, heights = zip(*(i.size for i in images))

    total_width = sum(widths)
    max_height = max(heights)

    new_im = Image.new('RGB', (total_width, max_height), color='white')

    x_offset = 0
    for im in images:
      new_im.paste(im, (x_offset, 0))
      x_offset += im.size[0]

    print("Saving %s" % output)
    new_im.save(output)


if __name__ == "__main__":
    main()
