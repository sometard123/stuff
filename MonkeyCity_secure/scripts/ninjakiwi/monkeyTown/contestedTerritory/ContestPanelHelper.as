package ninjakiwi.monkeyTown.contestedTerritory
{
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   import ninjakiwi.monkeyTown.town.gameEvents.GameplayEvent;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.callback;
   import ninjakiwi.monkeyTown.town.gameEvents.ui.useCurrentEvent;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   
   public class ContestPanelHelper
   {
      
      public static const TEXT_COLOUR_DARK:int = 1525071;
      
      public static const TEXT_COLOUR_LIGHT:int = 16777215;
      
      public static const MILLISECONDS_IN_A_DAY:Number = 1000 * 60 * 60 * 24;
      
      public static const MILLISECONDS_IN_A_WEEK:Number = MILLISECONDS_IN_A_DAY * 7;
      
      public static const DAY_OF_FIRST_MONDAY_UNIX:int = 4;
      
      public static const TIME_SINCE_FIRST_MONDAY_UNIX:Number = DAY_OF_FIRST_MONDAY_UNIX * MILLISECONDS_IN_A_DAY;
      
      public static const CONTESTED_TERRITORY_MAX_CAPTURE_TIME:Number = 86400000;
      
      public static const CONTESTED_TERRITORY_BLOONSTONES_REWARDS:Array = [50,20,10,0,0,0];
      
      public static const CONTESTED_TERRITORY_MAP_STARTING_MONDAY:int = 2318;
      
      public static const CONTESTED_TERRITORY_TRACK_LIST_CITY_1:Array = ["HeavyForest1","Grass1","Jungle2","Desert3","Lake4","Mountain4","River3","Grass2","HeavyForest2","Snow3","Jungle5","Grass5","Jungle1","Desert5","Grass6","Forest4","River2","Volcano4","Grass3","Snow4","Hills1","Volcano1","HeavyForest5","Lake2","Cave","Hills5","River4","Forest2","Mountain5","Lake3"];
      
      public static const CONTESTED_TERRITORY_TRACK_LIST_CITY_2:Array = ["Grass7","DesertBadlands2","River6","Desert6","Mountain1","Grass2","Lake6","Volcano2","HeavyForest6","Forest5","DesertBadlands3","Jungle6","Lake1","Grass4","Desert1","HeavyForest4","Hills2","Mountain6","DesertHighlands1","Desert4","Forest6","River5","Hills3","Jungle3","DesertBadlands1","DesertHighlands2","Mountain3","Hills6","DesertBadlands4"];
       
      
      public function ContestPanelHelper()
      {
         super();
      }
      
      public static function patchMissingScores(param1:Object) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in param1.cities)
         {
            _loc2_.score = param1.score[_loc2_.userID];
            if(_loc2_.score == null || _loc2_.hasOwnProperty("score") == false)
            {
               _loc2_.score = {
                  "current":0,
                  "best":0,
                  "time":0,
                  "duration":0,
                  "durationWithoutCurrent":0
               };
            }
            else
            {
               if(_loc2_.score.current == null || _loc2_.score.hasOwnProperty("current") == false)
               {
                  _loc2_.score.current = 0;
               }
               if(_loc2_.score.best == null || _loc2_.score.hasOwnProperty("best") == false)
               {
                  _loc2_.score.best = 0;
               }
               if(_loc2_.score.time == null || _loc2_.score.hasOwnProperty("time") == false)
               {
                  _loc2_.score.time = 0;
               }
               if(_loc2_.score.duration == null || _loc2_.score.hasOwnProperty("duration") == false)
               {
                  _loc2_.score.duration = 0;
               }
               _loc2_.score.durationWithoutCurrent = _loc2_.score.duration;
            }
         }
      }
      
      public static function fetchPlayersFromServerResponse(param1:Object) : Vector.<Object>
      {
         var _loc3_:Object = null;
         var _loc2_:Vector.<Object> = new Vector.<Object>();
         for each(_loc3_ in param1.cities)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function patchMissingScoresOfScoreObject(param1:Object) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_.current == null || _loc2_.hasOwnProperty("current") == false)
            {
               _loc2_.current = 0;
            }
            if(_loc2_.best == null || _loc2_.hasOwnProperty("best") == false)
            {
               _loc2_.best = 0;
            }
            if(_loc2_.time == null || _loc2_.hasOwnProperty("time") == false)
            {
               _loc2_.time = 0;
            }
            if(_loc2_.duration == null || _loc2_.hasOwnProperty("duration") == false)
            {
               _loc2_.duration = 0;
            }
            if(_loc2_.durationTime == null || _loc2_.hasOwnProperty("durationTime") == false)
            {
               _loc2_.durationTime = 0;
            }
            _loc2_.durationWithoutCurrent = _loc2_.duration;
         }
      }
      
      public static function fetchScoresFromScoreObject(param1:Object) : Vector.<Object>
      {
         var _loc3_:* = null;
         var _loc4_:Object = null;
         var _loc2_:Vector.<Object> = new Vector.<Object>();
         for(_loc3_ in param1)
         {
            _loc4_ = param1[_loc3_];
            _loc4_.userID = _loc3_;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function sortPlayersByTimeHeld(param1:Vector.<Object>) : void
      {
         var players:Vector.<Object> = param1;
         players.sort(function(param1:Object, param2:Object):int
         {
            if(param1.score.duration > param2.score.duration)
            {
               return -1;
            }
            if(param1.score.duration < param2.score.duration)
            {
               return 1;
            }
            return 0;
         });
      }
      
      public static function getUserIDWithHighestScoreBest(param1:Vector.<Object>, param2:int) : String
      {
         var _loc3_:String = "-1";
         var _loc4_:int = 1;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            if(param1[_loc5_].score.best >= param2)
            {
               if(param1[_loc5_].score.best > _loc4_)
               {
                  _loc3_ = param1[_loc5_].userID;
                  _loc4_ = param1[_loc5_].score.best;
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function getUserIDWithMostTimeHeld(param1:Vector.<Object>) : String
      {
         var _loc2_:String = "-1";
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            if(param1[_loc5_].score.duration > _loc3_)
            {
               _loc2_ = param1[_loc5_].userID;
               _loc3_ = param1[_loc5_].score.duration;
               _loc4_ = param1[_loc5_].score.time;
            }
            else if(param1[_loc5_].score.duration == _loc3_)
            {
               if(param1[_loc5_].score.time > _loc4_)
               {
                  _loc2_ = param1[_loc5_].userID;
                  _loc3_ = param1[_loc5_].score.duration;
                  _loc4_ = param1[_loc5_].score.time;
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function getPositionOfUserInPlayerList(param1:Vector.<Object>, param2:String) : int
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].userID == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public static function getTimeStringFromUnixTime(param1:Number) : String
      {
         if(isNaN(param1))
         {
            return "invalid time";
         }
         if(param1 == 0)
         {
            return "never captured";
         }
         if(param1 < 1000 * 60)
         {
            return "less than a minute";
         }
         var _loc2_:Date = new Date(param1);
         var _loc3_:* = "";
         var _loc4_:int = _loc2_.dateUTC - 1;
         if(_loc4_ != 0)
         {
            _loc3_ = String(_loc4_);
            if(_loc4_ == 1)
            {
               _loc3_ = _loc3_ + " day";
            }
            else
            {
               _loc3_ = _loc3_ + " days";
            }
         }
         var _loc5_:* = "";
         var _loc6_:* = int(_loc2_.hoursUTC);
         if(int(_loc2_.hoursUTC) != 0)
         {
            if(_loc4_ != 0)
            {
               _loc5_ = ", ";
            }
            _loc5_ = _loc5_ + String(_loc6_);
            if(_loc6_ == 1)
            {
               _loc5_ = _loc5_ + " hr";
            }
            else
            {
               _loc5_ = _loc5_ + " hrs";
            }
         }
         var _loc7_:* = "";
         var _loc8_:int = _loc2_.minutesUTC;
         if(_loc8_ != 0)
         {
            if(_loc4_ != 0 || _loc6_ != 0)
            {
               _loc7_ = ", ";
            }
            _loc7_ = _loc7_ + String(_loc8_);
            _loc7_ = _loc7_ + " min";
         }
         return _loc3_ + _loc5_ + _loc7_;
      }
      
      public static function addCurrentLeaderTotal(param1:Object, param2:Number) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Number = param2 - param1.score.time;
         _loc3_ = _loc3_ >= CONTESTED_TERRITORY_MAX_CAPTURE_TIME?Number(CONTESTED_TERRITORY_MAX_CAPTURE_TIME):Number(_loc3_);
         param1.score.duration = param1.score.durationWithoutCurrent + _loc3_;
      }
      
      public static function addCurrentLeaderTotalToScoreObject(param1:Object, param2:Number) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Number = param2 - param1.time;
         _loc3_ = _loc3_ >= CONTESTED_TERRITORY_MAX_CAPTURE_TIME?Number(CONTESTED_TERRITORY_MAX_CAPTURE_TIME):Number(_loc3_);
         param1.duration = param1.durationWithoutCurrent + _loc3_;
      }
      
      public static function getCurrentLeadingPlayer(param1:Vector.<Object>, param2:int, param3:Number) : Object
      {
         if(param1.length == 0)
         {
            return null;
         }
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:Number = 0;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         param1.sort(sortPlayersByEarliestCaptureTime);
         var _loc11_:int = 0;
         while(_loc11_ < param1.length)
         {
            _loc7_ = param1[_loc11_];
            _loc8_ = _loc7_.score.current;
            _loc9_ = _loc7_.score.time;
            _loc10_ = _loc9_ - _loc6_;
            if(_loc11_ == 0 || _loc10_ > CONTESTED_TERRITORY_MAX_CAPTURE_TIME || _loc8_ > _loc5_ && _loc8_ >= param2)
            {
               _loc4_ = _loc7_;
               _loc5_ = _loc8_;
               _loc6_ = _loc9_;
            }
            _loc11_++;
         }
         if(_loc5_ < param2)
         {
            _loc4_ = null;
         }
         return _loc4_;
      }
      
      public static function sortPlayersByEarliestCaptureTime(param1:Object, param2:Object) : int
      {
         if(param1.score.hasOwnProperty("time") == false && param2.score.hasOwnProperty("time") == false)
         {
            return 0;
         }
         if(param1.score.hasOwnProperty("time") == false && param2.score.hasOwnProperty("time"))
         {
            return -1;
         }
         if(param1.score.hasOwnProperty("time") && param2.score.hasOwnProperty("time") == false)
         {
            return 1;
         }
         if(param1.score.time == param2.score.time)
         {
            return 0;
         }
         if(param1.score.time < param2.score.time)
         {
            return -1;
         }
         return 1;
      }
      
      public static function sortScoresByEarliestCaptureTime(param1:Object, param2:Object) : int
      {
         if(param1.hasOwnProperty("time") == false && param2.hasOwnProperty("time") == false)
         {
            return 0;
         }
         if(param1.hasOwnProperty("time") == false && param2.hasOwnProperty("time"))
         {
            return -1;
         }
         if(param1.hasOwnProperty("time") && param2.hasOwnProperty("time") == false)
         {
            return 1;
         }
         if(param1.time == param2.time)
         {
            return 0;
         }
         if(param1.time < param2.time)
         {
            return -1;
         }
         return 1;
      }
      
      public static function sortByPlayersByWhoHaveCaptureTime(param1:Vector.<Object>) : void
      {
         var players:Vector.<Object> = param1;
         players.sort(function(param1:Object, param2:Object):int
         {
            if(param1.score.hasOwnProperty("time") == false || param1.score.time == 0)
            {
               return -1;
            }
            if(param2.score.hasOwnProperty("time") == false || param2.score.time == 0)
            {
               return 1;
            }
            if(param2.score.time > param1.score.time)
            {
               return -1;
            }
            if(param2.score.time < param1.score.time)
            {
               return 1;
            }
            return 0;
         });
      }
      
      public static function getCurrentLeadingScoreFromScores(param1:Vector.<Object>, param2:int, param3:Number, param4:Boolean = false) : Object
      {
         if(param1.length == 0)
         {
            return null;
         }
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:Number = 0;
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         var _loc10_:Number = 0;
         var _loc11_:Number = 0;
         param1.sort(sortScoresByEarliestCaptureTime);
         var _loc12_:int = 0;
         while(_loc12_ < param1.length)
         {
            _loc8_ = param1[_loc12_];
            _loc9_ = _loc8_.current;
            _loc10_ = _loc8_.time;
            _loc11_ = Math.abs(_loc10_ - _loc7_);
            if(_loc12_ == 0 || _loc11_ > CONTESTED_TERRITORY_MAX_CAPTURE_TIME || _loc9_ > _loc6_ && _loc9_ >= param2)
            {
               _loc5_ = _loc8_;
               _loc6_ = _loc9_;
               _loc7_ = _loc10_;
            }
            _loc12_++;
         }
         if(_loc6_ < param2)
         {
            _loc5_ = null;
         }
         if(param4)
         {
            if(CONTESTED_TERRITORY_MAX_CAPTURE_TIME < param3 - _loc7_)
            {
               _loc5_ = null;
            }
         }
         return _loc5_;
      }
      
      public static function sortByScoresByWhoHaveCaptureTime(param1:Vector.<Object>) : void
      {
         var scores:Vector.<Object> = param1;
         scores.sort(function(param1:Object, param2:Object):int
         {
            if(param1.hasOwnProperty("time") == false || param1.time == 0)
            {
               return -1;
            }
            if(param2.hasOwnProperty("time") == false || param2.time == 0)
            {
               return 1;
            }
            if(param2.time > param1.time)
            {
               return -1;
            }
            if(param2.time < param1.time)
            {
               return 1;
            }
            return 0;
         });
      }
      
      public static function getLatestLeaderTotalOffset(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = param2 - param1;
         var _loc4_:Number = _loc3_ > CONTESTED_TERRITORY_MAX_CAPTURE_TIME?Number(CONTESTED_TERRITORY_MAX_CAPTURE_TIME):Number(_loc3_);
         return _loc4_;
      }
      
      public static function doesRankingGiveBloonstones(param1:int) : Boolean
      {
         return CONTESTED_TERRITORY_BLOONSTONES_REWARDS[param1] != 0;
      }
      
      public static function canPlayerHaveBloonstones(param1:String, param2:Vector.<Object>, param3:int) : Boolean
      {
         if(param2[0].score.duration < CONTESTED_TERRITORY_MAX_CAPTURE_TIME)
         {
            return false;
         }
         if(param3 == 0)
         {
            return true;
         }
         var _loc4_:int = 1;
         while(_loc4_ < param2.length)
         {
            if(param2[_loc4_].score.duration <= 0)
            {
               return false;
            }
            if(param3 == _loc4_)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public static function getCurrentDayInYearUTC(param1:Number) : int
      {
         var _loc2_:Number = 1000 * 60 * 60 * 24;
         var _loc3_:Date = new Date(param1);
         var _loc4_:Date = new Date(_loc3_.fullYearUTC,0,0,0,0,0,0);
         var _loc5_:Number = param1;
         var _loc6_:Number = _loc4_.getTime();
         var _loc7_:Number = Math.abs(_loc5_ - _loc6_);
         var _loc8_:Number = Math.round(_loc7_ / _loc2_);
         return int(_loc8_);
      }
      
      public static function getNumOfMondaysSinceFirstMonday(param1:Number = -1) : int
      {
         var _loc2_:Number = 1000 * 60 * 60 * 24;
         param1 = param1 != -1?Number(param1):Number(new Date().getTime());
         var _loc3_:int = param1 / _loc2_;
         var _loc4_:int = _loc3_ - DAY_OF_FIRST_MONDAY_UNIX;
         var _loc5_:int = _loc4_ % 7;
         var _loc6_:int = _loc4_ - _loc5_;
         var _loc7_:int = _loc6_ / 7;
         return _loc7_;
      }
      
      public static function getContestedTerritoryTrackNameBasedOnID(param1:int, param2:int) : String
      {
         var _loc3_:int = 0;
         var _loc4_:String = "INVALID";
         switch(param2)
         {
            case 0:
               _loc3_ = param1 % CONTESTED_TERRITORY_TRACK_LIST_CITY_1.length;
               _loc4_ = CONTESTED_TERRITORY_TRACK_LIST_CITY_1[_loc3_];
               break;
            case 1:
               _loc3_ = param1 % CONTESTED_TERRITORY_TRACK_LIST_CITY_2.length;
               _loc4_ = CONTESTED_TERRITORY_TRACK_LIST_CITY_2[_loc3_];
         }
         return _loc4_;
      }
      
      public static function getStartTimeOfRoomInHistory(param1:Object) : Number
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = 0;
         var _loc4_:Date = new Date();
         if(param1.hasOwnProperty("startTime"))
         {
            _loc2_ = getNumOfMondaysSinceFirstMonday(param1.startTime);
            _loc3_ = convertWeeksToMilliseconds(_loc2_) + convertDaysToMilliseconds(ContestPanelHelper.DAY_OF_FIRST_MONDAY_UNIX);
            _loc4_.setTime(_loc3_);
            return _loc3_;
         }
         _loc5_ = param1.roomStart[0];
         _loc6_ = param1.roomStart[1];
         _loc7_ = param1.roomStart[2];
         var _loc8_:Date = new Date(_loc5_,_loc6_,_loc7_);
         _loc2_ = getNumOfMondaysSinceFirstMonday(_loc8_.getTime());
         _loc3_ = convertWeeksToMilliseconds(_loc2_) + convertDaysToMilliseconds(ContestPanelHelper.DAY_OF_FIRST_MONDAY_UNIX);
         _loc4_.setTime(_loc3_);
         return _loc3_;
      }
      
      public static function convertWeeksToMilliseconds(param1:Number) : Number
      {
         var _loc2_:Number = param1 * 1000 * 60 * 60 * 24 * 7;
         return _loc2_;
      }
      
      public static function convertDaysToMilliseconds(param1:Number) : Number
      {
         var _loc2_:Number = param1 * MILLISECONDS_IN_A_DAY;
         return _loc2_;
      }
   }
}
