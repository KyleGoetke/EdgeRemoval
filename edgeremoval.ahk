#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir C:\ ; Ensures a consistent starting directory.
CoordMode, Mouse, Screen
SysGet, MonitorCount, MonitorCount
SysGet, MonitorPrimary, MonitorPrimary
SysGet, MonitorName, MonitorName, %A_Index%
SysGet, Monitor, Monitor, %A_Index%
SysGet, MonitorWorkArea, MonitorWorkArea, %A_Index%

BlockInput, On
Gui, +AlwaysOnTop -SysMenu
Gui, Add, Text,, Please wait while computer setup is completed.
Gui, Show,, Setup In Progress

if (FileExist("C:\Users\Public\edgeremoval.txt") != "")
{
    FileRead, FileContents, C:\Users\Public\edgeremoval.txt
    Loop, parse, FileContents, `r`n
    {
        If InStr(FileContents, A_UserName, false) = 0
        {
            ;! check if edge is open - might need different keypresses
            MouseClick, right, 500, %MonitorBottom%
            Sleep, 1500
            Send {Up 1}
            Sleep, 1000
            Send {Enter}
            FileAppend, %A_UserName%`r`n, C:\Users\Public\edgeremoval.txt
            FileSetAttrib, +H, C:\Users\Public\edgeremoval.txt
        }
        else
        {
            Gui, Cancel
            BlockInput, Off
            ExitApp
        }
    }
}
else
{
    MouseClick, right, 500, %MonitorBottom%
    Sleep, 1500
    Send {Up 1}

    Sleep, 1000
    Send {Enter}
    if FileExist("C:\Users\Public\Desktop\Microsoft Edge.lnk")
    {
        FileDelete, C:\Users\Public\Desktop\Microsoft Edge.lnk
    }
    FileAppend, %A_UserName%`r`n, C:\Users\Public\edgeremoval.txt
    FileSetAttrib, +H, C:\Users\Public\edgeremoval.txt
    Gui, Cancel
    BlockInput, Off
    ExitApp
}
Gui, Cancel
BlockInput, Off
ExitApp
