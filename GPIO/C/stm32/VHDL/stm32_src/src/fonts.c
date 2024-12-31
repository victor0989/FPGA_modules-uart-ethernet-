#include <stdint.h>  // Incluir el encabezado para tipos de datos de tamaño fijo
#include "fonts.h"
#include "ssd1306.h"

// Aquí va el código de la función DrawChar y otras funciones...
void DrawChar(uint16_t x, uint16_t y, char c, uint8_t font_size)
{
    uint8_t i, j;
    const uint8_t *font;
    uint8_t char_index = (uint8_t)c;  // Asegurarse de que 'c' sea de tipo uint8_t

    if (font_size == 8)
    {
        font = Font8x8[char_index];  // Fuente de 8x8
    }
    else if (font_size == 16)
    {
        font = Font16x16[char_index];  // Fuente de 16x16
    }
    else
    {
        return;  // Si el tamaño no es reconocido, salimos
    }

    // Dibuja el carácter píxel por píxel
    for (i = 0; i < font_size; i++)
    {
        for (j = 0; j < 8; j++)
        {
            if (font[i] & (1 << j))  // Verifica si el bit está encendido
            {
                SSD1306_DrawPixel(x + j, y + i, 1);  // Dibuja el píxel en la pantalla
            }
        }
    }
}


