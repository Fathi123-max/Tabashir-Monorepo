from PIL import Image
import collections

def get_dominant_colors(image_path, num_colors=5):
    img = Image.open(image_path)
    img = img.convert('RGB')
    img = img.resize((100, 100)) # Resize for faster processing
    pixels = list(img.getdata())
    
    color_counts = collections.Counter(pixels)
    most_common = color_counts.most_common(num_colors)
    
    return [('#%02x%02x%02x' % c[0]).upper() for c in most_common]

if __name__ == "__main__":
    path = "/Users/Apple/Documents/tabashir/tabashir-mobile/assets/images/logo_light.png"
    colors = get_dominant_colors(path)
    print(f"Dominant colors: {colors}")
