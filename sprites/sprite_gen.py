from PIL import Image

WIDTH = 64
HEIGHT = 64
img = Image.open("azu_leafeon.jpeg").resize((WIDTH, HEIGHT))
img = img.convert("RGB")

with open("leafeon.mif", "w") as f:

    f.write(f"WIDTH=16;\n")
    f.write(f"DEPTH={WIDTH*HEIGHT};\n\n")

    f.write("ADDRESS_RADIX=UNS;\n")
    f.write("DATA_RADIX=UNS;\n\n")

    f.write("CONTENT BEGIN\n")

    addr = 0

    for y in range(HEIGHT):
        for x in range(WIDTH):

            r, g, b = img.getpixel((x, y))

            # Convertir RGB888 -> RGB565
            r5 = r >> 3
            g6 = g >> 2
            b5 = b >> 3

            value = (r5 << 11) | (g6 << 5) | b5

            f.write(f"{addr} : {value};\n")

            addr += 1

    f.write("END;\n")