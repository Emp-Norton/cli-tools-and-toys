import sys
from PIL import Image

ASCII_CHARS = "MN@8%#*+=-:. "

def resize_image(image, new_width=100):
    """Resize image to new width while maintaining aspect ratio."""
    width, height = image.size
    aspect_ratio = height / width
    new_height = int(new_width * aspect_ratio * 0.55)  # Adjust for font aspect ratio
    return image.resize((new_width, new_height))

def image_to_grayscale(image):
    """Convert image to grayscale."""
    return image.convert("L")


def map_pixels_to_ascii(image):
    """Map each pixel to an ASCII character based on intensity."""
    pixels = image.getdata()
    ascii_str = "".join([ASCII_CHARS[min(pixel // 25, len(ASCII_CHARS) - 1)] for pixel in pixels])
    return ascii_str


def generate_ascii_art(image_path, width=100):
    """Convert image at image_path to ASCII art."""
    try:
        image = Image.open(image_path)
    except Exception as e:
        print(f"Error opening image: {e}")
        return

    image = resize_image(image, new_width=width)
    grayscale_image = image_to_grayscale(image)
    ascii_str = map_pixels_to_ascii(grayscale_image)

    ascii_art = "\n".join(
        [ascii_str[i:i + width] for i in range(0, len(ascii_str), width)]
    )
    return ascii_art

def main():
    if len(sys.argv) < 2:
        print("Try this: python3 img_to_ascii.py <image_path> <? width ?>")
        return
    image_path = sys.argv[1]
    width = int(sys.argv[2]) if len(sys.argv) > 2 else 100
    ascii_art = generate_ascii_art(image_path, width)
    if ascii_art:
        print(ascii_art)

if __name__ == "__main__":
    main()

