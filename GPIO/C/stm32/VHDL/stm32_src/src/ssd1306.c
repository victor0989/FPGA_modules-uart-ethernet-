#include "ssd1306.h"
#include "stm32f1xx_hal.h"

// Buffer for the display
static uint8_t SSD1306_Buffer[SSD1306_WIDTH * SSD1306_HEIGHT / 8];

// Display state
static uint8_t SSD1306_DisplayOn = 0;

// I2C handle extern declaration
extern I2C_HandleTypeDef hi2c1;

// Internal prototype to send data via I2C
static void SSD1306_WriteCommand(uint8_t command);
static void SSD1306_WriteData(uint8_t data);

void SSD1306_Init(void) {
    // Wait for the device to stabilize after power-up
    HAL_Delay(100);

    // Initialize the SSD1306 with a series of commands
    SSD1306_WriteCommand(0xAE); // Display OFF
    SSD1306_WriteCommand(0xD5); // Set Display Clock Divisor
    SSD1306_WriteCommand(0x80); // Default Clock Divisor
    SSD1306_WriteCommand(0xA8); // Set Multiplex Ratio
    SSD1306_WriteCommand(SSD1306_HEIGHT - 1); // Multiplex Ratio for 64 rows
    SSD1306_WriteCommand(0xD3); // Set Display Offset
    SSD1306_WriteCommand(0x00); // No offset
    SSD1306_WriteCommand(0x40); // Set Display Start Line to 0
    SSD1306_WriteCommand(0x8D); // Enable charge pump regulator
    SSD1306_WriteCommand(0x14); // Enable charge pump
    SSD1306_WriteCommand(0x20); // Set Memory Addressing Mode
    SSD1306_WriteCommand(0x00); // Horizontal addressing mode
    SSD1306_WriteCommand(0xA1); // Set Segment Re-map to 127
    SSD1306_WriteCommand(0xC8); // Set COM Output Scan Direction
    SSD1306_WriteCommand(0xDA); // Set COM Pins Hardware Configuration
    SSD1306_WriteCommand(0x12); // Alternative COM pin config
    SSD1306_WriteCommand(0x81); // Set Contrast Control
    SSD1306_WriteCommand(0xCF); // Contrast value
    SSD1306_WriteCommand(0xD9); // Set Pre-charge Period
    SSD1306_WriteCommand(0xF1); // Pre-charge period
    SSD1306_WriteCommand(0xDB); // Set VCOMH Deselect Level
    SSD1306_WriteCommand(0x40); // VCOMH level
    SSD1306_WriteCommand(0xA4); // Resume to RAM content display
    SSD1306_WriteCommand(0xA6); // Normal display mode
    SSD1306_WriteCommand(0xAF); // Display ON

    // Clear the display buffer
    SSD1306_Clear();
    SSD1306_UpdateScreen();
}

void SSD1306_Clear(void) {
    // Clear the buffer
    for (uint16_t i = 0; i < sizeof(SSD1306_Buffer); i++) {
        SSD1306_Buffer[i] = 0x00;
    }
}

void SSD1306_UpdateScreen(void) {
    // Send the buffer to the display
    for (uint8_t page = 0; page < SSD1306_HEIGHT / 8; page++) {
        SSD1306_WriteCommand(0xB0 + page); // Set page address
        SSD1306_WriteCommand(0x00);       // Set lower column address
        SSD1306_WriteCommand(0x10);       // Set higher column address

        // Write the data for this page
        for (uint8_t col = 0; col < SSD1306_WIDTH; col++) {
            SSD1306_WriteData(SSD1306_Buffer[page * SSD1306_WIDTH + col]);
        }
    }
}

void SSD1306_DrawPixel(uint8_t x, uint8_t y, uint8_t color) {
    if (x >= SSD1306_WIDTH || y >= SSD1306_HEIGHT) {
        return; // Out of bounds
    }

    if (color) {
        SSD1306_Buffer[x + (y / 8) * SSD1306_WIDTH] |= (1 << (y % 8));
    } else {
        SSD1306_Buffer[x + (y / 8) * SSD1306_WIDTH] &= ~(1 << (y % 8));
    }
}

// Internal function to send a command
static void SSD1306_WriteCommand(uint8_t command) {
    uint8_t data[2];
    data[0] = SSD1306_COMMAND;
    data[1] = command;
    HAL_I2C_Master_Transmit(&hi2c1, SSD1306_I2C_ADDR, data, 2, 100);
}

// Internal function to send data
static void SSD1306_WriteData(uint8_t data) {
    uint8_t buf[2];
    buf[0] = SSD1306_DATA;
    buf[1] = data;
    HAL_I2C_Master_Transmit(&hi2c1, SSD1306_I2C_ADDR, buf, 2, 100);
}
