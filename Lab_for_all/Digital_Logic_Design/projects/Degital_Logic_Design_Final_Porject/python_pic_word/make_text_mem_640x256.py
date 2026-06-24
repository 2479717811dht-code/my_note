from PIL import Image, ImageDraw, ImageFont

output_mem = "text_data.mem"
output_preview = "text_preview_640x256.png"
W, H = 640, 256
PAGE_H = 128

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

font_big = load_font(48)
font_small = load_font(24)

def draw_centered(text, y, font, fill, outline=(0, 0, 0), stroke=2):
    bbox = draw.textbbox((0, 0), text, font=font, stroke_width=stroke)
    tw = bbox[2] - bbox[0]
    x = (W - tw) // 2
    draw.text((x, y), text, fill=fill, font=font, stroke_width=stroke, stroke_fill=outline)

# 0~127 行：胜利画面
draw_centered("MISSION PASSED", 24, font_big, (0, 255, 0))
draw_centered("Challenge Complete", 82, font_small, (255, 255, 255), stroke=1)

# 128~255 行：失败画面
draw_centered("MISSION FAILED", 128 + 24, font_big, (255, 0, 0))
draw_centered("Try Again", 128 + 82, font_small, (255, 255, 255), stroke=1)

img.save(output_preview)

with open(output_mem, "w", encoding="ascii") as f:
    for y in range(H):
        for x in range(W):
            r, g, b = img.getpixel((x, y))
            r4, g4, b4 = r >> 4, g >> 4, b >> 4
            # BGR444
            f.write(f"{b4:X}{g4:X}{r4:X}\n")

print("done: text_data.mem generated, 640x256 = 163840 lines")
print(f"preview saved: {output_preview}")
