#ifndef __SSD1306_H
#define __SSD1306_H

#include "stm32f1xx_hal.h"

// Definiciones de la dirección I2C del SSD1306 (por defecto 0x78 para dirección 0x3C)
#define SSD1306_I2C_ADDR      0x78
#define SSD1306_WIDTH          128
#define SSD1306_HEIGHT         64

// Comandos del SSD1306
#define SSD1306_COMMAND        0x00
#define SSD1306_DATA           0x40

// Inicialización del SSD1306
void SSD1306_Init(void);
void SSD1306_Clear(void);
void SSD1306_UpdateScreen(void);
void SSD1306_DrawPixel(uint8_t x, uint8_t y, uint8_t color);
void SSD1306_DrawChar(uint8_t x, uint8_t y, char c, uint8_t size);
void SSD1306_DrawString(uint8_t x, uint8_t y, char *str, uint8_t size);

#endif /* __SSD1306_H */
