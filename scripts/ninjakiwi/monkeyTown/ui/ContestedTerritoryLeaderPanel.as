package ninjakiwi.monkeyTown.ui
{
   import assets.btdmodule.ContestedTerritoryLeaderPanelClip;
   import com.lgrey.utils.LGDisplayListUtil;
   import flash.display.DisplayObjectContainer;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class ContestedTerritoryLeaderPanel extends HideRevealView
   {
       
      
      private var _clip:ContestedTerritoryLeaderPanelClip;
      
      private var _okButton:ButtonControllerBase;
      
      public function ContestedTerritoryLeaderPanel(param1:DisplayObjectContainer, param2:* = null)
      {
         this._clip = new ContestedTerritoryLeaderPanelClip();
         this._okButton = new ButtonControllerBase(this._clip.okButton);
         super(param1,param2);
         addChild(this._clip);
         isModal = true;
         enableDefaultOnResize(this._clip);
         LGDisplayListUtil.getInstance().setPlayStateOfAllChildMovieClips(this,false,true,true);
         this._okButton.setClickFunction(this.hide);
         this.hide();
      }
      
      public function updateInfo(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            this._clip.winDescriptionTxt.text = LocalisationConstants.CONTEST_LEADER_CANCELLED.split("<round>").join(param1);
         }
         else
         {
            this._clip.winDescriptionTxt.text = LocalisationConstants.CONTEST_LEADER_RAN_OUT.split("<round>").join(param1);
         }
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         super.reveal(param1);
         this._clip.glowingBanana.play();
      }
      
      override public function hide(param1:Number = 0.2) : void
      {
         super.hide(param1);
         this._clip.glowingBanana.stop();
      }
   }
}
