package ninjakiwi.monkeyTown.town.ui.terrain
{
   import assets.ui.TerrainRestrictionsDetail;
   import ninjakiwi.monkeyTown.data.TerrainTowerRestrictionsData;
   import ninjakiwi.monkeyTown.display.tileSystem.Tile;
   import ninjakiwi.monkeyTown.town.data.definitions.PopulationDefinition;
   import ninjakiwi.monkeyTown.utils.ErrorReporter;
   
   public class TerrainRestrictionModule
   {
       
      
      private var _linkedClip:TerrainRestrictionsDetail;
      
      private const _restrictedList:Vector.<TerrainRestrictionTowerIcon> = new Vector.<TerrainRestrictionTowerIcon>();
      
      private const _favoredList:Vector.<TerrainRestrictionTowerIcon> = new Vector.<TerrainRestrictionTowerIcon>();
      
      public function TerrainRestrictionModule(param1:TerrainRestrictionsDetail)
      {
         super();
         this._linkedClip = param1;
         this._restrictedList.push(new TerrainRestrictionTowerIcon(this._linkedClip.restrictedTower1));
         this._restrictedList.push(new TerrainRestrictionTowerIcon(this._linkedClip.restrictedTower2));
         this._restrictedList.push(new TerrainRestrictionTowerIcon(this._linkedClip.restrictedTower3));
         this._restrictedList.push(new TerrainRestrictionTowerIcon(this._linkedClip.restrictedTower4));
         this._favoredList.push(new TerrainRestrictionTowerIcon(this._linkedClip.favoredTower1));
         this._favoredList.push(new TerrainRestrictionTowerIcon(this._linkedClip.favoredTower2));
         this._favoredList.push(new TerrainRestrictionTowerIcon(this._linkedClip.favoredTower3));
         this._favoredList.push(new TerrainRestrictionTowerIcon(this._linkedClip.favoredTower4));
         this._linkedClip.noneRestricted.visible = false;
         this._linkedClip.noneFavored.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:TerrainRestrictionTowerIcon = null;
         for each(_loc1_ in this._restrictedList)
         {
            _loc1_.destroy();
         }
         for each(_loc1_ in this._favoredList)
         {
            _loc1_.destroy();
         }
         this._linkedClip = null;
      }
      
      public function syncTerrainRestrictions(param1:Tile) : void
      {
         this.syncTerrainRestrictionsWithType(param1.type);
      }
      
      public function syncTerrainRestrictionsWithType(param1:String) : void
      {
         var i:int = 0;
         var type:String = param1;
         var report:Object = TerrainTowerRestrictionsData.getTowerTerrainReport(type);
         var restricted:Vector.<String> = new Vector.<String>();
         var favored:Vector.<String> = new Vector.<String>();
         if(report.restricted != null)
         {
            try
            {
               if((report.restricted as Array).length > 0)
               {
                  this._linkedClip.noneRestricted.visible = false;
                  i = 0;
                  while(i < (report.restricted as Array).length)
                  {
                     restricted.push((report.restricted[i] as PopulationDefinition).id);
                     i++;
                  }
               }
               else
               {
                  this._linkedClip.noneRestricted.visible = true;
               }
            }
            catch(e:Error)
            {
               ErrorReporter.error("TerrainRestrictionModule::syncTerrainRestrictions() - report type is wrong");
            }
         }
         else
         {
            this._linkedClip.noneRestricted.visible = true;
         }
         if(report.favored != null)
         {
            try
            {
               if((report.favored as Array).length > 0)
               {
                  this._linkedClip.noneFavored.visible = false;
                  i = 0;
                  while(i < (report.favored as Array).length)
                  {
                     favored.push((report.favored[i] as PopulationDefinition).id);
                     i++;
                  }
               }
               else
               {
                  this._linkedClip.noneFavored.visible = true;
               }
            }
            catch(e:Error)
            {
               ErrorReporter.error("TerrainRestrictionModule::syncTerrainRestrictions() - report type is wrong");
            }
         }
         else
         {
            this._linkedClip.noneFavored.visible = true;
         }
         this.setIconGroup(restricted,this._restrictedList);
         this.setIconGroup(favored,this._favoredList);
      }
      
      private function setIconGroup(param1:Vector.<String>, param2:Vector.<TerrainRestrictionTowerIcon>) : void
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            if(_loc5_ < param2.length)
            {
               param2[_loc4_].setIcon(param1[_loc5_]);
               _loc4_++;
            }
            _loc5_++;
         }
         var _loc6_:int = _loc4_;
         while(_loc6_ < param2.length)
         {
            param2[_loc6_].setIcon(null);
            _loc6_++;
         }
      }
   }
}
