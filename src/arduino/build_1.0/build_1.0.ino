/**
 * License
 *   Copyright 2019 Scott Almond
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *     http://www.apache.org/licenses/LICENSE-2.0
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 * 
 * Purpose
 *   This code displays the current time while playing a .wav file on a continuous loop out of either on-board speakers or via a headphone jack
 * 
 *   The front panel has 8 buttons: sound previous/next, brightness previous/next, minute previous/next, hour previous/next
 *   .wav files are stored on an SD card and the user may go to the previous/next one by pressing the corresponding buttons
 *   When the .wav selection is changed, the .wav index from the SD card is briefly displayed
 *   Volume can be adjusted by rolling the thumbwheel along the edge of the device
 *   The 12-hour time is displayed on a 4-element, 7-segment display
 *   The time is stored on a Real Time Clock (RTC) between power cycles
 *   The 7-segment screen can be changed in brightness by pressing the brightness buttons
 *   The time can be changed with the increment/decrement minute/hour buttons
 * 
 * Usage
 *   Compile this code for Duemilanove, flash to the 328p installed on a Duemilanove, then relocate 328p to PCB
 * 
 * Library Dependencies
 *   WaveHC by William Greiman Version 1.0.0 https://github.com/adafruit/WaveHC
 *   RTClib by Adafruit Version 1.2.0 https://github.com/adafruit/RTClib
 *   Adafruit LED Backpack Library by Adafruit Version 1.1.6 https://github.com/adafruit/Adafruit_LED_Backpack
 * 
 */

//----- Buttons -----
/**
 * Button is a contruct to hold the status of the various user input buttons
 * Event transition diagram:
 * Initialization:
 *   The button is not pressed
 * Button is pressed:
 *   start_transition_ms = millis()
 * If button is held down and DEBOUNCE_MS elapses:
 *   tap_event_fired()
 * If button is held down and HOLD_START_MS passes:
 *   hold_event_fired()
 * While button is held down and every time "hold_press_delay_ms" passes:
 *   hold_event_fired()
 */
struct Button{
  int pin; //pin number assignment according to Duemilanove
  bool is_up; //by default, pin is NOT depressed, is_up=TRUE
  bool is_tap; //set to TRUE after ensuring there is no bouncing on mechanical device
  unsigned long start_transition_ms; //millis() time when the button transitioned from UP to PRESSED
  unsigned long last_hold_event_ms; //millis() time when the last HOLD event fired
  unsigned long hold_event_gap_ms; //number of milliseconds between HOLD events being fired
};

unsigned long DEBOUNCE_MS=100;//how long to wait until performing the action requested by the user to avoid debouncing artifacts
unsigned long HOLD_START_MS=1000;//how long after performing first action before performing hold actions

const int NUM_BUTTONS=8; //number of buttons on front panel
Button button_list[NUM_BUTTONS]={
  { 9,0,0,false,false,500},//change which wav file is looping from the list on the SD card
  {A2,0,0,false,false,500},//song inc
  {A3,0,0,false,false,300},//change the 7-segment LED illumination brightness
  {A0,0,0,false,false,300},//brightness inc
  {A1,0,0,false,false,100},//minute dec
  { 8,0,0,false,false,100},//minute inc
  { 7,0,0,false,false,300},//hour dec
  { 6,0,0,false,false,300} //hour inc
};

//----- Audio -----
#include <WaveHC.h>
#include <WaveUtil.h>

SdReader card;    // This object holds the information for the card
FatVolume vol;    // This holds the information for the partition on the card
FatReader root;   // This holds the information for the volumes root directory
WaveHC wave;      // This is the only wave (audio) object, since we will only play one at a time

uint8_t dirLevel; // indent level for file/dir names    (for prettyprinting)
dir_t dirBuf;     // buffer for directory reads
const int BUTTON_SONG_DEC=0;
const int BUTTON_SONG_INC=1;
uint8_t wav_selection=0;//load from RTC SRAM on boot
//bool loop_this_song=true;
bool flag_is_change_song=false;
bool flag_is_index_visible_to_user=false;
unsigned long last_song_select_ms=0;//time that the last song dec/inc was selected
unsigned long INDEX_USER_DISPLAY_MS=1000;//nunmber of milliseconds to display the song index before displaying the time
int EEPROM_SONG_ADDRESS=0;
int seek_song_index=-1;
int NUM_SONGS=-1;//total number of songs on disk: not known until booted up
bool is_booting=true;//don't display the song index on boot

//----- 4-element 7-segment Display -----
#include <Wire.h>
#include <Adafruit_GFX.h>
#include "Adafruit_LEDBackpack.h"

Adafruit_AlphaNum4 alpha4 = Adafruit_AlphaNum4();
char displaybuffer[5] = {' ', ' ', ' ', ' ',' '};
const int BUTTON_BRIGHTNESS_DEC=2;
const int BUTTON_BRIGHTNESS_INC=3;
int rtc_minute=0;//load from RTC on boot
int rtc_hour=0;//load from RTC on boot
bool is_display_update=true;//only push new state to rtc when it changes
const int MAX_BRIGHTNESS=15;
int brightness=MAX_BRIGHTNESS;//load from RTC SRAM on boot
int EEPROM_BRIGHTNESS_ADDRESS=1;

