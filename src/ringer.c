#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <string.h>
#include "ringer.h"

static volatile int is_ringing = 0;
static pthread_t ring_thread;

static void gpio_write(const char* pin, const char* value) {
    char path[64];
    snprintf(path, sizeof(path), "/sys/class/gpio/gpio%s/value", pin);
    FILE *fp = fopen(path, "w");
    if (fp) {
        fputs(value, fp);
        fclose(fp);
    } else {
        printf("[RINGER] Error writing in GPIO %s\n", pin);
    }
}

static void* ring_loop(void* arg) {
    while (is_ringing) {
        gpio_write(GPIO_IN1, "1");
        gpio_write(GPIO_IN2, "0");
        usleep(25000); // 25ms

        if (!is_ringing) break;

        gpio_write(GPIO_IN1, "0");
        gpio_write(GPIO_IN2, "1");
        usleep(25000); // 25ms (Total = 50ms = 20Hz)
    }

    gpio_write(GPIO_IN1, "0");
    gpio_write(GPIO_IN2, "0");
    
    return NULL;
}

int ringer_init(void) {
    printf("[RINGER] GPIOs initialized.\n");
    return 0;
}

void ringer_start(void) {
    if (!is_ringing) {
        is_ringing = 1;
        pthread_create(&ring_thread, NULL, ring_loop, NULL);
        printf("[RINGER] ringing!\n");
    }
}

void ringer_stop(void) {
    if (is_ringing) {
        is_ringing = 0;
        pthread_join(ring_thread, NULL);
        printf("[RINGER] stop ringing.\n");
    }
}