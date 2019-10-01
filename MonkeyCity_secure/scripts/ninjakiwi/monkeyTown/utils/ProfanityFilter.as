package ninjakiwi.monkeyTown.utils
{
   public class ProfanityFilter
   {
      
      {
         BlackList.list.sort(sortLongest);
      }
      
      public function ProfanityFilter()
      {
         super();
      }
      
      private static function sortLongest(param1:String, param2:String) : int
      {
         if(param1.length >= param2.length)
         {
            return -1;
         }
         return 1;
      }
      
      public static function filterString(param1:String) : String
      {
         var _loc2_:String = param1;
         var _loc3_:Vector.<String> = new Vector.<String>();
         var _loc4_:Vector.<int> = new Vector.<int>();
         _loc2_ = markWhiteListedBadWords(_loc2_,_loc3_,_loc4_);
         _loc2_ = applyCensorship(_loc2_);
         _loc2_ = applyCensorship(convertSubstitutes(_loc2_),_loc2_);
         _loc2_ = restoreWhiteListMarks(_loc2_,_loc3_,_loc4_);
         var _loc5_:RegExp = new RegExp(SignificantCharacters.temporaryCensorCharacter,"g");
         _loc2_ = _loc2_.replace(_loc5_,SignificantCharacters.censorCharacter);
         return _loc2_;
      }
      
      private static function applyCensorship(param1:String, param2:String = null) : String
      {
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:Boolean = false;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc3_:String = new String(!!param2?param2:param1);
         var _loc4_:String = param1.toLowerCase();
         _loc4_ = filterNonLetterCharacters(_loc4_);
         var _loc5_:Vector.<uint> = new Vector.<uint>();
         var _loc6_:int = 0;
         while(_loc6_ < BlackList.list.length)
         {
            _loc7_ = BlackList.list[_loc6_];
            _loc8_ = _loc4_.search(_loc7_);
            while(_loc8_ != -1)
            {
               _loc5_.length = 0;
               _loc9_ = _loc8_;
               while(_loc5_.length != _loc7_.length)
               {
                  _loc14_ = _loc7_.charAt(_loc5_.length);
                  _loc15_ = param1.charAt(_loc9_);
                  if(_loc14_.toLocaleLowerCase() == _loc15_.toLocaleLowerCase())
                  {
                     _loc5_.push(_loc9_);
                  }
                  else
                  {
                     _loc16_ = false;
                     _loc17_ = 0;
                     while(_loc17_ < SignificantCharacters.nonLetterCharacters.length)
                     {
                        if(SignificantCharacters.nonLetterCharacters[_loc17_] == _loc15_)
                        {
                           _loc16_ = true;
                           break;
                        }
                        _loc17_++;
                     }
                  }
                  _loc9_++;
               }
               _loc10_ = false;
               _loc11_ = new String();
               if(_loc5_[0] != 0)
               {
                  if(isCharacterLetter(param1.charAt(_loc5_[0] - 1)))
                  {
                     _loc10_ = false;
                     _loc18_ = 0;
                     while(_loc18_ < _loc5_.length)
                     {
                        if(_loc18_ + 1 != _loc5_.length)
                        {
                           if(_loc5_[_loc18_ + 1] - _loc5_[_loc18_] != 1)
                           {
                              if(_loc10_ == false)
                              {
                                 _loc10_ = true;
                              }
                              else
                              {
                                 _loc10_ = false;
                                 break;
                              }
                           }
                        }
                        _loc18_++;
                     }
                     if(_loc10_)
                     {
                        _loc11_ = "";
                        _loc19_ = 0;
                        while(_loc19_ < _loc7_.length)
                        {
                           _loc11_ = _loc11_ + SignificantCharacters.temporaryCensorCharacter;
                           _loc19_++;
                        }
                        _loc4_ = new String(_loc4_.substr(0,_loc8_) + _loc11_ + _loc4_.substr(_loc8_ + _loc7_.length));
                        _loc8_ = _loc4_.search(_loc7_);
                        continue;
                     }
                  }
               }
               if(_loc5_[_loc5_.length - 1] != _loc4_.length - 1)
               {
                  if(isCharacterLetter(param1.charAt(_loc5_[_loc5_.length - 1] + 1)))
                  {
                     _loc10_ = false;
                     _loc20_ = 0;
                     while(_loc20_ < _loc5_.length)
                     {
                        if(_loc20_ + 1 != _loc5_.length)
                        {
                           if(_loc5_[_loc20_ + 1] - _loc5_[_loc20_] != 1)
                           {
                              if(_loc10_ == false)
                              {
                                 _loc10_ = true;
                              }
                              else
                              {
                                 _loc10_ = false;
                                 break;
                              }
                           }
                        }
                        _loc20_++;
                     }
                     if(_loc10_)
                     {
                        _loc11_ = "";
                        _loc21_ = 0;
                        while(_loc21_ < _loc7_.length)
                        {
                           _loc11_ = _loc11_ + SignificantCharacters.temporaryCensorCharacter;
                           _loc21_++;
                        }
                        _loc4_ = new String(_loc4_.substr(0,_loc8_) + _loc11_ + _loc4_.substr(_loc8_ + _loc7_.length));
                        _loc8_ = _loc4_.search(_loc7_);
                        continue;
                     }
                  }
               }
               _loc12_ = new String(_loc3_);
               _loc13_ = 0;
               while(_loc13_ < _loc5_.length)
               {
                  _loc12_ = _loc3_.substr(0,_loc5_[_loc13_]);
                  _loc12_ = _loc12_ + SignificantCharacters.temporaryCensorCharacter;
                  if(_loc5_[_loc13_] < param1.length - 1)
                  {
                     _loc12_ = _loc12_ + String(_loc3_.substring(_loc5_[_loc13_] + 1));
                  }
                  _loc3_ = _loc12_;
                  _loc13_++;
               }
               _loc4_ = filterNonLetterCharacters(param2 == null?_loc12_:convertSubstitutes(_loc12_));
               _loc4_ = _loc4_.toLowerCase();
               _loc8_ = _loc4_.search(_loc7_);
            }
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function isProfane(param1:String) : Boolean
      {
         var _loc2_:String = filterString(param1);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            if(param1.charCodeAt(_loc5_) == SignificantCharacters.censorCharacter.charCodeAt())
            {
               _loc3_++;
            }
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_.length)
         {
            if(_loc2_.charCodeAt(_loc6_) == SignificantCharacters.censorCharacter.charCodeAt())
            {
               _loc4_++;
            }
            _loc6_++;
         }
         return _loc3_ != _loc4_;
      }
      
      private static function filterNonLetterCharacters(param1:String, param2:Boolean = false) : String
      {
         var _loc5_:RegExp = null;
         var _loc3_:String = new String(param1);
         var _loc4_:int = 0;
         while(_loc4_ < SignificantCharacters.nonLetterCharacters.length)
         {
            if(!(param2 && SignificantCharacters.nonLetterCharacters[_loc4_] == " "))
            {
               _loc5_ = new RegExp(SignificantCharacters.nonLetterCharacters[_loc4_],"g");
               _loc3_ = _loc3_.replace(_loc5_,"");
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function markWhiteListedBadWords(param1:String, param2:Vector.<String>, param3:Vector.<int>) : String
      {
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc4_:String = new String(param1);
         var _loc5_:String = new String(param1.toLowerCase());
         var _loc6_:int = 0;
         while(_loc6_ < BlackList.list.length)
         {
            _loc7_ = BlackList.list[_loc6_];
            while(true)
            {
               _loc5_ = _loc4_.toLowerCase();
               _loc8_ = _loc5_.indexOf(_loc7_,_loc8_ + 1);
               if(_loc8_ == -1)
               {
                  break;
               }
               _loc9_ = getWord(_loc5_,_loc8_);
               _loc10_ = isInWhiteListAt(_loc7_,_loc9_);
               if(_loc10_ != -1)
               {
                  _loc11_ = new String(_loc4_.substr(0,_loc8_ - _loc10_));
                  _loc12_ = new String("");
                  _loc13_ = _loc8_ - _loc10_;
                  if(_loc13_ + _loc9_.length < _loc4_.length)
                  {
                     _loc12_ = _loc12_ + String(_loc4_.substring(_loc13_ + _loc9_.length));
                  }
                  _loc14_ = 0;
                  while(_loc14_ < _loc9_.length)
                  {
                     if(param1.charAt(_loc13_ + _loc14_).toLowerCase() == param1.charAt(_loc13_ + _loc14_))
                     {
                        _loc11_ = _loc11_ + SignificantCharacters.whitelistMarkCharacterLower;
                     }
                     else
                     {
                        _loc11_ = _loc11_ + SignificantCharacters.whitelistMarkCharacterUpper;
                     }
                     _loc14_++;
                  }
                  _loc4_ = _loc11_;
                  _loc4_ = _loc4_ + _loc12_;
                  param2.push(_loc9_);
                  param3.push(_loc13_);
               }
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      private static function restoreWhiteListMarks(param1:String, param2:Vector.<String>, param3:Vector.<int>) : String
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc4_:int = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param1.substr(0,param3[_loc4_]);
            _loc6_ = new String();
            _loc7_ = 0;
            while(_loc7_ < param2[_loc4_].length)
            {
               if(param1.charAt(_loc7_ + param3[_loc4_]) == SignificantCharacters.whitelistMarkCharacterUpper)
               {
                  _loc6_ = _loc6_ + param2[_loc4_].charAt(_loc6_.length).toUpperCase();
               }
               else
               {
                  _loc6_ = _loc6_ + param2[_loc4_].charAt(_loc6_.length).toLowerCase();
               }
               _loc7_++;
            }
            _loc8_ = param1.substr(param3[_loc4_] + param2[_loc4_].length);
            param1 = _loc5_ + _loc6_ + _loc8_;
            _loc4_++;
         }
         return param1;
      }
      
      private static function convertSubstitutes(param1:String) : String
      {
         var _loc2_:String = new String(param1);
         var _loc3_:int = 0;
         while(_loc3_ < SignificantCharacters.substituteCharacters.length)
         {
            _loc2_ = _loc2_.split(SignificantCharacters.substituteCharacters[_loc3_][0]).join(SignificantCharacters.substituteCharacters[_loc3_][1]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function isInWhiteList(param1:String, param2:String) : Boolean
      {
         var _loc3_:Array = WhiteList.badInGoodDic[param1];
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(param2 == _loc3_[_loc4_])
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private static function isInWhiteListAt(param1:String, param2:String) : int
      {
         var _loc3_:Array = WhiteList.badInGoodDic[param1];
         if(_loc3_ == null)
         {
            return -1;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(param2 == _loc3_[_loc4_])
            {
               return param2.search(param1);
            }
            _loc4_++;
         }
         return -1;
      }
      
      private static function isCharacterLetter(param1:String) : Boolean
      {
         return param1.toLowerCase().charCodeAt() >= "a".charCodeAt() && param1.toLowerCase().charCodeAt() <= "z".charCodeAt();
      }
      
      private static function getWord(param1:String, param2:int) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = -1;
         var _loc5_:String = new String(param1);
         while(true)
         {
            param1 = new String(filterNonLetterCharacters(param1,true));
            _loc3_ = param1.indexOf(" ",_loc4_ + 1);
            if(_loc3_ != -1)
            {
               if(_loc3_ > param2)
               {
                  return param1.substring(_loc4_ + 1,_loc3_);
               }
               _loc4_ = _loc3_;
               continue;
            }
            break;
         }
         if(_loc4_ == -1)
         {
            return param1;
         }
         return param1.substring(_loc4_ + 1,int.MAX_VALUE);
      }
   }
}