//----- Real Time Clock -----
#include <Wire.h>
#include "RTClib.h" //RTC = Real Time Clock
RTC_DS3231 rtc;
const int BUTTON_MINUTE_DEC=4;
const int BUTTON_MINUTE_INC=5;
const int BUTTON_HOUR_DEC=6;
const int BUTTON_HOUR_INC=7;
unsigned long last_update_s=0;//storage for the last Arduino time that an RTC timestamp was pushed live to 7-segment display
//only check RTC roughly once a second for a time change to minimize processing time (maximize time available for sound buffering and reduce risk of sound gap when looping)

//------ EEPROM ------
#include <EEPROM.h>

// Function definitions (we define them here, but the code is below)
//void play(FatReader &dir);

//////////////////////////////////// SETUP
void setup(){
  //----- Debug -----
  Serial.begin(9600);
  
  //----- Clock Display -----
  alpha4.begin(0x70);  // pass in the address
  alpha4.clear();
  alpha4.writeDisplay();
  brightness=EEPROM.read(EEPROM_BRIGHTNESS_ADDRESS);//fetch brightness value stored from previous boot cycle
  alpha4.setBrightness(brightness);//assume value is correct, no limit checking

  //----- Buttons -----
  //assign pull ups to all pins.  Button state can be read as: HIGH is_released, LOW is_pressed
  for(int iter=0;iter<NUM_BUTTONS;iter++) pinMode(button_list[iter].pin,INPUT_PULLUP);

  //----- Audio -----
  seek_song_index=EEPROM.read(EEPROM_SONG_ADDRESS);//Load song selection from last boot cycle.  Assume value is correct, no limit checking
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
void play(FatReader &dir) {
  FatReader file;
  int curr_song_index=0;//index of the song currently being inspected from SD card
  while (dir.readDir(dirBuf) > 0) {    // Read every file in the directory one at a time
  
    // Skip it if not a subdirectory and not a .WAV file
    if (!DIR_IS_SUBDIR(dirBuf) && strncmp_P((char *)&dirBuf.name[8], PSTR("WAV"), 3)) continue;

    if (!file.isDir()) {
      songSeekLimitCheck();
      if(curr_song_index==seek_song_index)//if looking at target song, then play it
      {
        if(is_booting) is_booting=false;
        else
        {
          is_display_update=true;
          flag_is_index_visible_to_user=true;
        }
        EEPROM.put(EEPROM_SONG_ADDRESS,curr_song_index);
        // Aha! we found a file that isnt a directory
        putstring("Playing ");
        printEntryName(dirBuf);              // print it out
        if (!wave.create(file)) {            // Figure out, is it a WAV proper?
          putstring(" Not a valid WAV");     // ok skip it
        } else {
          flag_is_change_song=false;
          while(loop_this_song())
          {
            wave.play();
            while(wave.isplaying and loop_this_song())
            {
              updateButtonState();
              updateDisplay();
            }
            if(loop_this_song())
              wave.seek(0);
            else
              wave.stop();
          }
        }
      }
      curr_song_index++;//increment index pointer after completing current song
    }
  }
  NUM_SONGS=curr_song_index;//after first run-through of all songs, store the number of all songs on disk
}

//ensure seek_song_index is in range, if possible
void songSeekLimitCheck()
{
  if(NUM_SONGS>=0)
  {
    if(seek_song_index<0) seek_song_index=NUM_SONGS-1;
    if(seek_song_index>=NUM_SONGS) seek_song_index=0;//if seek_index is invalid, set it to a valid value - may require a loop through all songs on SD card first
  }
}

bool loop_this_song()
{
  return !flag_is_change_song;
}

//go to next/prev song by setting corresponding flags
void changeSong(bool is_inc)
{
  last_song_select_ms=millis();
  flag_is_change_song=true;
  seek_song_index+=is_inc?1:-1;
}

//given a brightness level, push it live to 7-segment display, and also save it to EEPROM storage
void addBrightness(bool is_inc)
{
  brightness+=is_inc?1:-1;
  if(brightness<0) brightness=0;
  if(brightness>MAX_BRIGHTNESS) brightness=MAX_BRIGHTNESS;
  alpha4.setBrightness(brightness);
  EEPROM.put(EEPROM_BRIGHTNESS_ADDRESS,brightness);
}

//add or subtract a minute
void addMinute(bool is_inc)
{
  DateTime now = rtc.now();
  DateTime future=DateTime(now + TimeSpan(0,0,is_inc?1:-1,-now.second()));//increment 1 minute, zero out the seconds
  if(future.hour() != now.hour())//if incrementing caused the hour to change, then recompute with one less hour
    future=DateTime(now + TimeSpan(0,is_inc?-1:1,is_inc?1:-1,-now.second()));
  rtc.adjust(future);
  is_display_update=true;
}

//add or subtract an hour
void addHour(bool is_inc)
{
  DateTime now = rtc.now();
  DateTime future (now + TimeSpan(0,is_inc?1:-1,0,0));//increment 1 hour, zero out the seconds
  rtc.adjust(future);
  is_display_update=true;
}

//check state of all buttons, if any has been tapped or is being held, call the respective helper function for that button
void updateButtonState()
{
  for(int iter=0;iter<NUM_BUTTONS;iter++)
  {
    if(updateButton(&(button_list[iter])))
    {//fires when an update is needed: either because button was tapper or because it is being held
      switch(iter)
      {
        case BUTTON_SONG_DEC:
        case BUTTON_SONG_INC:
          changeSong(iter==BUTTON_SONG_INC);
        break;
        case BUTTON_BRIGHTNESS_DEC:
        case BUTTON_BRIGHTNESS_INC:
          addBrightness(iter==BUTTON_BRIGHTNESS_INC);
        break;
        case BUTTON_MINUTE_DEC:
        case BUTTON_MINUTE_INC:
          addMinute(iter==BUTTON_MINUTE_INC);
        break;
        case BUTTON_HOUR_DEC:
        case BUTTON_HOUR_INC:
          addHour(iter==BUTTON_HOUR_INC);
        break;
        default:
          //invalid case
        break;
      }
    }
  }
}

//measure the live up/down state of the button
//returns TRUE when it is time to do something in response to the button state being depressed (either tapped or held)
bool updateButton(Button *button)
{
  bool is_up=digitalRead((*button).pin);
  if((*button).is_up && !is_up)
  {//transition from released to pressed
    (*button).start_transition_ms=millis();//50 day roll over
    (*button).last_hold_event_ms=0;
    (*button).is_tap=false;
  }
  (*button).is_up=is_up;
  return getIsUpdate(button);
}

//if the user pressed the button briefly, but longer than debounce DEBOUNCE_MS, return TRUE
//if the user holds (HOLD_START_MS) the button down, report a TRUE state update at the configred rate HOLD_PRESSED_MS
//else return FALSE
bool getIsUpdate(Button *button)
{
  unsigned long now_ms=millis();
  unsigned long start_elapsed_ms=now_ms-(*button).start_transition_ms;
  unsigned long hold_elapsed_ms=now_ms-(*button).last_hold_event_ms;
  unsigned long HOLD_PRESSED_MS=(*button).hold_event_gap_ms;
  bool state_update=false;
  if(not (*button).is_up)
  {
    if(not (*button).is_tap && start_elapsed_ms>=DEBOUNCE_MS)
    {//user tapped the button
      (*button).is_tap=true;
      state_update=true;
    }
    if(start_elapsed_ms>HOLD_START_MS && hold_elapsed_ms>HOLD_PRESSED_MS)
    {//user is holding down the button
      (*button).last_hold_event_ms=now_ms;
      state_update=true;
    }
  }
  return state_update;
}

//set the visible contents of the 4-element 7-segment display
void updateDisplay()
{
  songIndexDisplay();
  updateTimeDisplay();
}

//display the song index to the user right after they push the button
void songIndexDisplay()
{
  if(is_display_update && flag_is_index_visible_to_user)
  {
    int carry=seek_song_index+1;//use temp variable and shave off decimal MSB to display
    alpha4.writeDigitAscii(4,0);//turn off colon
    bool is_zero=carry/1000==0;//hide leading zeros
    alpha4.writeDigitAscii(0,is_zero?' ':((carry/1000)+'0'));//MSB
    carry-=1000*(carry/1000);
    is_zero=is_zero && (carry/100==0);
    alpha4.writeDigitAscii(1,is_zero?' ':((carry/100)+'0'));
    carry-=100*(carry/100);
    is_zero=is_zero && (carry/10==0);
    alpha4.writeDigitAscii(2,is_zero?' ':((carry/10)+'0'));
    carry-=10*(carry/10);
    alpha4.writeDigitAscii(3,carry+'0');//LSB
    alpha4.writeDisplay();
    is_display_update=false;
  }
  if(flag_is_index_visible_to_user && millis()>(last_song_select_ms+INDEX_USER_DISPLAY_MS))
  { //when done displaying the song index, set flags to display time
    flag_is_index_visible_to_user=false;
    is_display_update=true;
  }
}

//display the current time to the user, unless they just changed the song (and the index is visible), in which case leave the display as-is
void updateTimeDisplay()
{
  unsigned long time_ms=millis();
  if(time_ms/1000 != last_update_s)
  {//fetch time from RTC when local Arduino time reports a change in the second (check RTC at 1 Hz without worring about 50-day roll-over)
    DateTime now = rtc.now();
    if(now.minute() != rtc_minute) is_display_update=true;//if minute changed, then push new state to display
    rtc_hour=now.hour();
    rtc_minute=now.minute();
    last_update_s=time_ms;
  }
  if(is_display_update && !flag_is_index_visible_to_user)
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
    alpha4.writeDigitAscii(4,1);//turn ON colon in center of screen
    alpha4.writeDisplay();
  }
  is_display_update=false;
}
