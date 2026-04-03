#ifndef RINGER_H
#define RINGER_H

// change
#define GPIO_IN1 "60" 
#define GPIO_IN2 "61"

int ringer_init(void);

void ringer_start(void);

void ringer_stop(void);

#endif 