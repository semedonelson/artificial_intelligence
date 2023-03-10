//+------------------------------------------------------------------+
//|                                                     1001pips.mq4 |
//|                               Copyright © 2010, Silvio Invernici |
//|                                       http://www.trading-team.it |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2010, Silvio Invernici"
#property link      "http://www.trading-team.it"

//#property indicator_separate_window
#property indicator_chart_window

extern int X = 25;
extern int Y = 25;
extern int Corner = 1;
extern int fontsize = 8;
extern string font = "Arial";
extern bool Credits = false;

#define ID_USD  0
#define ID_EUR  1
#define ID_GBP  2
#define ID_JPY  3
#define ID_CHF  4
#define ID_CAD  5
#define ID_NZD  6
#define ID_AUD  7
#define N_CROSS 8

double ValoreZero_Output[N_CROSS];

string SingolaValuta[] = {"USD", 
                          "EUR", 
                          "GBP", 
                          "JPY", 
                          "CHF", 
                          "CAD", 
                          "NZD", 
                          "AUD"};

color ColoreValuta[] = {White, 
                        CornflowerBlue, 
                        Turquoise, 
                        Coral, 
                        Pink,
                        PaleGreen, 
                        MediumOrchid, 
                        Gold};
                    
string CoppiaValuta[] = {"EURUSD", 
                         "GBPUSD",
                         "AUDUSD", 
                         "USDJPY", 
                         "USDCHF", 
                         "USDCAD", 
                         "EURAUD", 
                         "EURCAD", 
                         "EURCHF", 
                         "EURGBP", 
                         "EURJPY", 
                         "GBPJPY", 
                         "GBPCHF", 
                         "NZDUSD", 
                         "AUDCAD", 
                         "AUDJPY", 
                         "CHFJPY", 
                         "AUDNZD", 
                         "NZDJPY", 
                         "NZDCAD", 
                         "NZDCHF", 
                         "GBPNZD", 
                         "EURNZD", 
                         "GBPCAD", 
                         "GBPAUD", 
                         "AUDCHF", 
                         "CADCHF", 
                         "CADJPY"};
string space = "";
string NomeIndi;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   NomeIndi = WindowExpertName();
   SetIndexBuffer(0,ValoreZero_Output);
   
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
  for (int i = 0; i <= ArraySize(SingolaValuta)*2; i++) 
  {    
       ObjectDelete(SingolaValuta[i]+"_pos");
       ObjectDelete(SingolaValuta[i]+"_nom");
       ObjectDelete(SingolaValuta[i]+"_val");
       }
   ObjectDelete("credits");
       
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int    counted_bars=IndicatorCounted();
     
   displayMeter();

   return(0);
  }
  
//+------------------------------------------------------------------+
//| displayMeter function                                            |
//+------------------------------------------------------------------+
void displayMeter() 
   {

   double ValoreZero[N_CROSS,2];
   color  ColoreZero[N_CROSS,2];
   
   ValoreZero[ID_USD,0] = currency_strength(SingolaValuta[ID_USD]);
   ValoreZero[ID_EUR,0] = currency_strength(SingolaValuta[ID_EUR]);
   ValoreZero[ID_GBP,0] = currency_strength(SingolaValuta[ID_GBP]);
   ValoreZero[ID_JPY,0] = currency_strength(SingolaValuta[ID_JPY]);
   ValoreZero[ID_CHF,0] = currency_strength(SingolaValuta[ID_CHF]);
   ValoreZero[ID_CAD,0] = currency_strength(SingolaValuta[ID_CAD]);
   ValoreZero[ID_NZD,0] = currency_strength(SingolaValuta[ID_NZD]);
   ValoreZero[ID_AUD,0] = currency_strength(SingolaValuta[ID_AUD]);
   
   ValoreZero_Output[0] = ValoreZero[ID_USD,0];
   ValoreZero_Output[1] = ValoreZero[ID_EUR,0];
   ValoreZero_Output[2] = ValoreZero[ID_GBP,0];
   ValoreZero_Output[3] = ValoreZero[ID_JPY,0];
   ValoreZero_Output[4] = ValoreZero[ID_CHF,0];
   ValoreZero_Output[5] = ValoreZero[ID_CAD,0];
   ValoreZero_Output[6] = ValoreZero[ID_NZD,0];
   ValoreZero_Output[7] = ValoreZero[ID_AUD,0];
   
   ValoreZero[ID_USD,1] = ID_USD;  //1
   ValoreZero[ID_EUR,1] = ID_EUR;  //2
   ValoreZero[ID_GBP,1] = ID_GBP;  //3
   ValoreZero[ID_JPY,1] = ID_JPY;  //4
   ValoreZero[ID_CHF,1] = ID_CHF;  //5
   ValoreZero[ID_CAD,1] = ID_CAD;  //6
   ValoreZero[ID_NZD,1] = ID_NZD;  //7
   ValoreZero[ID_AUD,1] = ID_AUD;  //8
   

   ArraySort(ValoreZero,WHOLE_ARRAY,0,MODE_DESCEND);
   
   int win = WindowFind(NomeIndi);
 
   int j,Y2=Y;
   
   for(int i=0; i<N_CROSS; i++)
   {
      j = ValoreZero[i,1];
      objectCreate(SingolaValuta[j]+"_pos", Corner, X+50, Y2, 0,( i+1)+". ", fontsize, font, Silver);
      objectCreate(SingolaValuta[j]+"_nom", Corner, X+30, Y2, 0, SingolaValuta[j], fontsize, font, ColoreValuta[j]);
      objectCreate(SingolaValuta[j]+"_val", Corner, X, Y2, 0, DoubleToStr(ValoreZero[i,0],2), fontsize, font, symcolor(ValoreZero[i,0]));
      Y2 += 12;
   }
   
   if (Credits)objectCreate("credits", Corner, X-5, Y+4, 90, "www.trading-team.it", fontsize, font, DimGray);
   
}

