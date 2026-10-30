from PIL import Image, ImageDraw, ImageFont

output_mem = "menu_data.mem"
output_preview = "menu_preview_640x128.jpg"
W, H = 640, 128

img = Image.new("RGB", (W, H), (0, 0, 0))
draw = ImageDraw.Draw(img)


def load_font(size):
    candidates = [
        "C:/Windows/Fonts/arialbd.ttf",
        "C:/Windows/Fonts/arial.ttf",
        "C:/Windows/Fonts/calibrib.ttf",
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
        "/System/Library/Fonts/Supplemental/Arial Bold.ttf",
    ]
    for p in candidates:
        try:
            return ImageFont.truetype(p, size=size)
        except Exception:
            pass
    return ImageFont.load_default()

font_title = load_font(32)
font_hint = load_font(24)

def draw_centered(text, y, font, fill, outline=(0, 0, 0)):
    bbox = draw.textbbox((0, 0), text, font=font, stroke_width=2)
    tw = bbox[2] - bbox[0]
    x = (W - tw) // 2
    draw.text((x, y), text, fill=fill, font=font, stroke_width=2, stroke_fill=outline)

# 透明背景规则：黑色 000 在 Verilog 里当透明，所以画布黑色即可。
draw_centered("ZJU_Lowrider Challenge_Lite", 24, font_title, (57, 255, 20))
draw_centered("Press Space to Start", 74, font_hint, (0, 255, 255))

img.save(output_preview)

with open(output_mem, "w", encoding="ascii") as f:
    for y in range(H):
        for x in range(W):
            r, g, b = img.getpixel((x, y))
            r4, g4, b4 = r >> 4, g >> 4, b >> 4
            # BGR444
            f.write(f"{b4:X}{g4:X}{r4:X}\n")

print("done: menu_data.mem generated, 640x128 = 81920 lines")
print(f"preview saved: {output_preview}")
