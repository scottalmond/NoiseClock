/**
 * Project requirements:
 * 1. Display the 12-hour time on a large display
 *    1.1. Upon application of power to the unit, the clock shall display the last user-configured time without any user input
 *    1.2. In response to a user command, the clock shall adjust the hour and minute
 *    1.3. In response to a user command, the brightness of the screen shall be changed
 *    1.4. Upon application of power to the unit, the screen shall appear at the last user-configured brightness level
 * 2. Play a user-selectable sound
 *    2.1. When no headphones are installed in the unit, audio shall play audio from the speaker
 *    2.2. When headphones are install in the unit, audio shall play from the headphones while the speaker is silenced
 *    2.3. In response to a user command, the next/previous audio file shall be played
 *    2.4. In response to a user command, the unit shall play the audio stream at a higher/lower volume
 *    2.5. Upon application of power to the unit, the last user-selected audio file shall be played
 *    2.6. When audio is played from the unit, the audio file shall loop indefinitely
 * 
 * Implementation approach:
 * 1. Use an Arduino Nano or equivalent 328p processor
 *    1.1. Arduino Nano has a small form factor
 *    1.2. Arduino Nano has a fast boot up time vs RPi
 *    1.3. 328p is the minimum size needed for the SD card player code
 * 2. Use a Real Time Clock to retain the time between hard resets
 *    2.1. Using TBD library
 * 3. Use a 2.3" display and associated driver chip
 *    3.1. Using TBD library
 * 4. Use buttons for user input
 *    4.1. Audio file +, Audio file -
 *    4.2. Brightness +, Brightness -
 *    4.3. Hour +, Hour -
 *    4.4. Minute +, Minute -
 * 5. Use Arduino audio shield and SD card
 *    5.1. Create new audio files by removing SD card and installing in PC.  .wav files must be in TBD format
 *    5.2. Using TBD library
 */

//----- Buttons -----
/**
 * Button is a contruct to hold the status of the various user input buttons
 * Event transition diagram:
 * Initialization:
 *   The button is not pressed
 * Button is pressed:
 *   start_transition_ms = millis()
 * If buton is held down and DEBOUNCE_MS elapses:
 *   tap_event_fired()
 * If button is held down and HOLD_START_MS passes:
 *   hold_event_fired()
 * While button is held down and every time "hold_press_delay_ms" passes:
 *   hold_event_fired()
 */
struct Button{
  int pin;
  bool is_up;
  bool is_tap;
  unsigned long start_transition_ms; //millis() time when the button transitioned from UP to PRESSED
  unsigned long last_hold_event_ms; //millis() time when the last HOLD event fired
  unsigned long hold_event_gap_ms; //number of milliseconds between HOLD events being fired
};

unsigned long DEBOUNCE_MS=100;//how long to wait until performing the action requested by the user to avoid debouncing artifacts
unsigned long HOLD_START_MS=1000;//how long after performing first action before performing hold actions
 
//----- Audio Shield -----
#include <WaveHC.h>
#include <WaveUtil.h>

SdReader card;    // This object holds the information for the card
FatVolume vol;    // This holds the information for the partition on the card
FatReader root;   // This holds the information for the volumes root directory
WaveHC wave;      // This is the only wave (audio) object, since we will only play one at a time

uint8_t dirLevel; // indent level for file/dir names    (for prettyprinting)
dir_t dirBuf;     // buffer for directory reads
Button button_wav={8,0,0,false,false,500};
uint8_t wav_selection=0;//load from RTC SRAM on boot
bool loop_this_song=true;

//----- Clock Display -----
#include <Wire.h>
#include <Adafruit_GFX.h>
#include "Adafruit_LEDBackpack.h"

Adafruit_AlphaNum4 alpha4 = Adafruit_AlphaNum4();
char displaybuffer[5] = {' ', ' ', ' ', ' ',' '};
Button button_brightness={9,0,0,false,false,300};
int rtc_minute=0;//load from RTC on boot
int rtc_hour=0;//load from RTC on boot
bool is_display_update=true;//only push new state to rtc when it changes
int brightness=15;//load from RTC SRAM on boot

//----- Real Time Clock -----
#include <Wire.h>
#include "RTClib.h"
RTC_DS3231 rtc;
Button button_minute={6,0,0,false,false,100};
Button button_hour={7,0,0,false,false,300};
unsigned long last_update_s=0;//only check RTC once a second for a time change to minimize processing time (maximize time available for sound buffering)


