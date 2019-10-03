package ninjakiwi.monkeyTown.net.kloud
{
   import flash.net.SharedObject;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.analytics.AnalyticsUtil;
   import ninjakiwi.monkeyTown.common.Constants;
   import ninjakiwi.monkeyTown.data.KeyValueStore;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.display.tileSystem.persistence.TileSaveDefinition;
   import ninjakiwi.monkeyTown.net.Squeeze;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.city.CityInfoSaveDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.CityResourcesSaveDefinition;
   import ninjakiwi.monkeyTown.town.data.definitions.ResourceStoreSaveDefinition;
   import ninjakiwi.monkeyTown.town.terrainGenerator.WorldSeed;
   import ninjakiwi.net.WebAction;
   import org.osflash.signals.Signal;
   
   public class Kloud
   {
      
      public static const loadCoreDataBeginSignal:Signal = new Signal();
      
      private static const _system:MonkeySystem = MonkeySystem.getInstance();
      
      private static const _previousCityInfo:CityInfoSaveDefinition = new CityInfoSaveDefinition();
      
      private static var lockLSO:Boolean = false;
       
      
      public function Kloud()
      {
         super();
      }
      
      public static function get userID() : String
      {
         if(_system.nkGatewayUser == null || _system.nkGatewayUser.loginInfo == null)
         {
            Main.instance.unLockReturnToHomeScreen();
            Main.instance.returnToHomeScreen();
            return "";
         }
         return _system.nkGatewayUser.loginInfo.id;
      }
      
      public static function shakeHandsWithServer(param1:Function) : void
      {
         var callback:Function = param1;
         if(_system.nkGatewayUser === null)
         {
            Main.instance.unLockReturnToHomeScreen();
            Main.instance.returnToHomeScreen();
            return;
         }
         var webAction:WebAction = WebAction.getActionFor("getHandshake");
         var restURL:String = Constants.KLOUD_HOST + userID + "/handshake";
         WebAction.authenticate(_system.nkGatewayUser.loginInfo.token);
         webAction.load(restURL,function(param1:Object):void
         {
            if(param1.success)
            {
               WebAction.initialiseSession(param1.sid,param1.sessionID,param1.nkApiID);
               callback(param1);
            }
            else
            {
               t.obj(param1);
            }
         });
      }
      
      public static function checkStatus(param1:Function) : void
      {
         var callback:Function = param1;
         if(_system.nkGatewayUser === null)
         {
            Main.instance.unLockReturnToHomeScreen();
            Main.instance.returnToHomeScreen();
            return;
         }
         var webAction:WebAction = WebAction.getActionFor("statusCheck");
         var restURL:String = Constants.KLOUD_HOST + userID + "/status";
         WebAction.authenticate(_system.nkGatewayUser.loginInfo.token);
         webAction.load(restURL,function(param1:Object):void
         {
            callback(param1);
         });
      }
      
      public static function saveNewCity(param1:CityInfoSaveDefinition, param2:WorldSeed, param3:String, param4:Vector.<TileSaveDefinition>, param5:Object, param6:CityResourcesSaveDefinition, param7:Object, param8:Function = null) : void
      {
         var tileSaveDef:TileSaveDefinition = null;
         var cityInfo:CityInfoSaveDefinition = param1;
         var worldSeed:WorldSeed = param2;
         var terrainData:String = param3;
         var tilesSaveDefinitions:Vector.<TileSaveDefinition> = param4;
         var upgradeTreeSaveData:Object = param5;
         var cityResources:CityResourcesSaveDefinition = param6;
         var questData:Object = param7;
         var callback:Function = param8;
         var restURL:String = Constants.KLOUD_HOST + userID + "/cities/";
         var cityIndex:int = cityInfo.cityIndex;
         var compressedTiles:Array = [];
         var i:int = 0;
         while(i < tilesSaveDefinitions.length)
         {
            tileSaveDef = tilesSaveDefinitions[i];
            compressedTiles[i] = {
               "x":tileSaveDef.x,
               "y":tileSaveDef.y,
               "tileData":Squeeze.serialiseAndCompress(tileSaveDef)
            };
            i++;
         }
         var savePayload:Object = {
            "userName":_system.userName,
            "userClan":_system.nkGatewayUser.profileData.clan,
            "cityName":cityInfo.name,
            "cityLevel":1,
            "cityIndex":cityIndex,
            "cityInfo":{
               "cityIndex":cityInfo.cityIndex,
               "cityLevel":cityInfo.cityLevel,
               "name":cityInfo.name,
               "xp":cityInfo.xp,
               "xpDebt":cityInfo.xpDebt
            },
            "worldSeed":Squeeze.serialiseAndCompress(worldSeed),
            "terrainData":terrainData,
            "upgradeTree":Squeeze.serialiseAndCompress(upgradeTreeSaveData),
            "tiles":compressedTiles,
            "cityResources":Squeeze.serialiseAndCompress(cityResources),
            "quests":Squeeze.serialiseAndCompress(questData),
            "cityStats":null,
            "v":4
         };
         var webAction:WebAction = WebAction.getActionFor("city" + cityIndex);
         webAction.save(restURL,savePayload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
         _previousCityInfo.copy(cityInfo);
      }
      
      public static function loadCity(param1:int, param2:Function) : void
      {
         var i:int = 0;
         var cityIndex:int = param1;
         var callback:Function = param2;
         var webAction:WebAction = WebAction.getActionFor("city" + cityIndex);
         var restURL:String = Constants.KLOUD_HOST + userID + "/cities/" + cityIndex;
         var payload:Object = {"time":0};
         webAction.loadWithPayload(restURL,payload,function(param1:Object):void
         {
            var cityData:Object = null;
            var cityInfoSaveDefinition:CityInfoSaveDefinition = null;
            var oldResources:ResourceStoreSaveDefinition = null;
            var converted:CityResourcesSaveDefinition = null;
            var length:int = 0;
            var tileDataObject:Object = null;
            var response:Object = param1;
            if(response.success)
            {
               cityData = response.cityInfo;
               cityInfoSaveDefinition = new CityInfoSaveDefinition();
               cityInfoSaveDefinition.cityIndex = response.cityInfo.index;
               cityInfoSaveDefinition.cityLevel = response.cityInfo.level;
               cityInfoSaveDefinition.name = response.cityInfo.cityName;
               cityInfoSaveDefinition.xp = response.cityInfo.xp;
               cityInfoSaveDefinition.xpDebt = response.cityInfo.xpDebt;
               cityInfoSaveDefinition.honour = response.cityInfo.honour;
               response.cityInfo = cityInfoSaveDefinition;
               _previousCityInfo.copy(cityInfoSaveDefinition);
               if(response.content.cityResources)
               {
                  response.content.cityResources = Squeeze.derialiseAndDecompress(response.content.cityResources);
                  if(response.content.cityResources is ResourceStoreSaveDefinition)
                  {
                     oldResources = response.content.cityResources;
                     converted = new CityResourcesSaveDefinition();
                     converted.bloontonium = oldResources.bloontonium;
                     converted.monkeyMoney = oldResources.monkeyMoney;
                     converted.maxCashPillage = oldResources.maxCashPillage;
                     response.content.cityResources = converted;
                  }
               }
               else
               {
                  response.content.cityResources = null;
               }
               response.content.quests = Squeeze.derialiseAndDecompress(response.content.quests);
               response.content.cityStats = Squeeze.derialiseAndDecompress(response.content.cityStats);
               response.content.worldSeed = Squeeze.derialiseAndDecompress(response.content.worldSeed);
               response.content.upgradeTree = Squeeze.derialiseAndDecompress(response.content.upgradeTree);
               try
               {
                  length = response.content.tiles.length;
                  i = 0;
                  while(i < length)
                  {
                     tileDataObject = response.content.tiles[i];
                     tileDataObject.tile = Squeeze.derialiseAndDecompress(tileDataObject.tileData);
                     if(!tileDataObject.hasOwnProperty("saveTime"))
                     {
                        tileDataObject.saveTime = 0;
                     }
                     i++;
                  }
                  response.content.tiles = removeDuplicatedTiles(response.content.tiles);
               }
               catch(e:Error)
               {
                  response = {
                     "success":false,
                     "message":"Failed to decode tiles",
                     "error":e
                  };
               }
            }
            if(callback !== null)
            {
               callback(response);
            }
         });
      }
      
      private static function removeDuplicatedTiles(param1:Array) : Array
      {
         var _loc2_:TileSaveDefinition = null;
         var _loc3_:TileSaveDefinition = null;
         var _loc4_:TileSaveDefinition = null;
         var _loc8_:int = 0;
         var _loc5_:Array = [];
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         while(_loc7_ < param1.length)
         {
            if(!param1[_loc7_].hasOwnProperty("noNotConsider"))
            {
               _loc2_ = param1[_loc7_].tile;
               _loc3_ = _loc2_;
               _loc8_ = _loc7_ + 1;
               while(_loc8_ < param1.length)
               {
                  if(!param1[_loc8_].hasOwnProperty("noNotConsider"))
                  {
                     _loc4_ = param1[_loc8_].tile;
                     if(_loc2_.x === _loc4_.x && _loc2_.y === _loc4_.y)
                     {
                        if(param1[_loc8_].saveTime > param1[_loc7_].saveTime)
                        {
                           _loc3_ = _loc4_;
                        }
                        param1[_loc8_].noNotConsider = 1;
                        _loc6_ = true;
                     }
                  }
                  _loc8_++;
               }
               _loc5_.push(_loc3_);
            }
            _loc7_++;
         }
         if(_loc6_)
         {
            AnalyticsUtil.track("duplicate_tiles_found");
         }
         return _loc5_;
      }
      
      public static function saveCityInfo(param1:CityInfoSaveDefinition, param2:Function) : void
      {
         var cityInfo:CityInfoSaveDefinition = param1;
         var callback:Function = param2;
         var webAction:WebAction = WebAction.getActionFor("saveCityInfo" + cityInfo.cityIndex);
         var restURL:String = Constants.KLOUD_HOST + userID + "/cities/" + cityInfo.cityIndex + "/info";
         var cityInfoChange:Object = {};
         if(cityInfo.cityLevel > _previousCityInfo.cityLevel)
         {
            cityInfoChange.cityLevel = cityInfo.cityLevel - _previousCityInfo.cityLevel;
         }
         if(cityInfo.xp > _previousCityInfo.xp)
         {
            cityInfoChange.xp = cityInfo.xp - _previousCityInfo.xp;
         }
         if(cityInfo.xpDebt !== _previousCityInfo.xpDebt)
         {
            cityInfoChange.xpDebt = cityInfo.xpDebt - _previousCityInfo.xpDebt;
         }
         if(cityInfo.honour !== _previousCityInfo.honour)
         {
            cityInfoChange.honour = cityInfo.honour - _previousCityInfo.honour;
         }
         var savePayload:Object = {
            "cityName":cityInfo.name,
            "cityLevel":cityInfo.cityLevel,
            "cityInfoChange":cityInfoChange,
            "v":3
         };
         webAction.save(restURL,savePayload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
         _previousCityInfo.copy(cityInfo);
      }
      
      public static function loadCityList(param1:Function) : void
      {
         var callback:Function = param1;
         var restURL:String = Constants.KLOUD_HOST + userID + "/cities/list";
         var webAction:WebAction = WebAction.getActionFor(userID + "getCityList");
         webAction.load(restURL,function(param1:Object):void
         {
            param1.cityList.sortOn("index",Array.NUMERIC);
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function loadCoreData(param1:Function) : void
      {
         var callback:Function = param1;
         var restURL:String = Constants.KLOUD_HOST + userID + "/core";
         var webAction:WebAction = WebAction.getActionFor(userID + "_core");
         webAction.load(restURL,function(param1:Object):void
         {
            var coreObject:Object = null;
            var keysRequiringResave:Object = null;
            var key:String = null;
            var encoded:* = undefined;
            var encodedValue:* = undefined;
            var requiresDecoding:Boolean = false;
            var response:Object = param1;
            coreObject = !!response[CoreDataPersistence.CORE_KEY]?response[CoreDataPersistence.CORE_KEY]:null;
            if(coreObject)
            {
               if(coreObject[CoreDataPersistence.RESOURCES_KEY])
               {
                  coreObject[CoreDataPersistence.RESOURCES_KEY] = Squeeze.derialiseAndDecompress(coreObject[CoreDataPersistence.RESOURCES_KEY]);
               }
               else
               {
                  coreObject[CoreDataPersistence.RESOURCES_KEY] = null;
               }
               if(coreObject[CoreDataPersistence.SPECIAL_ITEMS_KEY])
               {
                  coreObject[CoreDataPersistence.SPECIAL_ITEMS_KEY] = Squeeze.derialiseAndDecompress(coreObject[CoreDataPersistence.SPECIAL_ITEMS_KEY]);
               }
               else
               {
                  coreObject[CoreDataPersistence.SPECIAL_ITEMS_KEY] = null;
               }
               if(coreObject[CoreDataPersistence.TUTORIAL_KEY])
               {
                  coreObject[CoreDataPersistence.TUTORIAL_KEY] = Squeeze.derialiseAndDecompress(coreObject[CoreDataPersistence.TUTORIAL_KEY]);
               }
               else
               {
                  coreObject[CoreDataPersistence.TUTORIAL_KEY] = null;
               }
               if(coreObject[CoreDataPersistence.PREFERENCES_KEY])
               {
                  coreObject[CoreDataPersistence.PREFERENCES_KEY] = Squeeze.derialiseAndDecompress(coreObject[CoreDataPersistence.PREFERENCES_KEY]);
               }
               else
               {
                  coreObject[CoreDataPersistence.PREFERENCES_KEY] = null;
               }
               if(coreObject[CoreDataPersistence.STATS_KEY])
               {
                  if(!(coreObject[CoreDataPersistence.STATS_KEY] is String))
                  {
                     setTimeout(function():void
                     {
                        CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.STATS_KEY,coreObject[CoreDataPersistence.STATS_KEY]);
                     },1000);
                  }
                  else
                  {
                     coreObject[CoreDataPersistence.STATS_KEY] = Squeeze.derialiseAndDecompress(coreObject[CoreDataPersistence.STATS_KEY]);
                  }
               }
               else
               {
                  coreObject[CoreDataPersistence.STATS_KEY] = null;
               }
            }
            keysRequiringResave = {};
            var resaveRequired:Boolean = false;
            var monkeyKnowledgeObject:Object = !!response.hasOwnProperty(CoreDataPersistence.MONKEY_KNOWLEDGE_KEY)?response[CoreDataPersistence.MONKEY_KNOWLEDGE_KEY]:null;
            if(monkeyKnowledgeObject)
            {
               for(key in monkeyKnowledgeObject)
               {
                  encoded = monkeyKnowledgeObject[key];
                  if(encoded == "")
                  {
                     delete monkeyKnowledgeObject[key];
                  }
                  else
                  {
                     encodedValue = monkeyKnowledgeObject[key];
                     requiresDecoding = true;
                     if(!(encodedValue is String) && encodedValue.hasOwnProperty("points"))
                     {
                        requiresDecoding = false;
                        resaveRequired = true;
                        keysRequiringResave[key] = encodedValue;
                     }
                     if(requiresDecoding)
                     {
                        monkeyKnowledgeObject[key] = Squeeze.derialiseAndDecompress(encodedValue);
                     }
                     if(monkeyKnowledgeObject[key] == null)
                     {
                        delete monkeyKnowledgeObject[key];
                     }
                  }
               }
            }
            else
            {
               response[CoreDataPersistence.MONKEY_KNOWLEDGE_KEY] = null;
            }
            if(resaveRequired)
            {
               setTimeout(function():void
               {
                  CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.MONKEY_KNOWLEDGE_KEY,keysRequiringResave);
               },1000);
            }
            var dataStoreObject:Object = !!coreObject.hasOwnProperty(CoreDataPersistence.DATA_STORE_KEY)?coreObject[CoreDataPersistence.DATA_STORE_KEY]:null;
            if(dataStoreObject)
            {
               KeyValueStore.getInstance().initData(Squeeze.derialiseAndDecompress(dataStoreObject as String));
            }
            else
            {
               KeyValueStore.getInstance().initData({});
            }
            if(callback !== null)
            {
               callback(response);
            }
         });
      }
      
      public static function saveCore(param1:Object, param2:Function) : void
      {
         var _loc6_:Object = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = Constants.KLOUD_HOST + userID + "/core/save";
         var _loc4_:Object = {};
         if(param1.hasOwnProperty(CoreDataPersistence.CORE_KEY))
         {
            _loc4_[CoreDataPersistence.CORE_KEY] = {};
            _loc6_ = param1[CoreDataPersistence.CORE_KEY];
            for(_loc7_ in _loc6_)
            {
               _loc4_[CoreDataPersistence.CORE_KEY][_loc7_] = Squeeze.serialiseAndCompress(_loc6_[_loc7_]);
            }
         }
         if(param1.hasOwnProperty(CoreDataPersistence.MONKEY_KNOWLEDGE_KEY))
         {
            _loc4_[CoreDataPersistence.MONKEY_KNOWLEDGE_KEY] = {};
            for(_loc8_ in param1[CoreDataPersistence.MONKEY_KNOWLEDGE_KEY])
            {
               _loc4_[CoreDataPersistence.MONKEY_KNOWLEDGE_KEY][_loc8_] = Squeeze.serialiseAndCompress(param1[CoreDataPersistence.MONKEY_KNOWLEDGE_KEY][_loc8_]);
            }
         }
         if(param1.hasOwnProperty(CoreDataPersistence.CRATES_KEY))
         {
            _loc4_[CoreDataPersistence.CRATES_KEY] = {};
            _loc4_[CoreDataPersistence.CRATES_KEY] = param1[CoreDataPersistence.CRATES_KEY];
         }
         var _loc5_:WebAction = WebAction.getActionFor("saveCore");
         _loc5_.save(_loc3_,_loc4_,param2);
      }
      
      public static function saveContent(param1:Object, param2:Function) : void
      {
         var _loc7_:Object = null;
         var _loc8_:* = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:Tile = null;
         var _loc13_:TileSaveDefinition = null;
         var _loc14_:String = null;
         var _loc3_:Object = {};
         if(param1.hasOwnProperty(CityDataPersistence.CONTENT_KEY))
         {
            _loc3_[CityDataPersistence.CONTENT_KEY] = {};
            _loc7_ = param1[CityDataPersistence.CONTENT_KEY];
            for(_loc8_ in _loc7_)
            {
               if(CityDataPersistence.TERRAIN_DATA_KEY == _loc8_)
               {
                  _loc3_[CityDataPersistence.CONTENT_KEY][_loc8_] = _loc7_[_loc8_];
               }
               else
               {
                  _loc3_[CityDataPersistence.CONTENT_KEY][_loc8_] = Squeeze.serialiseAndCompress(_loc7_[_loc8_]);
               }
            }
         }
         if(param1.hasOwnProperty(CityDataPersistence.TILES_KEY))
         {
            _loc3_[CityDataPersistence.TILES_KEY] = {};
            _loc9_ = param1[CityDataPersistence.TILES_KEY];
            _loc10_ = [];
            _loc11_ = 0;
            while(_loc11_ < _loc9_.length)
            {
               _loc12_ = _loc9_[_loc11_] as Tile;
               _loc13_ = _loc12_.getSaveDefinition();
               _loc14_ = Squeeze.serialiseAndCompress(_loc13_);
               _loc10_[_loc11_] = {
                  "x":_loc13_.x,
                  "y":_loc13_.y,
                  "tileData":Squeeze.serialiseAndCompress(_loc13_)
               };
               _loc11_++;
            }
            _loc3_[CityDataPersistence.TILES_KEY] = _loc10_;
         }
         var _loc4_:int = _system.city.cityIndex;
         var _loc5_:* = Constants.KLOUD_HOST + userID + "/cities/" + _loc4_ + "/content";
         var _loc6_:WebAction = WebAction.getActionFor("saveContent");
         _loc6_.save(_loc5_,_loc3_,param2);
      }
      
      public static function saveKeyValueStore(param1:Object, param2:Function) : void
      {
         CoreDataPersistence.getInstance().saveValue(CoreDataPersistence.DATA_STORE_KEY,param1);
      }
      
      public static function deleteAllDataForUser() : void
      {
         shakeHandsWithServer(function(param1:Object):void
         {
            var webAction:WebAction = null;
            var restURL:String = null;
            var response:Object = param1;
            if(response.success)
            {
               webAction = WebAction.getActionFor("deleteAllDataForUser");
               restURL = Constants.KLOUD_HOST + userID;
               webAction.remove(restURL,function(param1:Object):void
               {
               });
            }
         });
      }
      
      public static function updateServerTimestamp(param1:int, param2:Function = null) : void
      {
         var cityIndex:int = param1;
         var callback:Function = param2;
         var restURL:String = Constants.KLOUD_HOST + userID + "/pvp/" + cityIndex + "/timestamp";
         var webAction:WebAction = WebAction.getActionFor("timestamp");
         webAction.save(restURL,null,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback();
            }
         });
      }
      
      public static function loadFullFriendsList(param1:Function = null) : void
      {
         var callback:Function = param1;
         var friendsLoader:FriendsListLoader = new FriendsListLoader(userID,function loadFullFriendsListCallback(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function loadDataForFriendGroup(param1:Array, param2:Function) : void
      {
         var friendIDs:Array = param1;
         var callback:Function = param2;
         var webAction:WebAction = new WebAction();
         var restURL:String = Constants.KLOUD_HOST + userID + "/pvp/" + _system.city.cityIndex + "/friends";
         if(friendIDs.length === 0)
         {
            callback({
               "success":true,
               "friendIDs":friendIDs,
               "friends":[]
            });
            return;
         }
         webAction.loadWithPayload(restURL,{"friends":friendIDs},function(param1:Object):void
         {
            var _loc2_:int = 0;
            var _loc3_:Object = null;
            if(callback !== null)
            {
               _loc2_ = 0;
               while(_loc2_ < param1.friends.length)
               {
                  _loc3_ = param1.friends[_loc2_];
                  _loc3_.cities.sortOn("cityIndex",Array.NUMERIC);
                  _loc2_++;
               }
               param1["friendIDs"] = friendIDs;
               callback(param1);
            }
         });
      }
      
      public static function requestCrates(param1:Array, param2:Function = null) : void
      {
         var userIDs:Array = param1;
         var callback:Function = param2;
         var restURL:String = Constants.KLOUD_HOST + userID + "/crate/request";
         var webAction:WebAction = new WebAction();
         var payload:Object = {"userIDs":userIDs};
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function sendCrates(param1:Array, param2:Function = null) : void
      {
         var userIDs:Array = param1;
         var callback:Function = param2;
         if(userIDs.length === 0)
         {
            return;
         }
         var restURL:String = Constants.KLOUD_HOST + userID + "/crate/send";
         var webAction:WebAction = new WebAction();
         var payload:Object = {
            "senderName":MonkeySystem.getInstance().userName,
            "userIDs":userIDs
         };
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function useCrate(param1:Function = null) : void
      {
         var callback:Function = param1;
         var restURL:String = Constants.KLOUD_HOST + userID + "/crate";
         var webAction:WebAction = new WebAction();
         webAction.save(restURL,null,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function loadCrates(param1:Function = null) : void
      {
         var callback:Function = param1;
         var restURL:String = Constants.KLOUD_HOST + userID + "/crate";
         var webAction:WebAction = new WebAction();
         webAction.load(restURL,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function buyMoreCrateSends(param1:Function = null) : void
      {
         var callback:Function = param1;
         var restURL:String = Constants.KLOUD_HOST + userID + "/crate/buy/sends";
         var webAction:WebAction = new WebAction();
         webAction.save(restURL,null,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function sendSelfCrates(param1:int, param2:Function = null) : void
      {
         var amount:int = param1;
         var callback:Function = param2;
         var restURL:String = Constants.KLOUD_HOST + userID + "/crate/bonus";
         var payload:Object = {
            "senderName":MonkeySystem.getInstance().userName,
            "amount":amount
         };
         var webAction:WebAction = new WebAction();
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function joinContestedTerritory(param1:int, param2:String, param3:String, param4:Object, param5:Function = null) : void
      {
         var cityLevel:int = param1;
         var userName:String = param2;
         var cityName:String = param3;
         var data:Object = param4;
         var callback:Function = param5;
         var restURL:String = Constants.KLOUD_HOST + userID + "/contest/" + _system.city.cityIndex + "/join";
         var webAction:WebAction = WebAction.getActionFor("joinContested");
         var payload:Object = {
            "cityLevel":cityLevel,
            "userName":userName,
            "cityName":cityName,
            "data":Squeeze.serialiseAndCompress(data)
         };
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function loadContestedTerritory(param1:Number, param2:Function = null) : void
      {
         var timestamp:Number = param1;
         var callback:Function = param2;
         var restURL:String = Constants.KLOUD_HOST + userID + "/contest/" + _system.city.cityIndex;
         var webAction:WebAction = WebAction.getActionFor("loadContested");
         var payload:Object = {"time":timestamp};
         webAction.loadWithPayload(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function saveScoreContestedTerritory(param1:int, param2:String, param3:Number, param4:Number, param5:Boolean = false, param6:int = -1, param7:Function = null) : void
      {
         var payload:Object = null;
         var newScore:int = param1;
         var roomID:String = param2;
         var lootTimeOffset:Number = param3;
         var timestamp:Number = param4;
         var isPersonalBest:Boolean = param5;
         var cityLevel:int = param6;
         var callback:Function = param7;
         var restURL:String = Constants.KLOUD_HOST + userID + "/contest/" + _system.city.cityIndex + "/score/" + roomID;
         var webAction:WebAction = WebAction.getActionFor("saveContested");
         payload = {
            "score":newScore,
            "lootTimeOffset":lootTimeOffset,
            "time":timestamp,
            "isPersonalBest":isPersonalBest
         };
         if(cityLevel != -1)
         {
            payload["cityLevel"] = cityLevel;
         }
         webAction.save(restURL,payload,function(param1:Object):void
         {
            param1.id = newScore;
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function collectLootContestedTerritory(param1:Number, param2:String, param3:Function = null) : void
      {
         var lootTime:Number = param1;
         var roomID:String = param2;
         var callback:Function = param3;
         var restURL:String = Constants.KLOUD_HOST + userID + "/contest/" + _system.city.cityIndex + "/loot/" + roomID;
         var webAction:WebAction = WebAction.getActionFor("lootContested");
         var payload:Object = {
            "time":0,
            "lootTime":lootTime
         };
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function loadHistoryContestedTerritory(param1:Function = null) : void
      {
         var restURL:String = null;
         var webAction:WebAction = null;
         var callback:Function = param1;
         restURL = Constants.KLOUD_HOST + userID + "/contest/" + _system.city.cityIndex + "/history";
         webAction = WebAction.getActionFor("loadContestedHistory");
         webAction.load(restURL,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1,{
                  "url":restURL,
                  "sid":webAction.sid,
                  "userID":userID,
                  "cityIndex":_system.city.cityIndex
               });
            }
         });
      }
      
      public static function updateContestedTerritory(param1:String, param2:Number, param3:Function = null) : void
      {
         var roomID:String = param1;
         var timestamp:Number = param2;
         var callback:Function = param3;
         var restURL:String = Constants.KLOUD_HOST + userID + "/contest/" + _system.city.cityIndex + "/score/" + roomID;
         var webAction:WebAction = WebAction.getActionFor("loadContestedScore");
         var payload:Object = {"time":timestamp};
         webAction.loadWithPayload(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function claimEndOfWeekRewardContestedTerritory(param1:String, param2:Number, param3:Function = null) : void
      {
         var roomID:String = param1;
         var timestamp:Number = param2;
         var callback:Function = param3;
         var restURL:String = Constants.KLOUD_HOST + userID + "/contest/" + _system.city.cityIndex + "/history/" + roomID + "/claim";
         var webAction:WebAction = WebAction.getActionFor("claimContestedTerritoryEndOfWeekLoot");
         webAction.load(restURL,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function closeRoomContestedTerritory(param1:String, param2:Boolean, param3:Function = null) : void
      {
         var roomID:String = param1;
         var isLegacyRoom:Boolean = param2;
         var callback:Function = param3;
         var restURL:String = Constants.KLOUD_HOST + userID + "/contest/" + _system.city.cityIndex + "/history/" + roomID + "/close";
         var webAction:WebAction = WebAction.getActionFor("closeContestedTerritoryRoom");
         var payload:Object = {"isLegacyRoom":isLegacyRoom};
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
      
      public static function loadCookie(param1:String, param2:Function = null) : SharedObject
      {
         lockLSO = true;
         var _loc3_:SharedObject = SharedObject.getLocal(param1);
         lockLSO = false;
         if(param2 !== null)
         {
            param2(_loc3_);
         }
         return _loc3_;
      }
      
      public static function saveCookie(param1:String, param2:Vector.<String>, param3:Vector.<int>) : Boolean
      {
         if(lockLSO)
         {
            return false;
         }
         var _loc4_:SharedObject = SharedObject.getLocal(param1);
         var _loc5_:int = 0;
         while(_loc5_ < param2.length && _loc5_ < param3.length)
         {
            _loc4_.data[param2[_loc5_]] = param3[_loc5_];
            _loc5_++;
         }
         _loc4_.flush();
         return true;
      }
      
      public static function saveCookieFromObjects(param1:String, param2:Vector.<String>, param3:Vector.<Object>) : Boolean
      {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         if(lockLSO)
         {
            return false;
         }
         var _loc4_:SharedObject = SharedObject.getLocal(param1);
         var _loc5_:int = 0;
         while(_loc5_ < param2.length && _loc5_ < param3.length)
         {
            _loc6_ = param2[_loc5_];
            _loc7_ = param3[_loc5_];
            _loc4_.data[_loc6_] = _loc7_;
            _loc5_++;
         }
         _loc4_.flush();
         return true;
      }
      
      public static function saveMonkeyKnowledgeKeys(param1:Object, param2:Function = null) : void
      {
         var key:String = null;
         var restURL:String = null;
         var webAction:WebAction = null;
         var payload:Object = null;
         var data:Object = param1;
         var callback:Function = param2;
         for(key in data)
         {
            data[key] = Squeeze.serialiseAndCompress(data[key]);
         }
         restURL = Constants.KLOUD_HOST + userID + "/knowledge";
         webAction = new WebAction();
         payload = data;
         webAction.save(restURL,payload,function(param1:Object):void
         {
            if(callback !== null)
            {
               callback(param1);
            }
         });
      }
   }
}
