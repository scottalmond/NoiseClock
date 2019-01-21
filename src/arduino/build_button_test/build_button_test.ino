//prints status of all user input buttons (1 nominal state, 0 is depressed)
//S1: 1
//S2: 1
//S3: 0
//S4: 1
// ...
//S{BUTTON_COUNT}: 1
//115200 baud serial output, 5 Hz

const int BUTTON_COUNT=8;
const int BUTTON_PINS[BUTTON_COUNT]={9,11,12,A0,A1,8,7,6};
//S1 dec song, S2 inc song
//S3 dec brightness, S4 inc brightness
//S5 dec minute, S6 inc minute
//S7 dec hour, S8 inc hour

void setup() {
  // put your setup code here, to run once:
  for(int iter=0;iter<BUTTON_COUNT;iter++)
  {
    pinMode(BUTTON_PINS[iter],INPUT_PULLUP);
  }
  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  for(int iter=0;iter<BUTTON_COUNT;iter++)
  {
    bool is_high=digitalRead(BUTTON_PINS[iter]);
    Serial.print("S");
    Serial.print(iter+1,DEC);
    Serial.print(": ");
    Serial.print(is_high,DEC);
    Serial.println();
  }
  Serial.println();
  delay(200);
}
