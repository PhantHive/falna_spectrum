from PIL import Image
import os

input_dir = r'E:\PROG\15-IDL\falna_spectrum\fft_analysis\spectrum'

for name in ['fatigue_fft', 'floor_fft']:
    input_ps = os.path.join(input_dir, f'{name}.ps')
    output_png = os.path.join(input_dir, f'{name}.png')

    os.system(f'gswin64c -dNOPAUSE -dBATCH -sDEVICE=png16m -r150 '
              f'-sOutputFile="{output_png}" "{input_ps}"')

    img = Image.open(output_png)
    img = img.rotate(90, expand=True)
    img.save(output_png)
    print(f'{name}.png saved!')