//+------------------------------------------------------------------+
//| symcolor function                                                |
//+------------------------------------------------------------------+
int symcolor(double ad_0) {
   int li_ret_8;
   if (ad_0 <= 2.0) li_ret_8 = 3937500; /// red
   if (ad_0 > 2.0) li_ret_8 = 16777215; /// silver
   if (ad_0 >= 7.0) li_ret_8 = 65280;   /// green
   return (li_ret_8);
}

//+------------------------------------------------------------------+
//| currency_strength function                                       |
//+------------------------------------------------------------------+
double currency_strength(string couple) {
   int index;
   string Pair;
   double HiLo;
   double ld_28;
   double ld_ret_36 = 0;
   int cnt = 0;
   for (int i = 0; i < ArraySize(CoppiaValuta); i++) {
      index = 0;
      Pair = CoppiaValuta[i];
      if (couple == StringSubstr(Pair, 0, 3) || couple == StringSubstr(Pair, 3, 3)) {
         Pair = Pair + space;
         HiLo = (MarketInfo(Pair, MODE_HIGH) - MarketInfo(Pair, MODE_LOW)) * MarketInfo(Pair, MODE_POINT);
         if (HiLo != 0.0) {
            ld_28 = 100.0 * ((MarketInfo(Pair, MODE_BID) - MarketInfo(Pair, MODE_LOW)) / HiLo * MarketInfo(Pair, MODE_POINT));
            if (ld_28 >  3.0) index = 1;
            if (ld_28 > 10.0) index = 2;
            if (ld_28 > 25.0) index = 3;
            if (ld_28 > 40.0) index = 4;
            if (ld_28 > 50.0) index = 5;
            if (ld_28 > 60.0) index = 6;
            if (ld_28 > 75.0) index = 7;
            if (ld_28 > 90.0) index = 8;
            if (ld_28 > 97.0) index = 9;
            cnt++;
            if (couple == StringSubstr(Pair, 3, 3)) index = 9 - index;
            ld_ret_36 += index;
         }
      }
   }
   if(cnt > 0) ld_ret_36 /= cnt;
   return (ld_ret_36);
}

//+------------------------------------------------------------------+
//| objectCreate function                                            |
//+------------------------------------------------------------------+
void objectCreate(string nome, int angolo, int val_x, int val_y, int val_ang, string testo = "-", int _fontsize = 42, string fontname = "Arial", color colore1 = -1)
   {
   if (ObjectFind(nome) != 0) {
      ObjectCreate(nome, OBJ_LABEL, 0, 0, 0);
      ObjectSet(nome, OBJPROP_CORNER, angolo);
      ObjectSet(nome, OBJPROP_COLOR, colore1);
      ObjectSet(nome, OBJPROP_XDISTANCE, val_x);
      ObjectSet(nome, OBJPROP_YDISTANCE, val_y);
      ObjectSet(nome, OBJPROP_ANGLE, val_ang);
      ObjectSetText(nome, testo, _fontsize, fontname, colore1);
      return;
   }
   ObjectSet(nome, OBJPROP_CORNER, angolo);
   ObjectSet(nome, OBJPROP_COLOR, colore1);
   ObjectSet(nome, OBJPROP_XDISTANCE, val_x);
   ObjectSet(nome, OBJPROP_YDISTANCE, val_y);
   ObjectSet(nome, OBJPROP_ANGLE, val_ang);
   ObjectSetText(nome, testo, _fontsize, fontname, colore1);
}

