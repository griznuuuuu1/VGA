from PIL import Image

img = Image.open("leafeon.png").resize((128, 128))
img = img.convert("RGB")

with open("sprite_pkg.vhd", "w") as f:
    f.write("LIBRARY IEEE;\n")
    f.write("USE IEEE.STD_LOGIC_1164.ALL;\n\n")
    f.write("USE WORK.basic_package.ALL;\n\n")
    f.write("PACKAGE sprite_pkg IS\n\n")
    f.write("    CONSTANT SPRITE : SPRITE_T := (\n")

    for y in range(128):
        f.write("        (\n")
        for x in range(128):
            r, g, b = img.getpixel((x, y))

            f.write(f"            (R => x\"{r:02X}\", G => x\"{g:02X}\", B => x\"{b:02X}\")")

            if x != 127:
                f.write(",\n")
            else:
                f.write("\n")

        if y != 127:
            f.write("        ),\n")
        else:
            f.write("        )\n")

    f.write("    );\n\n")
    f.write("END PACKAGE;\n")