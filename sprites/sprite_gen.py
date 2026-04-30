from PIL import Image

WIDTH = 128
HEIGHT = 128

img = Image.open("leafeon.png").resize((WIDTH, HEIGHT))
img = img.convert("RGB")

with open("sprite.mif", "w") as f:
    f.write(f"WIDTH=24;\n")
    f.write(f"DEPTH={WIDTH*HEIGHT};\n\n")

    f.write("ADDRESS_RADIX=UNS;\n")
    f.write("DATA_RADIX=UNS;\n\n")
    f.write("CONTENT BEGIN\n")

    addr = 0
    for y in range(HEIGHT):
        for x in range(WIDTH):
            r, g, b = img.getpixel((x, y))

            value = (r << 16) | (g << 8) | b

            f.write(f"{addr} : {value};\n")
            addr += 1

    f.write("END;\n")