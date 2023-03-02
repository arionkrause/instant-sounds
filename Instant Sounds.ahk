#persistent
#noEnv
#singleInstance force
setWorkingDir %A_ScriptDir%

menu tray, tip, Instant sounds

#F1::playSound(1)
#F2::playSound(2)
#F3::playSound(3)
#F4::playSound(4)
#F5::playSound(5)
#F6::playSound(6)
#F7::playSound(7)
#F8::playSound(8)
#F9::playSound(9)
#F10::playSound(10)
#F11::playSound(11)
#F12::playSound(12)
^#F12::showQuickMenu()

playSound(idSound)
{
	iniRead soundFileName, Instant sounds.ini, sound%idSound%, filename
	iniRead soundVolume, Instant sounds.ini, sound%idSound%, volume

	if (soundFileName == "" || soundVolume == "") {
		return
	}

	soundGet volumeBefore, speakers, volume
	soundSet %soundVolume%, speakers, volume
	soundPlay sounds\%soundFileName%, wait
	soundSet %volumeBefore%, speakers, volume
}

showQuickMenu()
{
	message := ""

	loop 12
	{
		iniRead soundFileName, Instant sounds.ini, sound%A_Index%, filename

		if (soundFileName != "") {
			soundFileNameWithoutExtension := regExReplace(soundFileName, "\.mp3$", "")

			if (message == "") {
				message := A_Index . " - " . soundFileNameWithoutExtension
			} else {
				message .= "`n" . A_Index . " - " . soundFileNameWithoutExtension
			}
		}
	}

	toolTip %message%, A_ScreenWidth - 285, A_ScreenHeight - 235
	sleep 7000
	toolTip
}