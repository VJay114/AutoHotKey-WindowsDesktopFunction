
#SingleInstance, Force ; Allow only one running instance of the script
#Persistent ; Keep the script permanently running until terminated



#LAlt::           _NavigateDesktop("Right")
#LCtrl::          _NavigateDesktop("Left")
^Space::          _NavigateDesktop("Alwaysontop")





>!Up::            _WinOpacity("Up")
^#WheelUp::       _WinOpacity("Up")
>!Down::          _WinOpacity("Down")
^#WheelDown::     _WinOpacity("Down")    
^#Space::         _WinOpacity("Toggle")



#WheelRight::     _SnapWindow("Right")
#WheelLeft::      _SnapWindow("Left")

>^Up::            _Multimedia("Volume_Up")
>^Down::          _Multimedia("Volume_Down")
>^Home::          _Multimedia("Media_Play_Pause")
>^PgUp::          _Multimedia("Media_Stop")
>^PgDn::          _Multimedia("Media_Prev")
>^End::           _Multimedia("Media_Next")
      
XButton1::        _ShowHideWindows() 
XButton2::        _ShowHideWindows("A", 0)    



#Del::            _DeleteAllTemp()

OnExit,
    _ShowHideWindows()
    ExitApp

_ShowHideWindows(wintitle := "A", show := 1){
    static windows := []
    
    if (show)
    {
        for each, active_id in windows
            WinShow, % "ahk_id " . active_id
        windows := []
    }
    else
    {
        WinGet, active_id, ID, % wintitle
        windows.push(active_id)
        WinHide, % "ahk_id " . active_id
    }
}
_WinOpacity(opacity){
 WinGet, ActiveTransparency, transparent, A 
      if (opacity = "Up"){
            If (ActiveTransparency= "")

                  ActiveTransparency= 255
            else {

                  ActiveTransparency+= 2.5

                  If ActiveTransparency> 255

                  ActiveTransparency= 255

            }
            g_opacity := ActiveTransparency
      }
      else if (opacity ="Down"){
            If (ActiveTransparency= "")

                  ActiveTransparency= 230

            else {

                  ActiveTransparency-= 2.5

            If ActiveTransparency< 2.5

                  ActiveTransparency= 2.5
            }
            g_opacity := ActiveTransparency
      }
      else {
         While (GetKeyState("Space", "P") = 1) 
            {
                  WinSet, Transparent, 255, A
	      }

      }
      WinSet, transparent, %ActiveTransparency%,A
      Sleep, 50 ;

      return
}
_Multimedia(name){
      if (name ="Volume_Up"){
            Send {Volume_Up} 
      }
      else if (name ="Volume_Down"){
            Send {Volume_Down}
      }
      else if (name ="Media_Play_Pause"){
            Send {Media_Play_Pause} 
      }
      else if (name ="Media_Stop"){
            Send {Media_Stop} 
      }
      else if (name ="Media_Prev"){
            Send {Media_Prev} 
      }
      else if (name ="Media_Next"){
            Send {Media_Next} 
      }
      return
}
_NavigateDesktop(nav){
      if (nav="Left")
      {
            Send ^#{Left}
      }
      else if (nav = "Right")
      {
           Send ^#{Right}
      }
      else if (nav ="Alwaysontop"){
            Winset, Alwaysontop, toggle, A
      }
      return 
}
_DeleteAllTemp(){
      FileDelete, C:\Windows\Temp\*
      FileDelete, C:\Users\Jaypro\AppData\Local\Temp\*
      FileDelete, C:\Windows\Prefetch\*

      run C:\Windows\Temp\
      run C:\Users\Jaypro\AppData\Local\Temp\
      run C:\Windows\Prefetch\
      return
}
_SnapWindow(nav){
      if (nav ="Right"){
            SysGet, Mon1, Monitor, 2
            WinGetPos, , , WW, WH, A
            WinGetClass, class, A
            if class != Shell_TrayWnd
            if class != Progman
            if class != DV2ControlHost
            WinMove, A, , (( Mon1Right-Mon1Left - WW ) / 2) +Mon1Left, (Mon1Bottom - 30 - WH ) / 2
            return
      }
      else if (nav ="Left"){
                  SysGet, Mon1, Monitor, 1
      WinGetPos, , , WW, WH, A
      WinGetClass, class, A
      if class != Shell_TrayWnd
      if class != Progman
      if class != DV2ControlHost
        WinMove, A, , (( Mon1Right-Mon1Left - WW ) / 2) +Mon1Left, (Mon1Bottom - 30 - WH ) / 2
      return
      }
}

; FUNCTION  CODE        LEFT              RIGHT
;------------------------------------------------------
; shift     +           <+ LShift         >+ RShift
; alt       !           <! LAlt           >! RAlt
; ctrl      ^           <^ LCtrl          >^ RCtrl
; windows   #           <# LWin           ># RWin
