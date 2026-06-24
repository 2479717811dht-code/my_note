from PIL import Image

input_image = "background.jpg"
output_mem = "bg_data.mem"
W, H = 640, 480

img = Image.open(input_image).convert("RGB")
img = img.resize((W, H))

with open(output_mem, "w", encoding="ascii") as f:
    for y in range(H):
        for x in range(W):
            r, g, b = img.getpixel((x, y))
            r4, g4, b4 = r >> 4, g >> 4, b >> 4
            # 你的 VGA_Driver 是 BGR444: [11:8]=B, [7:4]=G, [3:0]=R
            f.write(f"{b4:X}{g4:X}{r4:X}\n")

print("done: bg_data.mem generated, 640x480 = 307200 lines")