/*
 * Define macro to put error messages in flash memory
 */
#define error(msg) error_P(PSTR(msg))

// Function definitions (we define them here, but the code is below)
void play(FatReader &dir);

//////////////////////////////////// SETUP
void setup(){
  //----- Debug -----
  Serial.begin(115200);
  
  //----- Clock Display -----
  alpha4.begin(0x70);  // pass in the address
  alpha4.clear();
  alpha4.writeDisplay();

  //----- Buttons -----
  pinMode(button_wav.pin,INPUT_PULLUP);
  pinMode(button_brightness.pin,INPUT_PULLUP);
  pinMode(button_minute.pin,INPUT_PULLUP);
  pinMode(button_hour.pin,INPUT_PULLUP);

  //----- Audio Shield -----
  card.init();
  card.partialBlockRead(true);
  // Now find a FAT partition
  uint8_t part;
  for (part = 0; part < 5; part++) {   // there are up to 5 slots to look in
    if (vol.init(card, part)) 
      break;                           // found one, exit loop
  }
  root.openRoot(vol);

  //----- Real Time Clock -----
  rtc.begin();
  DateTime now = rtc.now();
  rtc_hour=now.hour();
  rtc_minute=now.minute();
}


//////////////////////////////////// LOOP
void loop() {
  root.rewind();
  play(root);
}

/////////////////////////////////// HELPERS

/*
 * play recursively - possible stack overflow if subdirectories too nested
 */
void play(FatReader &dir) {
  FatReader file;
  while (dir.readDir(dirBuf) > 0) {    // Read every file in the directory one at a time
  
    // Skip it if not a subdirectory and not a .WAV file
    if (!DIR_IS_SUBDIR(dirBuf)
         && strncmp_P((char *)&dirBuf.name[8], PSTR("WAV"), 3)) {
      continue;
    }

    Serial.println();            // clear out a new line
    
    for (uint8_t i = 0; i < dirLevel; i++) {
       Serial.write(' ');       // this is for prettyprinting, put spaces in front
    }
    if (!file.open(vol, dirBuf)) {        // open the file in the directory
      error("file.open failed");          // something went wrong
    }
    
    if (file.isDir()) {                   // check if we opened a new directory
      putstring("Subdir: ");
      printEntryName(dirBuf);
      Serial.println();
      dirLevel += 2;                      // add more spaces
      // play files in subdirectory
      play(file);                         // recursive!
      dirLevel -= 2;    
    }
    else {
      // Aha! we found a file that isnt a directory
      putstring("Playing ");
      printEntryName(dirBuf);              // print it out
      if (!wave.create(file)) {            // Figure out, is it a WAV proper?
        putstring(" Not a valid WAV");     // ok skip it
      } else {
        loop_this_song=true;
        while(loop_this_song)
        {
          wave.play();
          while(wave.isplaying and loop_this_song)
          {
            updateButtonState();
            updateTimeDisplay();
            /*if(Serial.available())
            {
              char c = Serial.read();
              if (isprint(c))
              {
                  displaybuffer[0] = displaybuffer[1];
                  displaybuffer[1] = displaybuffer[2];
                  displaybuffer[2] = displaybuffer[3];
                  displaybuffer[3] = displaybuffer[4];
                  displaybuffer[4] = c;
                 
                  // set every digit to the buffer
                  alpha4.writeDigitAscii(0, displaybuffer[0]);
                  alpha4.writeDigitAscii(1, displaybuffer[1]);
                  alpha4.writeDigitAscii(2, displaybuffer[2]);
                  alpha4.writeDigitAscii(3, displaybuffer[3]);
                  alpha4.writeDigitAscii(4, displaybuffer[4]);
                 
                  // write it out!
                  alpha4.writeDisplay();
              }
            }*/
          }
          if(loop_this_song)
            wave.seek(0);
          else
            wave.stop();
        }
        /*
        Serial.println();                  // Hooray it IS a WAV proper!
        wave.play();                       // make some noise!
        
        uint8_t n = 0;
        while (wave.isplaying) {// playing occurs in interrupts, so we print dots in realtime
          putstring(".");
          if (!(++n % 32))Serial.println();
          delay(100);
        }       
        sdErrorCheck();                    // everything OK?
        // if (wave.errors)Serial.println(wave.errors);     // wave decoding errors
        */
      }
    }
  }
}

