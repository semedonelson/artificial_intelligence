//+------------------------------------------------------------------+
//|                                              Noslenodemes.v8.mq4 |
//|                                   Copyright 2020, Nelson Semedo. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Nelson Semedo."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#import "kernel32.dll"
   int CreateFileW(string, uint, int, int, int, int, int);
   int GetFileSize(int, int);
   int ReadFile(int, uchar&[], int, int&[], int);
   int CloseHandle(int);
#import

//extern variables
extern string Condiction1Validation = "";
extern double MaxLot = 1000.0;
extern bool ClosePositionsOnEndOfFriday = true;
extern bool ClosePositionsOnEndOfTheDay = true;
extern bool OnNewOrderCloseOpositeOne = true;
extern bool UseDailyGoalPercentage = true;
extern bool UseTakeProfit = true;
extern bool DoBreakEven = false;
extern bool DoTraillingStop = true;
extern int MaxOrders = 1;
extern int MinStopLossPoints = 200;

//Others
bool ValidateMaxSymbols = false;
double MinDistanceBetweenOrders = 50;
double StrengthMinimumLevel = 8.0;
int TopStrengthCurrencies = 2;
string MinHourToHandleOpenPositions = "01:00";
string MinHourToTraillingStop = "01:00";
string Version = "v.15.03.0";
double MinCurrencyStrengthPowerDiff = 3.0;
int Timeframe_Entry = PERIOD_M15;
int Timeframe_Trend = PERIOD_H4;
int Timeframe_TraillingSL = PERIOD_M30;
double DailyGoalPercentage = 25.0;
double BreakEvenSLMultiplier = 1.0;
double GridDistanceSL = 1000.0;
double RiskReward = 0.75;
int MaxOrderPerDayPerSymbol = 3;
int StopLossMinimumDistance = 125;
int MinimumWaveSizePoints = 500;
int MondayStartTradingHour = 1;
double MinCurrencyStrengthDiff = 2.0;
double PercentageToFilterStrength = 33.0;
int MAGIC_1 = 100;
int MAGIC_2 = 200;
int MAPERIOD_L = 200;
int MAPERIOD_M = 100;
int MAPERIOD_S = 50;
int HullMAMAPeriod = 200;
double OrderSpeedTraillingPercentage = 80.0;
int OrdersDistancePoints = 10;
int StochasticLevelJoin = 5;
bool UseDailyGoalStopLoss = false;
double DailyStopLossPercentage = 20.0;
int LevelJoinDistance = 10;
int PPLevelJoinDistance = 50;
int DailyOpenPriceJoin = 15;
int TrendJoinDistance = 20;
int TrendLine4HJoinDistance = 50;
int MAStochasticJoinDistance = 30;
bool SendEmailWhenAllOrderClosed = true;
string NumberDecimalSeparator = ",";
string NumberThousandsSeparator = ".";
bool ShowOpenOrdersOnResumeEmail = true;
int ZigZagDepth = 12;
int ZigZagDeviation = 5;
int ZigZagBackstep = 3;
int ZigZagDepth_Trigger = 12;
int ZigZagDeviation_Trigger = 5;
int ZigZagBackstep_Trigger = 3;
bool ErrorMessageSend = true;
bool ShowDailyGoalPercentage = true;
bool ShowOpenOrdersCount = false;
int MinuteBeforeNewsStopTrading = 60;   
int MinutesForCloseOrder = 45;   
bool StopTradeOnHighImpactNews = true;
bool StopTradeOnMediumImpactNews = false;    
bool UseAccountEquityToCalculateLot = false;
int MaxMessageToTheServer = 4990;
long MaxOpenOrders = 0;
int StartDailyGoalCheckHour = 2;
double BreakDistancePoints = 10;
double StopLossDistancePoints = 10;
bool SendResumeEmail = true;
bool SendAllClosedOrderEmail = false;
int LastCountOrders = 0;
int Timeframe_M1 = PERIOD_M1;
int Timeframe_M5 = PERIOD_M5;
int Timeframe_M15 = PERIOD_M15;
int Timeframe_M30 = PERIOD_M30;
int Timeframe_H1 = PERIOD_H1;
int Timeframe_H4 = PERIOD_H4;
int Timeframe_D = PERIOD_D1;
int Timeframe_W = PERIOD_W1;
int Timeframe_MN = PERIOD_MN1;
int Timeframe_Long = 0;
int Timeframe_Medium = 0;
int Timeframe_Short = 0;
datetime lastOpenTime_m1;
datetime lastOpenTime_m5;
datetime lastOpenTime_m15;
datetime lastOpenTime_m30;
datetime lastOpenTime_h1;
datetime lastOpenTime_h4;
datetime lastOpenTime_d;
bool StartBar_Daily = true;
bool StartBar_H4 = true;
bool StartBar_H1 = true;
bool StartBar_M30 = true;
bool StartBar_M15 = true;
bool StartBar_M5 = true;
bool StartBar_M1 = true;
bool Symbols_OpenOrderErrors[];
string TradingSessionsExceptions[];
double LastWeekClosedBalance = 0;
double LastMonthClosedBalance = 0;
double YesterdayClosedBalance = 0;
bool FirstRun = true;
bool FirstRunCheckNewOrders = true;
double MinMarginPercentage = 100;
double MarginSOAdd = 5;
double MinMarginPercentageToValidate = 2;
bool DailyGoalPercentageReched = true;
bool DailyGoal = false;
string Symbols[];
//int SymbolsGetSignalResult[];
string Resistence[];
string Support[];
string SupportAndResistence[];
long StartDayTime = 0; 
bool StartTrading = false;
double CurrencyStrengthStrong = 5.0;
double CurrencyStrengthWeak = 3.0;
double Symbols_Strength_Average = 0;
string space = "";
bool CurrencyStrengthHistoryArrayFilled = false;
bool CurrencyStrengthValuesArrayFilled = false;
int CurrencyStrengthHistoryMinutes = 0;
int CurrencyStrengthValuesMinutes = 0;
string CurrencyStrength[];
double CurrencyStrengthValue[];
double CurrencyStrengthThreshold = 0.5;
double CurrencyStrengthHistory[][10];
int CurrencyStrengthHistorySize = 10;
double CurrencyStrengthValues[][3];
string Currency[] = {"USD",
                    "EUR",
                    "GBP",
                    "JPY",
                    "CHF",
                    "CAD",
                    "NZD",
                    "AUD"};
string CurrencyStrengthList [] = {"EUR", "GBP", "USD", "JPY", "AUD", "NZD", "CAD", "CHF"}; 
int CurrencyStrengthSignal[]; 
double CurrencyStrengthMA[], CurrencyStrengthMAPrev[];
string ADXTriggers[], BandsTriggers[];
int CurrencyStrengthMAPeriod = 5;
enum direction
{
   Up,
   Down
};
int Interval = 500; // Interval between zones in points.
int Stochastic_Kperiod_Z = 14;
int Stochastic_Dperiod_Z = 5;
int Stochastic_Slowing_Z = 5;
int Stochastic_Kperiod_T = 5;
int Stochastic_Dperiod_T = 3;
int Stochastic_Slowing_T = 3;
int Stochastic_Method = MODE_SMA;
double Stochastic_Up_Level_Trigger = 80.0;
double Stochastic_Down_Level_Trigger = 20.0;
double Stochastic_Up_Level_Zone = 70.0;
double Stochastic_Down_Level_Zone = 30.0;
double PSAR_Step_Entry = 0.02;
double PSAR_Step_Trailling = 0.02;
double PSAR_Maximum_Entry = 0.2;
double PSAR_Maximum_Trailling = 0.2;
int MACDFastEMA = 12;
int MACDSlowEMA = 26;
int MACDSMA = 9;
int MACDMAShortPeriod = 2;
int MACDMALongPeriod = 5;
int CMAPeriod = 5;
int ATR_PERIOD = 14;
int STD_PERIOD = 20;
int ATR_MA_Period = 5;
int STD_MA_Period = 5;
int CCIPeriod = 14;
int ATR_LongMA_Period = 200;
long StartTradeMinute = 0;
long ThisTradeMinute = 0;
bool StartDayRefresh = false;
int SymbolsSignal[];
int TrendLineZZExtDepth = 30;
int TrendLineZZExtDeviation = 5;
int TrendLineZZExtBackstep = 3;
int ADXPeriod = 14;
int ADXMAPeriod = 5;
double ADXVolatilityThreshold = 25;
int TrendDirectionForceIndexPeriod = 5;
double TrendDirectionForceIndexTriggerUp = 0.1;
double TrendDirectionForceIndexTriggerDown = -0.1;
int TrendDirectionForceIndexMAMethod = 10;
int TrendDirectionForceIndexMAPeriod = 5;
int SuperTrendNbrPeriod = 10;
double SuperTrendMultiplier = 3.0;
int MoneyFlowIndexPeriod = 8;
double MoneyFlowIndexUpLevel = 80.0;
double MoneyFlowIndexDnLevel = 20.0;
int BollingerBandsPeriod = 20;
double BollingerBandsDeviations = 2.0;
double BollingerBandsDeviations_outer = 2;
double BollingerBandsDeviations_inner = 1;
int RSIPeriod = 7;
double RSIUPLevel = 70.0;
double RSIDNLevel = 30.0;
double PeakThreshold = 15;
int AtrTraillingStopBackPeriod = 100;
int AtrTraillingStopATRPeriod = 3;
double AtrTraillingStopFactor = 3.0;
bool AtrTraillingStopTypicalPrice = false;
int KeltnerChannelPeriod = 200;
string SymbolsMovingAverageSignal[];
string ZigZagPoints[];
string StochasticSignals[];
string SignalResult[];
int FibonacciSignalUP[];
int FibonacciSignalDN[];
double FibonacciSignalUPLevels[28][5];
double FibonacciSignalDNLevels[28][5];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
   Print("Version: ",Version);
   MaxOpenOrders = AccountInfoInteger(ACCOUNT_LIMIT_ORDERS);
   ReadConfig();
   UseDailyGoalStopLoss = UseDailyGoalPercentage;
   if(UseDailyGoalPercentage) {
      ClosePositionsOnEndOfFriday = true;      
   }
   CalculateDailyPercentages();
   ArrayResize(Symbols_OpenOrderErrors, ArraySize(Symbols));
   ArrayResize(CurrencyStrength, ArraySize(Currency));
   ArrayResize(SymbolsSignal, ArraySize(Symbols));
   ArrayResize(Resistence, ArraySize(Symbols));
   ArrayResize(Support, ArraySize(Symbols));
   ArrayResize(SupportAndResistence, ArraySize(Symbols));
   ArrayResize(CurrencyStrengthHistory, ArraySize(Symbols));
   ArrayInitialize(CurrencyStrengthHistory, 0.0);
   ArrayResize(CurrencyStrengthValue, ArraySize(Symbols));
   ArrayResize(SymbolsMovingAverageSignal, ArraySize(Symbols));
   ArrayResize(ZigZagPoints, ArraySize(Symbols));
   ArrayResize(StochasticSignals, ArraySize(Symbols));
   ArrayResize(SignalResult, ArraySize(Symbols));
   ArrayResize(CurrencyStrengthSignal, ArraySize(Symbols));
   ArrayResize(CurrencyStrengthMA, ArraySize(CurrencyStrengthList));
   ArrayResize(CurrencyStrengthMAPrev, ArraySize(CurrencyStrengthList));
   ArrayResize(ADXTriggers, ArraySize(Symbols));
   ArrayResize(BandsTriggers, ArraySize(Symbols));
   ArrayResize(FibonacciSignalUP, ArraySize(Symbols));
   ArrayResize(FibonacciSignalDN, ArraySize(Symbols));
   
   FirstRun = true;
   Timeframe_Long = Timeframe_H4;
   Timeframe_Medium = Timeframe_H1;
   Timeframe_Short = Timeframe_M5;
   Timeframe_Entry = Timeframe_M15;
   Timeframe_Trend = Timeframe_H4;
   Timeframe_TraillingSL = Timeframe_M30;
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
   //Set EURUSD as a chart Symbol
   if(_Symbol != "EURUSD" || Period() != Timeframe_H1) ChartSetSymbolPeriod(0, "EURUSD", Timeframe_H1); 
   
   //Currency Strength
   if(!IsTesting()) {
      //SetCurrencyStrength();
   }
         
   //Check New bars
   StartBar_M1 = IsNewBar_M1();
   StartBar_M5 = IsNewBar_M5();
   StartBar_M15 = IsNewBar_M15();
   StartBar_M30 = IsNewBar_M30();
   StartBar_H1 = IsNewBar_H1();
   StartBar_H4 = IsNewBar_H4();
   StartBar_Daily = IsNewBar_Daily();
   
   if(StartBar_M1) {
      //SetCurrencyStrengthHistory();
   }   
   
   if(StartBar_M5) {
      ArrayInitialize(Symbols_OpenOrderErrors, false);
   }
   if(StartBar_M1) {
      ThisTradeMinute = iTime(_Symbol, Timeframe_M1, 0);
   }
      
   long today_time = iTime(_Symbol, Timeframe_D, 0);
   if(today_time > StartDayTime) {
      StartBar_Daily = true;
   }
      
   if (StartBar_H1 || StartBar_H4 || StartBar_Daily) {
      RefreshBalances();
   }
   
   if(StartBar_M15) {
      ArrayInitialize(SymbolsSignal, 0);
   }
      
   CheckMondayTradingHours();
      
   //New Day
   if(StartBar_Daily) {
      DailyGoalPercentageReched = false;
      SendAllClosedOrderEmail = false; 
      ErrorMessageSend = true;     
      GetTradingSessionsExceptions();
      StartDayRefresh = false;
      if(!FirstRun) {
         SaveNewServerMessage("SERVER_MESSAGES.csv", 0);
      }
      StartDayTime = iTime(_Symbol, Timeframe_D, 0);
      //if(!IsTesting())ObjectsDeleteAll();
      if(FirstRun)StartTradeMinute = iTime(_Symbol, Timeframe_M1, 0);
      Print("New Trading Day Started!");
   }
   
   MarginCallPrevent();  
   
   DailyGoal = DailyGoalReached(); 
      
   if(StartBar_M1 && !FirstRun && ThisTradeMinute > StartTradeMinute) {
      StartTrading = true;
   }
   if(StartBar_M1) {
      DailyBoxUpDn("EURUSD", Timeframe_M15);
   }
   
   if(CheckEnableTrading() && CheckMinHourToHandleOpenPositions()) {
      HandleOpenPositions(Timeframe_TraillingSL);
   }
        
   if(CheckEnableTrading() && !DailyGoal && (StartTrading || IsTesting())) {
      CheckNewOrders(Timeframe_Trend, Timeframe_Entry, 1);
   }
   
   // Account Details //
   if(StartBar_H1 && !FirstRun && (CountOrders() > 0 || LastCountOrders > 0) && !IsTesting() && SendResumeEmail) {
      SendEmail(1, 0, 0, "");
      LastCountOrders = CountOrders();
   }

   if(SendEmailWhenAllOrderClosed)AllOrderClosedNotification();
   
   //Trading day refresh
   if(TimeHour(TimeCurrent()) == 0 && TimeMinute(TimeCurrent()) > 5 && TimeMinute(TimeCurrent()) < 10) {
      if(!StartDayRefresh) {
         RefreshBalances();
         SendEmail(4, 0, 0, ""); //Trading Sessions Exceptions
         SendEmail(5, 0, 0, "");//New trading day notification
         StartDayRefresh = true;
      }
   }
    
   FirstRun = false;
}
//+------------------------------------------------------------------+
void CheckNewOrders(int timeframe_trend, int timeframe_trigger, int shift) {
   double bid = 0, ask = 0, lt = 0, tp = 0, sl = 0;
   double pivot_r3 = 0, pivot_r2 = 0, pivot_r1 = 0, pivot_pp = 0, pivot_s1 = 0, pivot_s2 = 0, pivot_s3 = 0;
   double pivot_tc = 0, pivot_bc = 0, pivot_pp_prev = 0, pivot_pp_prev1 = 0, pivot_middle_r1 = 0, pivot_middle_s1 = 0;
   int pivot_dir = 0, camarilla_dir = 0;
   //double pivot_pp_prev = 0, pivot_bc_prev = 0, pivot_tc_prev = 0, pivot_s1_middle = 0, pivot_r1_middle = 0;
   //double pivot_pp_s1_middle = 0, pivot_pp_r1_middle = 0;
   double camarilla_h5 = 0, camarilla_h4 = 0, camarilla_h3 = 0, camarilla_l3 = 0, camarilla_l4 = 0, camarilla_l5 = 0, camarilla_middle = 0;
   double camarilla_join = 0;
   string symbol = "", signal = "", camarilla_points = "", bands_signal = "", pivot_points_curr = "", ma_signal = "";
   string hull_signal = "", trend_line_signal = "";
   int magic_b = 0, magic_s = 0;//, stochastic_l = 0, stochastic_m = 0, stochastic_s = 0, stochastic_up = 0, stochastic_dn = 0
   //11.3--------------------------------------
   double level_join = 0;
   double spread = 0;
   double min_sl_points = 0, take_profit_points = 0, high = 0, low = 0, close = 0, open = 0, ma_value_l = 0, ma_value_m = 0, ma_value_s = 0;
   //15.0--------------------------------------
   string ma_trigger_signal = "";
   int strength_signal = 0, stochastic_trigger = 0, hull_trend = 0;
   double ma_value = 0;
   bool adx_volatility = false;
      
   if(FirstRunCheckNewOrders)Print("CheckNewOrders Method Started!");
   if(!CheckMondayTradingHours()) {
      if(FirstRunCheckNewOrders) {
         Print("CheckNewOrders Method Finished! First Trading Day.");
         FirstRunCheckNewOrders = false;         
      }
      return;
   }
   
   //Calculate Currencies Strength
   CurrencyStrengthLinesSignalV7(CurrencyStrengthSignal, timeframe_trend, shift);
   
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);

      //Start Validations
      if(symbol != _Symbol && IsTesting())continue;
      if(StringLen(symbol) == 0)continue;
      if(!IsTheMarketOpened(symbol)) {
         continue;
      }

      if(!IsValidateSpread(symbol) && !IsTesting()) {
         continue;
      }
      if(RetrieveValueFromArray_bool(symbol, Symbols_OpenOrderErrors, Symbols)) {
         continue;
      }
      if(MaxMessagesToTheServerReached()) {
         string saved_message = ReadSavedServerMessages();
         int server_message = 0;
         if(StringLen(saved_message) > 0) {
            server_message = GetIntiger(saved_message, ";", 1);            
         }      
         if(ErrorMessageSend && !FirstRunCheckNewOrders) {
            SendEmail(2, 0, 0, symbol + " " + " Server Message Validation Not Passed! Server Messages: "+NumberFormat(IntegerToString(server_message)));
            ErrorMessageSend = false;
         }
         break;
      }
      if(!ValidateMinMarginPercentage()) {
         break;
      }
      if(!ValidateMaxOpenOrders()) {
         break;
      }
      //End Validations
      //Initialize
      sl = 0; tp = 0;
      //
      spread = MarketInfo(symbol, MODE_SPREAD) * MarketInfo(symbol, MODE_POINT);
      level_join = (LevelJoinDistance * MarketInfo(symbol, MODE_POINT)) + spread; 
      min_sl_points = MinStopLossPoints * MarketInfo(symbol, MODE_POINT);
      //take_profit_points = TakeProfitPoints * MarketInfo(symbol, MODE_POINT);
      bid = SymbolInfoDouble(symbol, SYMBOL_BID);
      ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
      close = iClose(symbol, timeframe_trigger, shift);
      open = iOpen(symbol, timeframe_trigger, shift);
      high = iHigh(symbol, timeframe_trend, shift);
      low = iLow(symbol, timeframe_trend, shift);    
      
      //Pivot Points
      strength_signal = CurrencyStrengthSignal[i];    
      hull_trend = HullMASignal(symbol, timeframe_trend, shift);
      adx_volatility = ADXVolatility(symbol, timeframe_trend, false, shift);
      stochastic_trigger = StochasticTrigger(symbol, timeframe_trigger, Stochastic_Kperiod_T, Stochastic_Dperiod_T, Stochastic_Slowing_T, shift);
      
      if(StartBar_H4 && strength_signal == 1 && hull_trend == 1 && adx_volatility) {
         //SendEmail(2, 0, 0, symbol+": BUY");
         Print(symbol+": BUY");
      }
      else if(StartBar_H4 && strength_signal == -1 && hull_trend == -1 && adx_volatility) {
         //SendEmail(2, 0, 0, symbol+": SELL");
         Print(symbol+": SELL");
      }
      
      continue;    
      if (strength_signal == 1 && hull_trend == 1 && adx_volatility && stochastic_trigger == 1
         && OpenPositionsOnBar0Validation(symbol, timeframe_trigger, MaxOrders, OP_BUY)
         && MaxOrderValidation(symbol, OP_BUY, MaxOrders, MAGIC_1)
         && EntryPriceValidation(symbol, OP_BUY, ask)) {        
         sl = MathMin(bid - min_sl_points, low - level_join);
         if(UseTakeProfit) {
            tp = ask + ((ask - sl) * GetTakeProfitMultiplier(symbol)) + spread;
         }
         ValidateNewOrder(symbol, Up, ask, tp, sl, MAGIC_1, "", RiskReward);
      }
      else if (strength_signal == -1 && hull_trend == -1 && adx_volatility && stochastic_trigger == -1
         && OpenPositionsOnBar0Validation(symbol, timeframe_trigger, MaxOrders, OP_SELL)
         && MaxOrderValidation(symbol, OP_SELL, MaxOrders, MAGIC_1)
         && EntryPriceValidation(symbol, OP_SELL, bid)) {       
         sl = MathMax(ask + min_sl_points, high + level_join);
         if(UseTakeProfit) {
            tp = bid - ((sl - bid) * GetTakeProfitMultiplier(symbol)) - spread;
         }
         ValidateNewOrder(symbol, Down, bid, tp, sl, MAGIC_1, "", RiskReward); 
      }
   }
   
   if(FirstRunCheckNewOrders) {
      Print("CheckNewOrders Method Finished!");
      FirstRunCheckNewOrders = false;
   }
}
//+------------------------------------------------------------------+
void ValidateNewOrder(string symbol, const direction dir, double entry_price, double tp, double sl, int magic, string comment, double risk) {
   double lt = 0;
   double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
   double stop_level = MarketInfo(symbol, MODE_STOPLEVEL);
   
   if(dir == Up) {
      if(RetrieveValueFromArray_int(symbol, SymbolsSignal, Symbols) == 1 || IsTesting()) {      
         if(!ExistOpenOrderOnThisLevel(symbol, Up, entry_price)) {
            lt = CalculateDesiredLot(symbol, OP_BUY, sl, entry_price);  
            lt = ReajustLote(symbol, lt);
            if(lt == 0) return;
            if(!RiskRewardValidation(OP_BUY, entry_price, tp, sl, risk))return;

            DeletePendingOrders(symbol, Up);
            DeletePendingOrders(symbol, Down);
            //Entry
            if(NormalizeDouble(entry_price, (int)MarketInfo(symbol, MODE_DIGITS)) == NormalizeDouble(ask, (int)MarketInfo(symbol, MODE_DIGITS))) {
               Opentrade(symbol, entry_price, OP_BUY, lt, sl, tp, magic, OnNewOrderCloseOpositeOne, comment);
            }
            else if(entry_price > ask + stop_level * MarketInfo(symbol, MODE_POINT)) {
               Opentrade(symbol, entry_price, OP_BUYSTOP, lt, sl, tp, magic, OnNewOrderCloseOpositeOne, comment);
            }
            else if(entry_price < ask - stop_level * MarketInfo(symbol, MODE_POINT)) {
               Opentrade(symbol, ask, OP_BUY, lt, sl, tp, magic, OnNewOrderCloseOpositeOne, comment);
            }
         }
      } 
      else {
         SetSymbolsIntArray(symbol, 1, SymbolsSignal);
      }
   }
   else if(dir == Down) {
      if(RetrieveValueFromArray_int(symbol, SymbolsSignal, Symbols) == -1 || IsTesting()) {   
         if(!ExistOpenOrderOnThisLevel(symbol, Down, entry_price)) {
            lt = CalculateDesiredLot(symbol, OP_SELL, sl, entry_price);
            lt = ReajustLote(symbol, lt);
            if(lt == 0) return;
            if(!RiskRewardValidation(OP_SELL, entry_price, tp, sl, risk))return;  
            
            DeletePendingOrders(symbol, Up);
            DeletePendingOrders(symbol, Down);
            //Entry
            if(NormalizeDouble(entry_price, (int)MarketInfo(symbol, MODE_DIGITS)) == NormalizeDouble(bid, (int)MarketInfo(symbol, MODE_DIGITS))) {
               Opentrade(symbol, entry_price, OP_SELL, lt, sl, tp, magic, OnNewOrderCloseOpositeOne, comment);
            }
            else if(entry_price < bid - stop_level * MarketInfo(symbol, MODE_POINT)) {
               Opentrade(symbol, entry_price, OP_SELLSTOP, lt, sl, tp, magic, OnNewOrderCloseOpositeOne, comment);
            }
            else if(entry_price > bid + stop_level * MarketInfo(symbol, MODE_POINT)) {
               Opentrade(symbol, bid, OP_SELL, lt, sl, tp, magic, OnNewOrderCloseOpositeOne, comment);
            }
         }
      }
      else {
         SetSymbolsIntArray(symbol, -1, SymbolsSignal);
      }  
   }
}
//+------------------------------------------------------------------+
bool Opentrade(string symbol, double price, int type, double lt, double sl, double tp, int magic, bool close_oposite_order, string comment)
{   
   bool result = false;
   int ticket = 0, l = 0;
   double lote_array[];
   LotSplit(symbol, lt, lote_array);
   string mytype = "";
  
   if (type == OP_BUY || type == OP_BUYSTOP || type == OP_BUYLIMIT) {
      if(close_oposite_order) {
         CloseOrders(symbol, OP_SELL, magic);
      }
      for(l = 0; l < ArraySize(lote_array); l++) {
         lt = lote_array[l];
         ticket=OrderSend(symbol, type, NormalizeDouble(lt, 2), NormalizeDouble(price, (int)MarketInfo(symbol, MODE_DIGITS)), 3, NormalizeDouble(sl, (int)MarketInfo(symbol, MODE_DIGITS)), NormalizeDouble(tp, (int)MarketInfo(symbol, MODE_DIGITS)), comment, magic, 0, Blue);
         SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
         //TakeProfitAudit(ticket);
     }
   } 
   else  if (type == OP_SELL || type == OP_SELLSTOP || type == OP_SELLLIMIT) {
      if(close_oposite_order) {
         CloseOrders(symbol, OP_BUY, magic);
      }
      for(l = 0; l < ArraySize(lote_array); l++) {
         lt = lote_array[l];
         ticket=OrderSend(symbol, type, NormalizeDouble(lt, 2), NormalizeDouble(price, (int)MarketInfo(symbol, MODE_DIGITS)), 3, NormalizeDouble(sl, (int)MarketInfo(symbol, MODE_DIGITS)), NormalizeDouble(tp, (int)MarketInfo(symbol, MODE_DIGITS)), comment, magic , 0, Red);
         SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
         //TakeProfitAudit(ticket);
      }
   }

   int lasterror = GetLastError();
   if(ticket < 0) {
      if(lasterror > 0) {
         if(type == OP_BUY)mytype = "BUY";
         else if(type == OP_SELL)mytype = "SELL";
         else if(type == OP_BUYSTOP)mytype = "BUY STOP";
         else if(type == OP_SELLSTOP)mytype = "SELL STOP";
         
         if(!RetrieveValueFromArray_bool(symbol, Symbols_OpenOrderErrors, Symbols)) {
            SendEmail(2, 0, 0, "Order Open Error: Symbol: "+symbol+" ### Type: "+mytype+" ### Lote: "+DoubleToString(lt, 2)+" ### OP: "+DoubleToString(price, (int)MarketInfo(symbol, MODE_DIGITS))+
            " ### SL: "+DoubleToString(sl, (int)MarketInfo(symbol, MODE_DIGITS))+" ### TP: "+DoubleToString(tp, (int)MarketInfo(symbol, MODE_DIGITS))+" ### Ask: "+
            DoubleToString(SymbolInfoDouble(symbol, SYMBOL_ASK))+" ### Bid: "+DoubleToString(SymbolInfoDouble(symbol, SYMBOL_BID))+
            " Error number: "+IntegerToString(lasterror));
         }
      }
      SetOpenOrderErrorArray(symbol);
  }
  else {
      result = true;
  }
  
  return result;
}
//+------------------------------------------------------------------+
void FillSignals(int timeframe, int shift) {
   string symbol = "";
   double fiboLevelsUP[5];
   double fiboLevelsDN[5];
   int resUP = 0, resDN = 0;
   ArrayInitialize(FibonacciSignalUP, 0);
   ArrayInitialize(FibonacciSignalDN, 0);
   ArrayInitialize(FibonacciSignalUPLevels, 0);
   ArrayInitialize(FibonacciSignalDNLevels, 0);

   if(StartBar_M5) {      
      for(int i = 0; i < ArraySize(Symbols); i++) {      
         symbol = GetString(Symbols[i], ";", 0);
         ArrayInitialize(fiboLevelsUP, 0);
         ArrayInitialize(fiboLevelsDN, 0);
         FibonacciSignalUP[i] = FillZigZagLevels(symbol, timeframe, fiboLevelsUP, 1, shift);
         FibonacciSignalDN[i] = FillZigZagLevels(symbol, timeframe, fiboLevelsDN, -1, shift);
         //UP
         if(FibonacciSignalUP[i] > 0) {
            for(int x = 0; x < ArraySize(fiboLevelsUP); x++) {
               FibonacciSignalUPLevels[i][x] = fiboLevelsUP[x];
            }
         }
         //DN
         if(FibonacciSignalDN[i] < 0) {
            for(int x = 0; x < ArraySize(fiboLevelsDN); x++) {
               FibonacciSignalDNLevels[i][x] = fiboLevelsDN[x];
            }         
         }
      }
   }
}
//+------------------------------------------------------------------+
bool ValidateFiboLinesTouch(string symbol, int timeframe, int type, double &fibo[], int shift) {
   bool result = false;
   double open = iOpen(symbol, timeframe, shift);
   double low = iLow(symbol, timeframe, shift);
   double high = iLow(symbol, timeframe, shift);
   double close = iClose(symbol, timeframe, shift);
   double value = 0;
   
   if(type == 1) {
      for(int i = 0; i < ArraySize(fibo); i++) {
         value = fibo[i];
         if(open > value && low < value && close > value) {
            result = true;
            break;
         }
      }   
   }
   else if(type == -1) {
      for(int i = 0; i < ArraySize(fibo); i++) {
         value = fibo[i];
         if(open < value && high > value && close < value) {
            result = true;
            break;
         }
      }   
   } 
   
   return result;
}
//+------------------------------------------------------------------+
void RefreshBalances() {
   LastWeekClosedBalance = CalculateLastPeriodClosedBalance(1);
   LastMonthClosedBalance = CalculateLastPeriodClosedBalance(2);
   YesterdayClosedBalance = CalculateLastPeriodClosedBalance(3);  
}
/*
//+------------------------------------------------------------------+
void CheckChangeOnFractal(int timeframe) {
   string symbol = "";
   double fractal_up = 0, fractal_dn = 0;
   double last_up = 0, last_dn = 0;
   
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      fractal_up = LastFractal(symbol, timeframe, Up);
      fractal_dn = LastFractal(symbol, timeframe, Down);  
      last_up = LastFractalUPPoint[i];
      last_dn = LastFractalDNPoint[i];
      
      //Fractal UP
      if(last_up == 0) {
         LastFractalUPPoint[i] = fractal_up; 
      }
      else if(last_up != fractal_up) {
         if(CountOrdersPending(symbol) > 0) {
            DeletePendingOrders(symbol, Up);
            DeletePendingOrders(symbol, Down);         
         } 
         LastFractalUPPoint[i] = fractal_up; 
      }
      
      //Fractal DN   
      if(last_dn == 0) {
         LastFractalDNPoint[i] = fractal_dn;        
      }
      else if(last_dn != fractal_dn) {
         if(CountOrdersPending(symbol) > 0) {         
            DeletePendingOrders(symbol, Up);
            DeletePendingOrders(symbol, Down);        
         }
         LastFractalDNPoint[i] = fractal_dn;      
      }
   }
}
*/
//+------------------------------------------------------------------+
int CountOrdersMarketOrder(string symbol) {
   int result = 0;
   int cnt = 0;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderSymbol() == symbol && (OrderType() == OP_BUY || OrderType() == OP_SELL)) {
         result++;
      }
   }
   
   return result;  
}
//+------------------------------------------------------------------+
int CountOrdersPending(string symbol) {
   int result = 0;
   int cnt = 0;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {
         result++;
      }
   }
   
   return result;  
}
//+------------------------------------------------------------------+
int CountOrders(string symbol, int type) {
   int result = 0;
   int cnt = 0;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderSymbol() == symbol && OrderType() == type) {
         result++;
      }
   }
   
   return result;  
}
//+------------------------------------------------------------------+
bool CheckExistingOrder_byMagic(string symbol, int type, int magic) {
   bool result = false;
   int cnt = 0;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(type == Up) {
         if(OrderSymbol() == symbol && (OrderType() == OP_BUY || OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT) && OrderMagicNumber() == magic) {
            result = true;
            break;
         }      
      }
      else if(type == Down) {
         if(OrderSymbol() == symbol && (OrderType() == OP_SELL || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) && OrderMagicNumber() == magic) {
            result = true;
            break;
         }        
      }
   }
   
   return result;  
}
//+------------------------------------------------------------------+
bool OrderExist(string symbol, int type, double magic) {
   bool result = false;
   int cnt = 0;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderSymbol() == symbol && OrderType() == type && OrderMagicNumber() == magic) {
         result = true;
      }
   }
   
   return result;  
}
//+------------------------------------------------------------------+
int CountOrders() {
   int result = 0;
   int cnt = 0;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderType() == OP_BUY || OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT || 
         OrderType() == OP_SELL || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {
         result++;
      }
   }
   
   return result;  
}
//+------------------------------------------------------------------+
double GetDouble(string value, string separator, int position) {
   string sep = separator;                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
                                  //--- Get the separator code
   if (value == "") {
      return 0;
   }

   u_sep = StringGetCharacter(sep, 0);
   if (StringLen(value) == 0) {
      return 0;
   }
   
   //--- Split the string to substrings
   int k = StringSplit(value, u_sep, result);
   if (ArraySize(result) > position) {
      return StringToDouble(result[position]);
   }
   else {
      return 0;
   }
}
//+------------------------------------------------------------------+
void GetStringToArray(string value, string separator, string &result[]) {
   string sep = separator;                // A separator as a character
   ushort u_sep;                  // The code of the separator character
                                  //--- Get the separator code
   if (value != "") {
      u_sep = StringGetCharacter(sep, 0);      
      //--- Split the string to substrings
      int k = StringSplit(value, u_sep, result);
   }
}
//+------------------------------------------------------------------+
string GetString(string value, string separator, int position) {
   string sep = separator;                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
                                  //--- Get the separator code
   u_sep = StringGetCharacter(sep, 0);
   if (StringLen(value) == 0) {
      return "";
   }
   if (position == -1) {
      return "X";
   }

    //--- Split the string to substrings
   long k = StringSplit(value, u_sep, result);
   if (ArraySize(result) > position) {
      return result[position];
   }
   else {
      return "";
   }
}
//+------------------------------------------------------------------+
int GetIntiger(string value, string separator, int position) {
   string sep = separator;                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
                                  //--- Get the separator code
   if (value == "") {
      return 0;
   }

   u_sep = StringGetCharacter(sep, 0);
   if (StringLen(value) == 0) {
      return 0;
   }
   
   //--- Split the string to substrings
   int k = StringSplit(value, u_sep, result);
   if (ArraySize(result) > position) {
      return StrToInteger(result[position]);
   }
   else {
      return 0;
   }
}
//+------------------------------------------------------------------+
long GetDateTime(string value, string separator, int position) {
   string sep = separator;                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
                                  //--- Get the separator code
   if (value == "") {
      return 0;
   }

   u_sep = StringGetCharacter(sep, 0);
   if (StringLen(value) == 0) {
      return 0;
   }
   
   //--- Split the string to substrings
   long k = StringSplit(value, u_sep, result);
   if (ArraySize(result) > position) {
      return long(result[position]);
   }
   else {
      return 0;
   }
}
//+------------------------------------------------------------------+
bool RetrieveValueFromArray_bool(string key, bool &array[], string &loop_array[]) {
   bool result = false;
   int i = 0;
   for (i = 0; i < ArraySize(loop_array); i++) {
      if (key == GetString(loop_array[i], ";", 0)) {
         result = array[i];
         break;
      }
   }

   return result;
}
//+------------------------------------------------------------------+
bool CheckEnableTrading() {
   int i = 0;
   bool result = IsTradeAllowed();
   return result;
}
//+------------------------------------------------------------------+
bool CheckMondayTradingHours() {
   bool result = true;
   int hour = TimeHour(TimeCurrent());
   int day_of_week = DayOfWeek();
   
   if(day_of_week == 1 && hour < MondayStartTradingHour) {
      result = false;
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool OnTradingHour(string start_time, string end_time) {
   bool result = false;
   int hour = TimeHour(TimeCurrent());
   int minute = TimeMinute(TimeCurrent());
   int start_trading_hour = GetIntiger(start_time, ":", 0);
   int start_trading_minute = GetIntiger(start_time, ":", 1);
   int end_trading_hour = GetIntiger(end_time, ":", 0);
   int end_trading_minute = GetIntiger(end_time, ":", 1);   
   
   if(hour > start_trading_hour) {
      if(hour < end_trading_hour) {
         result = true;
      }
      else if(hour == end_trading_hour) {
         if(minute < end_trading_minute) {
            result = true;
         }
      }
   }
   else if(hour == start_trading_hour && minute >= start_trading_minute) {
      if(hour < end_trading_hour) {
         result = true;
      }
      else if(hour == end_trading_hour) {
         if(minute < end_trading_minute) {
            result = true;
         }
      }   
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool IsValidateSpread(string symbol) {
   bool result = true; 
   double maxSpread = 0;    
   double spread = MarketInfo(symbol, MODE_SPREAD);
    
   for(int i = 0; i < ArraySize(Symbols); i++) {
      if(GetString(Symbols[i], ";", 0) == symbol) {
         maxSpread = GetDouble(Symbols[i], ";", 3);
         break;
      }
   }
    
   if (spread > maxSpread && !IsTesting()) {
      result = false;
   }

   return result;
}
//+------------------------------------------------------------------+
bool IsNewBar_M1() {
   datetime thisOpenTime_m1 = iTime(_Symbol, Timeframe_M1, 0);
   if (thisOpenTime_m1 != lastOpenTime_m1) {
      lastOpenTime_m1 = thisOpenTime_m1;
      return (true);
   }
   else return (false);
}
//+------------------------------------------------------------------+
bool IsNewBar_M5() {
   datetime thisOpenTime_m5 = iTime(_Symbol, Timeframe_M5, 0);
   if (thisOpenTime_m5 != lastOpenTime_m5) {
      lastOpenTime_m5 = thisOpenTime_m5;
      return (true);
   }
   else return (false);
}
//+------------------------------------------------------------------+
bool IsNewBar_M15() {
   datetime thisOpenTime_m15 = iTime(_Symbol, Timeframe_M15, 0);
   if (thisOpenTime_m15 != lastOpenTime_m15) {
      lastOpenTime_m15 = thisOpenTime_m15;
      return (true);
   }
   else return (false);
}
//+------------------------------------------------------------------+
bool IsNewBar_M30() {
   datetime thisOpenTime_m30 = iTime(_Symbol, Timeframe_M30, 0);
   if (thisOpenTime_m30 != lastOpenTime_m30) {
      lastOpenTime_m30 = thisOpenTime_m30;
      return (true);
   }
   else return (false);
}
//+------------------------------------------------------------------+
bool IsNewBar_H1() {
   datetime thisOpenTime_h1 = iTime(_Symbol, Timeframe_H1, 0);
   if (thisOpenTime_h1 != lastOpenTime_h1) {
      lastOpenTime_h1 = thisOpenTime_h1;
      return (true);
   }
   else return (false);
}
//+------------------------------------------------------------------+
bool IsNewBar_H4() {
   datetime thisOpenTime_h4 = iTime(_Symbol, Timeframe_H4, 0);
   if (thisOpenTime_h4 != lastOpenTime_h4) {
      lastOpenTime_h4 = thisOpenTime_h4;
      return (true);
   }
   else return (false);
}
//+------------------------------------------------------------------+
bool IsNewBar_Daily() {
   datetime thisOpenTime_d = iTime(_Symbol, Timeframe_D, 0);
   if (thisOpenTime_d != lastOpenTime_d) {
      lastOpenTime_d = thisOpenTime_d;
      return (true);
   }
   else return (false);
}
//+------------------------------------------------------------------+
void CloseOrders(string symbol, int type, int magic) {  
   int total = OrdersTotal() - 1;   
   string orders[1];
   ArrayResize(orders, OrdersTotal());
   double close_price = 0;
   for (int i = total; i >= 0; i--) {
      close_price = 0;
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))  {        
         if (OrderSymbol() == symbol && OrderType() == type && OrderMagicNumber() == magic) {
            if(type == OP_BUY) close_price = SymbolInfoDouble(symbol, SYMBOL_BID);
            else if(type == OP_SELL) close_price = SymbolInfoDouble(symbol, SYMBOL_ASK);
            orders[i] = IntegerToString(OrderTicket()) +";"+ DoubleToString(OrderLots(), 2) +";"+ DoubleToString(close_price);
         }
      }    
   } 
   
   CloseOrdersArray(orders);
}
//+------------------------------------------------------------------+
void CloseOrders(string symbol) {  
   int total = OrdersTotal() - 1;   
   string orders[1];
   ArrayResize(orders, OrdersTotal());
   double close_price = 0;
   for (int i = total; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))  {      
         close_price = 0;  
         if (OrderSymbol() == symbol) {
            if(OrderType() == OP_BUY) {
               close_price = SymbolInfoDouble(symbol, SYMBOL_BID);
               orders[i] = IntegerToString(OrderTicket()) +";"+ DoubleToString(OrderLots(), 2) +";"+ DoubleToString(close_price);
            }
            else if(OrderType() == OP_SELL) {
               close_price = SymbolInfoDouble(symbol, SYMBOL_ASK);    
               orders[i] = IntegerToString(OrderTicket()) +";"+ DoubleToString(OrderLots(), 2) +";"+ DoubleToString(close_price);     
            }
            else if(OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {
               CloseOrder(OrderTicket(), OrderLots(), OrderType(), OrderSymbol(), false);
            }
         }
      }    
   } 
   
   CloseOrdersArray(orders);
}
//+------------------------------------------------------------------+
void CloseOrders() {  
   int total = OrdersTotal() - 1;   
   int type;
   string symbol;
   double close_price = 0;
   bool res = false;
   Print("Start CloseOrders");
   for (int i = total; i >= 0; i--) {
      close_price = 0;
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))  {        
         type = OrderType();
         symbol = OrderSymbol();
         if(type == OP_BUY) close_price = SymbolInfoDouble(symbol, SYMBOL_BID);
         else if(type == OP_SELL) close_price = SymbolInfoDouble(symbol, SYMBOL_ASK);         
         res = OrderClose(OrderTicket(), OrderLots(), close_price, 0);
      }    
   }
   Print("End CloseOrders"); 
}
//+------------------------------------------------------------------+
void CloseOrdersWithExcept(string symbol, int type_except, int magic_except) {  
   int total = OrdersTotal() - 1;   
   double close_price = 0;
   bool res = false;
   
   for (int i = total; i >= 0; i--) {
      close_price = 0;
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))  {        

         if(OrderSymbol() == symbol) {
            if(OrderType() == type_except && OrderMagicNumber() == magic_except) continue;
            
            if(OrderType() == OP_BUY) close_price = SymbolInfoDouble(symbol, SYMBOL_BID);
            else if(OrderType() == OP_SELL) close_price = SymbolInfoDouble(symbol, SYMBOL_ASK);         
            res = OrderClose(OrderTicket(), OrderLots(), close_price, 0);
            SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
         }
      }    
   }
}
//+------------------------------------------------------------------+
void ClosePendingOrder(string symbol, int type) {  
   int total = OrdersTotal() - 1;   
   double close_price = 0;
   bool res = false;
   
   for (int i = total; i >= 0; i--) {
      close_price = 0;
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))  {        

         if(OrderSymbol() == symbol) {
            if(type == Up) {
               if(OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT) {
                  res = OrderDelete(OrderTicket());
                  SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
               }
            }
            else if(type == Down) {
               if(OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {
                  res = OrderDelete(OrderTicket());
                  SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
               }
            }
         }
      }    
   }
}
//+------------------------------------------------------------------+
void CloseOrder(int ticket, double numLots, int type, string symbol, bool send_message) {
   bool result = false;
   double myPrice = 0;

   if (type == OP_BUY) {
      myPrice = SymbolInfoDouble(symbol, SYMBOL_BID);
      result = OrderClose(ticket, numLots, myPrice, 3, Violet);
   }
   else if (type == OP_SELL) {
      myPrice = SymbolInfoDouble(symbol, SYMBOL_ASK);
      result = OrderClose(ticket, numLots, myPrice, 3, Violet);
   }
   else if (type == OP_BUYSTOP || type == OP_SELLSTOP) { 
      result = OrderDelete(ticket);
   }
   
   SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
   if(result && send_message) SendEmail(2, 0, 0, "Order Closed: Tickect: "+IntegerToString(ticket));
   else if(send_message) SendEmail(2, 0, 0, "Error On Close Order "+IntegerToString(ticket)+" Order Number: "+IntegerToString(GetLastError()));
}
//+------------------------------------------------------------------+
void CloseOrdersArray(string &orders[]) {
   bool closed = false;
   for(int i = 0; i < ArraySize(orders); i++) {
      if(GetIntiger(orders[i], ";", 0) > 0) {
         closed = OrderClose(GetIntiger(orders[i], ";", 0), GetDouble(orders[i], ";", 1), GetDouble(orders[i], ";", 2), 20, Yellow);
         SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
      }
   }
}
//+------------------------------------------------------------------+
double CalculateDesiredLot(string symbol, int type, double sl, double op) {
   double point;
   if (StringFind(symbol, "JPY") < 0) point = 0.0001; else point = 0.01;
   double sl_pips = 0;
   double lote = 0;
   
   if(type == OP_BUY || type == OP_BUYSTOP) {
      sl_pips = (op - sl) / point;
   }
   else if(type == OP_SELL || type == OP_SELLSTOP) {
      sl_pips = (sl - op) / point;
   }
    
   lote = CalculateLotSize(symbol, sl_pips);

   if (lote < MarketInfo(symbol, MODE_MINLOT)) {
      if(MarketInfo(symbol, MODE_MINLOT) == 0.01) {
         lote = MarketInfo(symbol, MODE_MINLOT);
      }
      else {
         lote = 0;
      }
   }

   return lote;
}
//+------------------------------------------------------------------+
//We define the function to calculate the position size and return the lot to order
//Only parameter the Stop Loss, it will return a double
double CalculateLotSize(string symbol, double sl) { //Calculate the size of the position size 
   double riskPercentage = GetRiskPercentage(symbol);
   double lotSize=0;
   //We get the value of a tick
   double nTickValue=MarketInfo(symbol, MODE_TICKVALUE);
   //If the digits are 3 or 5 we normalize multiplying by 10
   if(Digits==3 || Digits==5){
      nTickValue=nTickValue*10;
   }
   
   if(nTickValue == 0) return 0;
   
   //We apply the formula to calculate the position size and assign the value to the variable
   if(UseAccountEquityToCalculateLot) {
      lotSize = (AccountEquity() * riskPercentage / 100) / (sl * nTickValue);
   }
   else {
      lotSize = (YesterdayClosedBalance * riskPercentage / 100) / (sl * nTickValue);
   }
   
   return lotSize;
}
//+------------------------------------------------------------------+
double GetRiskPercentage(string symbol) {  
   double risk = 0;    
   for(int i = 0; i < ArraySize(Symbols); i++) {
      if(GetString(Symbols[i], ";", 0) == symbol) {
         risk = GetDouble(Symbols[i], ";", 2);
         break;
      }
   }

   return risk;
}
//+------------------------------------------------------------------+
double GetTakeProfitMultiplier(string symbol) {  
   double tp_multiplier = 0;    
   for(int i = 0; i < ArraySize(Symbols); i++) {
      if(GetString(Symbols[i], ";", 0) == symbol) {
         tp_multiplier = GetDouble(Symbols[i], ";", 4);
         break;
      }
   }

   return tp_multiplier;
}
//+------------------------------------------------------------------+
void SetOpenOrderErrorArray(string symbol) {
   int i = 0;
   
   for(i = 0; i < ArraySize(Symbols); i++) {
      if(GetString(Symbols[i], ";", 0) == symbol) {
         Symbols_OpenOrderErrors[i] = true;
         break;
      }
   }
}
//+------------------------------------------------------------------+
void SetSymbolsIntArray(string symbol, int value, int &array[]) {
   int i = 0;
   
   for(i = 0; i < ArraySize(Symbols); i++) {
      if(GetString(Symbols[i], ";", 0) == symbol) {
         array[i] = value;
         break;
      }
   }
}
//+------------------------------------------------------------------+
void SendEmail(int type, int error, int ticket, string message) {
   double CurrentOpenedLot = 0;
   int l_pos_4 = 0;
   string or_type = "";
   long order_close = 0;
   double week_result = 0;
   double week_lot = 0;
   double this_month_result = 0;
   double this_month_deposit = 0;
   double this_month_withdrawal = 0;
   double month_lot = 0;
   double commission = 0;
   double week_commission = 0;
   double week_swap = 0;
   double month_commission = 0;
   double month_swap = 0;
   double CurrentPips = 0;
   int b = 0, s = 0, b_s = 0, s_s = 0, b_l = 0, s_l = 0;
   long this_week_open = 0;
   string title = AccountInfoString(ACCOUNT_COMPANY) + " - " + IntegerToString(AccountNumber()) + ": ";
   double daily_percentage_equity = 0, daily_balance = 0;

   CalculateOrderCostPeriod(week_lot, week_commission, week_swap, month_lot, month_commission, month_swap);
   week_result = AccountBalance() - LastWeekClosedBalance;
   this_month_result = AccountBalance() - LastMonthClosedBalance;

   if (type == 1) { // Account Details
      for (l_pos_4 = OrdersTotal() - 1; l_pos_4 >= 0; l_pos_4--) {
         if (!OrderSelect(l_pos_4, SELECT_BY_POS, MODE_TRADES)) {
            continue;
         }
         if (OrderType() == OP_SELL) {
            s++;
         }
         else if (OrderType() == OP_BUY) {
            b++;
         }
         else if (OrderType() == OP_SELLSTOP) {
            s_s++;
         }
         else if (OrderType() == OP_BUYSTOP) {
            b_s++;
         }
         else if (OrderType() == OP_BUYLIMIT) {
            b_l++;
         }
         else if (OrderType() == OP_SELLLIMIT) {
            s_l++;
         }         
      }

      long this_month_open = iTime(Symbol(), Timeframe_MN, 0);
      for (l_pos_4 = OrdersHistoryTotal() - 1; l_pos_4 >= 0; l_pos_4--) {
         if (!OrderSelect(l_pos_4, SELECT_BY_POS, MODE_HISTORY)) {
            continue;
         }
         order_close = OrderCloseTime();
         if (order_close > this_month_open) {
            if (OrderType() == 6) {
               if (OrderProfit() > 0) {
                  this_month_deposit += OrderProfit();
               }
               else {
                   this_month_withdrawal += OrderProfit();
               }
            }
         }
      }

      //---------------------------------------------------------------------
      double open_result = 0;
      string text = "<html>";
      //Open Orders
      if(UseDailyGoalPercentage) text = StringConcatenate(text, "<h2><font color='black'>Result:</font></h2>");
      else text = StringConcatenate(text, "<h2><font color='black'>Open Orders Result:</font></h2>");
      text = StringConcatenate(text, "<table border = '1'><tr bgcolor='LightSeaGreen'><th>Lots</th><th>Gross Result</th><th>Commission</th><th>Swap</th><th>Net Result</th><th>Equity</th>");
      if(UseDailyGoalPercentage)text = StringConcatenate(text, "<th>Daily Target</th><th>Target Equity</th></tr>");
      else text = StringConcatenate(text, "</tr>");

      double profit = 0;
      double pips_to_target = 0;
      double bid_ask = 0; double p = 0;
      int x = 0; long last_time = 0, last_minute = 0;
      double max_lote = 0, max_gross_result = 0, max_pips = 0, max_commission = 0, max_swap = 0, max_net_result = 0;
      double base_currency_strength = 0;
      double counter_currency_strength = 0;

      for (l_pos_4 = OrdersTotal() - 1; l_pos_4 >= 0; l_pos_4--) {
         if (!OrderSelect(l_pos_4, SELECT_BY_POS, MODE_TRADES)) {
            continue;
         }
         
         if(OrderType() == OP_BUY || OrderType() == OP_SELL) {
            profit = 0;
            pips_to_target = 0;
            
            max_lote += OrderLots(); 
            max_gross_result += OrderProfit(); 
            max_commission += OrderCommission(); 
            max_swap += OrderSwap();
         }
      }
     
      max_net_result = max_gross_result + max_commission + max_swap;
      string saved_message = ReadSavedServerMessages();
      int server_message = 0;
      if(StringLen(saved_message) > 0) {
         server_message = GetIntiger(saved_message, ";", 1);            
      }      

      //Total
      if (ShowDailyGoalPercentage && max_gross_result > 0) {
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(max_lote, 2)) + " </b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(max_gross_result, 2)) + " "+AccountCurrency()+"</b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(max_commission, 2)) + " "+AccountCurrency()+"</b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(max_swap, 2)) + " "+AccountCurrency()+"</b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(max_net_result, 2)) + " "+AccountCurrency()+" </b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(AccountEquity(), 2)) + " "+AccountCurrency()+" </b></font></h3></td>");
         if(UseDailyGoalPercentage) {
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(DailyGoalPercentage, 2)) + " % "+" </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString((YesterdayClosedBalance+(YesterdayClosedBalance*(DailyGoalPercentage/100))), 2)) + " "+AccountCurrency()+" </b></font></h3></td>");
         }
      }
      else if (ShowDailyGoalPercentage && max_gross_result < 0) {
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(max_lote, 2)) + " </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(max_gross_result, 2)) + " "+AccountCurrency()+"</b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(max_commission, 2)) + " "+AccountCurrency()+"</b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(max_swap, 2)) + " "+AccountCurrency()+"</b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(max_net_result, 2)) + " "+AccountCurrency()+" </b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(AccountEquity(), 2)) + " "+AccountCurrency()+" </b></font></h3></td>");
         if(UseDailyGoalPercentage) {
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(DailyGoalPercentage, 2)) + " % "+" </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString((YesterdayClosedBalance+(YesterdayClosedBalance*(DailyGoalPercentage/100))), 2)) + " "+AccountCurrency()+" </b></font></h3></td>");         
         }
      }
      else if (ShowDailyGoalPercentage && max_gross_result == 0) {
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(max_lote, 2)) + " </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(max_gross_result, 2)) + " "+AccountCurrency()+"</b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(max_commission, 2)) + " "+AccountCurrency()+"</b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(max_swap, 2)) + " "+AccountCurrency()+"</b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(max_net_result, 2)) + " "+AccountCurrency()+" </b></font></h3></td>");
         text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(AccountEquity(), 2)) + " "+AccountCurrency()+" </b></font></h3></td>");         
         if(UseDailyGoalPercentage) {
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(DailyGoalPercentage, 2)) + " % "+" </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString((YesterdayClosedBalance+(YesterdayClosedBalance*(DailyGoalPercentage/100))), 2)) + " "+AccountCurrency()+" </b></font></h3></td>");         
         }
      }
      text = StringConcatenate(text, "</table>");
      //---------------------------------------------------------------------
      text = StringConcatenate(text, "<br>");
      string type_order = "", symbol = "";
      double total_total = 0;
      text = StringConcatenate(text, "<h2><font color='black'>Last Hour Closed Orders:</font></h2>");
      text = StringConcatenate(text, "<table border = '1'><tr bgcolor='LightSeaGreen'><th> # </th><th>Symbol</th><th>Type</th><th>Closed At</th><th>Open Price</th><th>Close Price</th><th>Net Result</th></tr>");
      int op = 0;
      datetime last_hour_start = iTime(_Symbol, Timeframe_H1, 1);
      datetime last_hour_end = iTime(_Symbol, Timeframe_H1, 0);
      datetime closed_at;

      for (int cnt = OrdersHistoryTotal() - 1; cnt >= 0; cnt--) {
         if (!OrderSelect(cnt, SELECT_BY_POS, MODE_HISTORY)) {
            continue;
         }            
         closed_at = OrderCloseTime();
         if(closed_at < last_hour_start || closed_at > last_hour_end) continue;

         symbol = OrderSymbol();
         profit = OrderProfit() + OrderSwap() + OrderCommission();  
         total_total += profit;
         if(OrderType() == OP_BUY)type_order = "BUY";
         else if(OrderType() == OP_SELL)type_order = "SELL";
         else if(OrderType() == OP_BUYSTOP)type_order = "BUY STOP";
         else if(OrderType() == OP_SELLSTOP)type_order = "SELL STOP";
         op++;
         
         text = StringConcatenate(text, "<tr>");
         if(profit > 0) {
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(IntegerToString(op)) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + symbol + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + type_order + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + TimeToString(OrderCloseTime()) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(OrderOpenPrice(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(OrderClosePrice(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
            if(StringFind(OrderComment(), "[tp]", 0) >= 0) {
               text = StringConcatenate(text, "<td style='text-align:center' bgcolor='green'><h3><font color='black'><b>" + NumberFormat(DoubleToString(profit, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");
            }
            else if(StringFind(OrderComment(), "[sl]", 0) >= 0) {
               text = StringConcatenate(text, "<td style='text-align:center' bgcolor='red'><h3><font color='black'><b>" + NumberFormat(DoubleToString(profit, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");
            }
            else {
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(profit, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");
            }
         }
         else if(profit < 0){
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(IntegerToString(op)) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + symbol + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + type_order + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + TimeToString(OrderCloseTime()) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(OrderOpenPrice(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(OrderClosePrice(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");            
            if(StringFind(OrderComment(), "[sl]", 0) >= 0) {
               text = StringConcatenate(text, "<td style='text-align:center' bgcolor='red'><h3><font color='black'><b>" + NumberFormat(DoubleToString(profit, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");
            }
            else {
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(profit, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");         
            }
         }
         else {
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(IntegerToString(op)) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + symbol + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + type_order + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + TimeToString(OrderCloseTime()) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(OrderOpenPrice(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(OrderClosePrice(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");            
            text = StringConcatenate(text, "<td style='text-align:right'><h3><font color='black'><b>" + NumberFormat(DoubleToString(profit, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");                     
         }
         text = StringConcatenate(text, "</tr>");
      }
      text = StringConcatenate(text, "<tr>");
      text = StringConcatenate(text, "<td style='text-align:right' colspan='6'><h3><font color='black'><b> Total </b></font></h3></td>");         
      if(total_total > 0) {
         text = StringConcatenate(text, "<td style='text-align:right'><h3><font color='green'><b>" + NumberFormat(DoubleToString(total_total, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");
      }
      else if(total_total < 0) {
         text = StringConcatenate(text, "<td style='text-align:right'><h3><font color='red'><b>" + NumberFormat(DoubleToString(total_total, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");
      }
      else {
         text = StringConcatenate(text, "<td style='text-align:right'><h3><font color='black'><b>" + NumberFormat(DoubleToString(total_total, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");
      }
      text = StringConcatenate(text, "</tr>");
      text = StringConcatenate(text, "</table>");                
      //---------------------------------------------------------------------
      text = StringConcatenate(text, "<br>");
      double open_lots = 0, pending_lots = 0;
      double swap = 0;
      op = 0;
      if(ShowOpenOrdersOnResumeEmail) {
         text = StringConcatenate(text, "<h2><font color='black'>Open Orders:</font></h2>");
         text = StringConcatenate(text, "<table border = '1'><tr bgcolor='LightSeaGreen'><th> # </th><th>Symbol</th><th>Type</th><th>Open Time</th><th>Open Price</th><th>Stop Loss</th><th>Take Profit</th><th>Bid / Ask</th><th>Lots</th><th>Commission</th><th>Swap</th><th>Net Result</th></tr>");
         for (int cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
            if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
               continue;
            }            
            
            symbol = OrderSymbol();
            profit = OrderProfit() + OrderSwap() + OrderCommission(); 
            swap = OrderSwap();
            commission = OrderCommission();
            open_lots = OrderLots();            
            if(OrderType() == OP_BUY)type_order = "BUY";
            else if(OrderType() == OP_SELL)type_order = "SELL";
            else if(OrderType() == OP_BUYSTOP)type_order = "BUY STOP";
            else if(OrderType() == OP_SELLSTOP)type_order = "SELL STOP";
            op++;
            
            text = StringConcatenate(text, "<tr>");
            if(profit > 0) {
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(IntegerToString(op)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + symbol + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + type_order + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + TimeToString(OrderOpenTime()) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(OrderOpenPrice(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(OrderStopLoss(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(OrderTakeProfit(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(SymbolInfoDouble(symbol, SYMBOL_BID), (int)MarketInfo(symbol, MODE_DIGITS))) + " / " + NumberFormat(DoubleToString(SymbolInfoDouble(symbol, SYMBOL_ASK), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(open_lots, 2)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(commission, 2)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(swap, 2)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + NumberFormat(DoubleToString(profit, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");
            }
            else if(profit < 0){
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(IntegerToString(op)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + symbol + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + type_order + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + TimeToString(OrderOpenTime()) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(OrderOpenPrice(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(OrderStopLoss(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(OrderTakeProfit(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(SymbolInfoDouble(symbol, SYMBOL_BID), (int)MarketInfo(symbol, MODE_DIGITS))) + " / " + NumberFormat(DoubleToString(SymbolInfoDouble(symbol, SYMBOL_ASK), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");               
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(open_lots, 2)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(commission, 2)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(swap, 2)) + " </b></font></h3></td>");               
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='red'><b>" + NumberFormat(DoubleToString(profit, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");         
            }
            else {
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(IntegerToString(op)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + symbol + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + type_order + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + TimeToString(OrderOpenTime()) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(OrderOpenPrice(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(OrderStopLoss(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(OrderTakeProfit(), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(SymbolInfoDouble(symbol, SYMBOL_BID), (int)MarketInfo(symbol, MODE_DIGITS))) + " / " + NumberFormat(DoubleToString(SymbolInfoDouble(symbol, SYMBOL_ASK), (int)MarketInfo(symbol, MODE_DIGITS))) + " </b></font></h3></td>");               
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(open_lots, 2)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(commission, 2)) + " </b></font></h3></td>");
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(swap, 2)) + " </b></font></h3></td>");               
               text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='black'><b>" + NumberFormat(DoubleToString(profit, 2)) + " " + AccountCurrency()+ " </b></font></h3></td>");                     
            }
            text = StringConcatenate(text, "</tr>");
         }
         text = StringConcatenate(text, "</table>");
      }        
      //---------------------------------------------------------------------
      //Account Details
      text = StringConcatenate(text, "<body><h2><font color='black'>Account Details:</font></h2>");
      text = StringConcatenate(text, "<table border = '1'><tr bgcolor='LightSeaGreen'><td style='text-align:right'><h3><font color='blue'><b>Account Balance: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(AccountBalance(), 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
      daily_balance = AccountBalance()-YesterdayClosedBalance;
      if(daily_balance > 0) {
         text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='green'><b>Today Result: </b></font></h2></td><td style='text-align:left'><h3><font color='green'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(daily_balance, 2), 2)) + " "+AccountCurrency()+ " </b></font></h2></td></tr>");
      }
      else if(daily_balance < 0){
         text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='red'><b>Today Result: </b></font></h2></td><td style='text-align:left'><h3><font color='red'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(daily_balance, 2), 2)) + " "+AccountCurrency()+ " </b></font></h2></td></tr>");
      } 
      else {
         text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='black'><b>Today Result: </b></font></h2></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(daily_balance, 2), 2)) + " "+AccountCurrency()+ " </b></font></h2></td></tr>");
      }      

      if (week_result > 0) {
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='green'size><b>Week Gross Result: </b></font></h3></td><td style='text-align:left'><h3><font color='green'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_result + week_commission + week_swap * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='blue'size><b>Week Commission: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_commission * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='blue'size><b>Week Swap: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_swap, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow' style='text-decoration: underline'><td style='text-align:right'><h3><font color='green'size><b>Week Growth: </b></font></h3></td><td style='text-align:left'><h3><font color='green'><b>" + NumberFormat(DoubleToStr(NormalizeDouble((week_result / LastWeekClosedBalance) * 100, 2), 2)) + "% </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow' style='text-decoration: underline'><td style='text-align:right'><h2><font color='green'size><b>Week Net Result: </b></font></h2></td><td style='text-align:left'><h3><font color='green'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_result, 2), 2)) + " "+AccountCurrency()+"</b></font></h2></td></tr>");
      }
      else if (week_result < 0) {
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='red'><b>Week Gross Result: </b></font></h3></td><td style='text-align:left'><h3><font color='red'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_result + week_commission + week_swap * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='blue'size><b>Week Commission: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_commission * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='blue'size><b>Week Swap: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_swap, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow' style='text-decoration: underline'><td style='text-align:right'><h3><font color='red'size><b>Week Loss: </b></font></h3></td><td style='text-align:left'><h3><font color='red'><b>" + NumberFormat(DoubleToStr(NormalizeDouble((week_result / LastWeekClosedBalance) * 100, 2), 2)) + "% </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow' style='text-decoration: underline'><td style='text-align:right'><h2><font color='red'size><b>Week Net Result: </b></font></h2></td><td style='text-align:left'><h3><font color='red'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_result, 2), 2)) + " "+AccountCurrency()+"</b></font></h2></td></tr>");
      }
      else {
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='blue'><b>Week Gross Result: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_result + week_commission + week_swap * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='blue'size><b>Week Commission: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_commission * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='blue'size><b>Week Swap: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_swap, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow' style='text-decoration: underline'><td style='text-align:right'><h3><font color='blue'size><b>Week Growth: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble((week_result / LastWeekClosedBalance) * 100, 2), 2)) + " % </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow' style='text-decoration: underline'><td style='text-align:right'><h2><font color='blue'size><b>Week Net Result: </b></font></h2></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_result, 2), 2)) + " "+AccountCurrency()+"</b></font></h2></td></tr>");
      }
      text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='blue'><b>Week Lot: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(week_lot, 2), 2)) + " </b></font></h3></td></tr>");
      if (this_month_result > 0) {
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='green'><b>Month Gross Result: </b></font></h3></td><td style='text-align:left'><h3><font color='green'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(this_month_result + month_commission + month_swap * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='blue'><b>Month Commission: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(month_commission * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='blue'><b>Month Swap: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(month_swap, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender' style='text-decoration: underline'><td style='text-align:right'><h3><font color='green'><b>Month Growth: </b></font></h3></td><td style='text-align:left'><h3><font color='green'><b>" + NumberFormat(DoubleToStr(NormalizeDouble((this_month_result / LastMonthClosedBalance) * 100, 2), 2)) + " % </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender' style='text-decoration: underline'><td style='text-align:right'><h2><font color='green'><b>Month Net Result: </b></font></h2></td><td style='text-align:left'><h3><font color='green'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(this_month_result, 2), 2)) + " "+AccountCurrency()+"</b></font></h2></td></tr>");
      }
      else if (this_month_result < 0){
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='red'><b>Month : </b></font></h3></td><td style='text-align:left'><h3><font color='red'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(this_month_result + month_commission + month_swap * -1, 2), 2)) + " "+AccountCurrency()+" </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='blue'><b>Month Commission: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(month_commission * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='blue'><b>Month Swap: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(month_swap, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender' style='text-decoration: underline'><td style='text-align:right'><h3><font color='red'><b>Month Growth: </b></font></h3></td><td style='text-align:left'><h3><font color='red'><b>" + NumberFormat(DoubleToStr(NormalizeDouble((this_month_result / LastMonthClosedBalance) * 100, 2), 2)) + " % </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender' style='text-decoration: underline'><td style='text-align:right'><h2><font color='red'><b>Month Net Result: </b></font></h2></td><td style='text-align:left'><h3><font color='red'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(this_month_result, 2), 2)) + " "+AccountCurrency()+"</b></font></h2></td></tr>");
      }
      else {
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='black'><b>Month : </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(this_month_result + month_commission + month_swap * -1, 2), 2)) + " "+AccountCurrency()+" </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='blue'><b>Month Commission: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(month_commission * -1, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='blue'><b>Month Swap: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(month_swap, 2), 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender' style='text-decoration: underline'><td style='text-align:right'><h3><font color='black'><b>Month Growth: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble((this_month_result / LastMonthClosedBalance) * 100, 2), 2)) + " % </b></font></h3></td></tr>");
         text = StringConcatenate(text, "<tr bgcolor='Lavender' style='text-decoration: underline'><td style='text-align:right'><h2><font color='black'><b>Month Net Result: </b></font></h2></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(this_month_result, 2), 2)) + " "+AccountCurrency()+"</b></font></h2></td></tr>");
      }      

      text = StringConcatenate(text, "<tr bgcolor='LightGoldenRodYellow'><td style='text-align:right'><h3><font color='blue'><b>Last 30 Days Lot: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(Last30DaysLotClose(1), 2), 2)) + " </b></font></h3></td></tr>");
      if (this_month_deposit > 0) {
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='green'><b>This Month Deposit: </b></font></h3></td><td style='text-align:left'><h3><font color='green'><b>" + NumberFormat(DoubleToStr(this_month_deposit, 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
      }
      if (this_month_withdrawal > 0) {
         text = StringConcatenate(text, "<tr bgcolor='Lavender'><td style='text-align:right'><h3><font color='red'><b>This Month Withdrawal: </b></font></h3></td><td style='text-align:left'><h3><font color='red'><b>" + NumberFormat(DoubleToStr(this_month_withdrawal, 2)) + " "+AccountCurrency()+"</b></font></h3></td></tr>");
      }
      text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='blue'><b>Margin Level: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(DoubleToStr(NormalizeDouble(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL), 2), 2)) + " % </b></font></h3></td></tr>");
      if(ShowOpenOrdersCount) {
         if (b > 0) {
            text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='blue'><b>BUY Orders: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(IntegerToString(b)) + "</b></font></h3></td></tr>");
         }
         if (s > 0) {
            text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='blue'><b>SELL Orders: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(IntegerToString(s)) + "</b></font></h3></td></tr>");
         }
         if (b_s > 0) {
            text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='blue'><b>BUY STOP Orders: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(IntegerToString(b_s)) + "</b></font></h3></td></tr>");
         }
         if (s_s > 0) {
            text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='blue'><b>SELL STOP Orders: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(IntegerToString(s_s)) + "</b></font></h3></td></tr>");
         }
         if (b_l > 0) {
            text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='blue'><b>BUY LIMIT Orders: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(IntegerToString(b_l)) + "</b></font></h3></td></tr>");
         }
         if (s_s > 0) {
            text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='blue'><b>SELL LIMIT Orders: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(IntegerToString(s_l)) + "</b></font></h3></td></tr>");
         } 
      }
      if (OrdersTotal() > 0) {
         text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='blue'><b>Total Open Orders: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(IntegerToString(OrdersTotal())) + "</b></font></h3></td></tr>");
      }     
          
      text = StringConcatenate(text, "<tr bgcolor='Azure'><td style='text-align:right'><h3><font color='blue'><b>Messages: </b></font></h3></td><td style='text-align:left'><h3><font color='black'><b>" + NumberFormat(IntegerToString(server_message)) + "</b></font></h3></td></tr>");
      text = StringConcatenate(text, "</table>");
      //---------------------------------------------------------------------      
      text = StringConcatenate(text, "<h2><p><b><font color='black'>Nelson Semedo - Nosleno Demes,</font></b></p></h2>");
      text = StringConcatenate(text, "<h3><p><b><font color='black'><b>I am the Captain Of my Ship and Master of my Fate!</font></b></p></h3></body></html>");
      SendMail(title + "[Account Details] - " + TimeToStr(TimeCurrent()), text);
   }
   else if (type == 2) { //Notification
      string my_symbol = GetString(message, ";", 1);
      string my_message = GetString(message, ";", 0); ;
      string text = "<html>";
      text = StringConcatenate(text, "<body><h2><font color='black'> Notification:</font></h2>");
      text = StringConcatenate(text, "<h3><font color='blue'><b>Symbol:</b></font><font color='black'><b>" + my_symbol + "</b></font></h3>");
      text = StringConcatenate(text, "<h3><font color='blue'><b>Message:</b></font><font color='black'><b>" + my_message + "</b></font></h3>");
      text = StringConcatenate(text, "<br><br>");
      text = StringConcatenate(text, "<h2><p><b><font color='black'>Nelson Semedo - Nosleno Demes,</font></b></p></h2>");
      text = StringConcatenate(text, "<h3><p><b><font color='black'><b>I am the Captain Of my Ship and Master of my Fate!</font></b></p></h3></body></html>");
      SendMail(title + " Notification - " + TimeToStr(TimeCurrent()), text);
   }
   else if(type == 4) {
      if(ArraySize(TradingSessionsExceptions) > 0) {
         string text = "<html>";
         text = StringConcatenate(text, "<h2><font color='black'>Today Trending Sessions Exceptions:</font></h2>");
         text = StringConcatenate(text, "<table border = '1'><tr bgcolor='LightSeaGreen'><th> # </th><th>Day;Symbol;StartHour-EndHour-CloseOrderHour</th></tr>");
         
         for(int i = 0; i < ArraySize(TradingSessionsExceptions); i++) {
            text = StringConcatenate(text, "<tr><td style='text-align:center'><h3><font color='green'><b>" + IntegerToString(i) + " </b></font></h3></td>");
            text = StringConcatenate(text, "<td style='text-align:center'><h3><font color='green'><b>" + TradingSessionsExceptions[i] +"</b></font></h3></td>");            
         }
         
         text = StringConcatenate(text, "</table>");
         text = StringConcatenate(text, "<br><br>");
         text = StringConcatenate(text, "<h2><p><b><font color='black'>Nelson Semedo - Nosleno Demes,</font></b></p></h2>");
         text = StringConcatenate(text, "<h3><p><b><font color='black'><b>I am the Captain Of my Ship and Master of my Fate!</font></b></p></h3></body></html>");
         SendMail(title + "[Today Trending Sessions Exceptions] - " + TimeToStr(TimeCurrent()), text);           
      }
   }
   else if(type == 5) {
      datetime today = iTime(_Symbol, Timeframe_D, 0);
      string text = "<html>";
      text = StringConcatenate(text, "<br><br>");
      text = StringConcatenate(text, "<h1><font color='black'>Trading Day " +TimeToString(today, TIME_DATE)+ " </font></h1>");
      text = StringConcatenate(text, "<h2><font color='black'>Started Balance: " +NumberFormat(DoubleToString(YesterdayClosedBalance, 2))+ " " + AccountCurrency()+ "</font></h2>");
      if(UseDailyGoalPercentage) {
         text = StringConcatenate(text, "<h2><font color='green'>Daily Profit Target: " +NumberFormat(DoubleToString(DailyGoalPercentage, 2))+ " % </font></h2>");
         text = StringConcatenate(text, "<h2><font color='green'>Daily Profit Target: " +NumberFormat(DoubleToString(YesterdayClosedBalance + YesterdayClosedBalance * (DailyGoalPercentage / 100), 2))+ " " + AccountCurrency()+ "</font></h2>");
      }
      if(UseDailyGoalStopLoss) {
         text = StringConcatenate(text, "<h2><font color='red'>Daily Stop Loss Target: " +NumberFormat(DoubleToString(DailyStopLossPercentage, 2))+ " % </font></h2>");
         text = StringConcatenate(text, "<h2><font color='red'>Daily Stop Loss Target: " +NumberFormat(DoubleToString(YesterdayClosedBalance - YesterdayClosedBalance * (DailyStopLossPercentage / 100), 2))+ " " + AccountCurrency()+ "</font></h2>");
      }
      text = StringConcatenate(text, "<br>");
      text = StringConcatenate(text, "<h2><p><b><font color='black'>Nelson Semedo - Nosleno Demes,</font></b></p></h2>");
      text = StringConcatenate(text, "<h3><p><b><font color='black'><b>I am the Captain Of my Ship and Master of my Fate!</font></b></p></h3></body></html>");
      SendMail(title + "[New Trading Session Started] - " + TimeToStr(TimeCurrent()), text);        
   }
   else if(type == 6) {
      datetime today = iTime(_Symbol, Timeframe_D, 0);
      string text = "<html>";
      text = StringConcatenate(text, "<br><br>");
      text = StringConcatenate(text, "<h1><font color='black'>Trading Day " +TimeToString(today, TIME_DATE)+ " </font></h1>");
      text = StringConcatenate(text, "<h2><font color='black'>Daily Started Balance: " +NumberFormat(DoubleToString(YesterdayClosedBalance, 2))+ " " + AccountCurrency()+ "</font></h2>");
      text = StringConcatenate(text, "<h2><font color='green'>Percentage Reached: " +NumberFormat(DoubleToString(((AccountBalance()-YesterdayClosedBalance)*100)/YesterdayClosedBalance, 2))+ " % </font></h2>");
      text = StringConcatenate(text, "<h2><font color='green'>Result Reached: " +NumberFormat(DoubleToString(AccountEquity()-YesterdayClosedBalance, 2)) + " "+AccountCurrency() + " </font></h2>");
      text = StringConcatenate(text, "<h2><font color='green'>Balance Reached: " +NumberFormat(DoubleToString(AccountBalance(), 2))+ " " + AccountCurrency()+ "</font></h2>");
      
      text = StringConcatenate(text, "<h2><p><b><font color='black'>Nelson Semedo - Nosleno Demes,</font></b></p></h2>");
      text = StringConcatenate(text, "<h3><p><b><font color='black'><b>I am the Captain Of my Ship and Master of my Fate!</font></b></p></h3></body></html>");
      SendMail(title + "[Week Target Reached] - " + TimeToStr(TimeCurrent()), text);        
   }
   else if(type == 7) {
      datetime week = iTime(_Symbol, Timeframe_W, 0);
      string text = "<html>";
      text = StringConcatenate(text, "<br><br>");
      text = StringConcatenate(text, "<h1><font color='black'>Trading week started at " +TimeToString(week, TIME_DATE)+ " </font></h1>");
      text = StringConcatenate(text, "<h2><font color='black'>Week started Balance: " +NumberFormat(DoubleToString(LastWeekClosedBalance, 2))+ " " + AccountCurrency()+ "</font></h2>");
      if(AccountBalance() > LastWeekClosedBalance) {
         text = StringConcatenate(text, "<h2><font color='green'>Result Percentage: " +NumberFormat(DoubleToString(((AccountBalance()-LastWeekClosedBalance)*100)/LastWeekClosedBalance, 2))+ " % </font></h2>");
         text = StringConcatenate(text, "<h2><font color='green'>Result Capital: " +NumberFormat(DoubleToString(AccountEquity()-LastWeekClosedBalance, 2)) + " "+AccountCurrency() + " </font></h2>");
         text = StringConcatenate(text, "<h2><font color='green'>Current Balance: " +NumberFormat(DoubleToString(AccountBalance(), 2))+ " " + AccountCurrency()+ "</font></h2>");
      }
      else {
         text = StringConcatenate(text, "<h2><font color='red'>Result Percentage: " +NumberFormat(DoubleToString(((AccountBalance()-LastWeekClosedBalance)*100)/LastWeekClosedBalance, 2))+ " % </font></h2>");
         text = StringConcatenate(text, "<h2><font color='red'>Result Capital: " +NumberFormat(DoubleToString(AccountEquity()-LastWeekClosedBalance, 2)) + " "+AccountCurrency() + " </font></h2>");
         text = StringConcatenate(text, "<h2><font color='red'>Current Balance: " +NumberFormat(DoubleToString(AccountBalance(), 2))+ " " + AccountCurrency()+ "</font></h2>");
      }
      
      text = StringConcatenate(text, "<h2><p><b><font color='black'>Nelson Semedo - Nosleno Demes,</font></b></p></h2>");
      text = StringConcatenate(text, "<h3><p><b><font color='black'><b>I am the Captain Of my Ship and Master of my Fate!</font></b></p></h3></body></html>");
      SendMail(title + "[All Orders Closed] - " + TimeToStr(TimeCurrent()), text);        
   }   
   else if(type == 8) {
      datetime today = iTime(_Symbol, Timeframe_D, 0);
      string text = "<html>";
      text = StringConcatenate(text, "<br><br>");
      text = StringConcatenate(text, "<h1><font color='black'>Trading Day " +TimeToString(today, TIME_DATE)+ " </font></h1>");
      text = StringConcatenate(text, "<h2><font color='black'>Daily Started Balance: " +NumberFormat(DoubleToString(YesterdayClosedBalance, 2))+ " " + AccountCurrency()+ "</font></h2>");
      text = StringConcatenate(text, "<h2><font color='red'>Percentage Reached: " +NumberFormat(DoubleToString(((AccountBalance()-YesterdayClosedBalance)*100)/YesterdayClosedBalance, 2))+ " % </font></h2>");
      text = StringConcatenate(text, "<h2><font color='red'>Result Reached: " +NumberFormat(DoubleToString(AccountEquity()-YesterdayClosedBalance, 2)) + " "+AccountCurrency() + " </font></h2>");
      text = StringConcatenate(text, "<h2><font color='red'>Balance Reached: " +NumberFormat(DoubleToString(AccountBalance(), 2))+ " " + AccountCurrency()+ "</font></h2>");
      
      text = StringConcatenate(text, "<h2><p><b><font color='black'>Nelson Semedo - Nosleno Demes,</font></b></p></h2>");
      text = StringConcatenate(text, "<h3><p><b><font color='black'><b>I am the Captain Of my Ship and Master of my Fate!</font></b></p></h3></body></html>");
      SendMail(title + "[Daily Stop Loss Reached] - " + TimeToStr(TimeCurrent()), text);        
   }   
}
//+------------------------------------------------------------------+
double CalculateLastPeriodClosedBalance(int type) {
   double balance = AccountInfoDouble(ACCOUNT_BALANCE);
   int l_pos_4 = 0; long order_close = 0;
   double value_profit = 0, value_loss = 0, commission = 0, swap_positive = 0, swap_negative = 0;

   if (type == 1) {
      //Last Week Result
      long this_week_open = iTime(_Symbol, Timeframe_W, 0);
      long min1 = iTime(_Symbol, Timeframe_M1, 0);
      
      if(this_week_open == min1) {
         balance = AccountBalance();
      }
      else {   
         for (l_pos_4 = OrdersHistoryTotal() - 1; l_pos_4 >= 0; l_pos_4--) {
            if (!OrderSelect(l_pos_4, SELECT_BY_POS, MODE_HISTORY)) {
               continue;
            }
            if (OrderType() != OP_BUY && OrderType() != OP_SELL) {
               continue;
            }
   
            order_close = OrderCloseTime();
            if (order_close > this_week_open) {
               commission += OrderCommission();
               if (OrderProfit() > 0) {
                  value_profit += OrderProfit();
               }
               else {
                  value_loss += MathAbs(OrderProfit());
               }
   
               if (OrderSwap() > 0) {
                  swap_positive += OrderSwap();
               }
               else {
                  swap_negative += MathAbs(OrderSwap());
               }
            }
         }
         balance = balance + ((value_profit - value_loss) + commission + (swap_positive - swap_negative)) * -1;
      }
   }
   else if (type == 2)
   {
      //Last Month Result
      long this_month_open = iTime(_Symbol, Timeframe_MN, 0);
      long min1 = iTime(_Symbol, Timeframe_M1, 0);
      
      if(this_month_open == min1) {
         balance = AccountBalance();
      }
      else {
         for (l_pos_4 = OrdersHistoryTotal() - 1; l_pos_4 >= 0; l_pos_4--) {
            if (!OrderSelect(l_pos_4, SELECT_BY_POS, MODE_HISTORY)) {
               continue;
            }
            if (OrderType() != OP_BUY && OrderType() != OP_SELL) {
               continue;
            }
   
            order_close = OrderCloseTime();
            if (order_close > this_month_open) {
               commission += OrderCommission();
               if (OrderProfit() > 0) {
                  value_profit += OrderProfit();
               }
               else {
                  value_loss += MathAbs(OrderProfit());
               }
   
               if (OrderSwap() > 0) {
                  swap_positive += OrderSwap();
               }
               else {
                  swap_negative += MathAbs(OrderSwap());
               }
            }
         }
         balance = balance + ((value_profit - value_loss) + commission + (swap_positive - swap_negative)) * -1;
      }
   }
   else if (type == 3) {
      //Yesterday Result
      long today_open = iTime(_Symbol, Timeframe_D, 0);
      long min1 = iTime(_Symbol, Timeframe_M1, 0);
      
      if(today_open == min1) {
         balance = AccountBalance();
      }
      else {
         for (l_pos_4 = OrdersHistoryTotal() - 1; l_pos_4 >= 0; l_pos_4--) {
            if (!OrderSelect(l_pos_4, SELECT_BY_POS, MODE_HISTORY)) {
               continue;
            }
            if (OrderType() != OP_BUY && OrderType() != OP_SELL) {
               continue;
            }
   
            order_close = OrderCloseTime();
            if (order_close > today_open) {
               commission += OrderCommission();
               if (OrderProfit() > 0) {
                    value_profit += OrderProfit();
               }
               else {
                  value_loss += MathAbs(OrderProfit());
               }
   
               if (OrderSwap() > 0) {
                  swap_positive += OrderSwap();
               }
               else {
                  swap_negative += MathAbs(OrderSwap());
               }
            }
         }
         balance = balance + ((value_profit - value_loss) + commission + (swap_positive - swap_negative)) * -1;
      }
   }

   return balance;
}
//+------------------------------------------------------------------+
void CalculateOrderCostPeriod(double &week_lot, double &thisweek_commission, double &thisweek_swap, double &month_lot, double &thismonth_commission, double &thismonth_swap) {
   //double balance = AccountInfoDouble(ACCOUNT_BALANCE);
   int w_l_pos_4 = 0, m_l_pos_4 = 0; long order_close = 0, order_open = 0;
   double w_swap_positive = 0, w_swap_negative = 0, m_swap_positive = 0, m_swap_negative = 0;

   //This Week Result
   long this_week_open = iTime(_Symbol, Timeframe_W, 0);

   for (w_l_pos_4 = OrdersHistoryTotal() - 1; w_l_pos_4 >= 0; w_l_pos_4--) {
      if (!OrderSelect(w_l_pos_4, SELECT_BY_POS, MODE_HISTORY)) {
            continue;
      }
      if (OrderType() != OP_BUY && OrderType() != OP_SELL) {
         continue;
      }

      //order_close = OrderCloseTime();
      order_close = OrderCloseTime();
      if (order_close >= this_week_open) {
         thisweek_commission += MathAbs(OrderCommission());
         week_lot += OrderLots();
         if (OrderSwap() > 0) {
            w_swap_positive += OrderSwap();
         }
         else {
            w_swap_negative += MathAbs(OrderSwap());
         }
      }
   }
   thisweek_swap = w_swap_positive - w_swap_negative;


   //This Month Result
   long this_month_open = iTime(_Symbol, Timeframe_MN, 0);

   for (m_l_pos_4 = OrdersHistoryTotal() - 1; m_l_pos_4 >= 0; m_l_pos_4--) {
      if (!OrderSelect(m_l_pos_4, SELECT_BY_POS, MODE_HISTORY)) {
         continue;
      }
      if (OrderType() != OP_BUY && OrderType() != OP_SELL) {
         continue;
      }

      //order_close = OrderCloseTime();
      order_close = OrderCloseTime();
      if (order_close > this_month_open) {
         thismonth_commission += MathAbs(OrderCommission());
         month_lot += OrderLots();
         if (OrderSwap() > 0) {
            m_swap_positive += OrderSwap();
         }
         else {
            m_swap_negative += MathAbs(OrderSwap());
         }
      }
   }
   thismonth_swap = m_swap_positive - m_swap_negative;
}
//+------------------------------------------------------------------+
double Last30DaysLotClose(int type) { //0 - Closed; 1 - All
   double month_lot_closed = 0, month_lot_open;
   int m_l_pos_4= 0;
   long last30days_open = iTime(_Symbol, Timeframe_D, 30), order_time = 0;
    
   for (m_l_pos_4 = OrdersHistoryTotal() - 1; m_l_pos_4 >= 0; m_l_pos_4--) {
      if (!OrderSelect(m_l_pos_4, SELECT_BY_POS, MODE_HISTORY)){
         continue;
      }
      if (OrderType() != OP_BUY && OrderType() != OP_SELL) {
         continue;
      }
      order_time = OrderCloseTime();
        
      if (order_time > last30days_open) {
         month_lot_closed += OrderLots();
      }
   }
    
   month_lot_open = 0;    
   if(type == 1) {
      for (m_l_pos_4 = OrdersTotal() - 1; m_l_pos_4 >= 0; m_l_pos_4--) {
         if (!OrderSelect(m_l_pos_4, SELECT_BY_POS, MODE_TRADES)) {
            continue;
         }
         month_lot_open += OrderLots();
      }    
   }
       
   return month_lot_closed + month_lot_open;
}
//+------------------------------------------------------------------+
void MarginCallPrevent() {
   double percentage = AccountInfoDouble(ACCOUNT_MARGIN_LEVEL);
   double margin_stop_out = AccountInfoDouble(ACCOUNT_MARGIN_SO_SO);

   if (percentage > 0) {
      if (percentage < margin_stop_out + MarginSOAdd) {
         CloseOrderDueConditions();
      }
   }
}
//+------------------------------------------------------------------+
void CloseOrderDueConditions() {
   int cnt;
   int ticket = 0;
   string symbol_to_close = "";
   double lot = 0;
   int type = -1;
   double profit = 0, p = 0, last_profit = 0;
   bool is_first = true;

    for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      profit = OrderProfit() + OrderSwap() + OrderCommission();
      if((profit > last_profit || is_first)) {
         ticket = OrderTicket();
         lot = OrderLots();
         symbol_to_close = OrderSymbol();
         type = OrderType();
         last_profit = profit;
         is_first = false;
      }      
   }

   if (ticket > 0) {
      CloseOrder(ticket, lot, type, symbol_to_close, false);
      SendEmail(2, 0, 0, "Close Order due the Margin Call Prevent or Maximun Orders Opened. Current Account Margin Level: " + DoubleToString(AccountInfoDouble(ACCOUNT_MARGIN_LEVEL), 2)+" Total Open Orders: "+ IntegerToString(OrdersTotal()) +" Orders Closed: " + symbol_to_close);     
   }
}
//+------------------------------------------------------------------+
string GetSymbolDefinition(string symbol) {
   string result = "", tmp = "";
   int i = 0;
   
   for(i = 0; i < ArraySize(TradingSessionsExceptions); i++) {
      if(GetString(TradingSessionsExceptions[i], ";", 1) == symbol || GetString(TradingSessionsExceptions[i], ";", 1) == "ALL") {
         tmp = GetString(TradingSessionsExceptions[i], ";", 1) +";"+GetString(TradingSessionsExceptions[i], ";", 2);
         break;         
      }
   }
   
   if(tmp == "") {
      for(i = 0; i < ArraySize(Symbols); i++) {
         if(GetString(Symbols[i], ";", 0) == symbol) {
            result = Symbols[i];
            break;
         }
      }
   }
   
   return result;  
}
//+------------------------------------------------------------------+
//https://www.icmarkets.com/au/en/trading-pricing/trading-hours
bool IsTheMarketOpened(string symbol) {
   bool result = false;
   int i = 0;
   string start_hour = "", end_hour = "", close_hour = "";
   string definition = GetSymbolDefinition(symbol);

   start_hour = GetString(GetString(definition, ";", 1), "-", 0);
   end_hour = GetString(GetString(definition, ";", 1), "-", 1);
   close_hour = GetString(GetString(definition, ";", 1), "-", 2);
   
   if(GetIntiger(end_hour, ":", 0) > GetIntiger(close_hour, ":", 0))end_hour = close_hour;
   else if(GetIntiger(end_hour, ":", 0) == GetIntiger(close_hour, ":", 0) && GetIntiger(end_hour, ":", 1) > GetIntiger(close_hour, ":", 1))end_hour = close_hour;
   
   if (OnTradingHour(start_hour, end_hour))result = true;  

   return result;
}
//+------------------------------------------------------------------+
bool TODO_CheckClose(string symbol) {
   bool result = false;
   int i = 0;
   string end_hour = "", close_hour = "";
   string definition = GetSymbolDefinition(symbol);
   int hour = TimeHour(TimeCurrent());
   int minute = TimeMinute(TimeCurrent());   

   end_hour = GetString(GetString(definition, ";", 1), "-", 1);
   close_hour = GetString(GetString(definition, ";", 1), "-", 2);
   
   if(GetIntiger(end_hour, ":", 0) > GetIntiger(close_hour, ":", 0))end_hour = close_hour;
   else if(GetIntiger(end_hour, ":", 0) == GetIntiger(close_hour, ":", 0) && GetIntiger(end_hour, ":", 1) > GetIntiger(close_hour, ":", 1))end_hour = close_hour;
   
   int end_trading_hour = GetIntiger(end_hour, ":", 0);
   int end_trading_minute = GetIntiger(end_hour, ":", 1);    

   return result;
}
//+------------------------------------------------------------------+
bool IsTheMarketOpenedOnHour(string symbol) {
   bool result = false;
   int i = 0;
   string start_hour = "", end_hour = "";
   string definition = GetSymbolDefinition(symbol);

   start_hour = GetString(GetString(GetString(definition, ";", 1), "-", 0), ":", 0)+":00";
   end_hour = GetString(GetString(GetString(definition, ";", 1), "-", 1), ":", 0)+":59";
   
   if (OnTradingHour(start_hour, end_hour))result = true;  
   
   return result;
}
//+------------------------------------------------------------------+
void HandleOpenPositions(int timeframe) {    
   int cnt;
   double result = 0;
   string Orders[1];
   ArrayResize(Orders, OrdersTotal());
   double hama_trend = 0;
   string symbol = "";
   double currenct_equity = AccountEquity();
   string closeTradeHour = "";
   bool closed = false;

   if (CloseOrdersEndOfTodayTradingDay()) {
      if(OrdersTotal() > 0) {
         for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
            if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
               continue;
            }
            symbol = OrderSymbol(); 
            
            for(int i = 0; i < ArraySize(Symbols); i++) {
               if(GetString(Symbols[i], ";", 0) == symbol) {
                  closeTradeHour = GetString(GetString(Symbols[i], ";", 1), "-", 2);
                  if(TimeHour(TimeCurrent()) >= GetIntiger(closeTradeHour, ":", 0) && TimeMinute(TimeCurrent()) >= GetIntiger(closeTradeHour, ":", 1)) {
                     Orders[cnt] = IntegerToString(OrderTicket()) +";"+ DoubleToString(OrderLots(), 2) +";"+ IntegerToString(OrderType()) + ";" + symbol;
                  }
               }
            }
         }
         
         for (int i = 0; i < ArraySize(Orders); i++) {
            if(GetIntiger(Orders[i], ";", 0) > 0) {
               CloseOrder(GetIntiger(Orders[i], ";", 0), GetDouble(Orders[i], ";", 1), GetIntiger(Orders[i], ";", 2), GetString(Orders[i], ";", 3), false);
               closed = true;
            }
         }
      }
      
      if(closed && !StartBar_H1 && OrdersTotal() == 0) {
         SendEmail(1, 0, 0, "");
      }
   }            
   
   TraillingStop(timeframe, 1);
   //CheckEndDayClose();
}
//+------------------------------------------------------------------+
void TraillingStop(int timeframe, int shift) {
   int total = OrdersTotal() - 1;
   double sl = 0, ma_long = 0, ask = 0, bid = 0;
   bool modify = false;
   string symbol = "", ma_signal = "", hull_signal = "", pivot_points_curr  = "";
   double break_distance = 0, sl_distance = 0, ma_value = 0;
   bool start_bar = false;
   bool doTrailling = DoTraillingStop;
   double profit = 0;
   double close_1 = 0, open_1 = 0;
   double high_1 = 0, low_1 = 0;
   double trailling_sl_line = 0, hull_value = 0;
   int entry = 0, hull_trend = 0;
   int hour = TimeHour(TimeCurrent());
   datetime today = iTime(symbol, Timeframe_D, 0);
   datetime open_order_bar;
   //double fractal_up = 0, fractal_dn = 0;
   string psar_signal = "", bb_signal = "", ma_channel = "";
   int psar_trend = 0, bb_trend = 0;
   double pivot_tc = 0, pivot_bc = 0;
   double bb_middle = 0, fractal_up = 0, fractal_dn = 0;
   int open_bar = 0;
   double highest = 0, lowest = 0;
   bool adx_volatility = false;

   for (int i = total; i >= 0; i--)  {
      if(MaxMessagesToTheServerReached())break;
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))  {
         modify = false;
         symbol = OrderSymbol();
         open_order_bar = OrderOpenTime();
         trailling_sl_line = 0;
         pivot_tc = 0; pivot_bc = 0;
         pivot_points_curr = "";
         
         if(RetrieveValueFromArray_bool(symbol, Symbols_OpenOrderErrors, Symbols))continue;
         if(OrderType() != OP_BUY && OrderType() != OP_SELL)continue;
         if(OrderMagicNumber() != MAGIC_1 && OrderMagicNumber() != MAGIC_2)continue;
         //if(open_order_bar >= today) continue;
         
         bid = MarketInfo(symbol, MODE_BID);
         ask = MarketInfo(symbol, MODE_ASK); 
         open_1 = iOpen(symbol, timeframe, shift);  
         close_1 = iClose(symbol, timeframe, shift);        
         high_1 = iHigh(symbol, timeframe, shift); 
         low_1 = iLow(symbol, timeframe, shift); 
         
         if(timeframe == Timeframe_M1)start_bar = StartBar_M1;
         else if(timeframe == Timeframe_M5)start_bar = StartBar_M5;
         else if(timeframe == Timeframe_M15)start_bar = StartBar_M15;
         else if(timeframe == Timeframe_M30)start_bar = StartBar_M30;
         else if(timeframe == Timeframe_H1)start_bar = StartBar_H1;
         else if(timeframe >= Timeframe_H4)start_bar = StartBar_H4;
         
         break_distance = BreakDistancePoints * MarketInfo(symbol, MODE_POINT);
         sl_distance = StopLossDistancePoints * MarketInfo(symbol, MODE_POINT);
         profit = OrderProfit() + OrderSwap() + OrderCommission(); 

         /*
         hull_signal = HullMASignal(symbol, timeframe, shift);
         hull_trend = GetIntiger(hull_signal, ";", 0);
         hull_value = GetDouble(hull_signal, ";", 1); 
         //--
         */                        
         psar_signal = PSARSignal(symbol, timeframe, PSAR_Step_Trailling, PSAR_Maximum_Trailling, shift);
         psar_trend = GetIntiger(psar_signal, ";", 0);          
         //--
         /*
         bb_signal = BollingerBandsSignal(symbol, timeframe, shift);
         bb_trend = GetIntiger(bb_signal, ";", 0); 
         bb_middle = GetDouble(bb_signal, "", 2);
         fractal_up = FractalSignal_SL(symbol, timeframe, Up, 3);
         fractal_dn = FractalSignal_SL(symbol, timeframe, Down, 3);
         */
               
         if(OrderType() == OP_BUY && psar_trend == 1) {
            trailling_sl_line = GetDouble(psar_signal, ";", 1);
         }
         else if(OrderType() == OP_SELL && psar_trend == -1) {
            trailling_sl_line = GetDouble(psar_signal, ";", 1);
         }         
                                         
         if(OrderType() == OP_BUY) {
            //Break Even
            if(OrderStopLoss() == 0 || OrderStopLoss() < OrderOpenPrice()) {              
               trailling_sl_line = MathMax(trailling_sl_line, GetDouble(CalculateCamarilla(symbol, timeframe, shift), ";", 4));
               if(DoBreakEven && ((bid > OrderOpenPrice() + (OrderOpenPrice() - OrderStopLoss()) * BreakEvenSLMultiplier && OrderStopLoss() > 0)
                  || (trailling_sl_line - sl_distance >= OrderOpenPrice() + break_distance && close_1 > trailling_sl_line && trailling_sl_line != EMPTY_VALUE && trailling_sl_line > 0))) { 
                  modify = OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(OrderOpenPrice() + break_distance, (int)MarketInfo(symbol, MODE_DIGITS)), OrderTakeProfit(), 0, Yellow);
                  SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
                  if(!modify) {
                     if(!RetrieveValueFromArray_bool(symbol, Symbols_OpenOrderErrors, Symbols)) {
                        SetOpenOrderErrorArray(symbol);
                     }
                  }                  
               }
            } 

            if(!start_bar) continue; 
            if(!doTrailling) continue;
            if(trailling_sl_line == 0)continue;
            if(!CheckMinHourToTraillingStop())continue;
            
            sl = trailling_sl_line - sl_distance;  
            if(sl > OrderStopLoss() + break_distance && sl > OrderOpenPrice() + break_distance && close_1 > trailling_sl_line && trailling_sl_line != EMPTY_VALUE) {
               if(sl < bid) {// && OrderStopLoss() > OrderOpenPrice()
                  modify = OrderModify(OrderTicket(), OrderOpenPrice(), sl, OrderTakeProfit(), 0, Yellow);
                  SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
                  if(!modify) {
                     if(!RetrieveValueFromArray_bool(symbol, Symbols_OpenOrderErrors, Symbols)) {
                        SetOpenOrderErrorArray(symbol);
                     }
                  }                   
               }
            }
         }
         else if(OrderType() == OP_SELL) {       
            //Break Even
            if(OrderStopLoss() == 0 || OrderStopLoss() > OrderOpenPrice()) {
               trailling_sl_line = MathMin(trailling_sl_line, GetDouble(CalculateCamarilla(symbol, timeframe, shift), ";", 1));
               if(DoBreakEven && ((ask < OrderOpenPrice() - (OrderStopLoss() - OrderOpenPrice()) * BreakEvenSLMultiplier && OrderStopLoss() > 0)
                  || (trailling_sl_line + sl_distance <= OrderOpenPrice() - break_distance && close_1 < trailling_sl_line && trailling_sl_line != EMPTY_VALUE && trailling_sl_line > 0))) {
                  modify = OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(OrderOpenPrice() - break_distance, (int)MarketInfo(symbol, MODE_DIGITS)), OrderTakeProfit(), 0, Yellow);
                  SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
                  if(!modify) {
                     if(!RetrieveValueFromArray_bool(symbol, Symbols_OpenOrderErrors, Symbols)) {
                        SetOpenOrderErrorArray(symbol);
                     }
                  }                  
               }                           
            }                                      
                        
            if(!start_bar) continue;  
            if(!doTrailling) continue; 
            if(trailling_sl_line == 0)continue; 
            if(!CheckMinHourToTraillingStop())continue;
            
            sl = trailling_sl_line + sl_distance;
            if(sl < OrderStopLoss() - break_distance && sl < OrderOpenPrice() - break_distance && close_1 < trailling_sl_line && trailling_sl_line != EMPTY_VALUE) {
               if(sl > ask) {// && OrderStopLoss() < OrderOpenPrice()
                  modify = OrderModify(OrderTicket(), OrderOpenPrice(), sl, OrderTakeProfit(), 0, Yellow);
                  SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
                  if(!modify) {
                     if(!RetrieveValueFromArray_bool(symbol, Symbols_OpenOrderErrors, Symbols)) {
                        SetOpenOrderErrorArray(symbol);
                     }
                  }                   
               }       
            }
         }
      }    
   }
}
//+------------------------------------------------------------------+
bool DailyGoalReached() {
   bool result = false;
   RefreshRates();
   double currenct_equity = AccountEquity();
   int i = 0;
   int hour = TimeHour(TimeCurrent());

   if(!UseDailyGoalPercentage || hour < StartDailyGoalCheckHour) {
      result = false;
   }
   else if(DailyGoalPercentageReched) {
      result = true;
   }   
   else if(currenct_equity > YesterdayClosedBalance + YesterdayClosedBalance * ((DailyGoalPercentage + 1.0) / 100)) {
      if(OrdersTotal() > 0) {
         CloseOrders();
         
         //Notification
         if(OrdersTotal() == 0) {    
            SendEmail(6, 0, 0, "");//Daily goal reached!
            SendAllClosedOrderEmail = false;
            result = true;
            DailyGoalPercentageReched = true;
         }
      }
      else {
         result = true;
         DailyGoalPercentageReched = true;
      }
   }
   else if(UseDailyGoalStopLoss && currenct_equity < YesterdayClosedBalance - YesterdayClosedBalance * ((DailyStopLossPercentage - 0.5) / 100)) {
      if(OrdersTotal() > 0) {
         for(i = 0; i < ArraySize(Symbols); i++)         {           
            CloseOrders(GetString(Symbols[i], ";", 0));
         }
         
         //Notification
         if(OrdersTotal() == 0) {    
            SendEmail(8, 0, 0, "");//Daily Stop Loss reached!
            SendAllClosedOrderEmail = false;
            result = true;
            DailyGoalPercentageReched = true;
         }
      }
      else {
         result = true;
         DailyGoalPercentageReched = true;
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+ 
void LotSplit(string symbol, double total_lote, double &lote_array[]) {
   double max_lote = MaxLot;
   ArrayResize(lote_array, 1);
   double div_value_double = 0, div_value_int = 0;
   double remaining = 0;
   
   if(max_lote > MarketInfo(symbol, MODE_MAXLOT)) max_lote = MarketInfo(symbol, MODE_MAXLOT);
   
   if(total_lote <= max_lote) {
      lote_array[0] = NormalizeDouble(total_lote, 2);
   }
   else {
      remaining = MathMod(total_lote, max_lote);
      div_value_double = total_lote / max_lote;
      div_value_int = NormalizeDouble(div_value_double,0);
      if(div_value_int < div_value_double && remaining > 0) {
         div_value_int += 1;
      }
      ArrayResize(lote_array, (int)div_value_int);
      for(int i = 0; i < ArraySize(lote_array); i++) {
         lote_array[i] = NormalizeDouble(total_lote/div_value_int, 2);
      }
   }
}
//+------------------------------------------------------------------+
bool RiskRewardValidation(int type, double openprice, double takeprofit, double stoploss, double risk) {
   bool result = false;
   double tp = 0, sl = 0;
    
   if (type == OP_BUY || type == OP_BUYSTOP) {
      tp = takeprofit - openprice;
      sl = openprice - stoploss;
   }
   else if (type == OP_SELL || type == OP_SELLSTOP) {
      tp = openprice - takeprofit;
      sl = stoploss - openprice;
   }

   if (takeprofit == -1) {
      result = false;
   }
   else if(openprice == 0) {
      result = false;
   }
   else if ((sl * risk) <= tp || takeprofit == 0){
      result = true;
   }

   return result;
}
//+------------------------------------------------------------------+
string RetrieveValueFromArray_string(string key, string &array[], string &loop_array[]) {
    string result = "";
    int i = 0;

    for (i = 0; i < ArraySize(loop_array); i++)
    {
        if (key == GetString(loop_array[i], ";", 0))
        {
            result = array[i];
            break;
        }
    }

    return result;
}
//+------------------------------------------------------------------+
int RetrieveValueFromArray_int(string key, int &array[], string &loop_array[]) {
    int result = 0;
    int i = 0;

    for (i = 0; i < ArraySize(loop_array); i++)
    {
        if (key == GetString(loop_array[i], ";", 0))
        {
            result = array[i];
            break;
        }
    }

    return result;
}
//+------------------------------------------------------------------+
void SetValueToArray_int(string key, int &array[], string &loop_array[], int value) {
    int i = 0;

    for (i = 0; i < ArraySize(loop_array); i++)
    {
        if (key == GetString(loop_array[i], ";", 0))
        {
            array[i] = value;
            break;
        }
    }
}
//+------------------------------------------------------------------+
void SetValueToArray_string(string key, string &array[], string &loop_array[], string value) {
    int i = 0;

    for (i = 0; i < ArraySize(loop_array); i++)
    {
        if (key == GetString(loop_array[i], ";", 0))
        {
            array[i] = value;
            break;
        }
    }
}
//+------------------------------------------------------------------+
void WriteToFile(string data, string filename) {
   string fileName = filename;

   int fileHandle = FileOpen(fileName, FILE_CSV | FILE_READ | FILE_WRITE);

   FileSeek(fileHandle, 0, SEEK_END); // Write at the end of the file.
   FileWrite(fileHandle, data);
   FileClose(fileHandle);
}
//+------------------------------------------------------------------+
void ReadConfig() {
   string symbols[];
   int pos = 0;
   ReadCSVFile(symbols, "SYMBOLS_CONFIG.csv");
   ArrayResize(Symbols, 1);
   int max_symbols = (int)(MaxOpenOrders / MaxOrders);
   
   Print("Maximum Symbols allowed is " +IntegerToString(max_symbols)+ ".");
   if(AccountValidation() || IsTesting()) {
      //Symbols
      for(int i = 0; i<ArraySize(symbols); i++) {
         if(StringLen(symbols[i]) > 0) {
            Symbols[pos] = symbols[i];
            ArrayResize(Symbols, ArraySize(Symbols)+1);
            Print("Symbol "+ IntegerToString(pos + 1) +": "+GetString(Symbols[pos], ";", 0)+ " - " +GetString(Symbols[pos], ";", 1));         
            pos++;
         }
      } 
      ArrayResize(Symbols, ArraySize(Symbols)-1);
      Print("Symbols Loaded Successfully!");  
   } 
   else {
      Print("Condiction One Validation Meet!");  
   }   
   
   if(ValidateMaxSymbols && ArraySize(Symbols) > max_symbols && !IsTesting()) {
      Print("Maximum symobs allowed is " +IntegerToString(max_symbols)+ ". Total symbols to configure is " + IntegerToString(ArraySize(Symbols))+". Symbols Unloaded.");
      ArrayResize(Symbols, 0);
   }
}
//+------------------------------------------------------------------+
void CalculateDailyPercentages() {
   double daily_percentage_points = 0;
   
   if(UseDailyGoalPercentage) {
      if(DailyGoalPercentage < 20) {
         Print("Minimum daily percentage goal is 20%");
         DailyGoalPercentage = 20;
      }
      else if(DailyGoalPercentage > 100.0) {
         Print("Maximum daily percentage goal is 100.0%");
         DailyGoalPercentage = 100.0;
      }
      Print("Daily percentage Goal is: ", DoubleToString(DailyGoalPercentage, 2));
   }
   
   if(UseDailyGoalStopLoss) {
      if(UseDailyGoalPercentage) {
         daily_percentage_points = NormalizeDouble(100 / DailyGoalPercentage, 2);
         DailyStopLossPercentage = NormalizeDouble(100 / (daily_percentage_points + 1), 2);
      }
      Print("Daily percentage Stop Loss is: ",DailyStopLossPercentage);
   }
}
//+------------------------------------------------------------------+
void CalculateDailyPercentagesV1() {
   double daily_percentage_points = 0;
   int active_symbols = CheckActiveSymbols(Timeframe_M15, 1);
   double active_goals = 0;
   if(UseDailyGoalPercentage) {
      active_goals = active_symbols * 4.0;
      Print("Total active symbols: ",IntegerToString(active_symbols));
      if(active_goals > 50.0) {
         Print("Maximum daily percentage goal is 50.0%");
         active_goals = 50.0;
      }
      DailyGoalPercentage = active_goals;
      Print("Daily percentage Goal is: ", DoubleToString(DailyGoalPercentage, 2));
   }
   
   if(UseDailyGoalStopLoss) {
      if(UseDailyGoalPercentage) {
         daily_percentage_points = NormalizeDouble(100 / DailyGoalPercentage, 2);
         DailyStopLossPercentage = NormalizeDouble(100 / (daily_percentage_points + 1), 2);
      }
      Print("Daily percentage Stop Loss is: ",DailyStopLossPercentage);
   }
}
//+------------------------------------------------------------------+
void ReadCSVFile(string &result[], string file_name) {
   //--------------------------------------------------------------- 2 --
   int Handle;                         // File descriptor
   ArrayResize(result, 1);
   int i = 0; string line = "";
   //--------------------------------------------------------------- 3 --
   Handle=FileOpen(file_name,FILE_CSV|FILE_READ,"#");// File opening
   if(Handle<0) {                       // File opening fails   {
      if(GetLastError()==4103)         // If the file does not exist,..
         Alert("No file named ",file_name);//.. inform trader
      else                             // If any other error occurs..
         Alert("Error while opening file ",file_name);//..this message
      PlaySound("Bzrrr.wav");          // Sound accompaniment
      return;                          // Exit start()      
   }
   //--------------------------------------------------------------- 4 --
   while(FileIsEnding(Handle)==false) { // While the file pointer..
      // ..is not at the end of the file
      //--------------------------------------------------------- 5 --
      //Str_DtTm =FileReadString(Handle);// Date and time of the event (date)
      line     =FileReadString(Handle);// Text of event description
      //--------------------------------------------------------- 6 --
      if(i>0) {
         ArrayResize(result, i+1);
      }
      result[i] = line;
      i++;
      if(FileIsEnding(Handle)==true)   // File pointer is at the end
         break;                        // Exit reading and drawing      
   }
   //--------------------------------------------------------------- 8 --
   FileClose( Handle );                // Close file
   WindowRedraw();                     // Redraw object
}
//+------------------------------------------------------------------+
void SaveNewServerMessage(string filename, int message) {
   if(IsTesting())return;
   string saved_message = ReadSavedServerMessages();
   long today = iTime(_Symbol, Timeframe_D, 0);
   string message_to_save = "";
   int saved_value = 0;
   long saved_time = 0;
   if(StringLen(saved_message) > 0) {
      saved_time = GetDateTime(saved_message, ";", 0);
      saved_value = GetIntiger(saved_message, ";", 1);
   }
    
   if(saved_time != today) {
      message_to_save = IntegerToString(today) +";"+ IntegerToString(message);
   }
   else {
      message_to_save = IntegerToString(today) +";"+ IntegerToString(saved_value+message);
   }

   int fileHandle = FileOpen(filename, FILE_CSV | FILE_READ | FILE_WRITE);
    
   //FileSeek(fileHandle, 0, SEEK_END); // Write at the end of the file.
   FileWrite(fileHandle, message_to_save);
   FileClose(fileHandle);
}
//+------------------------------------------------------------------+
string ReadSavedServerMessages() {
   string messages[];
   ReadCSVFile(messages, "SERVER_MESSAGES.csv");
   string message = messages[0];  
   return message;
}
//+------------------------------------------------------------------+
bool MaxMessagesToTheServerReached() {
   bool result = false;
   long today = iTime(_Symbol, Timeframe_D, 0);
   int saved_value = 0;
   long saved_time = 0;   
   string saved_message = ReadSavedServerMessages();
   if(StringLen(saved_message) > 0) {
      saved_time = GetDateTime(saved_message, ";", 0);
      saved_value = GetIntiger(saved_message, ";", 1); 
         if(saved_time == today) {
            if(saved_value + OrdersTotal() + CountOrdersClosedSLTP() > MaxMessageToTheServer)result = true;//TODO: Include also margin call orders
         }            
   }
    
   return result;
}
//+------------------------------------------------------------------+
int CountOrdersClosedSLTP() {
   int result = 0;
   int total = OrdersHistoryTotal() - 1;
   datetime today = iTime(_Symbol, Timeframe_D, 0);	
   for (int i = total; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))  {
         if((StringFind(OrderComment(), "[tp]", 0) >= 0 || StringFind(OrderComment(), "[sl]", 0) >= 0) && OrderOpenTime() >= today) {
            result++;
         }    
      }    
   }
   
   return result;
}
//+------------------------------------------------------------------+ 
double SymbolOpenOrdersResult(string symbol) {
   double result = 0;
   int cnt = 0, total_orders = OrdersTotal();
      
   for (cnt = total_orders - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
        
      if (OrderSymbol() == symbol) {
         result += OrderProfit() + OrderSwap() + OrderCommission(); 
      }
   } 
   
   return result;
}
//+------------------------------------------------------------------+ 
double SymbolOpenOrdersResultInPoints(string symbol) {
   int cnt = 0, total_orders = OrdersTotal();
   double point;
   if (StringFind(symbol, "JPY") < 0) point = 0.0001; else point = 0.01;
   double total_pips = 0;      
   double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);   
      
   for (cnt = total_orders - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
        
      if (OrderSymbol() == symbol) {
         if(OrderType() == OP_BUY) {
            total_pips += (bid - OrderOpenPrice()) / point;
         }
         else if(OrderType() == OP_SELL) {
            total_pips += (OrderOpenPrice() - ask) / point;
         }
      }
   } 
   
   return total_pips;
}
//+------------------------------------------------------------------+ 
double SymbolOpenOrdersResultWithExcept(string symbol, int type, int except_magic) {
   double result = 0;
   int cnt = 0, total_orders = OrdersTotal();
      
   for (cnt = total_orders - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderType() == OP_BUY || OrderType() == OP_SELL) { 
         if (OrderSymbol() == symbol && ((OrderType() == type && OrderMagicNumber() != except_magic) || (OrderType() != type))) {
            result += OrderProfit() + OrderSwap() + OrderCommission(); 
         }
      }
   } 
   
   return result;
}
//+------------------------------------------------------------------+ 
double SymbolOpenOrdersResultCheckOrder(string symbol, int type, int magic) {
   double result = 0;
   int cnt = 0, total_orders = OrdersTotal();
      
   for (cnt = total_orders - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderType() == OP_BUY || OrderType() == OP_SELL) { 
         if (OrderSymbol() == symbol && OrderType() == type && OrderMagicNumber() == magic) {
            result += OrderProfit() + OrderSwap() + OrderCommission(); 
         }
      }
   } 
   
   return result;
}
//+------------------------------------------------------------------+ 
bool SymbolHasMultipleOrder(string symbol) {
   bool result = false;
   int cnt = 0, total_orders = OrdersTotal();
   bool has_buy = false, has_sell = false;
      
   for (cnt = total_orders - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
        
      if (OrderSymbol() == symbol) {
         if(OrderType() == OP_BUY)has_buy = true;
         else if(OrderType() == OP_SELL)has_sell = true;
         
         if(has_buy && has_sell) {
            result = true;
            break;            
         }
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool OpenPositionsOnBar0Validation(string symbol, int timeframe, int max_order, int type) {
   bool result = true;
   int number_pos = 0;
   int cnt;
   long time_start = iTime(symbol, timeframe, 0);
   long order_close_time = 0, order_open_time = 0;

   //Closed
   for (cnt = OrdersHistoryTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_HISTORY)) {
         continue;
      }
        
      order_close_time = OrderCloseTime();
      if (OrderSymbol() == symbol && order_close_time >= time_start && OrderType() == type) {
         number_pos++;
      }
   }
    
   if(number_pos == 0) {
      //Open
      for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
         if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
            continue;
         }
           
         order_open_time = OrderOpenTime();
         if (OrderSymbol() == symbol && order_open_time >= time_start && OrderType() == type) {
            number_pos++;
         }
      }
   }   
    
   if (number_pos >= max_order) {
      result = false;
   }

   return result;
}
//+------------------------------------------------------------------+
bool CanOpenNewPosition(string symbol, int type) {
   bool result = true;
   double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);  
   int cnt = 0;  
   double last_open_price = 0;
   bool found = false;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderSymbol() == symbol) {
         if(type == OP_BUY && OrderType() == type) {
            found = true;
            if(OrderOpenPrice() > last_open_price) last_open_price = OrderOpenPrice();
         }
         else if(type == OP_SELL && OrderType() == type) {
            found = true;
            if(OrderOpenPrice() < last_open_price || last_open_price == 0) last_open_price = OrderOpenPrice();
         }
      }
   }  
    
   if(found && type == OP_BUY && last_open_price + (OrdersDistancePoints * MarketInfo(symbol, MODE_POINT)) > ask) {
      result = false;
   }
   else if(found && type == OP_SELL && last_open_price - (OrdersDistancePoints * MarketInfo(symbol, MODE_POINT)) < bid) {
      result = false;
   }
   
   return result;
}
//+------------------------------------------------------------------+
void GetTradingSessionsExceptions() {
   string exceptions[];
   int pos = 0;
   ArrayResize(TradingSessionsExceptions, 0);
   ReadCSVFile(exceptions, "TRADING_SESSION_EXCEPTIONS.csv");
   string today = TimeToStr(iTime(_Symbol, Timeframe_D, 0), TIME_DATE);

   //Symbols
   for(int i = 0; i<ArraySize(exceptions); i++) {
      if(StringLen(exceptions[i]) > 0) {
         if(GetString(exceptions[i], ";", 0) == today) {
            ArrayResize(TradingSessionsExceptions, ArraySize(TradingSessionsExceptions)+1);
            TradingSessionsExceptions[pos] = exceptions[i];
            pos++;
         }
      }
   } 
   Print("Trading Sessions Exceptions Checked!");   
}
//+------------------------------------------------------------------+
//https://www.mql5.com/en/blogs/post/718703
double ReajustLote(string symbol, double lote) {
   double result = lote;
   double required_standard_margin = MarketInfo(symbol, MODE_MARGINREQUIRED);
   double this_margin = required_standard_margin * lote;
   double min_lote = MarketInfo(symbol, MODE_MINLOT);
   double free_margin = AccountFreeMargin();
   if(free_margin < this_margin * 2) {
      result = 0;
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool EntryPriceValidation(string symbol, int type, double open_price) {
   int total = OrdersTotal() - 1;
   bool result = true;
   double high_low_open_price = 0;
   int count_orders = 0;
   double min_points = MinDistanceBetweenOrders * MarketInfo(symbol, MODE_POINT);
   for (int i = total; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == symbol) {
            if(type == OP_BUY) {
               if(OrderType() == OP_BUY || OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT) {
                  count_orders++;
                  if(high_low_open_price == 0 || OrderOpenPrice() > high_low_open_price) high_low_open_price = OrderOpenPrice();
               }
            }
            else if(type == OP_SELL) {
               if(OrderType() == OP_SELL || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {
                  count_orders++;
                  if(high_low_open_price == 0 || OrderOpenPrice() < high_low_open_price) high_low_open_price = OrderOpenPrice();                
               }
            }
         }    
      }    
   }
   
   if(count_orders > 0) {
      if(type == OP_BUY && open_price < high_low_open_price + min_points) {
         result = false;
      }  
      else if(type == OP_SELL && open_price > high_low_open_price - min_points) {
         result = false;
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool MaxOrderValidation(string symbol, int type, int max_orders, int magic) {
   int total = OrdersTotal() - 1;
   bool result = true;
   int count_orders = 0;
   long today = iTime(_Symbol, Timeframe_D, 0);	
   long last_open_time = iTime(_Symbol, Timeframe_D, 1);
   long open_time = 0;
   for (int i = total; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
         if (OrderSymbol() == symbol) {
            if(type == OP_BUY && OrderMagicNumber() == magic) {
               if(OrderType() == OP_BUY || OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT) {
                  count_orders++;
                  open_time = OrderOpenTime();
                  if(open_time > last_open_time) last_open_time = open_time;
               }
            }
            else if(type == OP_SELL && OrderMagicNumber() == magic) {
               if(OrderType() == OP_SELL || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {
                  count_orders++;
                  open_time = OrderOpenTime();
                  if(open_time > last_open_time) last_open_time = open_time;                  
               }
            }
         }    
      }    
   }
   
   if(count_orders >= max_orders) {
      result = false;
   }
   /*
   else {
      if(last_open_time > today)result = false;
   }
   */
   
   return result;
}
//+------------------------------------------------------------------+
bool ValidateMinMarginPercentage() {
   bool result = true;
   double percentage = AccountInfoDouble(ACCOUNT_MARGIN_LEVEL);

   if (percentage > 0) {
      if (percentage < MinMarginPercentage + (MinMarginPercentage * (MinMarginPercentageToValidate / 100))) {
         result = false;
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool FundamentalNewsAhead(string symbol)
{
    bool result = false;
    int eventminute = (int)iCustom(symbol, 0, "FFC", true, true, true, true, true, false, "", "", true, 4, 0, 0);
    int eventimpact = (int)iCustom(symbol, 0, "FFC", true, true, true, true, true, false, "", "", true, 4, 1, 0);
    //Print("eventminute: ",eventminute," eventimpact: ",eventimpact);

    if (eventminute < MinuteBeforeNewsStopTrading)
    {
        if (eventimpact == 3 && StopTradeOnHighImpactNews)
        {
            result = true;
        }
        else if (eventimpact == 2 && StopTradeOnMediumImpactNews)
        {
            result = true;
        }
    }

    return result;
}
//+------------------------------------------------------------------+
void AllOrderClosedNotification() {
   int total_orders = CountOrders();
   
   if(!SendAllClosedOrderEmail) {
      if(total_orders > 0)SendAllClosedOrderEmail = true;
   }
   else {
      if(total_orders == 0 && SendAllClosedOrderEmail) {
         SendEmail(7, 0, 0, "");
         SendAllClosedOrderEmail = false;
      }
   }
}
//+------------------------------------------------------------------+
bool AccountValidation(){
   bool result = false;
   bool isdemo = IsDemo();
   int accounNumber = AccountNumber();
   int accounNumberReal1 = 310018546;
   int accounNumberReal2 = 1600116361;
   string demoAccount = Condiction1Validation;
   
   if(!isdemo && (StringFind(AccountName(), "Nelson") >= 0 && StringFind(AccountName(), "Semedo") >= 0)) {
      result = true;
   }
   else if(isdemo) {
      if(GetAccountNumberToValidate(accounNumber) == demoAccount) {
         result = true;
      }
   }

   return result;
}
//+------------------------------------------------------------------+
string GetAccountNumberToValidate(int accountNumber) {
   string result = "";
   string accountNumberResult = IntegerToString(accountNumber);
   int size = StringLen(accountNumberResult);
   int value = 0, sum = 0;
   
   for(int i = 0; i < size; i++) {
      value = (int)StringToInteger(StringSubstr(accountNumberResult, i, 1));
      sum += value;
   }
   
   result = accountNumberResult + IntegerToString(sum);
   
   return result;
}
//+------------------------------------------------------------------+
string NumberFormat(string number) {
   string result = "", signal = "";
   if(StringSubstr(number, 0, 1) == "-") {
      signal = "-";
      number = StringSubstr(number, 1, StringLen(number)-1);
   }
   int decimalPos = StringFind(number, ".", 0);
   string decimalPart = "";
   string integerPart = "";
   int numberSize = StringLen(number);
   int gruped = 0;
   
   if(decimalPos > 0) {
      integerPart = StringSubstr(number, 0, decimalPos);
      decimalPart = StringSubstr(number, decimalPos, numberSize-decimalPos);
   }
   else
   {
      integerPart = number;
      decimalPos = numberSize;
   }
   
   for(int i = decimalPos; i > 0; i--) {
      if(gruped == 3) {
         result = NumberThousandsSeparator + result;
         result = StringSubstr(integerPart, i-1, 1) + result;
         gruped = 1;
      }
      else {
         result = StringSubstr(integerPart, i-1, 1) + result;
         gruped++;      
      }
   }
   
   StringReplace(decimalPart, ".", NumberDecimalSeparator);
   result = signal + result + decimalPart;
   
   return result;
}
//+------------------------------------------------------------------+
bool CloseOrdersEndOfTodayTradingDay() {
   bool result = false;
   int day_of_week = DayOfWeek();
   
   if(ClosePositionsOnEndOfTheDay)result = true;
   else if(ClosePositionsOnEndOfFriday && day_of_week == 5)result = true;
   
   return result;
}
//+------------------------------------------------------------------+
bool ValidateMaxOpenOrders() {
   bool result = false;
   int open_orders = CountOrders();
   
   if(open_orders < MaxOpenOrders || MaxOpenOrders == 0)result = true;
   
   return result;
}
//+------------------------------------------------------------------+
void CloseOrderDueTheMaxOpenOrders() {
   CloseOrderDueConditions();
}
//+------------------------------------------------------------------+
//| currency_strength function                                       |
//+------------------------------------------------------------------+
double Currency_Strength(string couple) {
   int index;
   string Pair;
   double HiLo;
   double ld_28;
   double ld_ret_36 = 0;
   int cnt = 0;
   for (int i = 0; i < ArraySize(Symbols); i++) {
      index = 0;
      Pair = GetString(Symbols[i], ";", 0);
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
   return (NormalizeDouble(ld_ret_36, 2));
}
//+------------------------------------------------------------------+
void CurrencyStrengthLinesSignalV2(int &currencyStrengthSignal[], int timeframe, int shift) {
   string baseCurrency = "", counterCurrency = "", symbol = "";
   double currentStrength[], currentStrengthPrev[];
   int symbolsSignal[];
   double symbolsStrenthDiff[];
   ArrayResize(currentStrength, ArraySize(CurrencyStrengthList));
   ArrayResize(currentStrengthPrev, ArraySize(CurrencyStrengthList));
   ArrayResize(symbolsSignal, ArraySize(Symbols));
   ArrayResize(symbolsStrenthDiff, ArraySize(Symbols));
   double baseValueCurrent = 0, counterValueCurrent = 0, baseValuePrevious = 0, counterValuePrevious = 0;
   double baseCurrencyMA = 0, counterCurrencyMA = 0;
   
   for (int i = 0; i < ArraySize(CurrencyStrengthList); i++) {
      currentStrength[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift);
      currentStrengthPrev[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift + 1);
   }
   int found = 0;
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      baseValueCurrent = 0; counterValueCurrent = 0; baseValuePrevious = 0; counterValuePrevious = 0;
      baseCurrency = GetString(PairSepare(symbol), ";", 0);
      counterCurrency = GetString(PairSepare(symbol), ";", 1);  
      found = 0;
      for(int x = 0; x < ArraySize(CurrencyStrengthList); x++) {
         if(CurrencyStrengthList[x] == baseCurrency) {
            baseValueCurrent = currentStrength[x];
            baseValuePrevious = currentStrengthPrev[x];
            baseCurrencyMA = CurrencyStrengthMA[x];
            found++;
         }
         else if(CurrencyStrengthList[x] == counterCurrency) {
            counterValueCurrent = currentStrength[x];
            counterValuePrevious = currentStrengthPrev[x];
            counterCurrencyMA = CurrencyStrengthMA[x];
            found++;
         }         
         if (found == 2) break;
      }
      //do calculations
      if(baseValueCurrent > 0 && counterValueCurrent < 0) {
         if(((baseValueCurrent > baseValuePrevious) || (baseValueCurrent > baseCurrencyMA)) && ((counterValueCurrent < counterValuePrevious) || (counterValueCurrent < counterCurrencyMA))) {
            currencyStrengthSignal[i] = 1;
         }
         else {
            currencyStrengthSignal[i] = 0;
         }
      }
      else if(baseValueCurrent < 0 && counterValueCurrent > 0) {
         if(((baseValueCurrent < baseValuePrevious) || (baseValueCurrent < baseCurrencyMA)) && ((counterValueCurrent > counterValuePrevious) || (counterValueCurrent > counterCurrencyMA))) {
            currencyStrengthSignal[i] = -1;
         }
         else {
            currencyStrengthSignal[i] = 0;
         }
      }
      else {
         currencyStrengthSignal[i] = 0;
      }
   }
}
//+------------------------------------------------------------------+
void FillCurrencyStrenghtMA(double &currencyStrengthMA[], int timeframe, int shift) {
   double currencyEUR[1], currencyGBP[1], currencyUSD[1], currencyJPY[1], currencyAUD[1], currencyNZD[1], currencyCAD[1], currencyCHF[1];
   int array_pos = 0;
   ArrayResize(currencyEUR, Bars);
   ArrayResize(currencyGBP, Bars);
   ArrayResize(currencyUSD, Bars);
   ArrayResize(currencyJPY, Bars);
   ArrayResize(currencyAUD, Bars);
   ArrayResize(currencyNZD, Bars);
   ArrayResize(currencyCAD, Bars);
   ArrayResize(currencyCHF, Bars);
   
   for(int i = shift; i < Bars; i++)
   {
      currencyEUR[array_pos] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", 0, i);
      currencyGBP[array_pos] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", 1, i);
      currencyUSD[array_pos] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", 2, i);
      currencyJPY[array_pos] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", 3, i);
      currencyAUD[array_pos] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", 4, i);
      currencyNZD[array_pos] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", 5, i);
      currencyCAD[array_pos] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", 6, i);
      currencyCHF[array_pos] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", 7, i);
      array_pos++;
   }   
   
   ArraySetAsSeries(currencyEUR, true);
   ArraySetAsSeries(currencyGBP, true);
   ArraySetAsSeries(currencyUSD, true);
   ArraySetAsSeries(currencyJPY, true);
   ArraySetAsSeries(currencyAUD, true);
   ArraySetAsSeries(currencyNZD, true);
   ArraySetAsSeries(currencyCAD, true);
   ArraySetAsSeries(currencyCHF, true);
   
   currencyStrengthMA[0] = NormalizeDouble(iMAOnArray(currencyEUR, 0, CurrencyStrengthMAPeriod, 0, MODE_SMA, 0), 4);  
   currencyStrengthMA[1] = NormalizeDouble(iMAOnArray(currencyGBP, 0, CurrencyStrengthMAPeriod, 0, MODE_SMA, 0), 4);
   currencyStrengthMA[2] = NormalizeDouble(iMAOnArray(currencyUSD, 0, CurrencyStrengthMAPeriod, 0, MODE_SMA, 0), 4);
   currencyStrengthMA[3] = NormalizeDouble(iMAOnArray(currencyJPY, 0, CurrencyStrengthMAPeriod, 0, MODE_SMA, 0), 4);
   currencyStrengthMA[4] = NormalizeDouble(iMAOnArray(currencyAUD, 0, CurrencyStrengthMAPeriod, 0, MODE_SMA, 0), 4);
   currencyStrengthMA[5] = NormalizeDouble(iMAOnArray(currencyNZD, 0, CurrencyStrengthMAPeriod, 0, MODE_SMA, 0), 4);
   currencyStrengthMA[6] = NormalizeDouble(iMAOnArray(currencyCAD, 0, CurrencyStrengthMAPeriod, 0, MODE_SMA, 0), 4);
   currencyStrengthMA[7] = NormalizeDouble(iMAOnArray(currencyCHF, 0, CurrencyStrengthMAPeriod, 0, MODE_SMA, 0), 4);

}
//+------------------------------------------------------------------+
void CurrencyStrengthLinesSignalV3(int &currencyStrengthSignal[], int timeframe, int shift) {
   int shift_compare = shift + 2;
   int shift_compare_1 = shift_compare + 1;
   string baseCurrency = "", counterCurrency = "", symbol = "";
   double currentStrength[];
   double previous1Strength[];
   double previous2Strength[];
   string strengthInfo[];
   int currencySignal[];
   double symbolsStrenthDiff[];
   ArrayResize(currentStrength, ArraySize(CurrencyStrengthList));
   ArrayResize(previous1Strength, ArraySize(CurrencyStrengthList));
   ArrayResize(previous2Strength, ArraySize(CurrencyStrengthList));
   ArrayResize(strengthInfo, ArraySize(CurrencyStrengthList));
   ArrayResize(currencySignal, ArraySize(CurrencyStrengthList));
   ArrayResize(symbolsStrenthDiff, ArraySize(Symbols));
   double baseValueCurrent = 0, counterValueCurrent = 0, baseValuePrevious = 0, counterValuePrevious = 0, currentDiff = 0, previousDiff = 0;
   double diffValue = 0, totalDiffValue = 0, averageDiffValue = 0;
   
   for (int i = 0; i < ArraySize(CurrencyStrengthList); i++) {
      diffValue = 0;
      currentStrength[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift);
      previous1Strength[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift_compare);
      previous2Strength[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift_compare_1);
      
      if(currentStrength[i] > previous1Strength[i]) { 
         diffValue = currentStrength[i] - MathMin(previous1Strength[i], previous2Strength[i]);
         strengthInfo[i] = "1;" + DoubleToString(diffValue);
      }
      else if(currentStrength[i] < previous1Strength[i]) { 
         diffValue = MathMax(previous1Strength[i], previous2Strength[i]) - currentStrength[i];
         strengthInfo[i] = "-1;" + DoubleToString(diffValue);
      }
      else {
         strengthInfo[i] = "0;0.0";
      }
      totalDiffValue += diffValue; 
   }
   averageDiffValue = totalDiffValue / ArraySize(CurrencyStrengthList);
   for(int i = 0; i < ArraySize(CurrencyStrengthList); i++) {
      if(GetIntiger(strengthInfo[i], ";", 0) > 0 && GetDouble(strengthInfo[i], ";", 1) >= averageDiffValue && currentStrength[i] > 0) {
         currencySignal[i] = 1;
      }
      else if(GetIntiger(strengthInfo[i], ";", 0) < 0 && GetDouble(strengthInfo[i], ";", 1) >= averageDiffValue && currentStrength[i] < 0) {
         currencySignal[i] = -1;
      }
      else {
         currencySignal[i] = 0;
      }
   }
   int found = 0;
   double baseCurrencySignal = 0, counterCurrencySignal = 0;
   for(int i = 0; i < ArraySize(Symbols); i++) {
      baseCurrencySignal = 0; counterCurrencySignal = 0;
      symbol = GetString(Symbols[i], ";", 0);
      baseCurrency = GetString(PairSepare(symbol), ";", 0);
      counterCurrency = GetString(PairSepare(symbol), ";", 1);  
      found = 0;
      for(int x = 0; x < ArraySize(CurrencyStrengthList); x++) {
         if(CurrencyStrengthList[x] == baseCurrency) {
            baseCurrencySignal = currencySignal[x];
            found++;
         }
         else if(CurrencyStrengthList[x] == counterCurrency) {
            counterCurrencySignal = currencySignal[x];
            found++;
         }         
         if (found == 2) {
            if(baseCurrencySignal == 1 && counterCurrencySignal != 1) {
               currencyStrengthSignal[i] = 1;
            }
            else if(baseCurrencySignal == -1 && counterCurrencySignal != -1) {
               currencyStrengthSignal[i] = -1;
            }
            else {
               currencyStrengthSignal[i] = 0;
            }
            break;
         }
      }
   }
}
//+------------------------------------------------------------------+
void CurrencyStrengthLinesSignalV4(int &currencyStrengthSignal[], int timeframe, bool useMA, int shift) {
   string baseCurrency = "", counterCurrency = "", symbol = "";
   double currentStrength[];
   int symbolsSignal[];
   double symbolsStrenthDiff[];
   ArrayResize(currentStrength, ArraySize(CurrencyStrengthList));
   ArrayResize(symbolsSignal, ArraySize(Symbols));
   double baseValueCurrent = 0, counterValueCurrent = 0, baseValuePrevious = 0, counterValuePrevious = 0;
   double baseCurrencyMA = 0, counterCurrencyMA = 0;
   if(Period() != timeframe) ChartSetSymbolPeriod(0, _Symbol, timeframe); 
   
   for (int i = 0; i < ArraySize(CurrencyStrengthList); i++) {
      currentStrength[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift);
   }
   int found = 0;
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      baseValueCurrent = 0; counterValueCurrent = 0; baseValuePrevious = 0; counterValuePrevious = 0;
      baseCurrency = GetString(PairSepare(symbol), ";", 0);
      counterCurrency = GetString(PairSepare(symbol), ";", 1);  
      found = 0;
      for(int x = 0; x < ArraySize(CurrencyStrengthList); x++) {
         if(CurrencyStrengthList[x] == baseCurrency) {
            baseValueCurrent = currentStrength[x];
            baseCurrencyMA = CurrencyStrengthMA[x];
            found++;
         }
         else if(CurrencyStrengthList[x] == counterCurrency) {
            counterValueCurrent = currentStrength[x];
            counterCurrencyMA = CurrencyStrengthMA[x];
            found++;
         }         
         if (found == 2) break;
      }
      //do calculations
      if(((baseValueCurrent > baseCurrencyMA && useMA) || (baseValueCurrent > counterValueCurrent && !useMA)) && ((counterValueCurrent < counterCurrencyMA && useMA) || (baseValueCurrent < counterValueCurrent && !useMA))) {
         currencyStrengthSignal[i] = 1;
      }
      else if(((baseValueCurrent < baseCurrencyMA && useMA) || (baseValueCurrent < counterValueCurrent && !useMA)) && ((counterValueCurrent > counterCurrencyMA && useMA) || (counterValueCurrent > baseValueCurrent && !useMA))) {
         currencyStrengthSignal[i] = -1;
      }
      else {
         currencyStrengthSignal[i] = 0;
      }
   }
}
//+------------------------------------------------------------------+
void CurrencyStrengthLinesSignalV5(int &currencyStrengthSignal[], int timeframe, int shift) {
   string baseCurrency = "", counterCurrency = "", symbol = "";
   double currentStrength[];
   int symbolsSignal[];
   double symbolsStrenthDiff[];
   ArrayResize(currentStrength, ArraySize(CurrencyStrengthList));
   ArrayResize(symbolsSignal, ArraySize(Symbols));
   double baseValueCurrent = 0, counterValueCurrent = 0, baseValuePrevious = 0, counterValuePrevious = 0;
   
   for (int i = 0; i < ArraySize(CurrencyStrengthList); i++) {
      currentStrength[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift);
   }
   int found = 0;
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      baseValueCurrent = 0; counterValueCurrent = 0; baseValuePrevious = 0; counterValuePrevious = 0;
      baseCurrency = GetString(PairSepare(symbol), ";", 0);
      counterCurrency = GetString(PairSepare(symbol), ";", 1);  
      found = 0;
      for(int x = 0; x < ArraySize(CurrencyStrengthList); x++) {
         if(CurrencyStrengthList[x] == baseCurrency) {
            baseValueCurrent = currentStrength[x];
            found++;
         }
         else if(CurrencyStrengthList[x] == counterCurrency) {
            counterValueCurrent = currentStrength[x];
            found++;
         }         
         if (found == 2) break;
      }
      //do calculations
      if(baseValueCurrent > counterValueCurrent) {
         currencyStrengthSignal[i] = 1;
      }
      else if(baseValueCurrent < counterValueCurrent) {
         currencyStrengthSignal[i] = -1;
      }
      else {
         currencyStrengthSignal[i] = 0;
      }
   }
}
//+------------------------------------------------------------------+
void CurrencyStrengthLinesSignalV6(int &currencyStrengthSignal[], int timeframe, int shift) {
   string baseCurrency = "", counterCurrency = "", symbol = "";
   double currentStrength1[], currentStrength2[], currentStrength3[];
   int trigger[], trend[];
   int baseTrend = 0, baseTrigger = 0, counterTrend = 0, counterTrigger = 0;
   ArrayResize(currentStrength1, ArraySize(CurrencyStrengthList));
   ArrayResize(currentStrength2, ArraySize(CurrencyStrengthList));
   ArrayResize(currentStrength3, ArraySize(CurrencyStrengthList));
   ArrayResize(trigger, ArraySize(CurrencyStrengthList));
   ArrayResize(trend, ArraySize(CurrencyStrengthList));
   ArrayInitialize(currencyStrengthSignal, 0);
   double baseValue = 0, counterValue = 0;
   
   for (int i = 0; i < ArraySize(CurrencyStrengthList); i++) {
      currentStrength1[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift);
      currentStrength2[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift + 1);
      currentStrength3[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift + 2);
      
      if(currentStrength1[i] > currentStrength2[i]) {
         trend[i] = 1;
         if(currentStrength3[i] > currentStrength2[i]) {
            trigger[i] = 1;
         }
      }
      else if(currentStrength1[i] < currentStrength2[i]) {
         trend[i] = -1;
         if(currentStrength3[i] < currentStrength2[i]) {
            trigger[i] = -1;
         }
      }
   }
   
   int found = 0;
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      baseCurrency = GetString(PairSepare(symbol), ";", 0);
      counterCurrency = GetString(PairSepare(symbol), ";", 1);  
      found = 0;
      baseTrend = 0; baseTrigger = 0; counterTrend = 0; counterTrigger = 0;
      
      for(int x = 0; x < ArraySize(CurrencyStrengthList); x++) {
         if(CurrencyStrengthList[x] == baseCurrency) {
            baseTrend = trend[x];
            baseTrigger = trigger[x];
            baseValue = currentStrength2[x];
            found++;
         }
         else if(CurrencyStrengthList[x] == counterCurrency) {
            counterTrend = trend[x];
            counterTrigger = trigger[x];
            counterValue = currentStrength2[x];
            found++;
         }         
         if (found == 2) {            
            break;         
         }
      }
      
      if((baseTrend == 1 && counterTrigger == -1 && counterValue >= StrengthMinimumLevel && baseValue < 0) || (baseTrigger == 1 && counterTrend == -1 && baseValue <= StrengthMinimumLevel * -1 && counterValue > 0)) {
         currencyStrengthSignal[i] = 1;
      }
      else if((baseTrend == -1 && counterTrigger == 1 && counterValue <= StrengthMinimumLevel * -1 && baseValue > 0) || (baseTrigger == -1 && counterTrend == 1 && baseValue >= StrengthMinimumLevel && counterValue < 0)) {
         currencyStrengthSignal[i] = -1;
      }
   }
}
//+------------------------------------------------------------------+
void CurrencyStrengthLinesSignalV7(int &currencyStrengthSignal[], int timeframe, int shift) {
   string baseCurrency = "", counterCurrency = "", symbol = "";
   double currentStrength[];
   int trigger[], trend[];
   int baseTrend = 0, baseTrigger = 0, counterTrend = 0, counterTrigger = 0;
   ArrayResize(currentStrength, ArraySize(CurrencyStrengthList));
   ArrayInitialize(currencyStrengthSignal, 0);
   double baseValue = 0, counterValue = 0;
   
   for (int i = 0; i < ArraySize(CurrencyStrengthList); i++) {
      currentStrength[i] = iCustom(_Symbol, timeframe, "MQLTA MT4 Currency Strength Lines", i, shift);
   }
   
   int found = 0;
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      baseCurrency = GetString(PairSepare(symbol), ";", 0);
      counterCurrency = GetString(PairSepare(symbol), ";", 1);  
      found = 0;
      baseTrend = 0; counterTrend = 0;
      
      for(int x = 0; x < ArraySize(CurrencyStrengthList); x++) {
         if(CurrencyStrengthList[x] == baseCurrency) {
            baseValue = currentStrength[x];
            found++;
         }
         else if(CurrencyStrengthList[x] == counterCurrency) {
            counterValue = currentStrength[x];
            found++;
         }         
         if (found == 2) {            
            break;         
         }
      }
      
      if(baseValue > 0 && counterValue < 0) {
         currencyStrengthSignal[i] = 1;
      }
      else if(baseValue < 0 && counterValue > 0) {
         currencyStrengthSignal[i] = -1;
      }
   }
}
//+------------------------------------------------------------------+
int GetCurrencyRankPosition(string currency, double &currencyStrenth[]) {
   int result = 0;
   
   for(int i = 0; i < ArraySize(CurrencyStrengthList); i++) {
      if(CurrencyStrengthList[i] == currency) {
         result = GetPositionRank(currencyStrenth, currencyStrenth[i], i);
         break;
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
int GetPositionRank(double &symbolsStrenthForce[], double value, int pos) {
   int result = 0;
   
   for(int i = 0; i < ArraySize(symbolsStrenthForce); i++) {
      if(i == pos)continue;
      
      if(MathAbs(symbolsStrenthForce[i]) > MathAbs(value)) {
         result++;
      }
   }
   result = result + 1;
   
   return result;
}
//+------------------------------------------------------------------+
void SetCurrencyStrength() {
   int i = 0;
   string symbol = "";
   string result = "";
   double value_base = 0, value_counter = 0;
   long time = TimeCurrent();
   double total_strength = 0;
   double strength[8];
   long time_in_seconds = TimeSeconds(TimeCurrent());
   double usd = NormalizeDouble(iCustom(_Symbol, PERIOD_H1, "1000pipsMini_ns", 25, 25, 1, 8, "Arial", false, 0, 0), 2);////
   double eur = NormalizeDouble(iCustom(_Symbol, PERIOD_H1, "1000pipsMini_ns", 25, 25, 1, 8, "Arial", false, 0, 1), 2);////
   double gbp = NormalizeDouble(iCustom(_Symbol, PERIOD_H1, "1000pipsMini_ns", 25, 25, 1, 8, "Arial", false, 0, 2), 2);////
   double jpy = NormalizeDouble(iCustom(_Symbol, PERIOD_H1, "1000pipsMini_ns", 25, 25, 1, 8, "Arial", false, 0, 3), 2);////
   double chf = NormalizeDouble(iCustom(_Symbol, PERIOD_H1, "1000pipsMini_ns", 25, 25, 1, 8, "Arial", false, 0, 4), 2);////
   double cad = NormalizeDouble(iCustom(_Symbol, PERIOD_H1, "1000pipsMini_ns", 25, 25, 1, 8, "Arial", false, 0, 5), 2);////
   double nzd = NormalizeDouble(iCustom(_Symbol, PERIOD_H1, "1000pipsMini_ns", 25, 25, 1, 8, "Arial", false, 0, 6), 2);////
   double aud = NormalizeDouble(iCustom(_Symbol, PERIOD_H1, "1000pipsMini_ns", 25, 25, 1, 8, "Arial", false, 0, 7), 2);////
   total_strength = (usd + eur + gbp + jpy + chf + cad + nzd + aud);
   Symbols_Strength_Average = NormalizeDouble(total_strength / 8, 2);    

   if (usd == EMPTY_VALUE || eur == EMPTY_VALUE || gbp == EMPTY_VALUE || jpy == EMPTY_VALUE
      || chf == EMPTY_VALUE || cad == EMPTY_VALUE || nzd == EMPTY_VALUE || aud == EMPTY_VALUE) { 
      usd = Currency_Strength("USD");
      eur = Currency_Strength("EUR");
      gbp = Currency_Strength("GBP");
      jpy = Currency_Strength("JPY");
      chf = Currency_Strength("CHF");
      cad = Currency_Strength("CAD"); 
      nzd = Currency_Strength("NZD");
      aud = Currency_Strength("AUD");
   }
       
   if(usd > 0)CurrencyStrength[0] = IntegerToString(time + time_in_seconds) + ";" + DoubleToString(usd);//  + ";" + DoubleToString(total_strength) + ";" + DoubleToString(Symbols_Strength_Average)
   if(eur > 0)CurrencyStrength[1] = IntegerToString(time + time_in_seconds) + ";" + DoubleToString(eur);
   if(gbp > 0)CurrencyStrength[2] = IntegerToString(time + time_in_seconds) + ";" + DoubleToString(gbp);
   if(jpy > 0)CurrencyStrength[3] = IntegerToString(time + time_in_seconds) + ";" + DoubleToString(jpy);
   if(chf > 0)CurrencyStrength[4] = IntegerToString(time + time_in_seconds) + ";" + DoubleToString(chf);
   if(cad > 0)CurrencyStrength[5] = IntegerToString(time + time_in_seconds) + ";" + DoubleToString(cad);
   if(nzd > 0)CurrencyStrength[6] = IntegerToString(time + time_in_seconds) + ";" + DoubleToString(nzd);
   if(aud > 0)CurrencyStrength[7] = IntegerToString(time + time_in_seconds) + ";" + DoubleToString(aud);
}
//+------------------------------------------------------------------+
int SymbolStrengthSignal(string symbol, int timeframe, int time_shift) {
   int result = 0;
   string base_currency_strength_signal = "", counter_currency_strength_signal = "";
   
   base_currency_strength_signal = GetCurrencyStrength(GetString(PairSepare(symbol), ";", 0), CurrencyStrength);
   counter_currency_strength_signal = GetCurrencyStrength(GetString(PairSepare(symbol), ";", 1), CurrencyStrength);
   
   long base_currency_strength_time = GetDateTime(base_currency_strength_signal, ";", 0);
   double base_currency_strength = GetDouble(base_currency_strength_signal, ";", 1);
   long counter_currency_strength_time = GetDateTime(counter_currency_strength_signal, ";", 0);
   double counter_currency_strength = GetDouble(counter_currency_strength_signal, ";", 1); 
   
   long time = iTime(symbol, timeframe, time_shift); 

   if(base_currency_strength > 0 && counter_currency_strength > 0) {
      if(base_currency_strength_time > time && counter_currency_strength_time > time) {
         if(base_currency_strength > counter_currency_strength  && base_currency_strength - counter_currency_strength > MinCurrencyStrengthDiff) {
            result = 1;
         }
         else if(base_currency_strength < counter_currency_strength && counter_currency_strength - base_currency_strength > MinCurrencyStrengthDiff) {
            result = -1;
         }
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
double SymbolStrengthValue(string symbol) {
   double result = 0;
   string base_currency_strength_signal = "", counter_currency_strength_signal = "";
   
   base_currency_strength_signal = GetCurrencyStrength(GetString(PairSepare(symbol), ";", 0), CurrencyStrength);
   counter_currency_strength_signal = GetCurrencyStrength(GetString(PairSepare(symbol), ";", 1), CurrencyStrength);
   
   double base_currency_strength = GetDouble(base_currency_strength_signal, ";", 1);
   double counter_currency_strength = GetDouble(counter_currency_strength_signal, ";", 1); 
   
   result = base_currency_strength - counter_currency_strength;
   
   return result;
}
//+------------------------------------------------------------------+
string GetCurrencyStrength(string currency, string &currencyArray[]) {
   string result = "";
   int i = 0;

   for (i = 0; i < ArraySize(currencyArray); i++) {
      if (Currency[i] == currency) {
         result = currencyArray[i];
         break;
      }
   }

   return result;
}
//+------------------------------------------------------------------+
string PairSepare(string pair) {
   string result = "";
   result = StringSubstr(pair, 0, 3) + ";" + StringSubstr(pair, 3, 3);
   return result;
}
//+------------------------------------------------------------------+
double FindNextLevel(string symbol, const double sp, const direction dir) {
   // Multiplier for getting number of points in the price.
   double multiplier = MathPow(10, (int)MarketInfo(symbol, MODE_DIGITS));
   // Integer price (nubmer of points in the price).
   int integer_price = (int)MathRound(sp * MathPow(10, (int)MarketInfo(symbol, MODE_DIGITS)));
   // Distance from the next round number down.
   int distance = integer_price % Interval;
   if (dir == Down) {
      return(NormalizeDouble(MathRound(integer_price - distance) / multiplier, (int)MarketInfo(symbol, MODE_DIGITS)));
   }
   else if (dir == Up) {
      return(NormalizeDouble((integer_price + (Interval - distance)) / multiplier, (int)MarketInfo(symbol, MODE_DIGITS)));
   }
   return(EMPTY_VALUE);
}
//+------------------------------------------------------------------+
double GetNextLevel(string symbol, const direction dir) {
   double result = 0;
   double starting_price = NormalizeDouble(SymbolInfoDouble(symbol, SYMBOL_BID), (int)MarketInfo(symbol, MODE_DIGITS));

   if(dir == Up) {
      result = FindNextLevel(symbol, NormalizeDouble(starting_price, (int)MarketInfo(symbol, MODE_DIGITS)), Up);   
   }
   else if(dir == Down) {
      result = FindNextLevel(symbol, NormalizeDouble(starting_price, (int)MarketInfo(symbol, MODE_DIGITS)), Down);
   }
   
   return result;
}
//+------------------------------------------------------------------+
int GetDirection(string symbol, double level_up, double level_down) {
   int result = 0;
   double high = 0, low = 0, close = 0;
   int i = 0;
   int timeframe = 0;
   if(IsTesting()) timeframe = Timeframe_M15;
   else timeframe = Timeframe_M1;

   for (i = 0; i < Bars; i++) {
      high = iHigh(symbol, timeframe, i);
      low = iLow(symbol, timeframe, i);
      close = iClose(symbol, timeframe, i);
   
      if (high > level_up && low > level_down && close < level_up) {
         result = -1;
         break;
      }
      else if (low < level_down && high < level_up && close > level_down) {
         result = 1;
         break;
      }
   }   

   return result;
}
//+------------------------------------------------------------------+
void CheckLevelsToOpen(string symbol, double entry_level, int type, string &result[]) {
   double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
   double bid_nrm = NormalizeDouble(bid, (int)MarketInfo(symbol, MODE_DIGITS)-1);
   double ask_nrm = NormalizeDouble(ask, (int)MarketInfo(symbol, MODE_DIGITS)-1);
   double bid_distance = 0, ask_distance = 0, point = 0;
   int distance = 0;
   if (StringFind(symbol, "JPY") < 0) point = 0.0001; else point = 0.01;
   
   if(ArraySize(result) != 3) {
      Print("Incorrect Array Size for CheckLevelsToOpen");
      return;
   }
   else {
      result[0] = "";
      result[1] = "";
      result[2] = "";
   }
   
   if(type == Up) {
      ask_distance = (ask_nrm - entry_level) / point;
      distance = (int)NormalizeDouble(ask_distance, 0);
      if(!CheckExistingOrder_byMagic(symbol, type, distance - 1)) {
         result[0] = DoubleToString(ask_nrm - (10 * MarketInfo(symbol, MODE_POINT))) +";"+ IntegerToString(distance - 1);
      }
      if(!CheckExistingOrder_byMagic(symbol, type, distance)) {
         result[1] = DoubleToString(ask_nrm) +";"+ IntegerToString(distance);
      }
      if(!CheckExistingOrder_byMagic(symbol, type, distance + 1)) {
         result[2] = DoubleToString(ask_nrm + (10 * MarketInfo(symbol, MODE_POINT))) +";"+ IntegerToString(distance + 1);
      }
   }
   else if(type == Down) {
      bid_distance = (entry_level - bid_nrm) / point;
      distance = (int)NormalizeDouble(bid_distance, 0);
      if(!CheckExistingOrder_byMagic(symbol, type, distance - 1)) {
         result[0] = DoubleToString(bid_nrm + (10 * MarketInfo(symbol, MODE_POINT))) +";"+ IntegerToString(distance - 1);
      }
      if(!CheckExistingOrder_byMagic(symbol, type, distance)) {
         result[1] = DoubleToString(bid_nrm) +";"+ IntegerToString(distance);
      }
      if(!CheckExistingOrder_byMagic(symbol, type, distance + 1)) {
         result[2] = DoubleToString(bid_nrm - (10 * MarketInfo(symbol, MODE_POINT))) +";"+ IntegerToString(distance + 1);
      }  
   }
}
//+------------------------------------------------------------------+
string CMALevelsToOpen(string symbol, int type, double cmd_value) {
   string result = "";
   double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
   double cma_nrm = NormalizeDouble(cmd_value, (int)MarketInfo(symbol, MODE_DIGITS)-1);
   double bid_nrm = NormalizeDouble(bid, (int)MarketInfo(symbol, MODE_DIGITS)-1);
   double ask_nrm = NormalizeDouble(ask, (int)MarketInfo(symbol, MODE_DIGITS)-1);
      
   double cma_distance = 0, point = 0;
   int distance = 0;
   if (StringFind(symbol, "JPY") < 0) point = 0.0001; else point = 0.01;
      
   if(type == Up) {
      if(!CheckExistingOrder_byMagic(symbol, type, 1)) {
         result = DoubleToString(cma_nrm + (10 * MarketInfo(symbol, MODE_POINT))) + ";1";
      }
      else {
         if(!ExistOpenOrderOnThisLevel(symbol, Up, ask_nrm) && ask_nrm >= cma_nrm) {
            result = DoubleToString(ask_nrm) + ";0";
         }
      }
   }
   else if(type == Down) {
      if(!CheckExistingOrder_byMagic(symbol, type, 1)) {
         result = DoubleToString(cma_nrm - (10 * MarketInfo(symbol, MODE_POINT))) + ";1";
      } 
      else {
         if(!ExistOpenOrderOnThisLevel(symbol, Down, bid_nrm) && bid_nrm <= cma_nrm) {
            result = DoubleToString(bid_nrm) + ";0";
         }      
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool ExistOpenOrderOnThisLevel(string symbol, int type, double level) {
   bool result = false;
   int cnt = 0;
   string comment = "";
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
        
      if (OrderSymbol() == symbol) {
         comment = OrderComment();
         if(type == Up) {
            if(OrderType() == OP_BUY || OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT) {
               if(NormalizeDouble(GetDouble(comment, ";", 0), (int)MarketInfo(symbol, MODE_DIGITS)) == NormalizeDouble(level, (int)MarketInfo(symbol, MODE_DIGITS))) {
                  result = true;
                  break;
               }    
            }
         }
         else if(type == Down) {
            if(OrderType() == OP_SELL || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {
               if(NormalizeDouble(GetDouble(comment, ";", 0), (int)MarketInfo(symbol, MODE_DIGITS)) == NormalizeDouble(level, (int)MarketInfo(symbol, MODE_DIGITS))) {
                  result = true;
                  break;
               }            
            }         
         }
      }
   }
   
   return result; 
}
//+------------------------------------------------------------------+
bool ExistCloseOrderOnThisLevel(string symbol, int type, double level) {
   bool result = false;
   int cnt = 0;
   string comment = "";
   
   for (cnt = OrdersHistoryTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_HISTORY)) {
         continue;
      }
        
      if (OrderSymbol() == symbol) {
         comment = OrderComment();
         if(type == Up) {
            if(OrderType() == OP_BUY) {
               if(NormalizeDouble(GetDouble(comment, ";", 0), (int)MarketInfo(symbol, MODE_DIGITS)) == NormalizeDouble(level, (int)MarketInfo(symbol, MODE_DIGITS))) {
                  result = true;
                  break;
               }    
            }
         }
         else if(type == Down) {
            if(OrderType() == OP_SELL) {
               if(NormalizeDouble(GetDouble(comment, ";", 0), (int)MarketInfo(symbol, MODE_DIGITS)) == NormalizeDouble(level, (int)MarketInfo(symbol, MODE_DIGITS))) {
                  result = true;
                  break;
               }            
            }         
         }
      }
   }
   
   return result; 
}
//+------------------------------------------------------------------+
double GetFirstOrderLot(string symbol) {
   int cnt = 0;
   double result = 0;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
        
      if (OrderSymbol() == symbol && OrderMagicNumber() == 1) {
         result = OrderLots();
      }
   } 
   
   return result;
}
//+------------------------------------------------------------------+
int MaxOpenOrderByType(string symbol, int type) {
   int cnt = 0;
   int result = 0;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
        
      if (OrderSymbol() == symbol && OrderType() == type) {
         result++;
      }
   } 
   
   return result;
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
string CalculatePivot(string symbol, int timeframe, int shift) {
    //Variables Definitions
    string result = "";
    int i = 0, Dir = 0;
    double D_yesterday_high = 0, D_yesterday_open = 0, D_yesterday_low = 0, D_yesterday_close = 0, D_P, D_R1, D_R2, D_R3, D_S1, D_S2, D_S3;
    double res = 0, sup = 0, high = 0, low = 0, close = 0, buy_sl = 0, sell_sl = 0;
    long time_touch = 0;
    double touch_point = 0;
    double rates_d1[2][6]; 
    double BC = 0, TC = 0;
    double price = iClose(symbol, timeframe, shift);
    double pp_level_join = (PPLevelJoinDistance * MarketInfo(symbol, MODE_POINT)); 
    
    ArrayCopyRates(rates_d1, symbol, PERIOD_D1);
    D_yesterday_close = rates_d1[shift][4];//iClose(symbol, Timeframe_D, camarila_shift);//
    D_yesterday_open = rates_d1[shift][1];//iOpen(symbol, Timeframe_D, camarila_shift);//
    D_yesterday_high = rates_d1[shift][3];//iHigh(symbol, Timeframe_D, camarila_shift);//
    D_yesterday_low = rates_d1[shift][2];//iLow(symbol, Timeframe_D, camarila_shift);//    
        
    //---- Calculate Pivots DAY 0 
    D_P = NormalizeDouble((D_yesterday_high + D_yesterday_low + D_yesterday_close) / 3, (int)MarketInfo(symbol, MODE_DIGITS));
    D_R1 = NormalizeDouble((2 * D_P) - D_yesterday_low, (int)MarketInfo(symbol, MODE_DIGITS));
    D_S1 = NormalizeDouble((2 * D_P) - D_yesterday_high, (int)MarketInfo(symbol, MODE_DIGITS));
    D_R2 = NormalizeDouble(D_P + (D_yesterday_high - D_yesterday_low), (int)MarketInfo(symbol, MODE_DIGITS));//NormalizeDouble((D_P-D_S1)+D_R1, Digits);//
    D_S2 = NormalizeDouble(D_P - (D_yesterday_high - D_yesterday_low), (int)MarketInfo(symbol, MODE_DIGITS));//NormalizeDouble(D_P-(D_R1-D_S1), Digits);//
    D_R3 = NormalizeDouble((2 * D_P) + (D_yesterday_high - (2 * D_yesterday_low)), (int)MarketInfo(symbol, MODE_DIGITS));
    D_S3 = NormalizeDouble((2 * D_P) - ((2 * D_yesterday_high) - D_yesterday_low), (int)MarketInfo(symbol, MODE_DIGITS));
    BC = (D_yesterday_high + D_yesterday_low)/2;
    TC = 2 * D_P - BC;   
    if(BC > TC) {
      double temp = BC;
      BC = TC;
      TC = temp;
    }    

	 if(price < D_S3){ res = D_S3; sup = 0; buy_sl = 0; sell_sl = 0; }
	 else if(price > D_S3 && price < D_S2){ res = D_S2; sup = D_S3; buy_sl = D_S3 - (D_S2-D_S3); sell_sl = 0; }
	 else if(price > D_S2 && price < D_S1){ res = D_S1; sup = D_S2; buy_sl = D_S3; sell_sl = 0; }
	 else if(price > D_S1 && price < D_P){ res = D_P; sup = D_S1; buy_sl = D_S2; sell_sl = 0; }
	 else if(price > D_P && price < D_R1){ res = D_R1; sup = D_P; buy_sl = 0; sell_sl = D_R2; }
	 else if(price > D_R1 && price < D_R2){ res = D_R2; sup = D_R1; buy_sl = 0; sell_sl = D_R3; }
	 else if(price > D_R2 && price < D_R3){ res = D_R3; sup = D_R2; buy_sl = 0; sell_sl = D_R3 + (D_R3-D_R2); }
	 else if(price > D_R3){ res = 99999; sup = D_R2; buy_sl = 0; sell_sl = 0; }     
	 
    for (i = shift; i < 1440; i++) {
        high = iHigh(symbol, timeframe, i);
        low = iLow(symbol, timeframe, i);
        close = iClose(symbol, timeframe, i);
   
        if (iTime(symbol, timeframe, i) >= iTime(symbol, Timeframe_D, 0)) {
            if (high > res-pp_level_join && low > sup && close < res) {
                Dir = -1;
                touch_point = res;
                break;
            }
            else if (high < res && low < sup+pp_level_join && close > sup) {
                Dir = 1;
                touch_point = sup;
                break;
            }
        }
        else {
            break;
        }
    }	 
   
    result = DoubleToStr(D_R3) + ";" + DoubleToStr(D_R2) + ";" + DoubleToStr(D_R1) + ";" + DoubleToStr(D_P) + ";"
             + DoubleToStr(D_S1) + ";" + DoubleToStr(D_S2) + ";" + DoubleToStr(D_S3) + ";" 
             + DoubleToStr(TC) + ";" + DoubleToStr(BC) +";"+ IntegerToString(Dir) +";"+ DoubleToString(touch_point) +";"
             + DoubleToString(buy_sl) +";"+ DoubleToString(sell_sl);;

    return result;
}
//+------------------------------------------------------------------+
string CalculateCamarilla(string symbol, int timeframe, int shift) {
   int i = 0, dir = 0;
   double res = 0, sup = 0, high = 0, low = 0, close = 0, price = iClose(symbol, timeframe, shift);
   string result = "";
   //double day_high = 0;
   //double day_low = 0;
   double yesterday_high = 0;
   double yesterday_open = 0;
   double yesterday_low = 0;
   double yesterday_close = 0;
   double today_open = 0;
   double today_high = 0;
   double today_low = 0;
   double P = 0;
   double Q = 0;
   double R1, R2, R3;
   double M0, M1, M2, M3, M4, M5;
   double S1, S2, S3;
   double H5, H4, H3, L5, L4, L3;
   double nQ = 0;
   double nD = 0;
   //double D = 0;
   long time_touch = 0;
   double rates_d1[2][6];  
   double touch_point = 0, oposite_point = 0;
   R1=0; R2=0; R3=0;
   M0=0; M1=0; M2=0; M3=0; M4=0; M5=0;
   S1=0; S2=0; S3=0;
   H4=0; H3=0; L4=0; L3=0;   

   //---- Get new daily prices

   ArrayCopyRates(rates_d1, symbol, PERIOD_D1);
   if(shift < 1) shift = 1;

   yesterday_close = rates_d1[shift][4];//iClose(symbol, Timeframe_D, camarila_shift);//
   yesterday_open = rates_d1[shift][1];//iOpen(symbol, Timeframe_D, camarila_shift);//
   today_open = rates_d1[shift-1][1];//iOpen(symbol, Timeframe_D, camarila_shift - 1);//
   yesterday_high = rates_d1[shift][3];//iHigh(symbol, Timeframe_D, camarila_shift);//
   yesterday_low = rates_d1[shift][2];//iLow(symbol, Timeframe_D, camarila_shift);//
   
   //---- Calculate Pivots
   
   //D = (day_high - day_low);
   Q = (yesterday_high - yesterday_low);
   P = (yesterday_high + yesterday_low + yesterday_close) / 3;
   R1 = (2* P)-yesterday_low;
   S1 = (2* P)-yesterday_high;
   R2 = P+(yesterday_high - yesterday_low);
   S2 = P-(yesterday_high - yesterday_low);

   H5 = (yesterday_high / yesterday_low) * yesterday_close;
	H4 = (Q*0.55)+yesterday_close;
	H3 = (Q*0.275)+yesterday_close;
	R3 = (2* P)+(yesterday_high-(2* yesterday_low));
	M5 = (R2+R3)/2;
   //	R2 = P-S1+R1;
	M4 = (R1+R2)/2;
   //	R1 = (2*P)-yesterday_low;
	M3 = (P+R1)/2;
   //	P = (yesterday_high + yesterday_low + yesterday_close)/3;
	M2 = (P+S1)/2;
   //	S1 = (2*P)-yesterday_high;
	M1 = (S1+S2)/2;
   //	S2 = P-R1+S1;
	S3 = (2* P)-((2* yesterday_high)-yesterday_low);
	L5 = yesterday_close - (H5 - yesterday_close);
	L3 = yesterday_close-(Q*0.275);	
	L4 = yesterday_close-(Q*0.55);	
	M0 = (S2+S3)/2;  
	
	if(price < L5){ res = L5; sup = 0; }
	else if(price > L5 && price < L4){ res = L4; sup = L5; }
	else if(price > L4 && price < L3){ res = L3; sup = L4; }
	else if(price > L3 && price < H3){ res = H3; sup = L3; }
	else if(price > H3 && price < H4){ res = H4; sup = H3; }
	else if(price > H4 && price < H5){ res = H5; sup = H4; }
	else if(price > H5){ res = 99999; sup = H5; }
	
   for (i = shift; i < 1440; i++) {
       high = iHigh(symbol, timeframe, i);
       low = iLow(symbol, timeframe, i);
       close = iClose(symbol, timeframe, i);
   
       if (iTime(symbol, timeframe, i) >= iTime(symbol, Timeframe_D, 0)) {
           if (high > res && low > sup && close < high) {
               dir = -1;
               time_touch = iTime(symbol, timeframe, i);
               touch_point = res;
               oposite_point = sup;
               break;
           }
           else if (high < res && low < sup && close > sup) {
               dir = 1;
               time_touch = iTime(symbol, timeframe, i);
               touch_point = sup;
               oposite_point = res;
               break;
           }
       }
       else {
           break;
       }
   }			
	
	result = DoubleToString(H5, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(H4, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(H3, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(L3, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(L4, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(L5, (int)MarketInfo(symbol, MODE_DIGITS))+";"+IntegerToString(dir)+";"+DoubleToString(touch_point, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(oposite_point, (int)MarketInfo(symbol, MODE_DIGITS));

   return result;
}
//+------------------------------------------------------------------+
string CalculateCamarilla_old(int timeframe, string symbol, int camarila_shift, int shift) {
   int i = 0, dir = 0;
   double res = 0, sup = 0, price = iClose(symbol, timeframe, shift), high = 0, low = 0, close = 0;
   string result = "";
   //double day_high = 0;
   //double day_low = 0;
   double yesterday_high = 0;
   double yesterday_open = 0;
   double yesterday_low = 0;
   double yesterday_close = 0;
   double today_open = 0;
   double today_high = 0;
   double today_low = 0;
   double P = 0;
   double Q = 0;
   double R1, R2, R3;
   double M0, M1, M2, M3, M4, M5;
   double S1, S2, S3;
   double H5, H4, H3, L5, L4, L3;
   double nQ = 0;
   double nD = 0;
   //double D = 0;
   long time_touch = 0;
   double rates_d1[2][6];  
   double touch_point = 0;
   R1=0; R2=0; R3=0;
   M0=0; M1=0; M2=0; M3=0; M4=0; M5=0;
   S1=0; S2=0; S3=0;
   H4=0; H3=0; L4=0; L3=0;   

   //---- Get new daily prices

   //ArrayCopyRates(rates_d1, symbol, PERIOD_D1);

   yesterday_close = iClose(symbol, Timeframe_D, camarila_shift);//rates_d1[1][4];
   yesterday_open = iOpen(symbol, Timeframe_D, camarila_shift);//rates_d1[1][1];
   today_open = iOpen(symbol, Timeframe_D, camarila_shift - 1);//rates_d1[0][1];
   yesterday_high = iHigh(symbol, Timeframe_D, camarila_shift);//rates_d1[1][3];
   yesterday_low = iLow(symbol, Timeframe_D, camarila_shift);//rates_d1[1][2];
   //day_high = rates_d1[0][3];
   //day_low = rates_d1[0][2];   
   
   //---- Calculate Pivots
   
   //D = (day_high - day_low);
   Q = (yesterday_high - yesterday_low);
   P = (yesterday_high + yesterday_low + yesterday_close) / 3;
   R1 = (2* P)-yesterday_low;
   S1 = (2* P)-yesterday_high;
   R2 = P+(yesterday_high - yesterday_low);
   S2 = P-(yesterday_high - yesterday_low);

   H5 = (yesterday_high / yesterday_low) * yesterday_close;
	H4 = (Q*0.55)+yesterday_close;
	H3 = (Q*0.275)+yesterday_close;
	R3 = (2* P)+(yesterday_high-(2* yesterday_low));
	M5 = (R2+R3)/2;
   //	R2 = P-S1+R1;
	M4 = (R1+R2)/2;
   //	R1 = (2*P)-yesterday_low;
	M3 = (P+R1)/2;
   //	P = (yesterday_high + yesterday_low + yesterday_close)/3;
	M2 = (P+S1)/2;
   //	S1 = (2*P)-yesterday_high;
	M1 = (S1+S2)/2;
   //	S2 = P-R1+S1;
	S3 = (2* P)-((2* yesterday_high)-yesterday_low);
	L5 = yesterday_close - (H5 - yesterday_close);
	L3 = yesterday_close-(Q*0.275);	
	L4 = yesterday_close-(Q*0.55);	
	M0 = (S2+S3)/2;  
	
	if(price < L5){ res = L5; sup = 0; }
	else if(price > L5 && price < L4){ res = L4; sup = L5; }
	else if(price > L4 && price < L3){ res = L3; sup = L4; }
	else if(price > L3 && price < H3){ res = H3; sup = L3; }
	else if(price > H3 && price < H4){ res = H4; sup = H3; }
	else if(price > H4 && price < H5){ res = H5; sup = H4; }
	else if(price > H5){ res = 99999; sup = H5; }
	
	//double atr_sl_join = iATR(symbol, Timeframe_M1, ATR_PERIOD, shift);

   for (i = shift; i < 1440; i++) {
       high = iHigh(symbol, timeframe, i);
       low = iLow(symbol, timeframe, i);
       close = iClose(symbol, timeframe, i);
   
       if (iTime(symbol, timeframe, i) >= iTime(symbol, Timeframe_D, 0)) {
           if (high > res && low > sup && close < high) {
               dir = -1;
               time_touch = iTime(symbol, timeframe, i);
               touch_point = res;
               break;
           }
           else if (high < res && low < sup && close > sup) {
               dir = 1;
               time_touch = iTime(symbol, timeframe, i);
               touch_point = sup;
               break;
           }
       }
       else {
           break;
       }
   }		
	
	result = DoubleToString(H5, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(H4, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(H3, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(L3, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(L4, (int)MarketInfo(symbol, MODE_DIGITS))+";"+DoubleToString(L5, (int)MarketInfo(symbol, MODE_DIGITS))+";"+IntegerToString(dir)+";"+IntegerToString(time_touch)+";"+DoubleToString(touch_point, (int)MarketInfo(symbol, MODE_DIGITS));

   return result;
}
//+------------------------------------------------------------------+
void DeletePendingOrders_not_in_use() {
   int cnt = 0;
   bool res = false;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {      
         res = OrderDelete(OrderTicket());
         SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
      }
   } 
}
//+------------------------------------------------------------------+
void DeleteOutDatedPendingOrders_not_in_use(int timeframe, int shift) {
   int cnt = 0;
   bool res = false;
   datetime open_1 = iTime(_Symbol, timeframe, shift);
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {      
         if(OrderOpenTime() < open_1) {         
            res = OrderDelete(OrderTicket());
            SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
         }
      }
   } 
}
//+------------------------------------------------------------------+
void DeletePendingOrders(string symbol, const direction dir) {
   int cnt = 0;
   bool res = false;
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderSymbol() == symbol) {
         if(dir == Up) {
            if(OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT) {      
               res = OrderDelete(OrderTicket());
               SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
            }
         }
         else if(dir == Down) {
            if(OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {      
               res = OrderDelete(OrderTicket());
               SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
            }
         }
      }
   } 
}
//+------------------------------------------------------------------+
void DeleteSymbolPendingOrders_not_in_use(string symbol) {
   int cnt = 0;
   bool res = false;
   double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);  
   double distance = 30 * MarketInfo(symbol, MODE_POINT); 
   
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderSymbol() != symbol)continue;
      
      if(OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT) {      
         if(OrderOpenPrice() > ask + distance || OrderOpenPrice() < bid - distance) {
            res = OrderDelete(OrderTicket());
            SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
         }
      }
   } 
}
//+------------------------------------------------------------------+
int CCISignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double cci1 = iCCI(symbol,timeframe, CCIPeriod, PRICE_TYPICAL, shift);
   double cci2 = iCCI(symbol,timeframe, CCIPeriod, PRICE_TYPICAL, shift + 1);
   
   if(cci2 > cci1 && cci2 > 100) result = -1;
   else if(cci2 < cci1 && cci2 < -100) result = 1;
   
   return result;
}
//+------------------------------------------------------------------+
int RSISignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double rsi = iRSI(symbol, timeframe, 14, PRICE_CLOSE, shift);
   
   if(rsi > 50) result = 1;
   else if(rsi < 50) result = -1;
   
   return result;
}
//+------------------------------------------------------------------+
int EngulfingBarSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double up = iCustom(symbol, timeframe, "EngulfingBar(outsidebar-ProfitF)", 0, shift);
   double down = iCustom(symbol, timeframe, "EngulfingBar(outsidebar-ProfitF)", 1, shift);
   
   if(up != EMPTY_VALUE && up > 0 && down == EMPTY_VALUE) {
      result = 1;
   }
   else if(down != EMPTY_VALUE && down > 0 && up == EMPTY_VALUE) {
      result = -1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
string MovingAverageSignal_old01(string symbol, int timeframe, int ma_period, int shift) {
   string result = "";
   int trend = 0;
   double close = iClose(symbol, timeframe, shift);
   double high = iHigh(symbol, timeframe, shift);
   double low = iLow(symbol, timeframe, shift);
   double ema = iMA(symbol, timeframe, ma_period, 0, MODE_EMA, PRICE_CLOSE, shift);
   double vwap = iCustom(symbol, timeframe, "VWAP", 0, shift);
      
   if(vwap > ema && close > ema) {
      trend = 1;
   }
   else if(vwap < ema && close < ema) {
      trend = -1;      
   }
   
   result = IntegerToString(trend) +";"+ DoubleToString(ema);
      
   return result;
}
//+------------------------------------------------------------------+
int MovingAverageTrend(string symbol, int timeframe, int period, int shift) {
   int result = 0;
   double close = iClose(symbol, timeframe, shift);
   double ema_value = iMA(symbol, timeframe, period, 0, MODE_EMA, PRICE_CLOSE, shift);
      
   if(close > ema_value) {
      result = 1;
   }
   else if(close < ema_value) {
      result = -1;      
   }
         
   return result;
}
//+------------------------------------------------------------------+
string MovingAverageTriggerSignal(string symbol, int timeframe_trend, int timeframe_trigger, int shift) {
   string result = "0;0";
   int trend = 0;
   double open = iOpen(symbol, timeframe_trend, shift);
   double close = iClose(symbol, timeframe_trend, shift);
   double high = iHigh(symbol, timeframe_trend, shift);
   double low = iLow(symbol, timeframe_trend, shift);
   double ema_value_l = iMA(symbol, timeframe_trend, MAPERIOD_L, 0, MODE_EMA, PRICE_CLOSE, shift);
   double atr = iATR(symbol, timeframe_trigger, ATR_PERIOD, shift);
      
   if(close > ema_value_l && open > ema_value_l && low < ema_value_l + atr) {
      trend = 1;
   }
   else if(close < ema_value_l && open < ema_value_l && high > ema_value_l - atr) {
      trend = -1;      
   }
   
   result = IntegerToString(trend) +";"+ DoubleToString(ema_value_l);
         
   return result;
}
//+------------------------------------------------------------------+
string MovingAverageSignal(string symbol, int timeframe, int shift) {
   string result = "";
   int trend = 0;
   double close = iClose(symbol, timeframe, shift);
   double high = iHigh(symbol, timeframe, shift);
   double low = iLow(symbol, timeframe, shift);
   double ema_value_l = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_value_m = iMA(symbol, timeframe, MAPERIOD_M, 0, MODE_EMA, PRICE_CLOSE, shift);
      
   if(ema_value_m > ema_value_l && low < ema_value_m && close > ema_value_l - (ema_value_m - ema_value_l)) {
      trend = 1;
   }
   else if(ema_value_m < ema_value_l && high > ema_value_m && close < ema_value_l + (ema_value_l - ema_value_m)) {
      trend = -1;      
   }
   
   result = IntegerToString(trend) +";"+ DoubleToString(ema_value_l);
         
   return result;
}
/*
//+------------------------------------------------------------------+
string MASignal(string symbol, int timeframe, int bars, int shift) {
   string result = "";
   int trend = 0;
   int signal = 0;
   double close = iClose(symbol, timeframe, shift);
   double open = iOpen(symbol, timeframe, shift);
   double ema_value_l = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_value_m = iMA(symbol, timeframe, MAPERIOD_M, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_value_s = iMA(symbol, timeframe, MAPERIOD_S, 0, MODE_EMA, PRICE_CLOSE, shift);
   bool extension_validate = false;
   double target = 0;
      
   if(close > ema_value_m && ema_value_s > ema_value_m && ema_value_m > ema_value_l) {
      trend = 1;
   }
   else if(close < ema_value_m && ema_value_s < ema_value_m && ema_value_m < ema_value_l) {
      trend = -1;      
   }

   if(trend == 1) {
      extension_validate = true;
      if(close < ema_value_s && open > ema_value_s) {
         for(int i = shift + 1; i <= shift+bars; i++) {
            close = iClose(symbol, timeframe, i);
            ema_value_s = iMA(symbol, timeframe, MAPERIOD_S, 0, MODE_EMA, PRICE_CLOSE, i);
            if(close < ema_value_s) {
               extension_validate = false;
               break;
            }
         }
         //final validation
         if(extension_validate) {
            signal = -1;
            target = ema_value_m;
         }
      }
   }
   else if(trend == -1) {
      extension_validate = true;
      if(close > ema_value_s && open < ema_value_s) {
         for(int i = shift + 1; i <= shift+bars; i++) {
            close = iClose(symbol, timeframe, i);
            ema_value_s = iMA(symbol, timeframe, MAPERIOD_S, 0, MODE_EMA, PRICE_CLOSE, i);
            if(close > ema_value_s) {
               extension_validate = false;
               break;
            }
         }
         //final validation
         if(extension_validate) {
            signal = 1;
            target = ema_value_m;
         }
      }   
   }
   
   result = IntegerToString(signal) +";"+ DoubleToString(target);
         
   return result;
}
*/
//+------------------------------------------------------------------+
string MovingAverageWithFratalTriggerSignal(string symbol, int timeframe, string zigzag_points, int shift) {
   string signal = MovingAverageSignal(symbol, timeframe, shift);
   int trend = GetIntiger(signal, ";", 0);
   string tmp_signal = "";
   int tmp_trend = 0;
   double tmp_ma_l = 0, tmp_ma_m = 0, tmp_ma_s = 0;
   double fractal = 0;
   int fractal_position = 0;
   double close = iClose(symbol, timeframe, shift);
   int zigzap_start_up = GetIntiger(zigzag_points, ";", 1);
   int zigzap_start_dn = GetIntiger(zigzag_points, ";", 3);
   int zz_low_bar = iLowest(symbol, timeframe, MODE_LOW, zigzap_start_up, 1);
   int zz_high_bar = iHighest(symbol, timeframe, MODE_HIGH, zigzap_start_dn, 1);
   bool foundFirst = false;
   
   if(trend == 1) {
      for(int i = 3; i < Bars; i++) {
         tmp_signal = MovingAverageSignal(symbol, timeframe, i);
         tmp_trend = GetIntiger(tmp_signal, ";", 0);
         tmp_ma_l = GetDouble(tmp_signal, ";", 1);
         tmp_ma_m = GetDouble(tmp_signal, ";", 2);
         tmp_ma_s = GetDouble(tmp_signal, ";", 3);
         if(tmp_trend == 1 || fractal == 0) {
            fractal = iFractals(symbol, timeframe, MODE_LOWER, i);
            if(fractal > 0) {
               if(close > fractal) {
                  fractal_position = i;
                  break;
               }
               if(!foundFirst) {
                  foundFirst = true;
               }
            }         
         }
         if(foundFirst && i > zz_high_bar)break;
      }
   }
   else if(trend == -1) {
      for(int i = 3; i < Bars; i++) {
         tmp_signal = MovingAverageSignal(symbol, timeframe, i);
         tmp_trend = GetIntiger(tmp_signal, ";", 0);
         tmp_ma_l = GetDouble(tmp_signal, ";", 1);
         tmp_ma_m = GetDouble(tmp_signal, ";", 2);
         tmp_ma_s = GetDouble(tmp_signal, ";", 3);
         if(tmp_trend == -1 || fractal == 0) {
            fractal = iFractals(symbol, timeframe, MODE_UPPER, i);
            if(fractal > 0) {
            if(close < fractal) {
                  fractal_position = i;
                  break;
               }
            }
            if(!foundFirst) {
                  foundFirst = true;
            }         
         }
         if(foundFirst && i > zz_high_bar)break;
      }  
   }
   
   signal = signal +";"+ IntegerToString(fractal_position);
   return signal;
}
//+------------------------------------------------------------------+
string CheckSignal(string symbol, int timeframe_trend, int timeframe_trigger, string ma_signal, int shift_trend, int shift_trigger) {
   string result = "0;0;0;0";
   int trend = GetIntiger(ma_signal, ";", 0);
   int fractal_pos = GetIntiger(ma_signal, ";", 4);
   double high = 0, low = 0, base = 0, top = 0, close_trigger = 0, high_trend = 0, low_trend = 0;
   
   if(trend == 1 && fractal_pos > 0) {
      result = "1;0;0";
      low = iLow(symbol, timeframe_trend, fractal_pos); 
      base = MathMin(iOpen(symbol, timeframe_trend, fractal_pos), iClose(symbol, timeframe_trend, fractal_pos)); 
      top = MathMax(iOpen(symbol, timeframe_trend, fractal_pos), iClose(symbol, timeframe_trend, fractal_pos));  
      close_trigger = iClose(symbol, timeframe_trigger, shift_trigger);     
      low_trend = MathMin(iLow(symbol, timeframe_trend, shift_trend), iLow(symbol, timeframe_trend, shift_trend + 1));
      if(close_trigger > low && low_trend < base && close_trigger < top) {
         result = "1;1;" + DoubleToString(low);
      }
   }
   else if(trend == -1 && fractal_pos > 0) {
      result = "-1;0;0";
      high = iHigh(symbol, timeframe_trend, fractal_pos); 
      base = MathMin(iOpen(symbol, timeframe_trend, fractal_pos), iClose(symbol, timeframe_trend, fractal_pos)); 
      top = MathMax(iOpen(symbol, timeframe_trend, fractal_pos), iClose(symbol, timeframe_trend, fractal_pos)); 
      close_trigger = iClose(symbol, timeframe_trigger, shift_trigger);
      high_trend = MathMax(iHigh(symbol, timeframe_trend, shift_trend), iHigh(symbol, timeframe_trend, shift_trend + 1));   
      if(close_trigger < high && high_trend > top && close_trigger > base) {
         result = "-1;-1;" + DoubleToString(high);
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool GetFibonacciSignal(string symbol, int timeframe_trend, int timeframe_trigger, double zone_join_points, string zigzag_point, int trend, int shift) {
   bool result = false;
   int trigger = 0;
   double zigzag_start_point_up = GetDouble(zigzag_point, ";", 0);
   int zigzag_start_pos_up = GetIntiger(zigzag_point, ";", 1); 
   double zigzag_start_point_dn = GetDouble(zigzag_point, ";", 2);
   int zigzag_start_pos_dn = GetIntiger(zigzag_point, ";", 3);     
   double fibo_points[];
   ArrayResize(fibo_points, 4);
   double fibo_sl = 0, fibo_expansion_point = 0;
   double close_trigger = iClose(symbol, timeframe_trigger, shift);
   int other_fibo_point = 0;
   double lowest = 0, highest = 0;

   if(trend == 1) {
      FillFiboPoints(symbol, timeframe_trend, fibo_points, trend, zigzag_start_point_dn, zigzag_start_pos_dn, fibo_expansion_point, other_fibo_point, 1);
      lowest = iLow(symbol, timeframe_trend, iLowest(symbol, timeframe_trend, MODE_LOW, other_fibo_point, 0));
      if(lowest < fibo_points[0] + zone_join_points) {
         result = true;
      }
   }
   else if(trend == -1) {
      FillFiboPoints(symbol, timeframe_trend, fibo_points, trend, zigzag_start_point_up, zigzag_start_pos_up, fibo_expansion_point, other_fibo_point, 1);
      highest = iHigh(symbol, timeframe_trend, iHighest(symbol, timeframe_trend, MODE_HIGH, other_fibo_point, 0));
      if(highest > fibo_points[0] - zone_join_points) {
         result = true;
      }  
   }
   return result;
}
//+------------------------------------------------------------------+
void FillFiboPoints(string symbol, int timeframe, double &fibos_points[], int type, double fibostart_point, int fibostart_shift, double &fibo_expansion_point, int &other_fibo_point, int shift) {
   double fibo_high = 0, fibo_low = 0;
   double fb_expansion_start = 0;
   
   if(type == 1) {
      other_fibo_point = iHighest(symbol, timeframe, MODE_HIGH, fibostart_shift-shift, shift);
      fibo_high = iHigh(symbol, timeframe, other_fibo_point); 
      fb_expansion_start = iLow(symbol, timeframe, iLowest(symbol, timeframe, MODE_LOW, iHighest(symbol, timeframe, MODE_HIGH, fibostart_shift-shift, shift), 0));    
      fibos_points[0] = fibo_high - ((fibo_high - fibostart_point) * 0.236);
      fibos_points[1] = fibo_high - ((fibo_high - fibostart_point) * 0.382);
      fibos_points[2] = fibo_high - ((fibo_high - fibostart_point) * 0.500);
      fibos_points[3] = fibo_high - ((fibo_high - fibostart_point) * 0.618); 
      //fibo_expansion_point = fb_expansion_start + (fibo_high - fibostart_point);
      fibo_expansion_point = fibo_high;
   }
   else if(type == -1) {
      other_fibo_point = iLowest(symbol, timeframe, MODE_LOW, fibostart_shift-shift, shift);
      fibo_low = iLow(symbol, timeframe, other_fibo_point);
      fb_expansion_start = iHigh(symbol, timeframe, iHighest(symbol, timeframe, MODE_HIGH, iLowest(symbol, timeframe, MODE_LOW, fibostart_shift-shift, shift), 0));
      fibos_points[0] = fibo_low + ((fibostart_point - fibo_low) * 0.236);
      fibos_points[1] = fibo_low + ((fibostart_point - fibo_low) * 0.382);
      fibos_points[2] = fibo_low + ((fibostart_point - fibo_low) * 0.500);
      fibos_points[3] = fibo_low + ((fibostart_point - fibo_low) * 0.618); 
      //fibo_expansion_point = fb_expansion_start - (fibostart_point - fibo_low);  
      fibo_expansion_point = fibo_low;
   }
}
//+------------------------------------------------------------------+
double GetFibonacciPoint(string symbol, double level, int type, double up_point, double dn_point, int shit) {
   double result = 0;
   
   if(type == 1) {
      result = up_point - ((up_point - dn_point) * level);
   }
   else if(type == -1) {
      result = dn_point + ((up_point - dn_point) * level);
   }
   
   return result;
}
//+------------------------------------------------------------------+
string MovingAverageSignalV2(string symbol, int timeframe, bool useshortma, int stochastic_pos, int shift) {
   string result = "";
   bool condiction = false;
   int trend = 0, signal = 0;
   double high = 0, low = 0;
   double close = iClose(symbol, timeframe, shift);
   double ema_value_l = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_value_m = iMA(symbol, timeframe, MAPERIOD_M, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_value_s = iMA(symbol, timeframe, MAPERIOD_S, 0, MODE_EMA, PRICE_CLOSE, shift);
      
   if(ema_value_s > ema_value_m && ema_value_m > ema_value_l && close > ema_value_l) {
      signal = 1;
   }
   else if(ema_value_s < ema_value_m && ema_value_m < ema_value_l && close < ema_value_l) {
      signal = -1;      
   }
   
   if(signal == 1) {
      if(useshortma) {
         for(int i = shift; i <= stochastic_pos; i++) {
            if(iLow(symbol, timeframe, i) < iMA(symbol, timeframe, MAPERIOD_S, 0, MODE_EMA, PRICE_CLOSE, i)) {
               trend = 1;
               break;
            }
         }      
      }
      else {
         if(close > ema_value_m) {
            trend = signal;
         }
      }
   }
   else if(signal == -1) {
      if(useshortma) {
         for(int i = shift; i <= stochastic_pos; i++) {
            if(iHigh(symbol, timeframe, i) > iMA(symbol, timeframe, MAPERIOD_S, 0, MODE_EMA, PRICE_CLOSE, i)) {
               trend = -1;
               break;
            }
         }      
      }
      else {
         if(close < ema_value_m) {
            trend = signal;
         }
      }
   }
   
   result = IntegerToString(trend) +";"+ DoubleToString(ema_value_l) +";"+ DoubleToString(ema_value_m) +";"+ DoubleToString(ema_value_s);
         
   return result;
}
//+------------------------------------------------------------------+
int StochasticDivergenceSignal_old(string symbol, int timeframe, int shift) {
   int result = 0;
   shift = shift + 1;
   double bullishDivergence_1 = iCustom(symbol, timeframe, "stochastic-divergence-indicator", 14, 5, 5, false, true, true, false, 1, shift);
   double bearishDivergence_1 = iCustom(symbol, timeframe, "stochastic-divergence-indicator", 14, 5, 5, false, true, true, false, 2, shift);
   
   double bullishDivergence_2 = iCustom(symbol, timeframe, "Divergence Stochastic", 14, 5, 5, false, true, true, false, 1, shift);
   double bearishDivergence_2 = iCustom(symbol, timeframe, "Divergence Stochastic", 14, 5, 5, false, true, true, false, 2, shift);
   
   if(bullishDivergence_1 != EMPTY_VALUE || bullishDivergence_2 != EMPTY_VALUE) {
      result = 1;
   }
   else if(bearishDivergence_1 != EMPTY_VALUE || bearishDivergence_2 != EMPTY_VALUE) {
      result = -1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
string StochasticSLSignal(string symbol, int timeframe, int stochastic_kperiod, int stochastic_dperiod, int stochastic_slowing, int stochastic_method, direction dir, int shift) {
   string result = "";
   double stochastic_main = 0;
   if(dir == Up) {
      for(int i = shift + 1; i < 100; i++) {
         stochastic_main = iStochastic(symbol, timeframe, stochastic_kperiod, stochastic_dperiod, stochastic_slowing, stochastic_method, 0, MODE_MAIN, i);
         if(stochastic_main < Stochastic_Up_Level_Trigger) {
            result = DoubleToString(iHigh(symbol, timeframe, iHighest(symbol, timeframe, MODE_HIGH, i, shift))) +";"+ IntegerToString(i);
            break;
         }
      }
   }
   else if(dir == Down) {
      for(int i = shift + 1; i < 100; i++) {
         stochastic_main = iStochastic(symbol, timeframe, stochastic_kperiod, stochastic_dperiod, stochastic_slowing, stochastic_method, 0, MODE_MAIN, i);
         if(stochastic_main > Stochastic_Down_Level_Trigger) {
            result = DoubleToString(iLow(symbol, timeframe, iLowest(symbol, timeframe, MODE_LOW, i, shift))) +";"+ IntegerToString(i);
            break;
         }
      }   
   }
   
   return result;
}
//+------------------------------------------------------------------+
/*
int StochasticADXSignal(string symbol, int timeframe, int shift) {
   int result = 0, check = 0;
   double stochastic_main_0 = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, shift);
   double stochastic_main_1 = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, shift + 1);
   double adx_0 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift);
   double adx_1 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift + 1);
   double adx_2 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift + 2);
   
   if(stochastic_main_1 < Stochastic_Down_Level) {
      check = 1;
   }
   else if(stochastic_main_1 > Stochastic_Up_Level) {
      check = -1;
   }
   
   if((adx_1 > ADXVolatilityMaxThreshold && adx_0 < adx_1 && adx_1 > adx_2) || (adx_0 > ADXVolatilityMinThreshold && adx_1 < ADXVolatilityMinThreshold)) {
      result = check;
   }
   
   return result;
}
*/
//+------------------------------------------------------------------+
int StochasticDivergence(string symbol, int timeframe, int kperiod, int dperiod, int slowing, int shift) {
   int result = 0;
   string signal = StochasticSignalFast(symbol, timeframe, kperiod, dperiod, slowing, shift);
   int trigger = GetIntiger(signal, ";", 0);
   int pos = GetIntiger(signal, ";", 1);
   double stochastic_extreme_current = GetDouble(signal, ";", 2);
   double stochastic_extreme_last = 0;
   double extreme_value_current, extreme_value_last = 0, extreme_value_tmp = 0;
   bool level50 = false;
   
   if(trigger == 1) {
      extreme_value_current = iLow(symbol, timeframe, iLowest(symbol, timeframe, MODE_LOW, pos-shift, shift));
      for(int i = shift + 2; i < 100; i++) {          
         signal = StochasticSignalFast(symbol, timeframe, kperiod, dperiod, slowing, i);
         trigger = GetIntiger(signal, ";", 0);
         pos = GetIntiger(signal, ";", 1);
         stochastic_extreme_last = GetDouble(signal, ";", 2);     
             
         if(stochastic_extreme_last > extreme_value_tmp || extreme_value_tmp == 0) { 
            extreme_value_tmp = stochastic_extreme_last;
         } 
                
         if(extreme_value_tmp >= 50) level50 = true;    
         if(trigger == 1) {
            extreme_value_last = iLow(symbol, timeframe, iLowest(symbol, timeframe, MODE_LOW, pos-i, i));
            if(stochastic_extreme_current > stochastic_extreme_last && extreme_value_current <= extreme_value_last && level50) {
               result = 1;
            }
            break;
         }
      }
   }
   else if(trigger == -1) {
      extreme_value_current = iHigh(symbol, timeframe, iHighest(symbol, timeframe, MODE_HIGH, pos-shift, shift));
      for(int i = shift + 2; i < 100; i++) {         
         signal = StochasticSignalFast(symbol, timeframe, kperiod, dperiod, slowing, i);
         trigger = GetIntiger(signal, ";", 0);
         pos = GetIntiger(signal, ";", 1);
         stochastic_extreme_last = GetDouble(signal, ";", 2); 
         
         if(stochastic_extreme_last < extreme_value_tmp || extreme_value_tmp == 0) { 
            extreme_value_tmp = stochastic_extreme_last;
         }    
         
         if(extreme_value_tmp <= 50) level50 = true;
         if(trigger == -1) {
            extreme_value_last = iHigh(symbol, timeframe, iHighest(symbol, timeframe, MODE_HIGH, pos-i, i));
            if(stochastic_extreme_current < stochastic_extreme_last && extreme_value_current >= extreme_value_last && level50) {
               result = -1;
            }
            break;
         }
      }   
   }
   
   return result;
}
//+------------------------------------------------------------------+
string StochasticSignalFast(string symbol, int timeframe, int stochastic_kperiod, int stochastic_dperiod, int stochastic_slowing, int shift) {
   string result = ""; 
   int signal = 0, position = 0;
   double stochastic_main = 0;
   double stochastic_main_0 = iStochastic(symbol, timeframe, stochastic_kperiod, stochastic_dperiod, stochastic_slowing, Stochastic_Method, 0, MODE_MAIN, shift);
   double stochastic_main_1 = iStochastic(symbol, timeframe, stochastic_kperiod, stochastic_dperiod, stochastic_slowing, Stochastic_Method, 0, MODE_MAIN, shift + 1);
   double extreme = 0;
   
   if (stochastic_main_1 < Stochastic_Down_Level_Trigger && stochastic_main_0 > Stochastic_Down_Level_Trigger) {
      signal = 1;
      for(int i = shift + 2; i < Bars; i++) {
         stochastic_main = iStochastic(symbol, timeframe, stochastic_kperiod, stochastic_dperiod, stochastic_slowing, Stochastic_Method, 0, MODE_MAIN, i);
         if(stochastic_main < extreme || extreme == 0) extreme = stochastic_main;
         if(stochastic_main > Stochastic_Down_Level_Trigger) {
            position = i;
            break;
         }
      }
   }
   else if (stochastic_main_1 > Stochastic_Up_Level_Trigger && stochastic_main_0 < Stochastic_Up_Level_Trigger) {
      signal = -1;
      for(int i = shift + 2; i < Bars; i++) {
         stochastic_main = iStochastic(symbol, timeframe, stochastic_kperiod, stochastic_dperiod, stochastic_slowing, Stochastic_Method, 0, MODE_MAIN, i);
         if(stochastic_main > extreme || extreme == 0) extreme = stochastic_main;
         if(stochastic_main < Stochastic_Up_Level_Trigger) {
            position = i;
            break;
         }
      }      
   }
   
   result = IntegerToString(signal) +";"+ IntegerToString(position) +";"+ DoubleToString(extreme);
   
   return result;   
}
//+------------------------------------------------------------------+
int StochasticSignalV3(string symbol, int timeframe_long, int timeframe_short, int start_bar, int type, int shift) {
   int result = 0, current_signal = 0; 
   double stochastic_main_c = 0, stochastic_main_p = 0;
   datetime start_time = iTime(symbol, timeframe_long, start_bar);
   int last_bar_to_check = iBarShift(symbol, timeframe_short, start_time);
   int found = 0;
   double signal_close = 0, close = 0;
   
   if(type != 0) {
      stochastic_main_c = iStochastic(symbol, timeframe_short, Stochastic_Kperiod_T, Stochastic_Dperiod_T, Stochastic_Slowing_T, Stochastic_Method, 0, MODE_MAIN, shift);
      stochastic_main_p = iStochastic(symbol, timeframe_short, Stochastic_Kperiod_T, Stochastic_Dperiod_T, Stochastic_Slowing_T, Stochastic_Method, 0, MODE_MAIN, shift + 1);
      if(stochastic_main_p < Stochastic_Down_Level_Trigger && stochastic_main_c > Stochastic_Down_Level_Trigger) {
         current_signal = 1;
         result = 1;
         signal_close = iClose(symbol, timeframe_short, shift);
      }
      else if(stochastic_main_p > Stochastic_Up_Level_Trigger && stochastic_main_c < Stochastic_Up_Level_Trigger) {
         current_signal = -1;
         result = -1;
         signal_close = iClose(symbol, timeframe_short, shift);
      }
      
      if(current_signal == type) {
         for(int i = shift + 2; i <= last_bar_to_check; i++) {
            stochastic_main_c = iStochastic(symbol, timeframe_short, Stochastic_Kperiod_T, Stochastic_Dperiod_T, Stochastic_Slowing_T, Stochastic_Method, 0, MODE_MAIN, i);
            stochastic_main_p = iStochastic(symbol, timeframe_short, Stochastic_Kperiod_T, Stochastic_Dperiod_T, Stochastic_Slowing_T, Stochastic_Method, 0, MODE_MAIN, i + 1);
            if(current_signal == 1) {
               close = iClose(symbol, timeframe_short, i);
               if(stochastic_main_p < Stochastic_Down_Level_Trigger && stochastic_main_c > Stochastic_Down_Level_Trigger && close < signal_close) {
                  found++;
                  break;
               }
            }
            else if(current_signal == -1) {
               close = iClose(symbol, timeframe_short, i);
               if(stochastic_main_p > Stochastic_Up_Level_Trigger && stochastic_main_c < Stochastic_Up_Level_Trigger && close > signal_close) {
                  found++;
                  break;
               }
            }
         }         
         if(found > 1) result = 0;
      }
      else {
         result = 0;
      }
   }
   
   return result;   
}
//+------------------------------------------------------------------+
/*
int StochasticDivergenceSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double stochastic_main_0 = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, shift);
   double stochastic_main_1 = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, shift + 1);
   double stochastic_main_2 = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, shift + 2);
   double stochastic_main_0_i = 0, stochastic_main_1_i = 0, stochastic_main_2_i = 0;
   
   if (stochastic_main_1 < Stochastic_Down_Level_1 && stochastic_main_0 > stochastic_main_1 && stochastic_main_1 < stochastic_main_2) {
      for(int i = shift + 3; i < Bars; i++) {
         stochastic_main_0_i = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, i);
         stochastic_main_1_i = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, i + 1);
         stochastic_main_2_i = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, i + 2);      
         if(stochastic_main_1_i > Stochastic_Up_Level_1) {
            break;
         }
         else {
            if (stochastic_main_1_i < Stochastic_Down_Level && stochastic_main_0_i > stochastic_main_1_i && stochastic_main_1_i < stochastic_main_2_i) {
               if(stochastic_main_1_i < stochastic_main_1) {
                  double low_shift = iLow(symbol, timeframe, iLowest(symbol, timeframe, MODE_LOW, 5, shift));
                  double low_i = iLow(symbol, timeframe, iLowest(symbol, timeframe, MODE_LOW, 4, i-2));
                  if(low_shift < low_i) {
                     result = 1;
                     break;
                  }
               }
            }
         }
      }
   }
   else if (stochastic_main_1 > Stochastic_Up_Level_1 && stochastic_main_0 < stochastic_main_1 && stochastic_main_1 > stochastic_main_2) {
      for(int i = shift + 3; i < Bars; i++) {
         stochastic_main_0_i = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, i);
         stochastic_main_1_i = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, i + 1);
         stochastic_main_2_i = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, i + 2);      
         if(stochastic_main_1_i < Stochastic_Down_Level_1) {
            break;
         }
         else {
            if (stochastic_main_1_i > Stochastic_Up_Level && stochastic_main_0_i < stochastic_main_1_i && stochastic_main_1_i > stochastic_main_2_i) {
               if(stochastic_main_1_i > stochastic_main_1) {
                  double high_shift = iHigh(symbol, timeframe, iHighest(symbol, timeframe, MODE_HIGH, 5, shift));
                  double high_i = iLow(symbol, timeframe, iHighest(symbol, timeframe, MODE_HIGH, 4, i-2));
                  if(high_shift > high_i) {
                     result = -1;
                     break;
                  }
               }
            }
         }
      }      
   }   
   
   return result;
}
//+------------------------------------------------------------------+
string StochasticTrigger(string symbol, int timeframe, int shift) {
   string result = "0;0";
   double stochastic_main_0 = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, shift);
   double stochastic_main_1 = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, shift + 1);
   double stochastic_main = 0;
   int pattern_signal = PatternRecognitionSignal(symbol, timeframe, shift);
   
   if (stochastic_main_1 <= Stochastic_Down_Level && (stochastic_main_0 > Stochastic_Down_Level || pattern_signal == 1)) {
      for(int i = shift + 1; i < Bars; i++) {
         stochastic_main = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, i);
         if(stochastic_main > Stochastic_Down_Level){
            result = "1;" + IntegerToString(i);
            break;
         }
      }
   }
   else if (stochastic_main_1 >= Stochastic_Up_Level && (stochastic_main_0 < Stochastic_Up_Level || pattern_signal == -1)) {
      for(int i = shift + 1; i < Bars; i++) {
         stochastic_main = iStochastic(symbol, timeframe, Stochastic_Kperiod, Stochastic_Dperiod, Stochastic_Slowing, Stochastic_Method, 0, MODE_MAIN, i);
         if(stochastic_main < Stochastic_Up_Level){
            result = "-1;" + IntegerToString(i);
            break;
         }
      }
   } 
   return result;   
}
*/
//+------------------------------------------------------------------+
int StochasticTriggerV1(string symbol, int timeframe, int kperiod, int dperiod, int slowing, int shift) {
   int result = 0;
   double stochastic_main_0 = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, shift);
   double stochastic_main_1 = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, shift + 1);
   double stochastic_main_2 = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, shift + 2);
   double stochastic_main = 0;
   
   if (stochastic_main_1 <= Stochastic_Down_Level_Trigger && stochastic_main_0 > stochastic_main_1 && stochastic_main_1 < stochastic_main_2) {
      for(int i = shift + 1; i < Bars; i++) {
         stochastic_main = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, i);
         if(stochastic_main > Stochastic_Down_Level_Trigger){
            result = 1;
            break;
         }
         else if(stochastic_main < stochastic_main_1) break;
      }
   }
   if (stochastic_main_1 >= Stochastic_Up_Level_Trigger && stochastic_main_0 < stochastic_main_1 && stochastic_main_1 > stochastic_main_2) {
      for(int i = shift + 1; i < Bars; i++) {
         stochastic_main = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, i);
         if(stochastic_main < Stochastic_Up_Level_Trigger){
            result = -1;
            break;
         }
         else if(stochastic_main > stochastic_main_1) break;
      }   
   }
    
   return result;   
}
//+------------------------------------------------------------------+
int StochasticTrigger(string symbol, int timeframe, int kperiod, int dperiod, int slowing, int shift) {
   int result = 0;
   double stochastic_main_0 = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, shift);
   double stochastic_main_1 = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, shift + 1);
   double stochastic_main_2 = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, shift + 2);
   
   if (stochastic_main_1 <= Stochastic_Down_Level_Trigger && stochastic_main_0 > stochastic_main_1 && stochastic_main_1 < stochastic_main_2) {
      result = 1;
   }
   if (stochastic_main_1 >= Stochastic_Up_Level_Trigger && stochastic_main_0 < stochastic_main_1 && stochastic_main_1 > stochastic_main_2) {
      result = -1;   
   }
    
   return result;   
}
//+------------------------------------------------------------------+
int StochasticZone(string symbol, int timeframe, int kperiod, int dperiod, int slowing, int shift) {
   int result = 0;
   double stochastic_main_0 = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, shift);
   
   if (stochastic_main_0 < Stochastic_Down_Level_Zone) {
      result = 1;
   }
   if (stochastic_main_0 > Stochastic_Up_Level_Zone) {
      result = -1;
   }
    
   return result;   
}
//+------------------------------------------------------------------+
int StochasticDir(string symbol, int timeframe, int kperiod, int dperiod, int slowing, int shift) {
   int result = 0;
   double stochastic_main_0 = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, shift);
   double stochastic_main_1 = iStochastic(symbol, timeframe, kperiod, dperiod, slowing, Stochastic_Method, 0, MODE_MAIN, shift + 1);
   
   if (stochastic_main_0 > stochastic_main_1) {
      result = 1;
   }
   if (stochastic_main_0 < stochastic_main_1) {
      result = -1;
   }
    
   return result;   
}
//+------------------------------------------------------------------+
int StochasticEntrySignal(string symbol, int timeframe, const direction dir, double pivot_point, double camarilla_point, int shift) {
   int result = 0; 
   double close = iClose(symbol, timeframe, shift);
   double high = iHigh(symbol, timeframe, shift);
   double low = iLow(symbol, timeframe, shift);
   double stochastic_main = 0;
   bool start_looking = false, check_extreme = false;
   double extreme_point = 0;
   int extreme_bar = 0;
   
   for(int i = shift; i < Bars; i++) {
      stochastic_main = iStochastic(symbol, timeframe, Stochastic_Kperiod_T, Stochastic_Dperiod_T, Stochastic_Slowing_T, Stochastic_Method, 0, MODE_MAIN, i);
      if(dir == Up) {
         if(!stochastic_main) {
            if(stochastic_main > Stochastic_Down_Level_Trigger)stochastic_main = true;
         }
         else {
            if(stochastic_main <= Stochastic_Down_Level_Trigger && !check_extreme) {
               check_extreme = true;
               extreme_point = iLow(symbol, timeframe, i);
               extreme_bar = i;
            }
            else if(check_extreme) {
               if(iLow(symbol, timeframe, i) < extreme_point) {
                  extreme_point = iLow(symbol, timeframe, i);
                  extreme_bar = i;
               }
               //Break
               if(stochastic_main > Stochastic_Down_Level_Trigger) {
                  if(low < MathMin(iClose(symbol, timeframe, extreme_bar), iOpen(symbol, timeframe, extreme_bar)) 
                     && close > extreme_point && close > camarilla_point && low < pivot_point) result = 1;
                  break;
               }
            }
         }
      }
      else if(dir == Down) {
         if(!stochastic_main) {
            if(stochastic_main < Stochastic_Up_Level_Trigger)stochastic_main = true;
         }
         else {
            if(stochastic_main >= Stochastic_Up_Level_Trigger && !check_extreme) {
               check_extreme = true;
               extreme_point = iHigh(symbol, timeframe, i);
               extreme_bar = i;
            }
            else if(check_extreme) {
               if(iHigh(symbol, timeframe, i) > extreme_point) {
                  extreme_point = iHigh(symbol, timeframe, i);
                  extreme_bar = i;
               }
               //Break
               if(stochastic_main < Stochastic_Up_Level_Trigger) {
                  if(high > MathMax(iClose(symbol, timeframe, extreme_bar), iOpen(symbol, timeframe, extreme_bar)) 
                     && close < extreme_point && close < camarilla_point && high > pivot_point) result = -1;
                  break;
               }
            }
         }      
      }   
   }
   
   return result;   
}
//+------------------------------------------------------------------+
double FractalSignal_SL(string symbol, int timeframe, const direction dir, int start_bar, int shift) {
   double result = 0;
   int i = 0;  
   double new_h = 0, new_l = 0;
   if(start_bar < 3) start_bar = 3;
   
   for(i = start_bar; i < Bars; i++){
      if(dir == Up) {
         result = iFractals(symbol, timeframe, MODE_UPPER, i);
         if(result > 0) break;
      }
      else if(dir == Down) {
         result = iFractals(symbol, timeframe, MODE_LOWER, i);
         if(result > 0) break;
      }  
   }
   
   if(dir == Up) {
      new_h = iHigh(symbol, timeframe, iHighest(symbol, timeframe, MODE_HIGH, i, shift));
      if(new_h > result) result = new_h;
   }
   else if(dir == Down) {
      new_l = iLow(symbol, timeframe, iLowest(symbol, timeframe, MODE_LOW, i, shift));
      if(new_l < result) result = new_l;
   }
   
   return result;
}
//+------------------------------------------------------------------+
int FractalTodaySignal_old(string symbol, int timeframe, const direction dir, double pivot, int shift) {
   int result = 0, fractal_pos = 0;
   double fract_value = 0, fractal = 0;
   double bid = MarketInfo(symbol, MODE_BID);
   double ask = MarketInfo(symbol, MODE_ASK); 
   datetime today = iTime(symbol, Timeframe_D, 0);
   datetime process_bar;   
   double join_points = 10 * MarketInfo(symbol, MODE_POINT);
   
   for(int i = 3; i < 100; i++){
      process_bar = iTime(symbol, timeframe, i);
      if(process_bar < today) {
         break;
      }      
      else if(dir == Up) {
         fract_value = iFractals(symbol, timeframe, MODE_UPPER, i);
         if(fract_value > 0) {
            if(fract_value > pivot - join_points) {
               if(iLow(symbol, timeframe, i) < pivot + join_points) {
                  fractal_pos = i;
               }
            }            
         }
      }
      else if(dir == Down) {
         fract_value = iFractals(symbol, timeframe, MODE_LOWER, i);
         if(fract_value > 0) {
            if(fract_value < pivot + join_points) {
               if(iHigh(symbol, timeframe, i) > pivot - join_points) {
                  fractal_pos = i;
               }            
            }            
         }
      }  
   }
   
   if(fractal_pos == 0) result = 0;
   else if(dir == Up) {
      if(iHigh(symbol, timeframe, shift) >= MathMax(iOpen(symbol, timeframe, fractal_pos), iClose(symbol, timeframe, fractal_pos)) - join_points && iClose(symbol, timeframe, shift) < iHigh(symbol, timeframe, fractal_pos) && iClose(symbol, timeframe, shift) < pivot) {
         result = -1;
      }   
   }
   else if(dir == Down) {
      if(iLow(symbol, timeframe, shift) <= MathMin(iOpen(symbol, timeframe, fractal_pos), iClose(symbol, timeframe, fractal_pos)) + join_points && iClose(symbol, timeframe, shift) > iLow(symbol, timeframe, fractal_pos) && iClose(symbol, timeframe, shift) > pivot) {
         result = 1;
      }    
   }
   
   return result;
}
//+------------------------------------------------------------------+
double FractalTraillingStop(string symbol, int timeframe, const direction dir, datetime start_position_time) {
   double result = 0;
   double fract_value = 0;
   double bid = MarketInfo(symbol, MODE_BID);
   double ask = MarketInfo(symbol, MODE_ASK); 
   int i = 0;  
   double last_value = 0;
   datetime process_bar; 
      
   for(i = 3; i < Bars; i++){
      process_bar = iTime(symbol, timeframe, i);
      if(process_bar < start_position_time) {
         break;
      }      
      else if(dir == Up) {
         fract_value = iFractals(symbol, timeframe, MODE_UPPER, i);
         if(fract_value > 0) {
            result = fract_value;
            break;
         }
      }
      else if(dir == Down) {
         fract_value = iFractals(symbol, timeframe, MODE_LOWER, i);
         if(fract_value > 0) {
            result = fract_value;
            break;
         }
      }  
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool ATRVolatility(string symbol, int timeframe, int shift)
{
   bool trigger = false;
   double ATR_Array[1], ATR_LongArray[1];
   ArrayResize(ATR_Array, Bars);
   ArrayResize(ATR_LongArray, Bars);
   int i = 0;
   double ATR_MA_Current = 0, ATR_MA_Previous = 0, ATR_LongMA_Current = 0;
   int array_pos = 0;
   int digits = (int)MarketInfo(symbol, MODE_DIGITS);
   double atr_0 = NormalizeDouble(iATR(symbol, timeframe, ATR_PERIOD, shift), digits + 1);
   
   //ATR_Array
   for(i = shift; i < Bars; i++)
   {
      ATR_Array[array_pos] = iATR(symbol, timeframe, ATR_PERIOD, i);
      array_pos++;
   }
   
   /*
   //ATR_LongArray
   array_pos = 0;
   for(i = shift; i < shift + ATR_LongMA_Period + 1; i++)
   {
      ATR_LongArray[array_pos] = iATR(symbol, timeframe, ATR_PERIOD, i);
      array_pos++;
   }
   */
   
   ArraySetAsSeries(ATR_Array, true);
   ArraySetAsSeries(ATR_LongArray, true);
   
   ATR_MA_Current=NormalizeDouble(iMAOnArray(ATR_Array, 0, ATR_MA_Period, 0, MODE_SMA, 0), digits + 1);   
   //ATR_LongMA_Current=NormalizeDouble(iMAOnArray(ATR_LongArray, 0, ATR_LongMA_Period, 0, MODE_SMA, 0), digits + 1);   
   
   if(atr_0 >= ATR_MA_Current)
   {
      trigger = true;  
   }
      
   return trigger;
}
//+------------------------------------------------------------------+
bool StdVolatility(string symbol, int timeframe, int shift)
{
   bool result = false;
   double STD_Array[1];
   ArrayResize(STD_Array, Bars);
   int i = 0;
   double STD_MA_Current = 0, STD_MA_Previous = 0;
   int array_pos = 0;
   int digits = (int)MarketInfo(symbol, MODE_DIGITS);
   double std_0 = NormalizeDouble(iStdDev(symbol, timeframe, STD_PERIOD, 0, MODE_EMA, PRICE_CLOSE, shift), digits + 1);
   double std_1 = NormalizeDouble(iStdDev(symbol, timeframe, STD_PERIOD, 0, MODE_EMA, PRICE_CLOSE, shift + 1), digits + 1);
   
   //ATR_Array
   for(i = shift; i < Bars; i++)
   {
      STD_Array[array_pos] = iATR(symbol, timeframe, STD_PERIOD, i);
      array_pos++;
   }
   
   ArraySetAsSeries(STD_Array, true);
   
   STD_MA_Current=NormalizeDouble(iMAOnArray(STD_Array, 0, STD_MA_Period, 0, MODE_EMA, 0), digits + 1);    
   
   if(std_0 >= STD_MA_Current && std_0 > std_1)
   {
      result = true;  
   }
      
   return result;
}
//+------------------------------------------------------------------+
string PivotLevelsTrigger(string symbol, int timeframe, double &levels_pivot[], double &levels_camarilla[], direction dir, int shift, int cont) {
   string result = "";
   bool found = false;
   if (cont < 1) cont = 1;
   double high = iHigh(symbol, timeframe, iHighest(symbol, timeframe, MODE_HIGH, cont, shift));
   double low = iLow(symbol, timeframe, iLowest(symbol, timeframe, MODE_LOW, cont, shift));
   double close = iClose(symbol, timeframe, shift);
   double open1 = iOpen(symbol, timeframe, shift);
   double open2 = iOpen(symbol, timeframe, shift + 1);
   double atr = iATR(symbol, timeframe, ATR_PERIOD, shift);
   double join = 10 * MarketInfo(symbol, MODE_POINT);
   
   //Camarilla
   double camarilla_dist = levels_camarilla[1] - levels_camarilla[2];
   for(int i = 0; i < ArraySize(levels_camarilla); i++) {
      if(dir == Up) {
         if((low < levels_camarilla[i] || (HasNearLevel(symbol, timeframe, levels_camarilla[i], OP_BUY, levels_pivot, shift))) && (close > levels_camarilla[i]-join && close < levels_camarilla[i] + atr) && ((open1 > levels_camarilla[i] || open2 > levels_camarilla[i]) || (HasConfluence(symbol, levels_camarilla[i], levels_pivot)))
            && CheckMultipleLevelCrosValidation(symbol, timeframe, levels_camarilla[i], false, OP_BUY, levels_camarilla, levels_pivot, shift)) {
            if(i >= 3 || i == 2) {
               result = "1;" + DoubleToString(levels_camarilla[i] - camarilla_dist);
               found = true;
               break;
            }
         }
      }
      else if(dir == Down) {
         if((high > levels_camarilla[i] || (HasNearLevel(symbol, timeframe, levels_camarilla[i], OP_SELL, levels_pivot, shift)))&& (close < levels_camarilla[i]+join && close > levels_camarilla[i] - atr) && ((open1 < levels_camarilla[i] || open2 < levels_camarilla[i]) || (HasConfluence(symbol, levels_camarilla[i], levels_pivot)))
            && CheckMultipleLevelCrosValidation(symbol, timeframe, levels_camarilla[i], false, OP_SELL, levels_camarilla, levels_pivot, shift)) {
            if(i < 3 || i == 4) {
               result = "-1;" + DoubleToString(levels_camarilla[i] + camarilla_dist);
               found = true;
               break;
            }
         }      
      }
   }   
   
   if(!found) {
      //Pivot
      double pivot_dist = 0;
      for(int i = 0; i < ArraySize(levels_pivot); i++) {
         if(dir == Up) {
            if((low < levels_pivot[i] || (HasNearLevel(symbol, timeframe, levels_pivot[i], OP_BUY, levels_camarilla, shift))) && (close > levels_pivot[i]-join && close < levels_pivot[i] + atr) && ((open1 > levels_pivot[i] || open2 > levels_pivot[i]) || (HasConfluence(symbol, levels_pivot[i], levels_camarilla)))
               && CheckMultipleLevelCrosValidation(symbol, timeframe, levels_pivot[i], true, OP_BUY, levels_camarilla, levels_pivot, shift)) {
               if(i >= 3) {
                  if(i == ArraySize(levels_pivot) - 1) {
                     result = "1;" + DoubleToString(levels_pivot[i]);
                  }
                  else {
                     result = "1;" + DoubleToString(levels_pivot[i] - (levels_pivot[i]-levels_pivot[i + 1]) / 2);
                  }
                  break;
               }
            }
         }
         else if(dir == Down) {
            if((high > levels_pivot[i] || (HasNearLevel(symbol, timeframe, levels_pivot[i], OP_SELL, levels_camarilla, shift)))&& (close < levels_pivot[i]+join && close > levels_pivot[i] - atr) && ((open1 < levels_pivot[i] || open2 < levels_pivot[i])|| (HasConfluence(symbol, levels_pivot[i], levels_camarilla)))
               && CheckMultipleLevelCrosValidation(symbol, timeframe, levels_pivot[i], true, OP_SELL, levels_camarilla, levels_pivot, shift)) {
               if(i <= 3) {
                  if(i == 0) {
                     result = "-1;" + DoubleToString(levels_pivot[i]);
                  }
                  else {
                     result = "-1;" + DoubleToString(levels_pivot[i] + (levels_pivot[i - 1] - levels_pivot[i]) / 2);
                  }
                  break;
               }
            }      
         }
      }   
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool CheckMultipleLevelCrosValidation(string symbol, int timeframe, double level, bool isPivot, int type, double &camarillas[], double &pivots[], int shift) {
   bool result = true;
   double close = iClose(symbol, timeframe, shift);
   double high = iHigh(symbol, timeframe, shift);
   double low = iLow(symbol, timeframe, shift);
   int digits = (int)MarketInfo(symbol, MODE_DIGITS);
   
   if(type == OP_BUY) {
      if(low < level && close > level) {
         //Camarilla
         for(int i = 0; i < ArraySize(camarillas); i++) {
            if(!isPivot && NormalizeDouble(level, digits) != NormalizeDouble(camarillas[i], digits) && low < camarillas[i] && close > camarillas[i]) {
               if(camarillas[i] < level) {
                  result = false;
                  break;
               }
            }
            else if(isPivot && low < camarillas[i] && close > camarillas[i]) {
               if(camarillas[i] < level) {
                  result = false;
                  break;
               }
            }
         }
         //Pivot
         if(result) {
            for(int i = 0; i < ArraySize(pivots); i++) {
               if(isPivot && NormalizeDouble(level, digits) != NormalizeDouble(pivots[i], digits) && low < pivots[i] && close > pivots[i]) {
                  if(pivots[i] < level) {
                     result = false;
                     break;
                  }
               }
               else if(!isPivot && low < pivots[i] && close > pivots[i]) {
                  if(pivots[i] < level) {
                     result = false;
                     break;
                  }
               }
            }         
         }
      }
   }
   else if(type == OP_SELL) {
      if(high > level && close < level) {
         //Camarilla
         for(int i = 0; i < ArraySize(camarillas); i++) {
            if(!isPivot && NormalizeDouble(level, digits) != NormalizeDouble(camarillas[i], digits) && high > camarillas[i] && close < camarillas[i]) {
               if(camarillas[i] > level) {
                  result = false;
                  break;
               }
            }
            else if(isPivot && high > camarillas[i] && close < camarillas[i]) {
               if(camarillas[i] > level) {
                  result = false;
                  break;
               }
            }
         } 
         //Pivot
         if(result) {
            for(int i = 0; i < ArraySize(pivots); i++) {
               if(isPivot && NormalizeDouble(level, digits) != NormalizeDouble(pivots[i], digits) && high > pivots[i] && close < pivots[i]) {
                  if(pivots[i] > level) {
                     result = false;
                     break;
                  }
               }
               else if(!isPivot && high > pivots[i] && close < pivots[i]) {
                  if(pivots[i] > level) {
                     result = false;
                     break;
                  }
               }
            }         
         }              
      }
   }
   
   
   return result;
}
//+------------------------------------------------------------------+
bool HasNearLevel(string symbol, int timeframe, double level, int type, double &levels[], int shift) {
   bool result = false;
   double join = 50 * MarketInfo(symbol, MODE_POINT);
   double high = iHigh(symbol, timeframe, shift);
   double low = iLow(symbol, timeframe, shift);
   
   if(type == OP_BUY) {
      for (int i = 0; i < ArraySize(levels); i++) {
         if(levels[i] > level && levels[i] < level + join && low < levels[i]) {
            result = true;
            break;
         }
      }   
   }
   else if(type == OP_BUY) {
      for (int i = 0; i < ArraySize(levels); i++) {
         if(levels[i] < level && levels[i] > level - join && high > levels[i]) {
            result = true;
            break;
         }
      }    
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool HasConfluence(string symbol, double level, double &levels[]) {
   bool result = false;
   //double join = MathMin(iATR(symbol, Timeframe_M15, ATR_PERIOD, 1) * 0.5, 100 * MarketInfo(symbol, MODE_POINT));
   double join = iATR(symbol, Timeframe_M15, ATR_PERIOD, 1);
   
   for (int i = 0; i < ArraySize(levels); i++) {
      if(levels[i] < level + join && levels[i] > level - join) {
         result = true;
         break;
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
string GetLevelsDirection(string symbol, double &levels[], int timeframe, int shift) {
   string result = "";
   int max_interation = 1440;
   int interation = max_interation / timeframe;
   ArraySort(levels, WHOLE_ARRAY, 0, MODE_DESCEND);
   double res = 0, sup = 0, touch_point = 0, high = 0, low = 0;
   double close = iClose(symbol, timeframe, shift);
   int dir = 0;
   
   for(int i = 0; i < ArraySize(levels); i++) {
      if(i == 0) {
         res = 999999;
         sup = levels[i];
      }
      else if(i < ArraySize(levels) - 1) {
         res = levels[i];
         sup = levels[i + 1];      
      }
      else if(i == ArraySize(levels) - 1) {
         res = levels[i];
         sup = 0;
      }
      
      if(close > sup && close < res) {
         break;
      }
   }
   
   for (int i = shift; i < interation; i++) {
       high = iHigh(symbol, timeframe, i);
       low = iLow(symbol, timeframe, i);
       close = iClose(symbol, timeframe, i);
   
       if (iTime(symbol, timeframe, i) >= iTime(symbol, Timeframe_D, 0)) {
           if (high > res && low > sup && close < high) {
               dir = -1;
               touch_point = res;
               break;
           }
           else if (high < res && low < sup && close > sup) {
               dir = 1;
               touch_point = sup;
               break;
           }
       }
       else {
           break;
       }
   }
   
   result = IntegerToString(dir) +";"+ DoubleToString(touch_point);
      
   return result;
}
//+------------------------------------------------------------------+
string PSARSignal(string symbol, int timeframe, double step, double maximun, int shift) {
   string result = "";
   int trend = 0, trigger = 0;
   double psar_1 = iSAR(symbol, timeframe, step, maximun, shift);
   double psar_2 = iSAR(symbol, timeframe, step, maximun, shift + 1);
   double close_1 = iClose(symbol, timeframe, shift);
   double close_2 = iClose(symbol, timeframe, shift + 1);
   
   if(close_1 > psar_1)
   {
      trend = 1;
      if(psar_2 < close_2) {
         trigger = 1;
      }
   }
   else if(close_1 < psar_1)
   {
      trend = -1;
      if(psar_2 > close_2) {
         trigger = -1;
      }      
   }
   
   result = IntegerToString(trend) + ";" + DoubleToString(psar_1) + ";" + IntegerToString(trigger);
   
   return result;
}
//+------------------------------------------------------------------+
string CMASignal(string symbol, int timeframe, int shift) {
   string result = "";
   int trend = 0;
   double close = iClose(symbol, timeframe, shift);
   double cma_value = iCustom(symbol, timeframe, "CMA", CMAPeriod, MODE_SMMA, PRICE_CLOSE, 0, shift);
   
   if(close > cma_value) {
      trend = 1;
   }
   else if(close < cma_value) {
      trend = -1;     
   }
   
   result = IntegerToString(trend) +";"+ DoubleToString(cma_value);
   
   return result;
}
//+------------------------------------------------------------------+
int MACDSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double macd_main_current = iMACD(symbol, timeframe, MACDFastEMA, MACDSlowEMA, MACDSMA, PRICE_CLOSE, MODE_MAIN, shift);  
   double macd_main_previous = iMACD(symbol, timeframe, MACDFastEMA, MACDSlowEMA, MACDSMA, PRICE_CLOSE, MODE_MAIN, shift + 1);
   double macd_signal_current = iMACD(symbol, timeframe, MACDFastEMA, MACDSlowEMA, MACDSMA, PRICE_CLOSE, MODE_SIGNAL, shift);
   
   if(macd_main_current > macd_signal_current && macd_main_current >= macd_main_previous) {
      result = 1;
   }
   else if(macd_main_current < macd_signal_current && macd_main_current <= macd_main_previous) {
      result = -1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
int MACDTrigger(string symbol, int timeframe, int shift) {
   int result = 0;
   double macd_main_current = iMACD(symbol, timeframe, MACDFastEMA, MACDSlowEMA, MACDSMA, PRICE_CLOSE, MODE_MAIN, shift);  
   double macd_main_previous = iMACD(symbol, timeframe, MACDFastEMA, MACDSlowEMA, MACDSMA, PRICE_CLOSE, MODE_MAIN, shift + 1); 
   double macd_signal_current = iMACD(symbol, timeframe, MACDFastEMA, MACDSlowEMA, MACDSMA, PRICE_CLOSE, MODE_SIGNAL, shift);
   double macd_signal_previous = iMACD(symbol, timeframe, MACDFastEMA, MACDSlowEMA, MACDSMA, PRICE_CLOSE, MODE_SIGNAL, shift + 1);
   
   if(macd_main_current < 0 && macd_main_current > macd_signal_current && macd_main_previous <= macd_signal_previous) {
      result = 1;
   }
   else if(macd_main_current > 0 && macd_main_current < macd_signal_current && macd_main_previous >= macd_signal_previous) {
      result = -1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
int MACDMASignal(string symbol, int timeframe, int shift)
{
   int result = 0;
   double MACD_Short_Array[1], MACD_Long_Array[1];
   ArrayResize(MACD_Short_Array, Bars);
   ArrayResize(MACD_Long_Array, Bars);
   int i = 0;
   int array_pos = 0;
   int digits = (int)MarketInfo(symbol, MODE_DIGITS);
   double macd_main_current = 0, macd_ma_short_curr = 0, macd_ma_long_curr = 0, macd_ma_short_prev = 0, macd_ma_long_prev = 0;
   
   if(MACDMAShortPeriod >= MACDMALongPeriod) {
      Print("The MACDMAShortPeriod must be less than MACDMALongPeriod!");
      return 0;
   }
   
   //MACD Arrays
   for(i = shift; i < Bars; i++)
   {
      macd_main_current = iMACD(symbol, timeframe, MACDFastEMA, MACDSlowEMA, MACDSMA, PRICE_CLOSE, MODE_MAIN, i);
      if(array_pos < ArraySize(MACD_Short_Array)) {
         MACD_Short_Array[array_pos] = macd_main_current;
      }
      MACD_Long_Array[array_pos] = macd_main_current;
      array_pos++;
   }
   
   ArraySetAsSeries(MACD_Short_Array, true);
   ArraySetAsSeries(MACD_Long_Array, true);
   
   macd_ma_short_curr=NormalizeDouble(iMAOnArray(MACD_Short_Array, 0, MACDMAShortPeriod, 0, MODE_SMA, 0), digits + 1);   
   macd_ma_short_prev=NormalizeDouble(iMAOnArray(MACD_Short_Array, 0, MACDMAShortPeriod, 0, MODE_SMA, 1), digits + 1);    
   macd_ma_long_curr=NormalizeDouble(iMAOnArray(MACD_Long_Array, 0, MACDMALongPeriod, 0, MODE_SMA, 0), digits + 1); 
   macd_ma_long_prev=NormalizeDouble(iMAOnArray(MACD_Long_Array, 0, MACDMALongPeriod, 0, MODE_SMA, 1), digits + 1);      
   
   if(macd_ma_short_prev <= macd_ma_long_prev && macd_ma_short_curr > macd_ma_long_curr)
   {
      result = 1;  
   }
   else if(macd_ma_short_prev >= macd_ma_long_prev && macd_ma_short_curr < macd_ma_long_curr)
   {
      result = -1;  
   }
      
   return result;
}
//+------------------------------------------------------------------+
bool ValidateMaxOrderPerDay(string symbol) {
   bool result = true;
   int total = OrdersHistoryTotal() - 1;
   long today = iTime(_Symbol, Timeframe_D, 0);	
   int count = 0;
   
   for (int i = total; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))  {
         long open_time = OrderOpenTime();
         if((open_time >= today && OrderSymbol() == symbol) && OrderMagicNumber() == MAGIC_1) {
            count++;
         }    
      }    
   } 
   
   for (int cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         long open_time = OrderOpenTime();
         if((open_time >= today && OrderSymbol() == symbol) && OrderMagicNumber() == MAGIC_1) {
            count++;
         }      
      }
   }   
   
   if(count >= MaxOrderPerDayPerSymbol) {
      result = false;
   }
   
   return result;
}
//+------------------------------------------------------------------+
int AwesomeOscillatorSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double ao_0 = iAO(symbol, timeframe, shift);
   double ao_1 = iAO(symbol, timeframe, shift + 1);
   double ao_2 = iAO(symbol, timeframe, shift + 2);
   
   /*
   if(ao_1 < 0 && ao_0 > ao_1 && ao_2 > ao_1) result = 1;
   else if(ao_1 > 0 && ao_0 < ao_1 && ao_2 < ao_1) result = -1;
   */
   if(ao_0 > ao_1) result = 1;
   else if(ao_0 < ao_1) result = -1;   
   
   return result;
}
//+------------------------------------------------------------------+
void SetResistenceSupportLevels(string &resistence[], string &support[], int timeframe, int shift) {
   string symbol = "", obj_name = "";
   double apply_zones = 0;
   double trend_line_price = 0, rectangle_priceUP = 0, rectangle_priceDOWN = 0;
   double high = 0, low = 0;
   datetime start_date;
   int count = 0;
   
   //String array Initialize
   for(int i = 0; i < ArraySize(resistence); i++) {
      resistence[i] = "";
      support[i] = "";
   }
   
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      count = 0;
      if(IsTesting() && symbol != _Symbol) continue;
      ObjectsDeleteAll(0, OBJ_RECTANGLE);
      apply_zones = iCustom(symbol, timeframe, "shved_supply_and_demand", 0, shift);
      for (int obj =ObjectsTotal()-1; obj>=0; obj--)
      {
         obj_name = ObjectName(0, obj);
         if(ObjectGetInteger(0, obj_name, OBJPROP_TYPE) == OBJ_RECTANGLE) {
            if(StringFind(obj_name, "Verified", 0) > 0 || StringFind(obj_name, "Proven", 0) > 0 || StringFind(obj_name, "Untested") > 0) {
               rectangle_priceUP = ObjectGet(obj_name, OBJPROP_PRICE1);   
               rectangle_priceDOWN = ObjectGet(obj_name, OBJPROP_PRICE2); 
               start_date = (datetime)ObjectGet(obj_name, OBJPROP_TIME1);
               count = ZigZagCount(symbol, timeframe, rectangle_priceUP, rectangle_priceDOWN, start_date);               
               if(StringSubstr(GetString(obj_name, "#", 1), 0, 1) == "R" && count > 0)  {            
                  resistence[i] = resistence[i] +"|"+ DoubleToString(rectangle_priceUP) +";"+ DoubleToString(rectangle_priceDOWN) +";"+ IntegerToString(count);
               }
               else if(StringSubstr(GetString(obj_name, "#", 1), 0, 1) == "S" && count > 0)  {            
                  support[i] = support[i] +"|"+ DoubleToString(rectangle_priceUP) +";"+ DoubleToString(rectangle_priceDOWN) +";"+ IntegerToString(count);
               }
            }       
         }
      } 
   }
}
string ResistenceSupportZones(string symbol, int timeframe, string &resistence[], string &support[]) {
   string result = "";
   double bid = SymbolInfoDouble(symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(symbol, SYMBOL_ASK);
   double level = 0;
   bool found = false;
   double high = iHigh(symbol, timeframe, 1), low = iLow(symbol, timeframe, 1);;
   
   for(int i = 0; i < ArraySize(resistence); i++) {
      level = GetDouble(resistence[i], ";", 1);
      if((bid > level || high > level) && level > 0) {
         result = "-1;" + DoubleToString(GetDouble(resistence[i], ";", 0)) +";"+ IntegerToString(GetIntiger(resistence[i], ";", 2));
         found = true;
         break;
      }
   }
   
   if(!found) {
      for(int i = 0; i < ArraySize(support); i++) {
         level = GetDouble(support[i], ";", 0);
         if((ask < level || low < level) && level > 0) {
            result = "1;" + DoubleToString(GetDouble(support[i], ";", 1)) +";"+ IntegerToString(GetIntiger(support[i], ";", 2));
            break;
         }
      }   
   }
   
   return result;
}
//+------------------------------------------------------------------+
int ZigZagCount(string symbol, int timeframe, double up_level, double down_level, datetime enddate) {
   int count = 0;
   double zigzag = 0;
   datetime date;
   bool is_first = true;
   
   for(int i = 0; i < Bars; i++) {
      zigzag = iCustom(symbol, timeframe, "ZigZag", 30, 5, 3, 0, i);
      date = iTime(symbol, timeframe, i);
      if(zigzag > 0) {
         if(is_first) {
            is_first = false;
         }
         else {
            if(zigzag > down_level && zigzag < up_level) {
               count++;
            }         
         }
      }
      
      if(date < enddate) {
         break;
      }
   }
   
   return count;
}
//+------------------------------------------------------------------+
double GetTakeProfit(string symbol, const direction dir, string &array[]) {
   double result = 0;
   double value = 0;
   double last_value = 0;
   for(int i = 0; i < ArraySize(array); i++) {
      if(dir == Up) {
         value = GetDouble(array[i], ";", 1);
         if(value < last_value || last_value == 0) {
            last_value = value;
         }
      }
      else if(dir == Down) {
         value = GetDouble(array[i], ";", 0);
         if(value > last_value || last_value == 0) {
            last_value = value;
         }      
      }
   }
   
   result = last_value;
   
   return result;
}
//+------------------------------------------------------------------+
bool TrendStrength(string symbol, int timeframe, int shift) {
   bool result = false;
   double atr_value_0 = iCustom(symbol, timeframe, "Brooky_Trend_Strength", 14, 0, shift);
   double atr_value_1 = iCustom(symbol, timeframe, "Brooky_Trend_Strength", 14, 0, shift + 1);
   double sig_value_0 = iCustom(symbol, timeframe, "Brooky_Trend_Strength", 14, 1, shift);
   
   if(atr_value_0 > sig_value_0 && atr_value_0 > atr_value_1) result = true;
   
   return result;
}
//+------------------------------------------------------------------+
int Trend_old(string symbol, int timeframe, int shift) {
   int result = 0;
   double open = iOpen(symbol, timeframe, shift);
   double close = iClose(symbol, timeframe, shift);
   double high = iHigh(symbol, timeframe, shift);
   double low = iLow(symbol, timeframe, shift);
   double ema_150 = iMA(symbol, timeframe, 150, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_100 = iMA(symbol, timeframe, 100, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_50 = iMA(symbol, timeframe, 50, 0, MODE_EMA, PRICE_CLOSE, shift);
   
   if(ema_50 > ema_100 && ema_100 > ema_150 && low < ema_100 && close > ema_100 && close > open) {
      result = 1;
   }
   else if(ema_50 < ema_100 && ema_100 < ema_150 && high > ema_100 && close < ema_100 && close < open) {
      result = -1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
int VWAPSignal(string symbol, int timeframe, double pivot_tc, double pivot_bc, int shift) {
   int result = 0;
   double close = iClose(symbol, timeframe, shift);
   double vwap = iCustom(symbol, timeframe, "VWAP", 0, shift);
   double vwap_prev = 0;
   
   if(close > vwap) {
      if(vwap < pivot_tc) {
         result = 1;
      }
      else {
         result = 2;
      }
   }
   else if(close < vwap) {
      if(vwap > pivot_bc) {
         result = -1;
      }
      else {
         result = -2;       
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
double THV4CoralValue(string symbol, int timeframe, int shift) {
   double result = 0;
   double coral_value = iCustom(symbol, timeframe, "THV4 Coral  T@H (e3)", true, 305, 1.0, 2, "", "Lines on change Coral", false, 2, clrBlue, clrWhite, "", false, "Trend changed", false, "alert2", 0, shift);
   //double coral_green = iCustom(symbol, timeframe, "THV4 Coral  T@H (e3)", true, 305, 1.0, 2, "", "Lines on change Coral", false, 2, clrBlue, clrWhite, "", false, "Trend changed", false, "alert2", 1, shift);
   //double coral_red = iCustom(symbol, timeframe, "THV4 Coral  T@H (e3)", true, 305, 1.0, 2, "", "Lines on change Coral", false, 2, clrBlue, clrWhite, "", false, "Trend changed", false, "alert2", 2, shift);
   result = coral_value;
   
   return result;
}
//+------------------------------------------------------------------+
int ZZNRPATTSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double arrUP = iCustom(symbol, timeframe, "ZZ NRP AA TT", 3, shift);
   double arrDN = iCustom(symbol, timeframe, "ZZ NRP AA TT", 4, shift);
   
   if(arrUP > 0 && arrDN == 0) {
      result = 1;
   }
   else if(arrUP == 0 && arrDN > 0) {
      result = -1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
string Q2MASignal(string symbol, int timeframe, int shift) {
   string result = "";
   double red = iCustom(symbol, timeframe, "i-Q2MA", false, 21, 55, 1, 0, shift);
   double blue = iCustom(symbol, timeframe, "i-Q2MA", false, 21, 55, 1, 1, shift);
   double trend = iCustom(symbol, timeframe, "i-Q2MA", false, 21, 55, 1, 4, shift);
   
   result = DoubleToString(trend) +";"+ DoubleToString(red) +";"+ DoubleToString(blue);
   
   return result;
}
//+------------------------------------------------------------------+
string TrendLineSignalV2(string symbol, int timeframe, int shift) {
   string result = "0;0.0;0";
   double close = iClose(symbol, timeframe, shift);
   double arr_up_with_break = 0;
   double arr_dn_with_break = 0;
   string zigzag_points = GetZigZagPoints(symbol, timeframe);
   double zzUp1 = GetDouble(zigzag_points, ";", 0);
   double zzUp2 = GetDouble(zigzag_points, ";", 1); 
   double zzDn1 = GetDouble(zigzag_points, ";", 2); 
   double zzDn2 = GetDouble(zigzag_points, ";", 3);
   int iUp1 = GetIntiger(zigzag_points, ";", 4);
   int iUp2 = GetIntiger(zigzag_points, ";", 5);
   int iDn1 = GetIntiger(zigzag_points, ";", 6);
   int iDn2 = GetIntiger(zigzag_points, ";", 7);
   double blueline = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 3, shift);
   double redline = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 4, shift);
   double blueline_start = 0, blueline_signal = 0, redline_start = 0, redline_signal = 0, diff_start = 0, diff_signal = 0;
   
   for(int i = shift; i < MathMax(iUp1, iDn1); i++) {
      arr_up_with_break = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 0, i);
      arr_dn_with_break = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 1, i);   
      if(arr_up_with_break != EMPTY_VALUE && arr_dn_with_break == EMPTY_VALUE) {
         if(i <= iUp1 && zzUp1 < zzUp2 && close > redline && redline > blueline) {
            blueline_start = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 3, MathMin(iUp2, iDn2));
            blueline_signal = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 3, i);
            redline_start = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 4, MathMin(iUp2, iDn2));
            redline_signal = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 4, i);
            diff_start = redline_start - blueline_start;
            diff_signal = redline_signal - blueline_signal;
            if(diff_signal < diff_start * 0.75 || diff_signal > diff_start * 1.25) {
               result = "1;" + DoubleToString(redline) + ";" + IntegerToString(i);
            }
         }
         break;
      }
      else if(arr_dn_with_break != EMPTY_VALUE && arr_up_with_break == EMPTY_VALUE) {
         if(i <= iDn1 && zzDn1 > zzDn2 && close < blueline && redline > blueline) {
            blueline_start = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 3, MathMin(iUp2, iDn2));
            blueline_signal = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 3, i);
            redline_start = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 4, MathMin(iUp2, iDn2));         
            redline_signal = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 4, i);
            diff_start = redline_start - blueline_start;
            diff_signal = redline_signal - blueline_signal;            
            if(diff_signal < diff_start * 0.75 || diff_signal > diff_start * 1.25) {
               result = "-1;" + DoubleToString(blueline) + ";" + IntegerToString(i);
            }
         }
         break;
      }      
   }
   
   return result;
}
//+------------------------------------------------------------------+
string TrendLineSignal(string symbol, int timeframe, int shift) {
   string result = "0;0.0";   
   double arr_up_with_break = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 0, shift);
   double arr_dn_with_break = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 1, shift);   
   double blueline = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 3, shift);
   double redline = iCustom(symbol, timeframe, "TrendLines_Auto_ns", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 4, shift);   
   string zigzag_points = GetZigZagPoints(symbol, timeframe);
   double zzUp1 = GetDouble(zigzag_points, ";", 0);
   double zzUp2 = GetDouble(zigzag_points, ";", 1); 
   double zzDn1 = GetDouble(zigzag_points, ";", 2); 
   double zzDn2 = GetDouble(zigzag_points, ";", 3);
   if(arr_up_with_break != EMPTY_VALUE && arr_dn_with_break == EMPTY_VALUE && zzUp1 < zzUp2) {
      result = "1;" + DoubleToString(blueline);
   }
   else if(arr_dn_with_break != EMPTY_VALUE && arr_up_with_break == EMPTY_VALUE && zzDn1 > zzDn2) {
      result = "-1;" + DoubleToString(redline);
   }
   
   return result;
}
//+------------------------------------------------------------------+
int TrendLineSignal_old(string symbol, int timeframe, int shift) {
   int result = 0;
   double arr_up_with_break = iCustom(symbol, timeframe, "TrendLines_Auto", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 0, shift);
   double arr_dn_with_break = iCustom(symbol, timeframe, "TrendLines_Auto", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 1, shift);
   double arr_up_without_break = iCustom(symbol, timeframe, "TrendLines_Auto", "", false, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 0, shift);
   double arr_dn_without_break = iCustom(symbol, timeframe, "TrendLines_Auto", "", false, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 1, shift);   
   
   if((arr_up_with_break != EMPTY_VALUE || arr_up_without_break != EMPTY_VALUE) && (arr_dn_with_break == EMPTY_VALUE || arr_dn_without_break == EMPTY_VALUE)) {
      result = 1;
   }
   else if((arr_dn_with_break != EMPTY_VALUE || arr_dn_without_break != EMPTY_VALUE) && (arr_up_with_break == EMPTY_VALUE || arr_up_without_break == EMPTY_VALUE)) {
      result = -1;
   }
   //calcular o zigzag
   //break up so se res estiver a descar e vice-versa??
   //sem break up se o sup estiver a subir e vice-versa??
   
   return result;
}
//+------------------------------------------------------------------+
int TrendLineHistorySignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double arr_up_with_break = 0, arr_dn_with_break = 0, arr_up_without_break = 0, arr_dn_without_break = 0;  
   
   for(int i = 0; i < 200; i++) {
      arr_up_with_break = iCustom(symbol, timeframe, "TrendLines_Auto", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 0, i);
      arr_dn_with_break = iCustom(symbol, timeframe, "TrendLines_Auto", "", true, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 1, i);
      arr_up_without_break = iCustom(symbol, timeframe, "TrendLines_Auto", "", false, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 0, i);
      arr_dn_without_break = iCustom(symbol, timeframe, "TrendLines_Auto", "", false, true, false, false, false, false, "alert2.wav", "TrendlineUp", "TrendlineDn", clrBlue, clrRed, 0, "", TrendLineZZExtDepth, TrendLineZZExtDeviation, TrendLineZZExtBackstep, 1, i);         
            
      if((arr_up_with_break != EMPTY_VALUE || arr_up_without_break != EMPTY_VALUE) && (arr_dn_with_break == EMPTY_VALUE || arr_dn_without_break == EMPTY_VALUE)) {
         result = 1;
         break;
      }
      else if((arr_dn_with_break != EMPTY_VALUE || arr_dn_without_break != EMPTY_VALUE) && (arr_up_with_break == EMPTY_VALUE || arr_up_without_break == EMPTY_VALUE)) {
         result = -1;
         break;
      }   
   }
   
   return result;
}
/*
//+------------------------------------------------------------------+
string GetSignal(string symbol, int timeframe_long, int timeframe_medium, int shift) {
   string result = "";
   double close_medium = iClose(symbol, timeframe_medium, shift);
   double high_medium = iHigh(symbol, timeframe_medium, shift);
   double low_medium = iLow(symbol, timeframe_medium, shift);
   int ma_signal_l_current = MovingAverageSignal(symbol, timeframe_long, shift);
   int ma_signal_m_current = MovingAverageSignal(symbol, timeframe_medium, shift);
   int bands_signal = BollingerBandsSignal(symbol, timeframe_long, shift);
   string atr_signal_current = ATR_TS_Signal(symbol, timeframe_medium, shift);
   string atr_signal_previous = ATR_TS_Signal(symbol, timeframe_medium, shift + 1);
   int atr_trend_current = GetIntiger(atr_signal_current, ";", 0);
   int atr_trend_previous = GetIntiger(atr_signal_previous, ";", 0);
   double atr_value_current = GetDouble(atr_signal_current, ";", 1);
   double ema_200 = iMA(symbol, timeframe_medium, 200, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_100 = iMA(symbol, timeframe_medium, 100, 0, MODE_EMA, PRICE_CLOSE, shift);
   double max_ma = MathMax(ema_200, ema_100);
   double min_ma = MathMin(ema_200, ema_100);
   double sl = 0;
   
   if(bands_signal == 1 && ma_signal_l_current == 1 && ma_signal_m_current != -1 && atr_trend_current == 1 && (atr_trend_previous == -1 || low_medium < ema_200)) {
      sl = MathMax(atr_value_current, min_ma);
      if(ma_signal_m_current != 1 && atr_trend_previous == -1) {
         sl = MathMin(sl, FractalSignal_SL(symbol, timeframe_medium, Down, 3));
      }
      result = "1;" + DoubleToString(sl);
   }
   else if(bands_signal == -1 && ma_signal_l_current == -1 && ma_signal_m_current != 1 && atr_trend_current == -1 && (atr_trend_previous == 1 || high_medium > ema_200)) {
      sl = MathMin(atr_value_current, max_ma);
      if(ma_signal_m_current != -1 && atr_trend_previous == 1) {
         sl = MathMax(sl, FractalSignal_SL(symbol, timeframe_medium, Up, 3));
      }
      result = "-1;" + DoubleToString(sl);
   }
   
   return result;
}
*/
//+------------------------------------------------------------------+
int TrendDirectionForceIndexSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   int ma_method = 0;
   double signal = iCustom(symbol, timeframe, "trend-direction-force-index-averages", timeframe, TrendDirectionForceIndexPeriod, TrendDirectionForceIndexTriggerUp, TrendDirectionForceIndexTriggerDown, TrendDirectionForceIndexMAMethod, TrendDirectionForceIndexMAPeriod, false, false, false, false, false, false, false, true, 7, shift);
   
   if(signal == 1.0) result = 1;
   if(signal == -1.0) result = -1;
   
   return result;
}
//+------------------------------------------------------------------+
string SuperTrendSignal(string symbol, int timeframe, int shift) {
   string result = "";
   int trend = 0;
   double value = 0;
   double up = iCustom(symbol, timeframe, "super-trend", SuperTrendNbrPeriod, SuperTrendMultiplier, 0, shift);
   double dn = iCustom(symbol, timeframe, "super-trend", SuperTrendNbrPeriod, SuperTrendMultiplier, 1, shift);
   
   if(up != EMPTY_VALUE && dn == EMPTY_VALUE) {
      trend = 1;
      value = up;
   }
   else if(up == EMPTY_VALUE && dn != EMPTY_VALUE) {
      trend = -1;
      value = dn;
   }
   
   result = IntegerToString(trend) +";"+ DoubleToString(value);
   
   return result;
}
//+------------------------------------------------------------------+
string VoltyChannelStopSignal(string symbol, int timeframe, int shift) {
   string result = "";
   int trend = 0;
   double value = 0;
   double up = iCustom(symbol, timeframe, "volty-channel-stop-2-1", timeframe, PRICE_CLOSE, 4, MODE_EMA, 11, 4.0, 1.0, true, false, false, false, false, false, false, "alert2.wav", 0, shift);
   double dn = iCustom(symbol, timeframe, "volty-channel-stop-2-1", timeframe, PRICE_CLOSE, 4, MODE_EMA, 11, 4.0, 1.0, true, false, false, false, false, false, false, "alert2.wav", 1, shift);
   
   if(up != EMPTY_VALUE && dn == EMPTY_VALUE) {
      trend = 1;
      value = up;
   }
   else if(up == EMPTY_VALUE && dn != EMPTY_VALUE) {
      trend = -1;
      value = dn;
   }
   
   result = IntegerToString(trend) + ";" + DoubleToString(value);
   
   return result;
}
//+------------------------------------------------------------------+
int VolatilityHypertrend(string symbol, int timeframe, int shift) {
   int result = 0;
   double type_1 = iCustom(symbol, timeframe, "volatility-hypertrend", "", 10, 1.7, "", clrBlue, clrRed, clrBlue, clrRed, clrGreen, 2, 2, 1, "", false, false, "", false, "alert.wav", false, false, false, 5, shift);
   double type_2 = iCustom(symbol, timeframe, "volatility-hypertrend", "", 10, 1.7, "", clrBlue, clrRed, clrBlue, clrRed, clrGreen, 2, 2, 1, "", false, false, "", false, "alert.wav", false, false, false, 5, shift + 1);
   
   if(type_1 == OP_BUY && type_2 == OP_SELL) result = 1;
   else if(type_1 == OP_SELL && type_2 == OP_BUY) result = -1;
   
   return result;
}
//+------------------------------------------------------------------+
int TrendDirection(string symbol, int timeframe, int shift) {
   int result = 0;
   double up = iCustom(symbol, timeframe, "Trend_direction", 0, shift);
   double dn = iCustom(symbol, timeframe, "Trend_direction", 1, shift);
   
   if(up == 1.0 && dn == 0.0) result = 1;
   else if(up == 0.0 && dn == 1.0) result = -1;
   
   return result;
}
/*
//+------------------------------------------------------------------+
int ADXSignal_old(string symbol, int timeframe, int shift) {
   int result = 0;
   double adx_main_1 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift);
   double adx_main_2 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift + 1);
   double adx_plus_di_1 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_PLUSDI, shift);
   double adx_plus_di_2 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_PLUSDI, shift + 1);   
   double adx_minus_di_1 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MINUSDI, shift);
   double adx_minus_di_2 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MINUSDI, shift + 1); 
   
   if(adx_main_1 > adx_main_2 && adx_main_1 >= ADXVolatilityThreshold) {
      if(adx_plus_di_1 > adx_minus_di_1 && adx_plus_di_1 > adx_plus_di_2 && adx_minus_di_1 < adx_minus_di_2) {
         result = 1;
      }
      else if(adx_plus_di_1 < adx_minus_di_1 && adx_plus_di_1 < adx_plus_di_2 && adx_minus_di_1 > adx_minus_di_2) {
         result = -1;
      }
   }
   else if(adx_main_1 < adx_main_2 && adx_main_1 >= ADXVolatilityThreshold) {
      if(adx_minus_di_1 > adx_plus_di_1) {
         if(adx_minus_di_1 < adx_minus_di_2) {
            result = 1;
         }      
      }
      else if(adx_plus_di_1 > adx_minus_di_1) {
         if(adx_plus_di_1 < adx_plus_di_2) {
            result = -1;
         }      
      }
   }
   else if(adx_main_1 < ADXVolatilityThreshold) {
      result = 0;
   }
   
   return result;
}
*/
//+------------------------------------------------------------------+
/*
int ADXSignal_old(string symbol, int timeframe, int shift) {
   int result = 0;
   double adx_main_1 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift);
   double adx_plus_di_1 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_PLUSDI, shift);
   double adx_minus_di_1 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MINUSDI, shift);

   if(adx_main_1 >= ADXVolatilityThreshold) {
      if(adx_plus_di_1 > adx_minus_di_1) {
         result = 1;
      }
      else if(adx_plus_di_1 < adx_minus_di_1) {
         result = -1;
      }
   }
   
   return result;
}
*/
//+------------------------------------------------------------------+
string ADXTrigger(string symbol, int timeframe, int shift) {
   string result = "0;0";
   double adx_main_0 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift);
   double adx_main_1 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift + 1);
   double adx_main_2 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift + 2);
   double adx_main_i = 0, prev_adx = 0;
   
   if(adx_main_1 > ADXVolatilityThreshold && adx_main_1 > adx_main_0 && adx_main_1 > adx_main_2) {
      for(int i = shift + 2; i < Bars; i++) {
         adx_main_i = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, i);
         prev_adx = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, i + 1);
         if(adx_main_i < ADXVolatilityThreshold) {
            result = "1;" + IntegerToString(i);
         }
         else if(prev_adx > adx_main_i) break;
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool ADXVolatility(string symbol, int timeframe, bool withMA, int shift) {
   bool trigger = false;
   double ADX_Array[1];
   ArrayResize(ADX_Array, Bars);   
   int i = 0;
   double ADX_MA_Current = 0, ADX_Join = 3.0;
   int array_pos = 0;
   int digits = (int)MarketInfo(symbol, MODE_DIGITS);
   double adx_0 = NormalizeDouble(iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift), digits + 1);
   double adx_1 = NormalizeDouble(iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift + 1), digits + 1);
   
   if(withMA) {
      for(i = shift; i < Bars; i++)
      {
         ADX_Array[array_pos] = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, i);
         array_pos++;
      }
      ArraySetAsSeries(ADX_Array, true);
      ADX_MA_Current=NormalizeDouble(iMAOnArray(ADX_Array, 0, ADXMAPeriod, 0, MODE_EMA, 0), digits + 1);      
   }
   
   if(adx_0 > ADXVolatilityThreshold && (adx_0 > ADX_MA_Current || !withMA))
   {
      trigger = true;
   }
      
   return trigger;
}
//+------------------------------------------------------------------+
bool ValidateADXExpansion(string symbol, int timeframe, int shift) {
   bool result = false;
   double adx_0 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift);
   double adx_1 = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift + 1);
   
   if(adx_0 > adx_1) result = true;
   
   return result;
}
//+------------------------------------------------------------------+
/*
bool ADXNotVolatility_old(string symbol, int timeframe, int shift) {
   bool trigger = true;
   double ADX_Array[1];
   ArrayResize(ADX_Array, Bars);
   
   int i = 0;
   double ADX_MA_Current = 0, ADX_Join = 3.0;
   int array_pos = 0;
   int digits = (int)MarketInfo(symbol, MODE_DIGITS);
   double adx_0 = NormalizeDouble(iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift), digits + 1);
   double adx_1 = NormalizeDouble(iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, shift + 1), digits + 1);
   
   for(i = shift; i < Bars; i++)
   {
      ADX_Array[array_pos] = iADX(symbol, timeframe, ADXPeriod, PRICE_CLOSE, MODE_MAIN, i);
      array_pos++;
   }
   ArraySetAsSeries(ADX_Array, true);
   ADX_MA_Current=NormalizeDouble(iMAOnArray(ADX_Array, 0, ADXMAPeriod, 0, MODE_EMA, 0), digits + 1);   
   
   if(adx_0 > ADX_MA_Current && (adx_0 > ADXVolatilityThreshold || adx_0 > adx_1))
   {
      trigger = false;
   }
      
   return trigger;
}
*/
//+------------------------------------------------------------------+
int MoneyFlowIndexZone(string symbol, int timeframe, int shift) {
   int result = 0;
   double mfi = iMFI(symbol, timeframe, MoneyFlowIndexPeriod, shift);
   
   if(mfi > MoneyFlowIndexUpLevel) {
      result = -1;
   }
   else if(mfi < MoneyFlowIndexDnLevel) {
      result = 1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
int BollingerBandsSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double close_1 = iClose(symbol, timeframe, shift);
   double open_1 = iOpen(symbol, timeframe, shift); 
   double bands_up_1 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations, 0, PRICE_CLOSE, MODE_UPPER, shift);
   double bands_up_2 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations, 0, PRICE_CLOSE, MODE_UPPER, shift + 1);
   double bands_mn_1 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations, 0, PRICE_CLOSE, MODE_MAIN, shift);
   double bands_lo_1 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations, 0, PRICE_CLOSE, MODE_LOWER, shift);
   double bands_lo_2 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations, 0, PRICE_CLOSE, MODE_LOWER, shift + 1);
      
   if(bands_up_1 > bands_up_2 && bands_lo_1 < bands_lo_2) {
      if(close_1 > bands_mn_1) {
         result = 1;
      }
      else if(close_1 < bands_mn_1) {
         result = -1;
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
string BollingerBandsSignalVX(string symbol, int timeframe, int limit_shift, int shift) {
   string result = "0;0;0;0";
   int trend = 0;
   if(limit_shift < shift) limit_shift = shift;
   double close_1 = iClose(symbol, timeframe, shift);
   double open_1 = iOpen(symbol, timeframe, shift);
   double high_1 = iHigh(symbol, timeframe, shift), high_i = 0;
   double low_1 = iLow(symbol, timeframe, shift), low_i = 0;   
   double bands_up_i = 0, bands_lo_i = 0;
   double bands_up_1 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations_outer, 0, PRICE_CLOSE, MODE_UPPER, shift);
   double bands_up_2 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations_outer, 0, PRICE_CLOSE, MODE_UPPER, shift + 1);
   double bands_mn_1 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations_outer, 0, PRICE_CLOSE, MODE_MAIN, shift);
   double bands_lo_1 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations_outer, 0, PRICE_CLOSE, MODE_LOWER, shift);
   double bands_lo_2 = iBands(symbol, timeframe, BollingerBandsPeriod, BollingerBandsDeviations_outer, 0, PRICE_CLOSE, MODE_LOWER, shift + 1);
      
   if(open_1 > bands_mn_1 && close_1 < bands_up_1 && high_1 >= bands_up_1) {
      trend = -1;
   }
   else if(open_1 < bands_mn_1 && close_1 > bands_lo_1 && low_1 <= bands_lo_1) {
      trend = 1;
   }
   
   result = IntegerToString(trend) +";"+ DoubleToString(bands_up_1) +";"+ DoubleToString(bands_mn_1) +";"+ DoubleToString(bands_lo_1);
   
   return result;
}
//+------------------------------------------------------------------+
int RSIZone(string symbol, int timeframe, int shift) {
   int result = 0;
   double rsi = iRSI(symbol, timeframe, RSIPeriod, PRICE_CLOSE, shift);
   
   if(rsi > RSIUPLevel) result = -1;
   else if(rsi < RSIDNLevel) result = 1;
   
   return result;
}
//+------------------------------------------------------------------+
bool ValidateRSIOrderEntryZone(string symbol, int timeframe, int type, int shift) {
   bool result = true;
   bool rsi_on_zone = false;
   double rsi = iRSI(symbol, timeframe, RSIPeriod, PRICE_CLOSE, shift);
   double rsi_x = 0;
   int total = OrdersHistoryTotal() - 1;
   int start_pos = 0;
   
   if(type == OP_BUY) {
      if(rsi > RSIUPLevel) {
         rsi_on_zone = true;
         for(int i = shift + 1; i < Bars; i++) {
            rsi_x = iRSI(symbol, timeframe, RSIPeriod, PRICE_CLOSE, i);
            if(rsi_x <= RSIUPLevel) {
               start_pos = i;
               break;
            }
         }
      }
      else {
         result = false;
      }
   }
   else if(type == OP_SELL) {
      if(rsi < RSIDNLevel) {
         rsi_on_zone = true;
         for(int i = shift + 1; i < Bars; i++) {
            rsi_x = iRSI(symbol, timeframe, RSIPeriod, PRICE_CLOSE, i);
            if(rsi_x >= RSIDNLevel) {
               start_pos = i;
               break;
            }
         }         
      }
      else {
         result = false;
      }      
   }   
   
   if(rsi_on_zone) {
      for (int i = total; i >= 0; i--) {
         if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))  {
            if(OrderSymbol() == symbol && OrderType() == type && StringFind(OrderComment(), "[tp]", 0) >= 0) {
               if(OrderCloseTime() >= iTime(symbol, timeframe, start_pos)) {
                  result = false;
                  break;
               }
            }
         }    
      }    
   }
   
   return result;
}
//+------------------------------------------------------------------+
int FibonacciScalperSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double up = iCustom(symbol, timeframe, "FibonacciScalper", 3, 100, false, 0, shift);
   double dn = iCustom(symbol, timeframe, "FibonacciScalper", 3, 100, false, 1, shift);
   
   if(up > 0 && dn == 0)result = 1;
   else if(up == 0 && dn > 0)result = -1;
   
   return result;
}
//+------------------------------------------------------------------+
int PeakSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double gree_0 = iCustom(symbol, timeframe, "Peak", 150, 500, 0, 0, true, true, false, false, false, false, false, false, 25.0, 0, shift);
   double gree_1 = iCustom(symbol, timeframe, "Peak", 150, 500, 0, 0, true, true, false, false, false, false, false, false, 25.0, 0, shift + 1);
   double gree_2 = iCustom(symbol, timeframe, "Peak", 150, 500, 0, 0, true, true, false, false, false, false, false, false, 25.0, 0, shift + 2);
   double red_0 = iCustom(symbol, timeframe, "Peak", 150, 500, 0, 0, true, true, false, false, false, false, false, false, 25.0, 1, shift);
   double red_1 = iCustom(symbol, timeframe, "Peak", 150, 500, 0, 0, true, true, false, false, false, false, false, false, 25.0, 1, shift + 1);
   double red_2 = iCustom(symbol, timeframe, "Peak", 150, 500, 0, 0, true, true, false, false, false, false, false, false, 25.0, 1, shift + 2);
   
   if(gree_0 < gree_1 && gree_1 > gree_2 && gree_1 >= PeakThreshold) result = 1;
   else if(red_0 < red_1 && red_1 > red_2 && red_1 >= PeakThreshold) result = -1;
   
   return result;
}
//+------------------------------------------------------------------+
int PriceBorderSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double close = iClose(symbol, timeframe, shift);
   double high = MathMax(iHigh(symbol, timeframe, shift), iHigh(symbol, timeframe, shift + 1));
   double low = MathMin(iLow(symbol, timeframe, shift), iLow(symbol, timeframe, shift + 1));
   double outer_up = iCustom(symbol, timeframe, "Price Border", "All tf", 72, 0, 4.2, 110, true, false, false, false, false, false, false, 1, shift);
   double outer_dn = iCustom(symbol, timeframe, "Price Border", "All tf", 72, 0, 4.2, 110, true, false, false, false, false, false, false, 2, shift);
   double inner_up = iCustom(symbol, timeframe, "Price Border", "All tf", 72, 0, 3.0, 110, true, false, false, false, false, false, false, 1, shift);
   double inner_dn = iCustom(symbol, timeframe, "Price Border", "All tf", 72, 0, 3.0, 110, true, false, false, false, false, false, false, 2, shift);
   
   double val0 = iCustom(symbol, timeframe, "Price Border", "All tf", 72, 0, 4.2, 110, true, false, false, false, false, false, false, 0, shift);
   double val1 = iCustom(symbol, timeframe, "Price Border", "All tf", 72, 0, 4.2, 110, true, false, false, false, false, false, false, 1, shift);
   double val2 = iCustom(symbol, timeframe, "Price Border", "All tf", 72, 0, 4.2, 110, true, false, false, false, false, false, false, 2, shift);
   double val3 = iCustom(symbol, timeframe, "Price Border", "All tf", 72, 0, 4.2, 110, true, false, false, false, false, false, false, 3, shift);
   
   //Print("val0: ",val0," val1: ",val1," val2: ",val2," val3: ",val3);
   
   if(low < inner_dn && close > outer_dn) result = 1;
   else if(high > inner_up && close < outer_up) result = -1;
   
   return result;
}
//+------------------------------------------------------------------+
int IchimokuSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   int trend = 0, trigger = 0, inside_cloud = 0;
   double close = iClose(symbol, timeframe, shift);
   double high = iHigh(symbol, timeframe, shift);
   double low = iLow(symbol, timeframe, shift);
   double senkou_span_a = iIchimoku(symbol, timeframe, 9, 26, 52, MODE_SENKOUSPANA, shift);
   double senkou_span_b = iIchimoku(symbol, timeframe, 9, 26, 52, MODE_SENKOUSPANB, shift);   
   double senkou_span_a_future_1 = iIchimoku(symbol, timeframe, 9, 26, 52, MODE_SENKOUSPANA, shift - 25);
   double senkou_span_a_future_2 = iIchimoku(symbol, timeframe, 9, 26, 52, MODE_SENKOUSPANA, shift - 24);
   double senkou_span_b_future_1 = iIchimoku(symbol, timeframe, 9, 26, 52, MODE_SENKOUSPANB, shift - 25);   
   double senkou_span_b_future_2 = iIchimoku(symbol, timeframe, 9, 26, 52, MODE_SENKOUSPANB, shift - 24);   
   
   if(senkou_span_a_future_1 > senkou_span_b_future_1) {
      trend = 1;
   }
   else if(senkou_span_a_future_1 < senkou_span_b_future_1) {
      trend = -1;        
   }
   else if(senkou_span_a_future_1 == senkou_span_b_future_1) {
      if(senkou_span_a_future_2 < senkou_span_b_future_2) {
         trend = 1;         
      }
      else if(senkou_span_a_future_2 > senkou_span_b_future_2) {
         trend = -1;        
      }
   }

   result = trend;
   
   return result;
}
//+------------------------------------------------------------------+
bool HighSpeedTraillingStop(int tickect, int timeframe) {
   bool result = false;
   int cnt = 0, open_bar = 0;  
   double open_price = 0, max = 0, target = 0, did = 0;
    
   for (cnt = OrdersTotal() - 1; cnt >= 0; cnt--) {
      if (!OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES)) {
         continue;
      }
      
      if(OrderTicket() == tickect) {
         if(OrderTakeProfit() > 0) {
            if(OrderType() == OP_BUY) {
               open_price = OrderOpenPrice();
               open_bar = iBarShift(OrderSymbol(), timeframe, OrderOpenTime(), false);
               max = iHigh(OrderSymbol(), timeframe, iHighest(OrderSymbol(), timeframe, MODE_HIGH, open_bar, 0));  
               target = OrderTakeProfit() - OrderOpenPrice();
               did = max - OrderOpenPrice();
               if((did * 100) / target >= OrderSpeedTraillingPercentage) {
                  result = true;
               }
            }
            else if(OrderType() == OP_SELL) {
               open_price = OrderOpenPrice();
               open_bar = iBarShift(OrderSymbol(), timeframe, OrderOpenTime(), false);
               max = iLow(OrderSymbol(), timeframe, iLowest(OrderSymbol(), timeframe, MODE_LOW, open_bar, 0));  
               target = OrderOpenPrice() - OrderTakeProfit();
               did = OrderOpenPrice() - max;
               if((did * 100) / target >= OrderSpeedTraillingPercentage) {
                  result = true;
               }            
            }         
         }
      }
   }   
   
   return result;
}
//+------------------------------------------------------------------+
bool IsMonday() {
   bool result = false;
   int week_day = DayOfWeek();
   if(week_day == 1) {
      result = true;
   }
   
   return result;
}
//+------------------------------------------------------------------+
void FibonacciPivotPoints(string symbol, double &fibo[], int shift) {  
   double rates_d1[2][6];
   double fibo_s1 = 0, fibo_r1, fibo_s2 = 0, fibo_r2 = 0, fibo_s3 = 0, fibo_r3 = 0; 
   ArrayCopyRates(rates_d1, symbol, PERIOD_D1);
   double D_yesterday_close = rates_d1[shift][4];
   double D_yesterday_open = rates_d1[shift][1];
   double D_yesterday_high = rates_d1[shift][3];
   double D_yesterday_low = rates_d1[shift][2];
        
   //---- Calculate Pivots DAY 0 
   double D_P = NormalizeDouble((D_yesterday_high + D_yesterday_low + D_yesterday_close) / 3, (int)MarketInfo(symbol, MODE_DIGITS));
   double D_R = (D_yesterday_high - D_yesterday_low);
    
   fibo_r1 = NormalizeDouble(D_P + (D_R * 0.382), (int)MarketInfo(symbol, MODE_DIGITS));
   fibo_r2 = NormalizeDouble(D_P + (D_R * 0.618), (int)MarketInfo(symbol, MODE_DIGITS));
   fibo_r3 = NormalizeDouble(D_P + (D_R * 1.000), (int)MarketInfo(symbol, MODE_DIGITS));
   fibo_s1 = NormalizeDouble(D_P - (D_R * 0.382), (int)MarketInfo(symbol, MODE_DIGITS));
   fibo_s2 = NormalizeDouble(D_P - (D_R * 0.618), (int)MarketInfo(symbol, MODE_DIGITS));
   fibo_s3 = NormalizeDouble(D_P - (D_R * 1.000), (int)MarketInfo(symbol, MODE_DIGITS));      
      
   fibo[0] = fibo_r3; fibo[1] = fibo_r2; fibo[2] = fibo_r1; fibo[3] = D_P; 
   fibo[4] = fibo_s1; fibo[5] = fibo_s2; fibo[6] = fibo_s3;    
}
//+------------------------------------------------------------------+
int FiboPivotDir(string symbol, int timeframe, double fibo_pp, double fibo_extreme, const direction dir, int shift) {
   int result = 0;
   double low = 0, high = 0;
   datetime today = iTime(_Symbol, Timeframe_D, 0);
   datetime process_bar;
   double points = 10 * MarketInfo(symbol, MODE_POINT);
   
   for(int i = shift; i < Bars; i++) {
      process_bar = iTime(symbol, timeframe, i);
      high = iHigh(symbol, timeframe, i);
      low = iLow(symbol, timeframe, i);
      
      if(dir == Up) {
         if(high >= fibo_extreme - points) {
            result = -1;
            break;
         }
         else if(low <= fibo_pp + points) {
            result = 1;
            break;         
         }
         else if(process_bar < today) {
            break;
         }
      }
      else if(dir == Down) {
         if(low <= fibo_extreme + points) {
            result = 1;
            break;
         }
         else if(high >= fibo_pp - points) {
            result = -1;
            break;         
         }         
         else if(process_bar < today) {
            break;
         }      
      }   
   }
      
   return result;
}
//+------------------------------------------------------------------+
int FractalTrigger(string symbol, int timeframe, double camarilla_point, const direction dir, bool use_camarilla_on_close, int shift) {
   int result = 0, pos = 0;
   double fract_value = 0;
   double low_i = 0, high_i = 0, open = 0, close = 0, high = 0, low = 0, fractal_open_close_min = 0, fractal_open_close_max = 0;  
   datetime today = iTime(symbol, Timeframe_D, 0);
   datetime process_bar; 
   double level_join = (LevelJoinDistance * MarketInfo(symbol, MODE_POINT));
   
   for(int i = 3; i < Bars; i++) {
      process_bar = iTime(symbol, timeframe, i);
      if(dir == Up) {
         fract_value = iFractals(symbol, timeframe, MODE_UPPER, i);
         if(process_bar <= today) {
            break;
         }          
         else if(fract_value > 0) {
            low_i = iLow(symbol, timeframe, i);
            if(low_i < camarilla_point + level_join && fract_value > camarilla_point - level_join) {
               pos = i;
               open = iOpen(symbol, timeframe, shift);
               close = iClose(symbol, timeframe, shift);
               high = iHigh(symbol, timeframe, shift);
               fractal_open_close_min = MathMin(iOpen(symbol, timeframe, pos), iClose(symbol, timeframe, pos));
               fractal_open_close_max = MathMax(iOpen(symbol, timeframe, pos), iClose(symbol, timeframe, pos));
               if(open < fractal_open_close_max && high >= fractal_open_close_min
                  && ((close < camarilla_point && use_camarilla_on_close) || (close < fractal_open_close_max && !use_camarilla_on_close))) {
                  result = -1;
                  break;
               }
            }
         }        
      }
      else if(dir == Down) {
         fract_value = iFractals(symbol, timeframe, MODE_LOWER, i);
         if(process_bar <= today) {
            break;
         }         
         else if(fract_value > 0) {
            high_i = iHigh(symbol, timeframe, i);
            if(high_i > camarilla_point - level_join && fract_value < camarilla_point + level_join) {
               pos = i;
               open = iOpen(symbol, timeframe, shift);
               close = iClose(symbol, timeframe, shift);
               low = iLow(symbol, timeframe, shift);
               fractal_open_close_min = MathMin(iOpen(symbol, timeframe, pos), iClose(symbol, timeframe, pos));
               fractal_open_close_max = MathMax(iOpen(symbol, timeframe, pos), iClose(symbol, timeframe, pos));
               if(open > fractal_open_close_min && low <= fractal_open_close_max
                  && ((close > camarilla_point && use_camarilla_on_close) || (close > fractal_open_close_min && !use_camarilla_on_close))) {
                  result = 1;
                  break;
               }
            }
         }                 
      }   
   }
   
   return result;
}
//+------------------------------------------------------------------+
int GetTrend(string symbol, int timeframe, int shift) {
   int result = 0;
   int hull_ma_signal = GetIntiger(HullMASignal_v1(symbol, timeframe, shift), ";", 0);
   bool adx_volatility = ADXVolatility(symbol, timeframe, true, shift);
   
   if(hull_ma_signal == 1 && adx_volatility) result = 1;
   else if(hull_ma_signal == -1 && adx_volatility) result = -1;
   
   return result;
}
//+------------------------------------------------------------------+
string MovingAverageChannelSignal(string symbol, int timeframe, int type, bool usetrend, int shift) {
   string result = "";
   int trend = 0;
   double close = iClose(symbol, timeframe, shift);
   double ema_value_h_0 = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_HIGH, shift);
   double ema_value_h_1 = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_HIGH, shift + 1);
   double ema_value_l_0 = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_LOW, shift);
   double ema_value_l_1 = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_LOW, shift + 1);  
   double ma_value_h_shift = 0, ma_value_l_shift = 0;
   int ma_bar_shift = 0;
   datetime today_open_time = iTime(symbol, Timeframe_D, 0);
   int today_open_bar = iBarShift(symbol, timeframe, today_open_time, false);
   double ma_value_today_open_h = 0, ma_value_today_open_l = 0;
   ma_value_today_open_h = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_HIGH, today_open_bar);
   ma_value_today_open_l = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_LOW, today_open_bar);    
   
   if(type == OP_BUY) {        
      if(ema_value_h_0 > ema_value_h_1 && ema_value_l_0 > ema_value_l_1) {
         trend = 1;
      }
      else if(!usetrend) {
         ma_bar_shift = GetIntiger(ZigZagFirstPoints(symbol, timeframe), ";", 0);
         ma_value_h_shift = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_HIGH, ma_bar_shift);
         ma_value_l_shift = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_LOW, ma_bar_shift);
         if(ema_value_h_0 > ma_value_h_shift && ema_value_l_0 > ma_value_l_shift) {
            trend = 1;
         }
      }
   }
   else if(type == OP_SELL) {
      if(ema_value_h_0 < ema_value_h_1 && ema_value_l_0 < ema_value_l_1) {
         trend = -1;
      }
      else if(!usetrend) {
         ma_bar_shift = GetIntiger(ZigZagFirstPoints(symbol, timeframe), ";", 0);
         ma_value_h_shift = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_HIGH, ma_bar_shift);
         ma_value_l_shift = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_LOW, ma_bar_shift);      
         if(ema_value_h_0 < ma_value_h_shift && ema_value_l_0 < ma_value_l_shift) {
            trend = -1;
         }
      } 
   }
   
   result = IntegerToString(trend) +";"+ DoubleToString(ema_value_h_0) +";"+ DoubleToString(ema_value_l_0) 
            +";"+ DoubleToString(ma_value_today_open_h) +";"+ DoubleToString(ma_value_today_open_l);
   
   return result;
}
//+------------------------------------------------------------------+
int MovingAverageTrend(string symbol, int timeframe, int shift) {
   int result = 0;
   double close = iClose(symbol, timeframe, shift);
   double ema_value_l_0 = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_value_l_1 = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_CLOSE, shift + 1);
   double ema_value_s_0 = iMA(symbol, timeframe, MAPERIOD_S, 0, MODE_EMA, PRICE_CLOSE, shift);
   double ema_value_s_1 = iMA(symbol, timeframe, MAPERIOD_S, 0, MODE_EMA, PRICE_CLOSE, shift + 1);
      
   if(close > ema_value_l_0 && close > ema_value_s_0 && ema_value_s_0 > ema_value_l_0
      && ema_value_s_0 - ema_value_l_0 > ema_value_s_1 - ema_value_l_1) {
      result = 1;
   }
   else if(close < ema_value_l_0 && close < ema_value_s_0 && ema_value_s_0 < ema_value_l_0
      && ema_value_l_0 - ema_value_s_0 > ema_value_l_1 - ema_value_s_1) {
      result = -1;      
   }
         
   return result;
}
//+------------------------------------------------------------------+
string HullMASignal_v1(string symbol, int timeframe, int shift) {
   string result = "0;0.0";
   int trend = 0;
   double price = iClose(symbol, timeframe, shift);
   double up = iCustom(symbol, timeframe, "hull-moving-average", HullMAMAPeriod, MODE_LWMA, 0, shift);
   double dn = iCustom(symbol, timeframe, "hull-moving-average", HullMAMAPeriod, MODE_LWMA, 1, shift);
   double hull = 0;
   
   if(up != EMPTY_VALUE && dn == EMPTY_VALUE) {
      hull = up;
      if(price > hull) trend = 1;
   }
   else if(up == EMPTY_VALUE && dn != EMPTY_VALUE) {
      hull = dn;
      if(price < hull) trend = -1;
   }
   
   result = IntegerToString(trend) +";"+ DoubleToString(hull);
   
   return result;
}
//+------------------------------------------------------------------+
int HullMASignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double up = iCustom(symbol, timeframe, "hull-moving-average", HullMAMAPeriod, MODE_LWMA, 0, shift);
   double dn = iCustom(symbol, timeframe, "hull-moving-average", HullMAMAPeriod, MODE_LWMA, 1, shift);
   
   if(up != EMPTY_VALUE && dn == EMPTY_VALUE) {
      result = 1;
   }
   else if(up == EMPTY_VALUE && dn != EMPTY_VALUE) {
      result = -1;
   }
   
   return result;
}
/*
//+------------------------------------------------------------------+
string EntrySignalX(string symbol, int timeframe, int shift) {
   string result = "";
   int trend = 0;
   double atr = iATR(symbol, Timeframe_Trend, 14, shift) * 0.500;
   double min_wave_size = MinimumWaveSizePoints * MarketInfo(symbol, MODE_POINT); 
   double wave_size = 0, zigzag = 0, first_zigzag_point = 0, second_zigzag_point = 0;
   int impulsive_wave = 0, corrective_wave = 0, i = 0, j = 0;

   for(i = shift; i < Bars; i++) {
      zigzag = iCustom(symbol, timeframe, "ZigZag", ZigZagDepth, ZigZagDeviation, ZigZagBackstep, 0, i);
      if(zigzag > 0) {
         if(first_zigzag_point == 0) {
            first_zigzag_point = zigzag;
         }
         else {
            second_zigzag_point = zigzag;
            wave_size = MathMax(first_zigzag_point, second_zigzag_point) - MathMin(first_zigzag_point, second_zigzag_point);
            if(wave_size >= MathMax(ATRValue(symbol, i), min_wave_size)) {
               break;
            }
            else {
               first_zigzag_point = second_zigzag_point;
               second_zigzag_point = 0;
            }    
         }
      }
   }
   
   //Check Impulsive Wave
   if(first_zigzag_point > second_zigzag_point && second_zigzag_point > 0) {
      impulsive_wave = 1;
   }
   else if(first_zigzag_point < second_zigzag_point && second_zigzag_point > 0) {
      impulsive_wave = -1;
   }
   
   bool entered_on_retracement_channel = false;
   double close = 0, close_curr = 0, high_curr = 0, low_curr = 0, high_prev = 0, low_prev = 0;
   double top = MathMax(first_zigzag_point, second_zigzag_point);
   double button = MathMin(first_zigzag_point, second_zigzag_point);
   double level_236 = button + (top - button) * 0.236;
   double level_382 = button + (top - button) * 0.382;
   double level_618 = button + (top - button) * 0.618;
   double level_784 = button + (top - button) * 0.784;
   //Check Corrective Wave: Entrance on Retracement Channel
   for(j = i; j >= shift; j--) {
      close = iClose(symbol, timeframe, j);
      if(impulsive_wave == 1) {
         if(close < level_618) {
            entered_on_retracement_channel = true;
            break;
         }
      }
      else if(impulsive_wave == -1) {
         if(close > level_382) {
            entered_on_retracement_channel = true;
            break;
         }      
      }
   }

   //Check Corrective Wave: Signal   
   if(entered_on_retracement_channel) {
      close_curr = iClose(symbol, timeframe, shift);
      high_curr = iHigh(symbol, timeframe, shift);
      low_curr = iLow(symbol, timeframe, shift);
      high_prev = iHigh(symbol, timeframe, shift + 1);
      low_prev = iLow(symbol, timeframe, shift + 1);      
      if(low_curr >= level_784 && close_curr >= level_784 && low_prev < level_784) {
         trend = 1;
         result = IntegerToString(trend) +";"+ DoubleToString(button);
      }
      else if(high_curr <= level_236 && close_curr <= level_236 && high_prev > level_236) {
         trend = -1;
         result = IntegerToString(trend) +";"+ DoubleToString(top);
      }
   }
   
   return result;
}
*/
//+------------------------------------------------------------------+
/*
double ATRValueX(string symbol, int shift) {
   double atr = 0;
   
   datetime trade_bar_dt = iTime(symbol, Timeframe_Trade, shift);
   int trend_bar_shift = iBarShift(symbol, Timeframe_Trend, trade_bar_dt, false) + 1;
   atr = iATR(symbol, Timeframe_Trend, 14, trend_bar_shift) * 0.618;

   return atr;
}
//+------------------------------------------------------------------+
void CheckEndDayClose() {
   string symbol = "";
   int total = OrdersTotal() - 1;
   double high = 0, low = 0, profit = 0;
   if(CloseOrdersEndOfTodayTradingDay()) {
      for (int i = total; i >= 0; i--)  {
         if(MaxMessagesToTheServerReached())break;
         if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))  {
            symbol = OrderSymbol();   
            if(!IsTheMarketOpened(symbol)) {
               high = 0; low = 0;
               profit = OrderProfit() + OrderSwap() + OrderCommission(); 
               if(OrderType() == OP_BUY) {
                  low = iLow(symbol, Timeframe_Trade, 0);
                  if(low < OrderOpenPrice()) {    
                     if(profit > 0) {
                        CloseOrder(OrderTicket(), OrderLots(), OrderType(), symbol, false);
                     }
                  }
               }
               else if(OrderType() == OP_SELL) {
                  high = iHigh(symbol, Timeframe_Trade, 0);
                  if(high > OrderOpenPrice()) {    
                     if(profit > 0) {
                        CloseOrder(OrderTicket(), OrderLots(), OrderType(), symbol, false);
                     }
                  }               
               }
            }
         }
      }   
   }
}
*/
//+------------------------------------------------------------------+
void FillStrengthSignal(int timeframe) {
   string symbol = "";
   double strengh = 0;
   double fractal_up = 0, fractal_dn = 0, ask = 0, bid = 0, range = 0;
   int digit = 0;
   
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      bid = SymbolInfoDouble(symbol, SYMBOL_BID);
      ask = SymbolInfoDouble(symbol, SYMBOL_ASK);   
      digit = (int)MarketInfo(symbol, MODE_DIGITS);    
      strengh = NormalizeDouble(SymbolStrengthValue(symbol), 5);
      
      if(strengh > 0) {
         fractal_dn = LastFractal(symbol, timeframe, Down);
         range = NormalizeDouble(bid - fractal_dn, digit + 3);
         //if(StartBar_M15)Print(symbol,": fractal_dn: ",fractal_dn," bid: ",bid," range: ",range);
      }
      else if(strengh < 0) {
         fractal_up = LastFractal(symbol, timeframe, Up);
         range = NormalizeDouble(fractal_up - ask, digit + 3);
         //if(StartBar_M15)Print(symbol,": fractal_up: ",fractal_up," ask: ",ask," range: ",range);
      }
   }   
}
//+------------------------------------------------------------------+
int LastFractal(string symbol, int timeframe, const direction dir) {
   int result = 0; 
   int i = 0;  
   double fractal = 0;
   double new_h = 0, new_l = 0;
   int start_bar = 3;
   
   for(i = start_bar; i < start_bar + 100; i++){
      if(dir == Up) {
         fractal = iFractals(symbol, timeframe, MODE_UPPER, i);
         if(fractal > 0) {
            result = i;
            break;
         }
      }
      else if(dir == Down) {
         fractal = iFractals(symbol, timeframe, MODE_LOWER, i);
         if(fractal > 0) {
            result = i;
            break;
         }
      }  
   }
   
   return result;
}
//+------------------------------------------------------------------+
double GetLastFractalValue(string symbol, int timeframe, const direction dir) {
   double result = 0; 
   int i = 0;  
   double fractal = 0;
   double new_h = 0, new_l = 0;
   int start_bar = 3;
   
   for(i = start_bar; i < start_bar + 100; i++){
      if(dir == Up) {
         fractal = iFractals(symbol, timeframe, MODE_UPPER, i);
         if(fractal > 0) {
            result = fractal;
            break;
         }
      }
      else if(dir == Down) {
         fractal = iFractals(symbol, timeframe, MODE_LOWER, i);
         if(fractal > 0) {
            result = fractal;
            break;
         }
      }  
   }
   
   return result;
}
/*
//+------------------------------------------------------------------+
void TakeProfitAudit(int ticket) {
   int total = OrdersTotal() - 1; 
   int type = -1; 
   bool modify = false;
   double sl_points = 0, tp_points = 0; 

   for (int i = total; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))  {        
         if(OrderTicket() == ticket) {
            type = OrderType();
            if(type == OP_BUY && OrderOpenPrice() > OrderStopLoss()) {
               sl_points = OrderOpenPrice() - OrderStopLoss();
               tp_points = OrderTakeProfit() - OrderOpenPrice();
               if(tp_points < sl_points * TakeProfitMultiplier) {
                  modify = OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), NormalizeDouble(OrderOpenPrice() + sl_points * TakeProfitMultiplier, (int)MarketInfo(OrderSymbol(), MODE_DIGITS)), 0, Yellow);
                  SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
               }
            }
            else if(type == OP_SELL && OrderOpenPrice() < OrderStopLoss()) {
               sl_points = OrderStopLoss() - OrderOpenPrice();
               tp_points = OrderOpenPrice() - OrderTakeProfit();
               if(tp_points < sl_points * TakeProfitMultiplier) {
                  modify = OrderModify(OrderTicket(), OrderOpenPrice(), OrderStopLoss(), NormalizeDouble(OrderOpenPrice() - sl_points * TakeProfitMultiplier, (int)MarketInfo(OrderSymbol(), MODE_DIGITS)), 0, Yellow);
                  SaveNewServerMessage("SERVER_MESSAGES.csv", 1);
               }            
            }            
            break;
         }
      }    
   }
}
*/
//+------------------------------------------------------------------+
int ATRTraillingStopSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double trailling_blue_line = iCustom(symbol, timeframe, "atr-trailing-stop", AtrTraillingStopBackPeriod, AtrTraillingStopATRPeriod, AtrTraillingStopFactor, AtrTraillingStopTypicalPrice, 0, shift);
   double trailling_red_line = iCustom(symbol, timeframe, "atr-trailing-stop", AtrTraillingStopBackPeriod, AtrTraillingStopATRPeriod, AtrTraillingStopFactor, AtrTraillingStopTypicalPrice, 1, shift);
   if(trailling_blue_line != EMPTY_VALUE && trailling_red_line == EMPTY_VALUE) {
      result = 1;
   }
   else if(trailling_blue_line == EMPTY_VALUE && trailling_red_line != EMPTY_VALUE) {
      result = -1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
string KeltnerChannelSignal(string symbol, int timeframe, int shift) {
   string result = "";
   int trend = 0;
   double close = iClose(symbol, timeframe, shift);
   double high = MathMax(iHigh(symbol, timeframe, shift), iHigh(symbol, timeframe, shift + 1));
   double low = MathMin(iLow(symbol, timeframe, shift), iLow(symbol, timeframe, shift + 1));

   double up = iCustom(symbol, timeframe, "keltner-channel", KeltnerChannelPeriod, 0, shift);
   double md = iCustom(symbol, timeframe, "keltner-channel", KeltnerChannelPeriod, 1, shift);
   double dn = iCustom(symbol, timeframe, "keltner-channel", KeltnerChannelPeriod, 2, shift);
   
   result = "0;" + DoubleToString(up) + ";" +DoubleToString(md) + ";" + DoubleToString(dn);
   
   if(low < up && close > up) {
      result = "1;" + DoubleToString(up) + ";" +DoubleToString(md) + ";" + DoubleToString(dn);
   }
   else if(high > dn && close < dn) {
      result = "-1;" + DoubleToString(up) + ";" +DoubleToString(md) + ";" + DoubleToString(dn);
   }
   
   return result;
}
//+------------------------------------------------------------------+
string ATR_TS_Signal(string symbol, int timeframe, int shift) {
   string result = "0;0";
   double blue = iCustom(symbol, timeframe, "atr-trailing-stop", AtrTraillingStopBackPeriod, AtrTraillingStopATRPeriod, AtrTraillingStopFactor, AtrTraillingStopTypicalPrice, 0, shift);
   double red = iCustom(symbol, timeframe, "atr-trailing-stop", AtrTraillingStopBackPeriod, AtrTraillingStopATRPeriod, AtrTraillingStopFactor, AtrTraillingStopTypicalPrice, 1, shift);
   
   if(blue != EMPTY_VALUE && red == EMPTY_VALUE) {
      result = "1;" + DoubleToString(blue);
   }
   else if(blue == EMPTY_VALUE && red != EMPTY_VALUE) {
      result = "-1;" + DoubleToString(red);
   }
   
   return result;

}
//+------------------------------------------------------------------+
int ADXMASignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double blue_line = iCustom(symbol, timeframe, "adx-ma", 250, 0.00001, 5000, 0, shift);
   double red_line = iCustom(symbol, timeframe, "adx-ma", 250, 0.00001, 5000, 1, shift);
   
   if(blue_line != EMPTY_VALUE && red_line == EMPTY_VALUE) {
      result = 1;
   }
   else if(blue_line == EMPTY_VALUE && red_line != EMPTY_VALUE) {
      result = -1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
string ADXVMABandsSignal(string symbol, int timeframe, int shift) {
   string result = "";
   int trend = 0;
   double center_band = iCustom(symbol, timeframe, "adxvma-bands-indicator", "Current time frame", 10.0, 4, 20.0, 20.0, 2.5, true, true, 0, shift);
   double blue = iCustom(symbol, timeframe, "adxvma-bands-indicator", "Current time frame", 10.0, 4, 20.0, 20.0, 2.5, true, true, 1, shift);
   double red = iCustom(symbol, timeframe, "adxvma-bands-indicator", "Current time frame", 10.0, 4, 20.0, 20.0, 2.5, true, true, 3, shift);
   double up_band = iCustom(symbol, timeframe, "adxvma-bands-indicator", "Current time frame", 10.0, 4, 20.0, 20.0, 2.5, true, true, 5, shift);
   double dn_band = iCustom(symbol, timeframe, "adxvma-bands-indicator", "Current time frame", 10.0, 4, 20.0, 20.0, 2.5, true, true, 6, shift);
   
   if(blue > 0 && red == EMPTY_VALUE) {
      trend = 1;
   }
   else if(blue == EMPTY_VALUE && red > 0) {
      trend = -1;
   }
   
   if(center_band != EMPTY_VALUE && up_band != EMPTY_VALUE && dn_band != EMPTY_VALUE) {
      result = IntegerToString(trend) + ";" + DoubleToString(up_band) + ";" + DoubleToString(center_band) + ";" + DoubleToString(dn_band);
   }
   
   return result;
}
//+------------------------------------------------------------------+
int ADXVMABandsZone(string symbol, int timeframe, int shift) {
   int result = 0;
   double close = iClose(symbol, timeframe, shift);
   double center_band = iCustom(symbol, timeframe, "adxvma-bands-indicator", "Current time frame", 10.0, 4, 20.0, 20.0, 3.0, true, true, 0, shift);
   
   if(center_band != EMPTY_VALUE && close < center_band) {
      result = 1;
   }
   else if(center_band != EMPTY_VALUE && close > center_band) {
      result = -1;
   }
   
   return result;
}
//+------------------------------------------------------------------+
string PsyLevelsSignal(string symbol, int timeframe, int shift) {
   string result = "0;0";
   double bounceUP = 0, bounceDN = 0, breakUP = 0, breakDN = 0;
   
   for(int i = shift; i < Bars; i++) {
      bounceUP = iCustom(symbol, timeframe, "PsyLevels_v2", 0.0, 0.0, 100.0, 2.0, clrGray, 2, 1, 1, "--- Alerts & Emails ---", 0, 5, 5, "alert.wav", "alert2.wav", 0, 1, 0, i);
      bounceDN = iCustom(symbol, timeframe, "PsyLevels_v2", 0.0, 0.0, 100.0, 2.0, clrGray, 2, 1, 1, "--- Alerts & Emails ---", 0, 5, 5, "alert.wav", "alert2.wav", 0, 1, 1, i);
      breakUP = iCustom(symbol, timeframe, "PsyLevels_v2", 0.0, 0.0, 100.0, 2.0, clrGray, 2, 1, 1, "--- Alerts & Emails ---", 0, 5, 5, "alert.wav", "alert2.wav", 0, 1, 2, i);   
      breakDN = iCustom(symbol, timeframe, "PsyLevels_v2", 0.0, 0.0, 100.0, 2.0, clrGray, 2, 1, 1, "--- Alerts & Emails ---", 0, 5, 5, "alert.wav", "alert2.wav", 0, 1, 3, i);      
      
      if(bounceUP != EMPTY_VALUE && bounceDN == EMPTY_VALUE) {
         result = IntegerToString(1) +";"+ DoubleToString(bounceUP);
         break;
      }
      else if(breakUP != EMPTY_VALUE && breakDN == EMPTY_VALUE) {
         result = IntegerToString(1) +";"+ DoubleToString(breakUP);
         break;
      }
      else if(bounceUP == EMPTY_VALUE && bounceDN != EMPTY_VALUE) {
         result = IntegerToString(-1) +";"+ DoubleToString(bounceDN);
         break;
      }
      else if(breakUP == EMPTY_VALUE && breakDN != EMPTY_VALUE) {
         result = IntegerToString(-1) +";"+ DoubleToString(breakDN);
         break;
      }      
   }
   
   return result;
}
//+------------------------------------------------------------------+
int FillZigZagLevels(string symbol, int timeframe, double& levels[], int type, int shift) {
   int result = 0;
   string fistUP = GetZigZagPoints(symbol, timeframe, 1, ZigZagDepth, ZigZagDeviation, ZigZagBackstep, shift);
   string fistDN = GetZigZagPoints(symbol, timeframe, -1, ZigZagDepth, ZigZagDeviation, ZigZagBackstep, shift);
   string zigzagCurrPoints = "", zigzagLastPoints = "";
   double atr = iATR(symbol, Timeframe_D, ATR_PERIOD, shift);
   double zigzag_up = 0, zigzag_dn = 0;
   bool found = false;
   int who_is_first = 0, zigzag_last_bar = 0, zigzag_last_point = 0;
   bool do_search = true;
   datetime today = iTime(symbol, Timeframe_D, 0);
   datetime process_bar;
   
   if(type == 1) {
      if(GetIntiger(fistUP, ";", 1) < GetIntiger(fistDN, ";", 1)) {
         who_is_first = 1;
         zigzag_up = GetDouble(fistUP, ";", 0);
         zigzag_dn = GetDouble(fistDN, ";", 0);
         if(zigzag_up - zigzag_dn > atr / 2) {
            levels[0] = zigzag_up;
            levels[1] = zigzag_up - ((zigzag_up - zigzag_dn) * 0.382);
            levels[2] = zigzag_up - ((zigzag_up - zigzag_dn) * 0.500);
            levels[3] = zigzag_up - ((zigzag_up - zigzag_dn) * 0.618);
            levels[4] = zigzag_dn;
            found = true;
            result = 1;
         }
      }
      else {
         who_is_first = -1;
      }
   }
   else if(type == -1) {
      if(GetIntiger(fistDN, ";", 1) < GetIntiger(fistUP, ";", 1)) {
         who_is_first = -1;
         zigzag_up = GetDouble(fistUP, ";", 0);
         zigzag_dn = GetDouble(fistDN, ";", 0);
         if(zigzag_up - zigzag_dn > atr / 2) {
            levels[0] = zigzag_dn;
            levels[1] = zigzag_dn + ((zigzag_up - zigzag_dn) * 0.382);
            levels[2] = zigzag_dn + ((zigzag_up - zigzag_dn) * 0.500);
            levels[3] = zigzag_dn + ((zigzag_up - zigzag_dn) * 0.618);
            levels[4] = zigzag_up;
            found = true;
            result = -1;
         }
      }
      else {
         who_is_first = 1;
      }   
   }
   
   if(!found) {
      if(who_is_first == 1) {
         zigzagLastPoints = fistDN;
         zigzag_last_bar = GetIntiger(fistDN, ";", 1);
         zigzag_last_point = -1;
      }
      else if(who_is_first == -1) {
         zigzagLastPoints = fistUP;
         zigzag_last_bar = GetIntiger(fistUP, ";", 1);
         zigzag_last_point = 1;
      }
      
      while(do_search) {
         process_bar = iTime(symbol, timeframe, zigzag_last_bar);
         if(process_bar <= today) {
            break;
         }          
         //do search
         if(zigzag_last_point == 1) {
            zigzagCurrPoints = GetZigZagPoints(symbol, timeframe, -1, ZigZagDepth, ZigZagDeviation, ZigZagBackstep, zigzag_last_bar);
            if(type == 1) {
               zigzag_up = GetDouble(zigzagLastPoints, ";", 0);
               zigzag_dn = GetDouble(zigzagCurrPoints, ";", 0);
               if(zigzag_up - zigzag_dn > atr / 2) {
                  levels[0] = zigzag_up;
                  levels[1] = zigzag_up - ((zigzag_up - zigzag_dn) * 0.382);
                  levels[2] = zigzag_up - ((zigzag_up - zigzag_dn) * 0.500);
                  levels[3] = zigzag_up - ((zigzag_up - zigzag_dn) * 0.618);
                  levels[4] = zigzag_dn;
                  result = 1;
                  break;
               }
               else {
                  zigzag_last_point = -1;
                  zigzag_last_bar = GetIntiger(zigzagCurrPoints, ";", 1);
                  zigzagLastPoints = zigzagCurrPoints;
               }           
            }
            else if(type == -1) {
               zigzag_last_point = -1;
               zigzag_last_bar = GetIntiger(zigzagCurrPoints, ";", 1);      
               zigzagLastPoints = zigzagCurrPoints;      
            }
         }
         else if(zigzag_last_point == -1) {
            zigzagCurrPoints = GetZigZagPoints(symbol, timeframe, 1, ZigZagDepth, ZigZagDeviation, ZigZagBackstep, zigzag_last_bar);
            if(type == -1) {
               zigzag_up = GetDouble(zigzagCurrPoints, ";", 0);
               zigzag_dn = GetDouble(zigzagLastPoints, ";", 0);
               if(zigzag_up - zigzag_dn > atr / 2) {
                  levels[0] = zigzag_dn;
                  levels[1] = zigzag_dn + ((zigzag_up - zigzag_dn) * 0.382);
                  levels[2] = zigzag_dn + ((zigzag_up - zigzag_dn) * 0.500);
                  levels[3] = zigzag_dn + ((zigzag_up - zigzag_dn) * 0.618);
                  levels[4] = zigzag_up;
                  result = -1;
                  break;
               }
               else {
                  zigzag_last_point = 1;
                  zigzag_last_bar = GetIntiger(zigzagCurrPoints, ";", 1);
                  zigzagLastPoints = zigzagCurrPoints;   
               }           
            }
            else if(type == 1) {
               zigzag_last_point = 1;
               zigzag_last_bar = GetIntiger(zigzagCurrPoints, ";", 1);  
               zigzagLastPoints = zigzagCurrPoints;             
            }
         }
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
string GetZigZagPoints(string symbol, int timeframe, int type, int zig_zag_depth, int zig_zag_deviation, int zig_zag_backstep, int shift) {
   string result = "";
   double point = 0;
   int barShift = 0;
   double zzCurrent = 0, zzTmp = 0;
   bool first_found = false;
   int fist_bar = 0;
   
   for(int i=shift; i<Bars; i++) {
      zzTmp=iCustom(symbol, timeframe, "ZigZag", zig_zag_depth, zig_zag_deviation, zig_zag_backstep, 0, i);//current
      if(zzTmp > 0.0 && !first_found) {
         zzCurrent = zzTmp; 
         first_found = true;
         fist_bar = i;
      }
      else if(zzTmp>0.0) {
         if(type == 1) {
            if(zzTmp > zzCurrent) {
               point = zzTmp;
               barShift = i;
               break;
            }
            else {
               point = zzCurrent;
               barShift = fist_bar;
               break;
            }
         }
         else if(type == -1) {
            if(zzCurrent > zzTmp) {
               point = zzTmp;
               barShift = i;
               break;
            }
            else {
               point = zzCurrent;
               barShift = fist_bar;
               break;
            }         
         }
      }      
   }
   result = DoubleToString(point) +";"+ IntegerToString(barShift);
   return result;
}
//+------------------------------------------------------------------+
string FillTrendLineInfo(string symbol, int timeframe, const direction dir, int shift) {
   string result = "0;0";
   double zzUp1 = 0,zzUp2 = 0;   
   double zzDn1 = 0,zzDn2 = 0;
   int iUp1 = 0,iUp2 = 0,iDn1 = 0,iDn2 = 0;
   double zzCurrent = 0, zzTmp = 0;
   int j = 0,trend = 0;
   string TrendUpName = "TrendlineUp" +IntegerToString(timeframe) + symbol;
   string TrendDnName = "TrendlineDn" +IntegerToString(timeframe) + symbol;
   color TrendUp=Blue;
   color TrendDn=Red;  
   double close = iClose(symbol, timeframe, shift); 
   
   if(shift < 1) shift = 1;

   for(int i=0; i<Bars; i++) {
      zzTmp=iCustom(symbol, timeframe, "ZigZag", ZigZagDepth, ZigZagDeviation, ZigZagBackstep, 0, i);//current
      if(zzTmp>0.0 && j==0) {zzCurrent=zzTmp; j=1;}
      
      if(zzTmp>0.0 && j==1 && zzTmp<zzCurrent && zzDn1==0) {zzDn1=zzTmp; j=2; iDn1=i; trend=-1;}
      if(zzTmp>0.0 && j==1 && zzTmp>zzCurrent && zzUp1==0) {zzUp1=zzTmp; j=2; iUp1=i; trend=1; }
      
      if(trend==-1) {
         if(zzTmp>0.0 && j==2 && zzTmp>zzDn1 && zzUp1==0) {zzUp1=zzTmp; iUp1=i; j=3;}
         if(zzTmp>0.0 && j==3 && zzTmp<zzUp1 && zzDn2==0) {zzDn2=zzTmp; iDn2=i; j=4;}
         if(zzTmp>0.0 && j==4 && zzTmp>zzDn2 && zzUp2==0) {zzUp2=zzTmp; iUp2=i; j=5; break;}
      }
      if(trend==1) {
         if(zzTmp>0.0 && j==2 && zzTmp<zzUp1 && zzDn1==0) {zzDn1=zzTmp; iDn1=i; j=3;}
         if(zzTmp>0.0 && j==3 && zzTmp>zzDn1 && zzUp2==0) {zzUp2=zzTmp; iUp2=i; j=4;}
         if(zzTmp>0.0 && j==4 && zzTmp<zzUp2 && zzDn2==0) {zzDn2=zzTmp; iDn2=i; j=5; break;}
      }
   }

   if(zzUp1!=0.0 && zzUp2!=0.0 && zzDn1!=0.0 && zzDn2!=0.0) {
      
      //Line UP
      if(ObjectFind(TrendUpName)==-1) {
         if(ObjectCreate(TrendUpName, OBJ_TREND, 0, iTime(symbol, timeframe, iUp2), zzUp2, iTime(symbol, timeframe, iUp1), zzUp1)){
              ObjectSet(TrendUpName, OBJPROP_COLOR, TrendUp);                
              ObjectSet(TrendUpName, OBJPROP_WIDTH, 2);
              ObjectSet(TrendUpName, OBJPROP_RAY, TRUE);
         }
      }
      else {
         ObjectSet(TrendUpName, OBJPROP_TIME1, iTime(symbol, timeframe, iUp2));
         ObjectSet(TrendUpName, OBJPROP_PRICE1, zzUp2);
         ObjectSet(TrendUpName, OBJPROP_TIME2, iTime(symbol, timeframe, iUp1));
         ObjectSet(TrendUpName, OBJPROP_PRICE2, zzUp1);
      }
      //Line DN
      if(ObjectFind(TrendDnName)==-1) {
         if(ObjectCreate(TrendDnName, OBJ_TREND, 0, iTime(symbol, timeframe, iDn2), zzDn2, iTime(symbol, timeframe, iDn1), zzDn1)){
              ObjectSet(TrendDnName, OBJPROP_COLOR, TrendDn);                
              ObjectSet(TrendDnName, OBJPROP_WIDTH, 2);
              ObjectSet(TrendDnName, OBJPROP_RAY, TRUE);
         }
      }
      else {
         ObjectSet(TrendDnName, OBJPROP_TIME1, iTime(symbol, timeframe, iDn2));
         ObjectSet(TrendDnName, OBJPROP_PRICE1, zzDn2);
         ObjectSet(TrendDnName, OBJPROP_TIME2, iTime(symbol, timeframe, iDn1));
         ObjectSet(TrendDnName, OBJPROP_PRICE2, zzDn1);
      }
   }
   
   double price_up_shift = ObjectGetValueByShift(TrendUpName, shift);
   double price_dn_shift = ObjectGetValueByShift(TrendDnName, shift);
   double price_up = 0, price_dn = 0;

   if(dir == Up && price_up_shift > 0 && close > price_up_shift) {
      //UP
      for(j = shift; j <= iUp1; j++) {
         price_up = ObjectGetValueByShift(TrendUpName, j);
         if(price_up == 0) break;
        
         //Check if price broke TrendLine UP
         if(iOpen(symbol, timeframe, j) < price_up && iClose(symbol, timeframe, j) >= price_up) {
            result = "1;" + IntegerToString(j);
            break;
         }
      }
   }
   else if(dir == Down && price_dn_shift > 0 && close < price_dn_shift) {
      //DN
      for(j = shift; j <= iDn1; j++) {
         price_dn = ObjectGetValueByShift(TrendDnName, j);
         if(price_dn == 0) break;
         
         //Check if price broke TrendLine DN
         if(iOpen(symbol, timeframe, j) > price_dn && iClose(symbol, timeframe, j) <= price_dn) {
            result = "-1;" + IntegerToString(j);
            break;
         }
      }     
   }
   
   if(!IsTesting()) {
      ObjectDelete(0, TrendUpName);
      ObjectDelete(0, TrendDnName);
   }
   
   return result;
}
//+------------------------------------------------------------------+
int AwesomeOscillator(string symbol, int timeframe, int shift) {
   int result = 0;
   double ao_value_0 = iAO(symbol, timeframe, shift);
   double ao_value_1 = iAO(symbol, timeframe, shift + 1);
      
   if(ao_value_0 > 0 && ao_value_0 > ao_value_1) result = 1;
   else if(ao_value_0 < 0 && ao_value_0 < ao_value_1) result = -1;
   
   return result;
}
//+------------------------------------------------------------------+
bool Trigger(string symbol, int timeframe, const direction dir, int shift) {
   bool result = false;
   string ma_signal = MovingAverageSignal(symbol, timeframe, shift);
   int ma_trend = GetIntiger(ma_signal, ";", 0);
   double ma_value = GetDouble(ma_signal, ";", 1);
   int ao_signal = AwesomeOscillator(symbol, timeframe, shift);
   double high = 0, low = 0;
   
   if(dir == Up) {
      if(ma_trend == -1) result = false;
      else if(ma_trend == 1 && ao_signal == 1) {
         for(int i = shift; i < Bars; i++) {
            low = iLow(symbol, timeframe, i);
            ma_signal = MovingAverageSignal(symbol, timeframe, i);
            ma_value = GetDouble(ma_signal, ";", 1);
            ao_signal = AwesomeOscillator(symbol, timeframe, i + 1);            
            if(low < ma_value) {
               result = true;
               break;
            }
            else if(ao_signal == 1) {
               break;
            }
         }
      }
   }
   else if(dir == Down) {
      if(ma_trend == 1) result = false;
      else if(ma_trend == -1 && ao_signal == -1) {
         for(int i = shift; i < Bars; i++) {
            high = iHigh(symbol, timeframe, i);
            ma_signal = MovingAverageSignal(symbol, timeframe, i);
            ma_value = GetDouble(ma_signal, ";", 1);
            ao_signal = AwesomeOscillator(symbol, timeframe, i + 1);            
            if(high > ma_value) {
               result = true;
               break;
            }
            else if(ao_signal == -1) {
               break;
            }
         }      
      }
   }
   
   
   return result;
}
//+------------------------------------------------------------------+
string KeltnerChannelsJurikSignal(string symbol, int timeframe, int shift) {
   string result = "";
   int my_trend = 0;
   double jur = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 0, shift);
   double jurUpa = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 1, shift);
   double jurUpb = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 2, shift);
   double jurDna = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 3, shift);
   double jurDnb = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 4, shift);
   double upper = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 5, shift);
   double ma = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 6, shift);
   double lower = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 7, shift);
   double trend = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 8, shift);
   double trenc = iCustom(symbol, timeframe, "Keltner Channels Jurik NRP 2.01", timeframe, 75.0, 0, 0.0, false, 1.0, 20, 34, MODE_LWMA, 20, 1.0, true, true, 9, shift);
   
   if(trend == 1.0 && trenc == 1.0) {
      my_trend = 1;
   }
   else if(trend == -1.0 && trenc == -1.0) {
      my_trend = -1;
   }
   
   result = IntegerToString(my_trend) +";"+ DoubleToString(upper) +";"+ DoubleToString(lower);
   
   return result;
}
//+------------------------------------------------------------------+
void SetCurrencyStrengthHistory() {
   string symbol = "", base_currency_strength_signal = "", counter_currency_strength_signal = "";
   int digits = 2;
   double strengthArray[1];
   ArrayResize(strengthArray, CurrencyStrengthHistorySize);
   double base_currency_strength = 0, counter_currency_strength = 0;
   int i = 0, j = 0;
   for(i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      base_currency_strength_signal = GetCurrencyStrength(GetString(PairSepare(symbol), ";", 0), CurrencyStrength);
      counter_currency_strength_signal = GetCurrencyStrength(GetString(PairSepare(symbol), ";", 1), CurrencyStrength);      
      base_currency_strength = GetDouble(base_currency_strength_signal, ";", 1);
      counter_currency_strength = GetDouble(counter_currency_strength_signal, ";", 1);
      
      for(j = CurrencyStrengthHistorySize - 1; j > 0; j--) {
         CurrencyStrengthHistory[i, j] = CurrencyStrengthHistory[i, j - 1];
      }

      //Last record
      CurrencyStrengthHistory[i, 0] = NormalizeDouble(base_currency_strength - counter_currency_strength, digits); 
   }
   
   if(!CurrencyStrengthHistoryArrayFilled) {
      CurrencyStrengthHistoryMinutes++;
      if(CurrencyStrengthHistoryMinutes == CurrencyStrengthHistorySize) {
         CurrencyStrengthHistoryArrayFilled = true;
      }
   }   
   else {
      for(i = 0; i < ArraySize(Symbols); i++) {
         ArrayInitialize(strengthArray, 0.0);
         for(j = 0; j < CurrencyStrengthHistorySize; j++) {
            strengthArray[j] = CurrencyStrengthHistory[i, j];
         }
         ArraySetAsSeries(strengthArray, true);
         CurrencyStrengthValue[i] = iMAOnArray(strengthArray, 0, CurrencyStrengthHistorySize, 0, MODE_EMA, 0);
      }
      //SetCurrencyStrengthValues();
   }
} 
/*
//+------------------------------------------------------------------+
void SetCurrencyStrengthValues() {
   int i = 0, j = 0;
   string symbol = "";
   
   if(!CurrencyStrengthValuesArrayFilled) {
      CurrencyStrengthValuesMinutes++;
      if(CurrencyStrengthValuesMinutes == 3) {
         CurrencyStrengthValuesArrayFilled = true;
      }
   }
   
   for(i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      for(j = 2; j > 0; j--) {
         CurrencyStrengthValues[i, j] = CurrencyStrengthValues[i, j - 1];
      }

      //Last record
      CurrencyStrengthValues[i, 0] = StrengthSignal(symbol, Timeframe_Short, 1);
   } 
}
//+------------------------------------------------------------------+
double StrengthSignal(string symbol, int timeframe, int shift) {
   double result = 0;
   string m_symbol = "";
   int i = 0;
   double strengthValue = 0;
   if(shift < 1) shift = 1;
   double atr_previous = iATR(symbol, timeframe, ATR_PERIOD, shift);
   double atr_current = iATR(symbol, timeframe, 1, shift - 1);
   long minute = 0;
   double racio = 0;
   
   
   for(i = 0; i < ArraySize(Symbols); i++) {
      m_symbol = GetString(Symbols[i], ";", 0);
      if(m_symbol == symbol) {
         strengthValue = CurrencyStrengthValue[i];
         break;
      }
   }
   
   long time_previous = iTime(symbol, timeframe, shift - 1);
   long time_current = iTime(symbol, Timeframe_M1, 0);
   
   if(time_current > time_previous) {
      minute = (time_current - time_previous) / 60;
      atr_previous = atr_previous / timeframe;
      atr_current = atr_current / minute;
      racio = (atr_current * 100) / atr_previous;
      if(strengthValue > 0) {
         result = strengthValue * racio;
      }
      else if(strengthValue < 0) {
         result = strengthValue * racio;    
      }   
   }
   
   return result;
}
*/
//+------------------------------------------------------------------+
int Signal(string symbol) {
   int result = 0, i = 0;
   double strength = 0;
   
   if(CurrencyStrengthHistoryArrayFilled) {
      for(i = 0; i < ArraySize(CurrencyStrengthValue); i++) {
         if(GetString(Symbols[i], ";", 0) == symbol) {
            strength = CurrencyStrengthValue[i];
            if(strength > 0 && strength > CurrencyStrengthThreshold) {
               result = 1;
            }
            else if(strength < 0 && MathAbs(strength) > CurrencyStrengthThreshold) {
               result = -1;
            }
            break;
         }
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
double GetStopLoss(string symbol, int timeframe, const direction dir, int shift) {
   double result = 0;
   double blue_trailling_sl_line = iCustom(symbol, timeframe, "atr-trailing-stop", AtrTraillingStopBackPeriod, AtrTraillingStopATRPeriod, AtrTraillingStopFactor, AtrTraillingStopTypicalPrice, 0, shift);
   double red_trailling_sl_line = iCustom(symbol, timeframe, "atr-trailing-stop", AtrTraillingStopBackPeriod, AtrTraillingStopATRPeriod, AtrTraillingStopFactor, AtrTraillingStopTypicalPrice, 1, shift);   
   
   if(dir == Up) {
      if(blue_trailling_sl_line != EMPTY_VALUE) {
         result = blue_trailling_sl_line;
      }
      else {
         result = FractalSignal_SL(symbol, timeframe, Down, 3, shift);
      }
   }
   else if(dir == Down) {
      if(red_trailling_sl_line != EMPTY_VALUE) {
         result = red_trailling_sl_line;
      }
      else {
         result = FractalSignal_SL(symbol, timeframe, Up, 3, shift);
      }   
   }
   
   return result;  
}
//+------------------------------------------------------------------+
bool TodayTPOrderOpened(string symbol, int type) {
   bool result = false;
   int total = OrdersHistoryTotal() - 1;
   datetime today = iTime(_Symbol, Timeframe_D, 0);	
   for (int i = total; i >= 0; i--) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))  {
         if((StringFind(OrderComment(), "[tp]", 0) >= 0) && OrderCloseTime() > today && OrderType() == type) {
            result = true;
            break;
         }    
      }    
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool CheckMinHourToHandleOpenPositions() {
   bool result = false;
   
   if(TimeHour(TimeCurrent()) == GetIntiger(MinHourToHandleOpenPositions, ":", 0)) {
      if(TimeMinute(TimeCurrent()) >= GetIntiger(MinHourToHandleOpenPositions, ":", 1)) {
         result = true;
      }
   }
   else if (TimeHour(TimeCurrent()) > GetIntiger(MinHourToHandleOpenPositions, ":", 0)) {
      result = true;
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool CheckMinHourToTraillingStop() {
   bool result = false;
   
   if(TimeHour(TimeCurrent()) == GetIntiger(MinHourToTraillingStop, ":", 0)) {
      if(TimeMinute(TimeCurrent()) >= GetIntiger(MinHourToTraillingStop, ":", 1)) {
         result = true;
      }
   }
   else if (TimeHour(TimeCurrent()) > GetIntiger(MinHourToTraillingStop, ":", 0)) {
      result = true;
   }
   
   return result;
}
//+------------------------------------------------------------------+
void FillSupportAndResistence(int timeframe) {
   string symbol = "";;
   double execute = 0;
   string variableName = "", variableId = "";
   string variablesId[];
   double his[], los[], hits[], strengths[];
   bool isFirst = true;
   int position = 0, pos = 0;
   
   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      if(symbol != _Symbol && IsTesting())continue;
      
      execute = iCustom(symbol, timeframe, "v3.60_fxr_sr_zones", 0.4, true, "---", timeframe, "", clrRoyalBlue, clrRoyalBlue, clrRoyalBlue, clrRoyalBlue, clrRoyalBlue, clrCrimson, clrCrimson, clrCrimson, clrCrimson, clrCrimson, clrMediumSeaGreen, false, false, false, false, 5, false, false, false, false, false, 300, 0, 1);      
      for(int x = 0; x < GlobalVariablesTotal(); x++) {
         pos = 0;
         variableName = GlobalVariableName(x);
         pos = StringFind(variableName, "_", 5);
         position = 0; variableId = "";
         if(StringFind(variableName, "SSSR_", 0) >= 0 && StringFind(variableName, symbol, 0) > 0) {
            variableId = StringSubstr(variableName, pos+1, StringLen(variableName)-pos);
            if (isFirst) {
               ArrayResize(variablesId, 1);
               ArrayResize(his, 1);
               ArrayResize(los, 1);
               ArrayResize(hits, 1);
               ArrayResize(strengths, 1);
               variablesId[0] = variableId;
               isFirst = false;
            }
            else {
               position = GetArraysPosition(variableId, variablesId, his, los, hits, strengths);
            }
            
            if(StringFind(variableName, "_HI_", 4) >= 0) {
               his[position] = GlobalVariableGet(variableName);
            }
            else if(StringFind(variableName, "_LO_", 4) >= 0) {
               los[position] = GlobalVariableGet(variableName);
            }
            else if(StringFind(variableName, "_HITS_", 4) >= 0) {
               hits[position] = GlobalVariableGet(variableName);
            }
            else if(StringFind(variableName, "_STRENGTH_", 4) >= 0) {
               strengths[position] = GlobalVariableGet(variableName);
            }
         } 
      }
      bool firstRS = true;
      string join = "";
      string result = "";
      for(int x = 0; x < ArraySize(variablesId); x++) {
         if((hits[x] >= 1 && strengths[x] >= 1) || strengths[x] > 1) {
            if (firstRS) {
               firstRS = false;
            }
            else {
               join = "|";
            }
            result += join + DoubleToString(his[x]) +";"+ DoubleToString(los[x]) +";"+ DoubleToString(hits[x] * strengths[x]);
         }
      }      
      GlobalVariablesDeleteAll("SSSR_");
      ArrayResize(variablesId, 0);
      ArrayResize(his, 0);
      ArrayResize(los, 0);
      ArrayResize(hits, 0);
      ArrayResize(strengths, 0);  
      
      //Result
      SupportAndResistence[i] = result;
   }
}
//+------------------------------------------------------------------+
int GetArraysPosition(string variableId, string &variablesId[], double &his[], double &los[], double &hits[], double &strengths[]) {
   int result = 0;
   bool found = false;
   
   for(int i = 0; i < ArraySize(variablesId); i++) {
      if(variablesId[i] == variableId) {
         result = i;
         found = true;
         break;
      }
   }
   
   if(!found) {
      ArrayResize(variablesId, ArraySize(variablesId) + 1);
      ArrayResize(his, ArraySize(his) + 1);
      ArrayResize(los, ArraySize(los) + 1);
      ArrayResize(hits, ArraySize(hits) + 1);
      ArrayResize(strengths, ArraySize(strengths) + 1);
      variablesId[ArraySize(variablesId) - 1] = variableId;   
   }
   
   return result;
}
//+------------------------------------------------------------------+
string SupportAndResistenceSignal(string symbol, int timeframe, string sup_res, int shift) {
   string result = "", sr_res = "0;0", sr_sup = "0;0", result_b = "", result_s = "";
   double hi = 0, lo = 0;
   string sep = "|";
   ushort u_sep;
   string supres[]; 
   u_sep = StringGetCharacter(sep, 0);
   int k = StringSplit(sup_res, u_sep, supres);
   double close = iClose(symbol, timeframe, shift);
   double open = iOpen(symbol, timeframe, shift);
   double high_1 = MathMax(iHigh(symbol, timeframe, shift), iHigh(symbol, timeframe, shift + 1));
   double low_1 = MathMin(iLow(symbol, timeframe, shift), iLow(symbol, timeframe, shift + 1));
   bool found_b = false, found_s = false;
   
   for(int i = 0; i < ArraySize(supres); i++) {
      hi = GetDouble(supres[i], ";", 0);
      lo = GetDouble(supres[i], ";", 1);
      
      if(close < lo) { // RES
         if(GetDouble(sr_res, ";", 0) == 0 && GetDouble(sr_res, ";", 1) == 0) {
            sr_res = supres[i];
         }
         else {
            if(lo < GetDouble(sr_res, ";", 1)) {
               sr_res = supres[i];
            }
         }
      }
      else if(close > hi) { // SUP
         if(GetDouble(sr_sup, ";", 0) == 0 && GetDouble(sr_sup, ";", 1) == 0) {
            sr_sup = supres[i];
         }
         else {
            if(hi > GetDouble(sr_sup, ";", 0)) {
               sr_sup = supres[i];
            }
         }      
      }
      else if (close >= lo && close <= hi) {
         int level = GetLevel(symbol, timeframe, hi, lo, shift);
         if (level == 1) {
            if(GetDouble(sr_res, ";", 0) == 0 && GetDouble(sr_res, ";", 1) == 0) {
               sr_res = supres[i];
            }
            else {
               if(lo < GetDouble(sr_res, ";", 1)) {
                  sr_res = supres[i];
               }
            }         
         }
         else if(level == -1) {
            if(GetDouble(sr_sup, ";", 0) == 0 && GetDouble(sr_sup, ";", 1) == 0) {
               sr_sup = supres[i];
            }
            else {
               if(hi > GetDouble(sr_sup, ";", 0)) {
                  sr_sup = supres[i];
               }
            }         
         }
      }
   }
   
   //SELL
   if(GetDouble(sr_res, ";", 0) > 0 && GetDouble(sr_res, ";", 1) > 0) { // SELL
      if(high_1 > GetDouble(sr_res, ";", 1)) {
         result_s = "-1;" + sr_res  + ";" + DoubleToString(GetDouble(sr_sup, ";", 0));
         found_s = true;
      }
   }
   //BUY
   if(GetDouble(sr_sup, ";", 0) > 0 && GetDouble(sr_sup, ";", 1) > 0) { // BUY
      if(low_1 < GetDouble(sr_sup, ";", 0)) {
         result_b = "1;" + sr_sup + ";" + DoubleToString(GetDouble(sr_res, ";", 1));
         found_b = true;
      }
   }
   
   if(found_s && !found_b) {
      result = result_s;
   }
   else if(found_b && !found_s) {
      result = result_b;
   }
   
   return result;
}
//+------------------------------------------------------------------+
int GetLevel(string symbol, int timeframe, double hi, double lo, int shift) {
   int result = 0;
   double open = 0;
   
   for(int i = shift; i < Bars; i++) {
      open = iOpen(symbol, timeframe, i);
      if(open < lo) {
         result = 1;
         break;
      }
      else if(open > hi) {
         result = -1;
         break;
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
bool ValidateFirstBreak(string symbol, int timeframe, int type, double camarilla_lavel, int shift) {
   bool result = true;
   double close = 0;
   long today_open = iTime(symbol, Timeframe_D, 0);
   long current_time = 0;
   
   for(int i = shift + 1; i < Bars; i++) {
      close = iClose(symbol, timeframe, i);
      if(type == OP_BUY) {
         if(close > camarilla_lavel) {
            result = false;
            break;
         }
      }
      else if(type == OP_SELL) {
         if(close < camarilla_lavel) {
            result = false;
            break;
         }      
      }
      
      //Break
      current_time = iTime(symbol, timeframe, i);
      if(today_open > current_time) break;
   }   
   
   return result;
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
string ZigZagFirstPoints(string symbol, int timeframe) {
   string result = "0;0";
   double zzUp1 = 0,zzUp2 = 0;   
   double zzDn1 = 0,zzDn2 = 0;
   int iUp1 = 0,iUp2 = 0,iDn1 = 0,iDn2 = 0;
   double zzCurrent = 0, zzTmp = 0;
   int j = 0,trend = 0;
   
   for(int i=0; i<Bars; i++) {
      zzTmp=iCustom(symbol, timeframe, "ZigZag", ZigZagDepth, ZigZagDeviation, ZigZagBackstep, 0, i);//current
      if(zzTmp>0.0 && j==0) {zzCurrent=zzTmp; j=1;}
      
      if(zzTmp>0.0 && j==1 && zzTmp<zzCurrent && zzDn1==0) {zzDn1=zzTmp; j=2; iDn1=i; trend=-1;}
      if(zzTmp>0.0 && j==1 && zzTmp>zzCurrent && zzUp1==0) {zzUp1=zzTmp; j=2; iUp1=i; trend=1; }
      
      if(trend==-1) {
         if(zzTmp>0.0 && j==2 && zzTmp>zzDn1 && zzUp1==0) {zzUp1=zzTmp; iUp1=i; j=3; break;}
      }
      if(trend==1) {
         if(zzTmp>0.0 && j==2 && zzTmp<zzUp1 && zzDn1==0) {zzDn1=zzTmp; iDn1=i; j=3; break;}
      }
   }
   
   result = IntegerToString(iUp1) +";"+ IntegerToString(iDn1);
   
   return result;
}
//+------------------------------------------------------------------+
bool MAAndStochasticSignal(string symbol, int timeframe, int type, int stochasticPos, int shift) {
   bool result = false;
   double high = 0, low = 0, ema_value_l = 0;
   
   for(int i = stochasticPos; i >= shift; i--) {
      ema_value_l = iMA(symbol, timeframe, MAPERIOD_L, 0, MODE_EMA, PRICE_CLOSE, i);
      
      if(type == OP_BUY) {
         low = iLow(symbol, timeframe, i);
         if(low <= ema_value_l) {
            result = true;
            break;
         }
      }
      else if(type == OP_SELL) {
         high = iHigh(symbol, timeframe, i);
         if(high >= ema_value_l) {
            result = true;
            break;
         }
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
int PatternRecognitionSignal(string symbol, int timeframe, int shift) {
   int result = 0;
   double signal_sell = iCustom(symbol, timeframe, "Pattern_Recognition_Master_v3a", false, true, true, true, true, true, true, clrRed, 8, true, true, true, true, true, true, clrBlue, 8, true, true, clrRed, 8, true, true, 5, clrBlue, 8, true, true, clrRed, 8, true, true, clrBlue, 8, false, false, clrRed, 8, false, false, clrBlue, 8, false, false, false, 0, shift);
   double signal_buy = iCustom(symbol, timeframe, "Pattern_Recognition_Master_v3a", false, true, true, true, true, true, true, clrRed, 8, true, true, true, true, true, true, clrBlue, 8, true, true, clrRed, 8, true, true, 5, clrBlue, 8, true, true, clrRed, 8, true, true, clrBlue, 8, false, false, clrRed, 8, false, false, clrBlue, 8, false, false, false, 1, shift);
   
   if(signal_buy != EMPTY_VALUE && signal_sell == EMPTY_VALUE) {
      result = 1;
   }
   else if(signal_buy == EMPTY_VALUE && signal_sell != EMPTY_VALUE) {
      result = -1;
   }
   
   
   return result;
}
//+------------------------------------------------------------------+
int CheckTrend(int symbol_position, int timeframe, int start_shift, int end_shift) {
   int result = 0;
   CurrencyStrengthLinesSignalV2(CurrencyStrengthSignal, timeframe, start_shift);
   int signal = CurrencyStrengthSignal[symbol_position];
   if(end_shift <= start_shift) end_shift = start_shift + 1;   
   
   if(signal == 1) {
      for(int i = start_shift + 1; i <= end_shift; i++) {
         CurrencyStrengthLinesSignalV2(CurrencyStrengthSignal, timeframe, i);
         signal = CurrencyStrengthSignal[symbol_position];
         if(signal == -1) {
            result = 1;
            break;
         }
      }   
   }
   else if(signal == 1) {
      for(int i = start_shift + 1; i <= end_shift; i++) {
         CurrencyStrengthLinesSignalV2(CurrencyStrengthSignal, timeframe, i);
         signal = CurrencyStrengthSignal[symbol_position];
         if(signal == 1) {
            result = -1;
            break;
         }
      }    
   }
   
   
   return result;
}
//+------------------------------------------------------------------+
bool CheckCPRForce(double pivot_middle_r1, double pivot_middle_s1, double pivot_tc, double pivot_bc, double cpr_diff) {
   bool result = false;
   if((pivot_middle_r1 - cpr_diff > pivot_tc + cpr_diff) && (pivot_middle_s1 + cpr_diff < pivot_bc - cpr_diff)) {
      result = true;
   } 
   
   return result;  
}
//+------------------------------------------------------------------+
bool ValidateCPRNotOnTrendForce(double pivot_middle_r1, double pivot_middle_s1, double pivot_tc, double pivot_bc, double cpr_diff) {
   bool result = false;
   if((pivot_middle_r1 - cpr_diff < pivot_tc) || (pivot_middle_s1 + cpr_diff > pivot_bc)) {
      result = true;
   } 
   
   return result;  
}
//+------------------------------------------------------------------+
int CheckActiveSymbols(int timeframe, int shift) {
   int result = 0;
   string symbol = "", pivot_points_curr = "";
   double pivot_r1 = 0, pivot_pp = 0, pivot_s1 = 0, pivot_tc = 0, pivot_bc = 0, cpr_diff = 0, pivot_middle_r1 = 0, pivot_middle_s1 = 0;

   for(int i = 0; i < ArraySize(Symbols); i++) {
      symbol = GetString(Symbols[i], ";", 0);
      
      //Pivot Points
      pivot_points_curr = CalculatePivot(symbol, timeframe, shift);  
      pivot_r1 = GetDouble(pivot_points_curr, ";", 2);     
      pivot_pp = GetDouble(pivot_points_curr, ";", 3);
      pivot_s1 = GetDouble(pivot_points_curr, ";", 4);
      pivot_tc = GetDouble(pivot_points_curr, ";", 7);
      pivot_bc = GetDouble(pivot_points_curr, ";", 8);
      cpr_diff = pivot_tc - pivot_bc;
      pivot_middle_r1 = pivot_pp + ((pivot_r1 - pivot_pp) / 2);
      pivot_middle_s1 = pivot_pp - ((pivot_pp - pivot_s1) / 2);
      
      if(CheckCPRForce(pivot_middle_r1, pivot_middle_s1, pivot_tc, pivot_bc, cpr_diff)) {
         result++;
      }
   }
   
   return result;
}
//+------------------------------------------------------------------+
string GetZigZagPoints(string symbol, int timeframe) {
   string result = "0;0;0;0";
   double zzUp1 = 0,zzUp2 = 0;   
   double zzDn1 = 0,zzDn2 = 0;
   int iUp1 = 0,iUp2 = 0,iDn1 = 0,iDn2 = 0;
   double zzCurrent = 0, zzTmp = 0;
   int j = 0,trend = 0;

   for(int i=0; i<Bars; i++) {
      zzTmp=iCustom(symbol, timeframe, "ZigZag", ZigZagDepth, ZigZagDeviation, ZigZagBackstep, 0, i);//current
      if(zzTmp>0.0 && j==0) {zzCurrent=zzTmp; j=1;}
      
      if(zzTmp>0.0 && j==1 && zzTmp<zzCurrent && zzDn1==0) {zzDn1=zzTmp; j=2; iDn1=i; trend=-1;}
      if(zzTmp>0.0 && j==1 && zzTmp>zzCurrent && zzUp1==0) {zzUp1=zzTmp; j=2; iUp1=i; trend=1; }
      
      if(trend==-1) {
         if(zzTmp>0.0 && j==2 && zzTmp>zzDn1 && zzUp1==0) {zzUp1=zzTmp; iUp1=i; j=3;}
         if(zzTmp>0.0 && j==3 && zzTmp<zzUp1 && zzDn2==0) {zzDn2=zzTmp; iDn2=i; j=4;}
         if(zzTmp>0.0 && j==4 && zzTmp>zzDn2 && zzUp2==0) {zzUp2=zzTmp; iUp2=i; j=5; break;}
      }
      if(trend==1) {
         if(zzTmp>0.0 && j==2 && zzTmp<zzUp1 && zzDn1==0) {zzDn1=zzTmp; iDn1=i; j=3;}
         if(zzTmp>0.0 && j==3 && zzTmp>zzDn1 && zzUp2==0) {zzUp2=zzTmp; iUp2=i; j=4;}
         if(zzTmp>0.0 && j==4 && zzTmp<zzUp2 && zzDn2==0) {zzDn2=zzTmp; iDn2=i; j=5; break;}
      }
   }

   if(zzUp1!=0.0 && zzUp2!=0.0 && zzDn1!=0.0 && zzDn2!=0.0) {
      result = DoubleToString(zzUp1) +";"+ DoubleToString(zzUp2) +";"+ DoubleToString(zzDn1) +";"+ DoubleToString(zzDn2) +";"+
      IntegerToString(iUp1) +";"+ IntegerToString(iUp2) +";"+ IntegerToString(iDn1) +";"+ IntegerToString(iDn2);
   }
   
   return result;
}
//+-----------------------------------------------------------------+
string FractalTodaySignal(string symbol, int timeframe, double camarilla_h4, double camarilla_h3, double camarilla_l3, double camarilla_l4, int shift) {
   string result = "0;0.0";
   datetime today = iTime(symbol, Timeframe_D, 0);
   datetime process_bar; 
   double open = iOpen(symbol, timeframe, shift), open_fractal = 0;;
   double close = iClose(symbol, timeframe, shift), close_fractal = 0;
   double high = iHigh(symbol, timeframe, shift);
   double low = iLow(symbol, timeframe, shift);
   double fractal_up = 0, fractal_dn = 0;
   double join_level = 10 * MarketInfo(symbol, MODE_POINT);
   int last_up = LastFractal(symbol, timeframe, Up);
   int last_dn = LastFractal(symbol, timeframe, Down);
   
   for(int i = 3; i < Bars; i++) {
      process_bar = iTime(symbol, timeframe, i);      
      if(process_bar <= today) {
         break;
      }       
      fractal_up = iFractals(symbol, timeframe, MODE_UPPER, i);
      fractal_dn = iFractals(symbol, timeframe, MODE_LOWER, i);
      if((fractal_up != 0 && fractal_dn != 0) || (fractal_up == 0 && fractal_dn == 0))continue;   
      open_fractal = iOpen(symbol, timeframe, i);
      close_fractal = iClose(symbol, timeframe, i);
      if(fractal_up != 0) {
         if(fractal_up >= camarilla_h3 - join_level && fractal_up < camarilla_h4 && i > last_dn) {
            if((open < MathMax(open_fractal, close_fractal) && high > MathMax(open_fractal, close_fractal) && close < MathMax(open_fractal, close_fractal))
               || (open < fractal_up && high > MathMax(open_fractal, close_fractal) && close < fractal_up && close < open)) {
               result = "-1;" + DoubleToString(MathMax(camarilla_h4, fractal_up));
               break;
            }
         }
      }
      else if(fractal_dn != 0) {
         if(fractal_dn <= camarilla_l3 + join_level && fractal_dn > camarilla_l4 && i > last_up) {
            if((open > MathMin(open_fractal, close_fractal) && low < MathMin(open_fractal, close_fractal) && close > MathMin(open_fractal, close_fractal))
               || (open > fractal_dn && low < MathMin(open_fractal, close_fractal) && close > fractal_dn && close > open)) {
               result = "1;" + DoubleToString(MathMin(camarilla_l4, fractal_dn));
               break;
            }
         }
      }
   }
   
   return result;
}
//+-----------------------------------------------------------------+
string ValidateCPRZigZagSignal(string symbol, int timeframe, int type, double pivot_tc, double pivot_bc, int shift) {
   string result = "0;0";
   double zigzag = 0, last_zigzag = 0;
   datetime today = iTime(symbol, Timeframe_D, 0);
   datetime process_time;
   string fistUP = GetZigZagPoints(symbol, timeframe, 1, ZigZagDepth_Trigger, ZigZagDeviation_Trigger, ZigZagBackstep_Trigger, shift);
   string fistDN = GetZigZagPoints(symbol, timeframe, -1, ZigZagDepth_Trigger, ZigZagDeviation_Trigger, ZigZagBackstep_Trigger, shift);
   string zigzagCurrPoints = "";
   double zigzag_up = GetDouble(fistUP, ";", 0);
   double zigzag_dn = GetDouble(fistDN, ";", 0);  
   bool correct_side_validation = false, cpr_pp_validation = false; 
   int zigzag_bar_shit = 0, zigzag_last_type = 0;
   int cpr_pp_bar = 0;
   
   if(GetIntiger(fistUP, ";", 1) > GetIntiger(fistDN, ";", 1)) {
      zigzag_bar_shit = GetIntiger(fistUP, ";", 1);
      zigzag_last_type = 1;
   }
   else {
      zigzag_bar_shit = GetIntiger(fistDN, ";", 1);
      zigzag_last_type = -1;
   }
   
   if(type == 1) {
      if(zigzag_up > pivot_bc && zigzag_dn > pivot_bc) {
         correct_side_validation = true;
      }
   }
   else if(type == -1) {
      if(zigzag_up < pivot_tc && zigzag_dn < pivot_tc) {
         correct_side_validation = true;
      }   
   }
   
   if(correct_side_validation) {
      if(type == 1) {
         if(zigzag_last_type == -1 && iLow(symbol, timeframe, zigzag_bar_shit) < pivot_tc && iClose(symbol, timeframe, zigzag_bar_shit) > pivot_bc) {
            cpr_pp_validation = true;
            cpr_pp_bar = zigzag_bar_shit;
         }
      }
      else if(type == -1) {
         if(zigzag_last_type == 1 && iHigh(symbol, timeframe, zigzag_bar_shit) > pivot_bc && iClose(symbol, timeframe, zigzag_bar_shit) < pivot_tc) {
            cpr_pp_validation = true;
            cpr_pp_bar = zigzag_bar_shit;
         }      
      }
   
      if(!cpr_pp_validation) {
         for(int i = shift; i < Bars; i++) {
            zigzag_last_type = zigzag_last_type * -1;
            zigzagCurrPoints = GetZigZagPoints(symbol, timeframe, zigzag_last_type, ZigZagDepth_Trigger, ZigZagDeviation_Trigger, ZigZagBackstep_Trigger, zigzag_bar_shit);            
            zigzag_bar_shit = GetIntiger(zigzagCurrPoints, ";", 1);
            process_time = iTime(symbol, timeframe, zigzag_bar_shit); 
            if(process_time < today || cpr_pp_validation) break;            
            if(type == 1) {
               if(zigzag_last_type == -1 && iLow(symbol, timeframe, zigzag_bar_shit) < pivot_tc && iClose(symbol, timeframe, zigzag_bar_shit) > pivot_bc) {
                  cpr_pp_validation = true;
                  cpr_pp_bar = zigzag_bar_shit;
                  break;
               }
            }
            else if(type == -1) {
               if(zigzag_last_type == 1 && iHigh(symbol, timeframe, zigzag_bar_shit) > pivot_bc && iClose(symbol, timeframe, zigzag_bar_shit) < pivot_tc) {
                  cpr_pp_validation = true;
                  cpr_pp_bar = zigzag_bar_shit;
                  break;
               }              
            }
         }
      }
   }
   
   if(correct_side_validation && cpr_pp_validation) result = IntegerToString(type) + ";" + IntegerToString(cpr_pp_bar);
   
   return result;
}
//+-----------------------------------------------------------------+
bool ZigZagTrigger(string symbol, int timeframe, int type, int shift) {
   bool result = false;
   string zigzag = "";
   
   if(type == 1) {
      zigzag = GetZigZagPoints(symbol, timeframe, 1, ZigZagDepth_Trigger, ZigZagDeviation_Trigger, ZigZagBackstep_Trigger, shift);
      if(GetDouble(zigzag, ";", 0) > 0 && GetIntiger(zigzag, ";", 1) <= 1) {
         result = true;
      }
   }
   else if(type == -1) {
      zigzag = GetZigZagPoints(symbol, timeframe, -1, ZigZagDepth_Trigger, ZigZagDeviation_Trigger, ZigZagBackstep_Trigger, shift);
      if(GetDouble(zigzag, ";", 0) > 0 && GetIntiger(zigzag, ";", 1) <= 1) {
         result = true;
      }   
   }
   
   return result;  
}
//+-----------------------------------------------------------------+
string DailyBoxUpDn(string symbol, int timeframe) {
   string result = "0;0";
   int currentHour = TimeHour(TimeCurrent());
   datetime today = iTime(symbol, Timeframe_D, 0);
   datetime limit_time = today + ((8 * 60) * 60);
   int start_day_bar = iBarShift(symbol, timeframe, today, false);
   int end_day_bar = iBarShift(symbol, timeframe, limit_time, false);
   double high = 0, low = 0;
   
   if(currentHour >= 8) {
      high = iHigh(symbol, timeframe, iHighest(symbol, timeframe, MODE_HIGH, start_day_bar-end_day_bar, end_day_bar));
      low = iLow(symbol, timeframe, iLowest(symbol, timeframe, MODE_LOW, start_day_bar-end_day_bar, end_day_bar));
      result = DoubleToString(high) +";"+ DoubleToString(low);
   }
   return result;
}
//+-----------------------------------------------------------------+