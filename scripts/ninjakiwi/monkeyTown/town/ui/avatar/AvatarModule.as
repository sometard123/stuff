package ninjakiwi.monkeyTown.town.ui.avatar
{
   import assets.ui.AvatarModuleClip;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import ninjakiwi.monkeyTown.town.ui.AvatarLoader;
   import ninjakiwi.monkeyTown.town.ui.HonourDisplayModule;
   import ninjakiwi.monkeyTown.ui.UIConstants;
   
   public class AvatarModule extends AvatarModuleClip
   {
       
      
      private var _currentClanSymbol:MovieClip;
      
      private var _currentAvatar:AvatarLoader;
      
      private var _honourModule:HonourDisplayModule;
      
      public function AvatarModule(param1:DisplayObject)
      {
         super();
         param1.visible = false;
         this.x = param1.x;
         this.y = param1.y;
         this._honourModule = new HonourDisplayModule(this.honourSymbol,this.honourField);
      }
      
      public function syncPlayer(param1:String, param2:int, param3:String, param4:int) : void
      {
         this.setClanSymbol(param3);
         this.setLevel(param2);
         this.setAvatar(param1);
         this.setHonour(param4);
      }
      
      private function clearSymbol() : void
      {
         if(this._currentClanSymbol != null && this.contains(this._currentClanSymbol))
         {
            this.removeChild(this._currentClanSymbol);
         }
         this._currentClanSymbol = null;
      }
      
      private function setClanSymbol(param1:String) : void
      {
         this.clearSymbol();
         this._currentClanSymbol = UIConstants.getClanIconSmall(param1);
         this._currentClanSymbol.x = this.clanContainer.x;
         this._currentClanSymbol.y = this.clanContainer.y;
         this.addChild(this._currentClanSymbol);
      }
      
      private function setLevel(param1:int) : void
      {
         this.levelField.text = String(param1);
      }
      
      private function setHonour(param1:int) : void
      {
         this._honourModule.setHonour(param1);
      }
      
      private function clearAvatar() : void
      {
         if(this._currentAvatar != null && this.avatarContainer.container.contains(this._currentAvatar))
         {
            this.avatarContainer.container.removeChild(this._currentAvatar);
         }
         this._currentAvatar = null;
      }
      
      private function setAvatar(param1:String) : void
      {
         this.clearAvatar();
         if(this._currentAvatar != null)
         {
            if(this.avatarContainer.container.contains(this._currentAvatar))
            {
               this.avatarContainer.container.removeChild(this._currentAvatar);
            }
            this._currentAvatar.clear();
         }
         this._currentAvatar = new AvatarLoader(param1);
         this.avatarContainer.container.addChild(this._currentAvatar);
      }
   }
}