void updateButtonState()
{
  if(updateButton(&button_wav))
  {
    Serial.print("1W ");
    Serial.print(button_wav.is_tap,DEC);
    Serial.print(" ");
    Serial.println(millis(),DEC);
    loop_this_song=false;//set flag to progress to next song
  }
  if(updateButton(&button_brightness))
  {
    //Serial.print("2B ");
    //Serial.println(millis(),DEC);
    brightness--;
    if(brightness<0) brightness=15;
    if(brightness>15) brightness=0;
    alpha4.setBrightness(brightness);
  }
  if(updateButton(&button_minute))
  {
    DateTime now = rtc.now();
    DateTime future=DateTime(now + TimeSpan(0,0,1,-now.second()));//increment 1 minute, zero out the seconds
    if(future.hour() != now.hour())//if incrementing caused the hour to change, then recompute with one less hour
      future=DateTime(now + TimeSpan(0,-1,1,-now.second()));//increment 1 minute, zero out the seconds
    rtc.adjust(future);
    
    //Serial.print("3M ");
    //Serial.println(millis(),DEC);
    //rtc_minute=rtc_minute+1;
    //if(rtc_minute>=60) rtc_minute=0;
    is_display_update=true;
  }
  if(updateButton(&button_hour))
  {
    DateTime now = rtc.now();
    DateTime future (now + TimeSpan(0,1,0,0));//increment 1 hour, zero out the seconds
    rtc.adjust(future);
    
    //Serial.print("4H ");
    //Serial.println(millis(),DEC);
    //rtc_hour=rtc_hour+1;
    //if(rtc_hour>12) rtc_hour=1;
    is_display_update=true;
  }
}

//measure the live up/down state of the button
bool updateButton(Button *button)
{
  bool is_up=digitalRead((*button).pin);
  if((*button).is_up && !is_up)
  {//transition from released to pressed
    (*button).start_transition_ms=millis();//50 day roll over
    (*button).last_action_ms=0;
    (*button).is_tap=false;
  }
  (*button).is_up=is_up;
  return getIsUpdate(button);
}

//if the user pressed the button brielfy, but longer than a debounce DEBOUNCE_MS, return true
//if the user holds (HOLD_START_MS) the button down, report a true state update at the configred rate HOLD_PRESSED_MS
//else return false
bool getIsUpdate(Button *button)
{
  unsigned long now_ms=millis();
  unsigned long start_elapsed_ms=now_ms-(*button).start_transition_ms;
  unsigned long hold_elapsed_ms=now_ms-(*button).last_action_ms;
  unsigned long HOLD_PRESSED_MS=(*button).hold_press_delay_ms;
  bool state_update=false;
  if(not (*button).is_up)
  {
    if(not (*button).is_tap && start_elapsed_ms>=DEBOUNCE_MS)
    {//user tapped the button
      (*button).is_tap=true;
      state_update=true;
      //Serial.print("A");
    }
    if(start_elapsed_ms>HOLD_START_MS && hold_elapsed_ms>HOLD_PRESSED_MS)
    {//user is holding down the button
      (*button).last_action_ms=now_ms;
      state_update=true;
      //Serial.print("B ");
      //Serial.print(start_elapsed_ms,DEC);
      //Serial.print(" ");
      //Serial.print(hold_elapsed_ms,DEC);
      //Serial.print(" ");
    }
  }
  return state_update;
}

void updateTimeDisplay()
{
  unsigned long time_ms=millis();
  if(time_ms/1000 != last_update_s)
  {//fetch time
    DateTime now = rtc.now();
    if(now.minute() != rtc_minute) is_display_update=true;//if minute changed, then push new state to display
    rtc_hour=now.hour();
    rtc_minute=now.minute();
    last_update_s=time_ms;
  }
  if(is_display_update)
  {
    char hour_ten=(rtc_hour%12+1)/10;
    char hour_one=(rtc_hour%12+1)%10;
    char minute_ten=rtc_minute/10;
    char minute_one=rtc_minute%10;
    if(hour_ten==0) alpha4.writeDigitAscii(0, ' ');//if 1 AM, display as " 1", not "01"
    else alpha4.writeDigitAscii(0,hour_ten+'0');
    alpha4.writeDigitAscii(1,hour_one+'0');
    alpha4.writeDigitAscii(2,minute_ten+'0');
    alpha4.writeDigitAscii(3,minute_one+'0');
    alpha4.writeDigitAscii(1,'8');//turn on colon in center of screen
    alpha4.writeDisplay();
  }
  is_display_update=false;
}
