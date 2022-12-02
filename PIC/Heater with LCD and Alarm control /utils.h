char check_for_button_input();
char bcd_2_dec (char bcd);
int dec_2_bcd (char dec);
void Do_Beep();
void Do_Beep_Good();
void Do_Beep_Bad();
void Activate_Buzzer();
void Activate_Buzzer_4KHz();
void Activate_Buzzer_2KHz();
void Activate_Buzzer_500Hz();
void Deactivate_Buzzer();
void Wait_One_Sec();
void do_update_pwm(char duty_cycle);
void Set_DC_RGB(char duty_cycle);
void Set_RGB_Color(char color);
float read_volt();
unsigned int get_full_ADC();
void Init_ADC();


