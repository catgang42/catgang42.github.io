@shift /0
@echo off
:start
title nul
setlocal enabledelayedexpansion
setlocal enableextensions

    @mode 17,1

set "current_version_number=28"
set "updated_on=30/12/2022"


for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "BS=%%a"
set speed=100

    IF exist "%cd%\Cube_config.txt" goto skip_config_file_creation

:create_config_file
    echo. >> Cube_config.txt

    echo Download_Directory=default>> Cube_config.txt
    echo  - change this to change the default download location (make sure not to add a "\" at the end, and make sure not to add a {SPACE} at the end either) (By default a new folder is created and downloaded files will go there) >> Cube_config.txt
    echo. >> Cube_config.txt
    echo Auto_Update=[ 1 ] >> Cube_config.txt
    echo  - to turn off automatic update checking at startup set this to 0 (default is 1) >> Cube_config.txt
    echo. >> Cube_config.txt
    echo Window_Animation=[ 1 ] >> Cube_config.txt
    echo  - if you get a blank screen at the begining set this to 0, this stops the window from transitioning "Smoothly" (default is 1) >> Cube_config.txt
    echo. >> Cube_config.txt
    echo Text_Animation=[ 1 ] >> Cube_config.txt
    echo  - to turn off text animation set this to 0, which delays the letters to make them look cool (default is 1) >> Cube_config.txt
    echo. >> Cube_config.txt
    echo Text_Delay=[ 1 ] >> Cube_config.txt
    echo  - to turn off delays after every text output set this to 0  (default is 1) >> Cube_config.txt
    echo. >> Cube_config.txt
    echo Wipe_screen_animation=[ 1 ] >> Cube_config.txt
    echo  - to turn off the animated screen wipe that happens when transitioning between menus set this to 0 (default is 1) >> Cube_config.txt
    echo. >> Cube_config.txt
    echo Force_offline=[ 0 ] >> Cube_config.txt
    echo  - this forces offline mode use when setting is set to 1 (default is 0) >> Cube_config.txt

    @MODE 160,21
    set speed=1000

    call :t " "
    call :t "It is recommended that you put the cube.exe in a correct folder structure and generally in a folder"
    call :t "A folder such as [ C:/dir1/dir2/dir3 ] will work just fine, but a folder such as [ C:/dir 1/dir#@$/dir3 ] may cause some problems"
    call :t " "
    pause>nul
    cls
    call :t " "
    call :t "If you are viewing this in the new windows [terminal] application you may want to change it to the legacy cmd terminal for the intended experience"
    call :t "To do this follow the below instructions"
    call :t " "
    call :t "(To differentiate between the two: [Terminal] looks moddern and has tabs at the top of the window while [Windows Console Host] does not and looks plane)"
    call :t " "
    call :t "1. Open windows terminal application"
    call :t "2. Then enter the settings, which is located under the small arrow pointing down at the top tab"
    call :t "3. Then find [Default Terminal Application]"
    call :t "4. Then set it to [Windows Console Host]"
    call :t "5. Close this window and Run [Cube.exe] again"
    call :t " "
    call :t "Press anything to continue."
    pause>nul
    cls
    call :t " "
    call :t "If you get a blank screen after this you can go into the [Cube_config.txt] and set Window_Animation=1 to Window_Animation=0 and run [Cube.exe] again"
    call :t " "
    call :t "Press anything to continue."
    pause>nul

:skip_config_file_creation

    for /F "delims=" %%a in ('findstr /I "Window_Animation=" Cube_config.txt') do set "Window_Animation=%%a"
    if /i "%Window_Animation:~17,5%" == "[ 1 ]" (set do_Window_Animation=true) else set do_Window_Animation=false

    for /F "delims=" %%b in ('findstr /I "Text_Delay=" Cube_config.txt') do set "Text_Delay=%%b"  
    if /i "%Text_Delay:~11,5%" == "[ 1 ]" (set do_Text_Delay=true) else set do_Text_Delay=false

    for /F "delims=" %%c in ('findstr /I "Auto_Update=" Cube_config.txt') do set "Auto_Update=%%c"  
    if /i "%Auto_Update:~12,5%" == "[ 1 ]" (set do_Auto_Update=true) else set do_Auto_Update=false

    for /F "delims=" %%d in ('findstr /I "Text_Animation=" Cube_config.txt') do set "Text_Animation=%%d"  
    if /i "%Text_Animation:~15,5%" == "[ 1 ]" (set do_Text_Animation=true) else set do_Text_Animation=false

    for /F "delims=" %%e in ('findstr /I "Wipe_screen_animation=" Cube_config.txt') do set "Wipe_screen_animation=%%e"  
    if /i "%Wipe_screen_animation:~22,5%" == "[ 1 ]" (set do_Wipe_screen_animation=true) else set do_Wipe_screen_animation=false

    for /F "delims=" %%f in ('findstr /I "Download_Directory=" Cube_config.txt') do set "Download_Directory=%%f"  
    if exist "%Download_Directory:~19,99%" (
        set "dirtdnt=%Download_Directory:~19,99%\"
    ) else (
        mkdir Cube_Downloads
        set "dirtdnt=%cd%\Cube_Downloads\"
    )

    for /F "delims=" %%g in ('findstr /I "Force_offline=" Cube_config.txt') do set "Force_offline=%%g"  
    if /i "%Force_offline:~14,5%" == "[ 1 ]" (set do_Force_offline=true) else set do_Force_offline=false

    if /i "%Window_Animation:~0,17%" neq "Window_Animation=" set "error=(Window_Animation=) was not found in Cube_Config.txt" && set "tip=Reset the Cube_Config.txt file by deleting it and running the cube.exe again" && goto error
    if /i "%Text_Delay:~0,11%" neq "Text_Delay=" set "error=(Text_Delay=) was not found in Cube_Config.txt" && set "tip=Reset the Cube_Config.txt file by deleting it and running the cube.exe again" && goto error
    if /i "%Auto_Update:~0,12%" neq "Auto_Update=" set "error=(Auto_Update=) was not found in Cube_Config.txt" && set "tip=Reset the Cube_Config.txt file by deleting it and running the cube.exe again" && goto error
    if /i "%Text_Animation:~0,15%" neq "Text_Animation=" set "error=(Text_Animation=) was not found in Cube_Config.txt" && set "tip=Reset the Cube_Config.txt file by deleting it and running the cube.exe again" && goto error
    if /i "%Wipe_screen_animation:~0,22%" neq "Wipe_screen_animation=" set "error=(Wipe_screen_animation=) was not found in Cube_Config.txt" && set "tip=Reset the Cube_Config.txt file by deleting it and running the cube.exe again" && goto error
    if /i "%Download_Directory:~0,19%" neq "Download_Directory=" set "error=(Download_Directory=) was not found in Cube_Config.txt" && set "tip=Reset the Cube_Config.txt file by deleting it and running the cube.exe again" && goto error
    if /i "%Force_offline:~0,14%" neq "Force_offline=" set "error=(Force_offline=) was not found in Cube_Config.txt" && set "tip=Reset the Cube_Config.txt file by deleting it and running the cube.exe again" && goto error

    if exist old_Cube.exe del old_Cube.exe
    if exist new_Cube.exe ren new_Cube.exe Cube.exe
    
    if "%do_Force_offline%" == "true" ( set "c=false" ) else call :curl-check-internet

::if exist "C:\Program Files\7-Zip\7z.exe" (set Sevenzip="%ProgramFiles%\7-Zip\7z.exe") else If

    if exist 7za.exe ( set "Sevenzip=7za.exe" ) else if "%c%" == "true" curl --silent "https://img.guildedcdn.com/ContentMediaGenericFiles/f469af534ceec747ae3d4fbb79c896f5-Full.zip" --silent --output "7za.zip" && tar -xf "7za.zip" && del "7za.zip" && set "Sevenzip=7za.exe"
    if not exist wget.exe if "%c%" == "true" ( curl "https://img.guildedcdn.com/ContentMediaGenericFiles/70c447f293c4bb3dc274dbd16235472b-Full.zip" --silent --output "wget.zip">nul && tar -xf "wget.zip" && del wget.zip ) else ( set "error=Unable to download wget" && set "tip=Connect to the internet")
    
    call :Manual_Update_Check
    :skip_Auto_Update

cls
:intro
    set target_width=40
    set target_height=21
    call :Window_animate
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo        #+ @      # #              M#@
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo  .    .X  X.%%##@;# #   +@#######X. @H%%
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo    ,==.   ,######M+  -#####%M####M-    #
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo   :H##M%%:=##+ .M##M,;#####/+#######%% ,M#
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo  .M########=  =@#@.=#####M=M#######=  X#
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo  :@@MMM##M.  -##M.,#######M#######. =  M
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo              @##..###:.    .H####. @@ X,
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo    ############: ###,/####;  /##= @#. M
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo            ,M## ;##,@#M;/M#M  @# X#% X#
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo .%%=   ######M## ##.M#:   ./#M ,M #M ,#$
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo ##/         $## #+;#: #### ;#/ M M- @# :
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo #+ #M@MM###M-;M #:$#-##$H# .#X @ + $#. #
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo       ######/.: #%%%=# M#:MM./#.-#  @#: H#
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo +,.=   @###: /@ %%#,@  ##@X #,-#@.##%% .@#
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo #####+;/##/ @##  @#,+       /#M    . X,
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo    ;###M#@ M###H .#M-     ,##M  ;@@; ###
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo    .M#M##H ;####X ,@#######M/ -M###$  -H
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo     .M###%  X####H  .@@MM@;  ;@#M@
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo       H#M    /@####/      ,++.  / ==-,
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    echo                ,=/:, .+X@MMH@#H  #####$=
    ping localhost -n 1 >nul
    ping localhost -n 1 >nul
    timeout /t 2 /nobreak>nul

:clearscreenmainmenu
    call :clearscreen
    :mainmenu
    set speed=50
    if "%c%" == "true"  set target_width=34
    if "%c%" == "true"  set target_height=20
    if "%c%" == "false" set target_width=53
    if "%c%" == "false" set target_height=24
    call :Window_animate
    :mainmenu1
    cls
    title Main Menu
                        call :t "[ Version = %current_version_number% ]"
                        call :t " "
    if "%c%" == "false" call :t "[ No Internet ] - Some features have been Dissabled" 
    if "%c%" == "false" call :t " "
    if "%c%" == "true"  call :t "[ u ] - Update"       
    if "%c%" == "false" call :t "[ # ] - Update (Dissabled)"  
                        call :t "[ c ] - Change log"  
                        call :t "[ i ] - Info"
                        call :t "[ s ] - Settings"
                        call :t "[ r ] - Refresh"
                        call :t "[ # ] - Reset (Not implemented)"
                        call :t "[ ? ] - ?"
                        call :t " "
                        call :t "Cracked / Paid Downloads"
    if "%c%" == "true"  call :t "   [ 1 ] - Shaders"
    if "%c%" == "false" call :t "   [ # ] - Shaders (Dissabled)"
    if "%c%" == "true"  call :t "   [ 2 ] - Textures"
    if "%c%" == "false" call :t "   [ # ] - Textures (Dissabled)"
                        call :t "   [ 3 ] - Physics mod pro"
                        call :t "   [ # ] - Mods (Not implemented)"
                        call :t "   [ # ] - Maps (Not implemented)"
                        call :t " "
                        call :t "[ e ] - Exit"
    
    set /p mainmenu=
    if "%c%" == "true" if /i "%mainmenu%" == "u" goto Check_update
                       if /i "%mainmenu%" == "c" goto change_log
                       if /i "%mainmenu%" == "i" goto information
                       if /i "%mainmenu%" == "s" goto settings
    if "%c%" == "true" if /i "%mainmenu%" == "1" goto shaders
    if "%c%" == "true" if /i "%mainmenu%" == "2" goto textures
                       if /i "%mainmenu%" == "3" goto physics_mod_pro
                       if /i "%mainmenu%" == "?" goto The_Cube
                       if /i "%mainmenu%" == "r" goto Start
                if /i "%mainmenu%" == "compress" goto Compress_cube_exe
                       if /i "%mainmenu%" == "e" goto exit
    call :t "Enter a valid option."
    pause>nul
    goto mainmenu1

:information
    set speed=50
    set target_width=30
    set target_height=10
    call :Window_animate
    :information1
    cls
    title Information
    call :t "[ 1 ] - Shaders"       
    call :t "[ 2 ] - Textures"
    call :t "[ 3 ] - Physics Mod Pro"
    call :t "[ # ] - Mods (Not implemented)"
    call :t "[ # ] - Maps (Not implemented)"
    call :t "[ 4 ] - General / Credit"
    call :t " "
    call :t "[ b ] - main menu"

    set /p infomenu=
    if "%infomenu%" == "1" goto shader_information
    if "%infomenu%" == "2" goto texture_information
    if "%infomenu%" == "3" goto physics_mod_pro_information
    if "%infomenu%" == "4" goto general_info
    if /i "%infomenu%" == "b" goto clearscreenmainmenu
    if not defined %infomenu% ( 
    call :t "Enter a valid option."
    pause>nul
    call :clearscreen
    goto information1
    )
    
    



:settings
    set target_width=40
    set target_height=20
    call :Window_animate
    if not exist "Cube_Config.txt" set "error= Config file does not exist?" && set "tip=Try restarting the cube.exe by running it again" && goto error
    notepad.exe Cube_config.txt
    call :t "Press anything to Refresh"
    pause>nul|set/p =
    goto start

:Manual_Update_Check
    if "%do_Auto_Update%" == "false" goto skip_Auto_Update
:Check_update
    set speed=20
    cls
    set target_width=40
    set target_height=5
    call :Window_animate
    if "%c%" == "false" goto No_internet_no_update
    call :t " "
    call :t " "
    call :t " "
    call :t " "
    call :t "        Checking for new Updates       "
    call :t " "
    wget -q --no-hsts --no-config --output-document="Cube_Verison.txt" "https://www.dropbox.com/s/cyzjbajj0xtl1g1/Cube_Verison.txt?dl=1"

    if not exist "Cube_Verison.txt" set "error=Cube_Verison.txt does not exists" && set "tip=This maybe due to a firewall or antivirus blocking the cube.exe" && goto error
    
    timeout /t 1 /nobreak>nul
    for /F "delims=" %%d in ('findstr /I "Version=" Cube_Verison.txt') do set "New_Update=%%d"
    if /i "%New_Update:~0,8%" neq "Version=" set "error=(Version=) was not found in Cube_Verison.txt" && set "tip=No tip" && goto error
    if /i "%New_Update:~8,99%" GTR "%current_version_number%" (set Exist_New_Update=true) else set Exist_New_Update=false
    if "%Exist_New_Update%" == "true" (goto Update_Found) else goto No_Update
    exit /b

:Update_Found
    call :clearscreen
    call :t " "
    call :t " "
    call :t " "
    call :t " "
    call :t "             Update Found              "
    call :t " "
    del Cube_Verison.txt
    timeout /t 1 /nobreak>nul
    call :clearscreen
    cls

:Download_Update
    set target_width=130
    set target_height=11
    call :Window_animate
    cls
    call :t "[ Tip ] - your anti-virus will possibly delete the file, So temporarily deactive it if you are unable to download and update the Cube.exe"
    call :t "[ Important ] - The [Cube.exe] will never ask for administrative privileges"
    call :t " "
    call :t "Press anything to update."
    pause>nul
    cls
    call :t "Downloading latest file"
    call :t " "
    wget -q --show-progress --no-hsts --no-config --output-document="2gaKUq8bdONUhQ5E.7z" "https://www.dropbox.com/s/wy0ye1nostoxems/2gaKUq8bdONUhQ5E.7z?dl=1"
    if not exist "2gaKUq8bdONUhQ5E.7z" set "error=Updated file does not exist" && set "tip=This maybe due to a firewall or antivirus blocking the cube.exe" && goto error
    set "gtip=Check to see if you have either 7z installed or if 7za.exe is in the same folder and the Cube.exe if not contact support"
    if "%Sevenzip%" == "" set "error=Archiving program not set" && set "tip=%gtip%" && goto error
    if "%Sevenzip%" == " " set "error=Archiving program not set" && set "tip=%gtip%" && goto error
    %Sevenzip% x -y "2gaKUq8bdONUhQ5E.7z" -p"hkgz2ntbrnvw9d3gjq3hfmqshazv4qs2rkxewbjg2sd624mpcm9cwx74c8r7rzxwr2b3wbakqrm846kkq3qcgcdtjfad8tmjrv73e5xdcj38kp5dtp8bnnk46fvm6b9eq46gsmys9xk4hgqmtxws2vbr4mws52n8d95dau9zvd9a3uuxwahq8g8g6z5ttwgczka8nnbxnq9xhbg7vpeua8ervkaw8d5dbz33d26bwhj4bmsrgwh5vda5jedsxrx5vya4m735u2ndn9ach9443wh68eqv2d6av3f75ubyvq8a9568nb8eneambzuurf49hthcksmm222467ctbknpf92hrbfr5mqefyqxapwtr2fuaakc7qdyuh8qz5h5mgfgt8pgz2y6gq9qcwgdjcnktmn8kcb9y65j8hkuzejj5me2ggeuhxugf4gg392hngbjduwu9s3p6ujry62ncrakq4jp7k6kaakdt5bvwy2h5zvhmp5rm97zdmaan8ar6d5ycenz2cyv55m9t4wm7ybnu7ye8jvscu5h3jn9gjpc9dsb66a269s68xc8w4b4ws3ybkmqh9n455fzxwxuga5zxdfup28mvxsakrnx55er8xnzj8j7ryvjh8enzzrjtx9kbmnt6rn9tawuun5t4tf38jwvdq2cpp2ch6azjma5bsvgyn5r2rykv8tnf2qhz6b2z7pu554nsvbtv6za59ecrejmrxf37v3nnc5prk2ef27933hem5rreeq59h9gqff7gx4mcapk3s22eqzs9teg6qjv2zvvmgsjyejsmd94y3fnns8tu86apnrhkk4y6569va3zv9c4byqwg2ar6wx7s57bgecjrkmugdd5ajq5cpuqyt75zrcshgu5f5babz3meqwzqddrj4qwt9x2g6p6rzqyn3pvjwfvfz2d83f6b94t8qcxncjp64nr8nn883gz2ebjwkv59p6e6xka7xj5fg7k6w7qyqvmb47b5mefwzuqpz6thhyddwv6n3fa2rfndew7mv7t5egwgc4qhxctn3pf6zau26cbbt79ct78c9dm5byqbe3w6ga9qgmmtahgbu79juxy7qdctyvmnt2f985p8s6pd25m332taeujeu9hehk6pytg36g336zwv53jw6dy7q7h3wcfqv3bee8ndxquvn48x3cjcgrgvg3zujurgscynhqwdvvfr4kv2pmbrpm23csfwwz65vwhkz63ve7gg8tvqq2axmgjqxebm257mm6m5bb3gzeg95xy5gf9fbvpctj3mkvdxbryjufz9xvfwbtzpyjw4mga54kkx5b98r8tdeddkvktyxss6pkasj3veapm9yppy9hrpykyz75xkkge74kqwxwku33cujvfxnqacbv9susevz82392r8y4ueymt4puva4z5uquw2ku3ybygzcnyzgx5p3jy4yvcrfx46786kj9uf7qqst98g273mue43mm5gk44b638dpuvsy7kytfcw965kjy777usnta8n3yt88nymjsphujtfksvvxdc6ttbhmp288r6hqjtfhxe2g6jjq8u2gg8xwhgphn7tyhen7eygnhcq4z2tns8gdwcnz42m2brt7hwupx4at8rv6pw6hewyfp6969m39gu3u7faqb7dgxtefwmzkqh2qmqnajx7kw42x78mxg3sk4waygmpwtfez659vstghubwerdpnh245xbpnbuytgt8udtsjkumhmvtkghxa963hu93ymatwd73x5s888yn83jyayg3n89tb3kmapqsssz562kwv2nb89rk7sxrctg2ke7bqm8xtyn3tnfmfe29tnqv9zk6tfk6zcs5q25jh79bkxnbq2jzbay4x2tshygrnd2nguzeq7aqy25bsecjm3r4h2tafj6cq7mvwdxafumew26x6xgk4559shx925rhqcb5hjrq3hggwrjrchhe2ujdbfdm2fjj85ge9s9q9njph3avb6pgevp5wjytwt5szbemd3xsu283bb9mgg5ccu2z8e4nmp8gz5ung6b">nul
    
    if exist "2gaKUq8bdONUhQ5E.7z" ( del 2gaKUq8bdONUhQ5E.7z ) else ( call :t "2gaKUq8bdONUhQ5E.7z was not found and cant be deleted" )
    call :t "Downloaded the latest file"
    call :t " "
    if exist "Cube.exe" ( ren "Cube.exe" "old_Cube.exe" ) else set "error=update error 1" && goto error
    if exist "%cd%\container\new_Cube.exe" ( ren "%cd%\container\Cube.exe" "new_Cube.exe" ) else set "error=update error 2" && goto error
    if exist "%cd%\container\new_Cube.exe" ( move /y "%cd%\container\new_Cube.exe" "%cd%" ) else set "error=update error 3" && goto error
    if exist "%cd%\container" ( rmdir /s /q "%cd%\container" ) else set "error=update error 4" && goto error
    call :t "Done."
    call :t " "
    call :t "Manualy run [ new_Cube.exe ]"
    call :t " "
    call :t "Press anything to close."
    pause>nul
    call :clearscreen
    goto exit

:No_Update
    call :t " "
    call :t " "
    call :t " "
    call :t " "
    call :t "            No Updates Found           "
    call :t " "
    del Cube_Verison.txt
    timeout /t 1 /nobreak>nul
    call :clearscreen
    goto intro

:No_internet_no_update
    call :t " "
    call :t " "
    call :t " "
    call :t " "
    call :t "         No Internet, No Update        "
    call :t " "
    timeout /t 3 /nobreak>nul
    call :clearscreen
    goto intro

:Compress_cube_exe
    if not exist "Cube.exe" goto mainmenu1
    mkdir Container
    move "%cd%\Cube.exe" "%cd%\Container\Cube.exe"
    %Sevenzip% a -y "2gaKUq8bdONUhQ5E.7z" "%cd%\Container\" -p"hkgz2ntbrnvw9d3gjq3hfmqshazv4qs2rkxewbjg2sd624mpcm9cwx74c8r7rzxwr2b3wbakqrm846kkq3qcgcdtjfad8tmjrv73e5xdcj38kp5dtp8bnnk46fvm6b9eq46gsmys9xk4hgqmtxws2vbr4mws52n8d95dau9zvd9a3uuxwahq8g8g6z5ttwgczka8nnbxnq9xhbg7vpeua8ervkaw8d5dbz33d26bwhj4bmsrgwh5vda5jedsxrx5vya4m735u2ndn9ach9443wh68eqv2d6av3f75ubyvq8a9568nb8eneambzuurf49hthcksmm222467ctbknpf92hrbfr5mqefyqxapwtr2fuaakc7qdyuh8qz5h5mgfgt8pgz2y6gq9qcwgdjcnktmn8kcb9y65j8hkuzejj5me2ggeuhxugf4gg392hngbjduwu9s3p6ujry62ncrakq4jp7k6kaakdt5bvwy2h5zvhmp5rm97zdmaan8ar6d5ycenz2cyv55m9t4wm7ybnu7ye8jvscu5h3jn9gjpc9dsb66a269s68xc8w4b4ws3ybkmqh9n455fzxwxuga5zxdfup28mvxsakrnx55er8xnzj8j7ryvjh8enzzrjtx9kbmnt6rn9tawuun5t4tf38jwvdq2cpp2ch6azjma5bsvgyn5r2rykv8tnf2qhz6b2z7pu554nsvbtv6za59ecrejmrxf37v3nnc5prk2ef27933hem5rreeq59h9gqff7gx4mcapk3s22eqzs9teg6qjv2zvvmgsjyejsmd94y3fnns8tu86apnrhkk4y6569va3zv9c4byqwg2ar6wx7s57bgecjrkmugdd5ajq5cpuqyt75zrcshgu5f5babz3meqwzqddrj4qwt9x2g6p6rzqyn3pvjwfvfz2d83f6b94t8qcxncjp64nr8nn883gz2ebjwkv59p6e6xka7xj5fg7k6w7qyqvmb47b5mefwzuqpz6thhyddwv6n3fa2rfndew7mv7t5egwgc4qhxctn3pf6zau26cbbt79ct78c9dm5byqbe3w6ga9qgmmtahgbu79juxy7qdctyvmnt2f985p8s6pd25m332taeujeu9hehk6pytg36g336zwv53jw6dy7q7h3wcfqv3bee8ndxquvn48x3cjcgrgvg3zujurgscynhqwdvvfr4kv2pmbrpm23csfwwz65vwhkz63ve7gg8tvqq2axmgjqxebm257mm6m5bb3gzeg95xy5gf9fbvpctj3mkvdxbryjufz9xvfwbtzpyjw4mga54kkx5b98r8tdeddkvktyxss6pkasj3veapm9yppy9hrpykyz75xkkge74kqwxwku33cujvfxnqacbv9susevz82392r8y4ueymt4puva4z5uquw2ku3ybygzcnyzgx5p3jy4yvcrfx46786kj9uf7qqst98g273mue43mm5gk44b638dpuvsy7kytfcw965kjy777usnta8n3yt88nymjsphujtfksvvxdc6ttbhmp288r6hqjtfhxe2g6jjq8u2gg8xwhgphn7tyhen7eygnhcq4z2tns8gdwcnz42m2brt7hwupx4at8rv6pw6hewyfp6969m39gu3u7faqb7dgxtefwmzkqh2qmqnajx7kw42x78mxg3sk4waygmpwtfez659vstghubwerdpnh245xbpnbuytgt8udtsjkumhmvtkghxa963hu93ymatwd73x5s888yn83jyayg3n89tb3kmapqsssz562kwv2nb89rk7sxrctg2ke7bqm8xtyn3tnfmfe29tnqv9zk6tfk6zcs5q25jh79bkxnbq2jzbay4x2tshygrnd2nguzeq7aqy25bsecjm3r4h2tafj6cq7mvwdxafumew26x6xgk4559shx925rhqcb5hjrq3hggwrjrchhe2ujdbfdm2fjj85ge9s9q9njph3avb6pgevp5wjytwt5szbemd3xsu283bb9mgg5ccu2z8e4nmp8gz5ung6b" -mhe>nul
    rd /s /q "%cd%\container"
    call :clearscreen
    goto mainmenu1

::YEz6zG4z2SnhkSM6
::kAhRrmHnZcTA8DUM

:physics_mod_pro
    title Physics Mod Pro
    set target_width=65
    set target_height=10
    call :Window_animate
:physics_mod_pro1
    cls
    if "%c%" == "true"  call :t "[ 1 ] - Precracked Physics mod pro files"
    if "%c%" == "false" call :t "[ # ] - Precracked Physics mod pro files (Dissabled)"
    call :t " "
    call :t "[ 2 ] - Physics mod pro Manipulator (auto-cracker and uncracker)"
    call :t " "
    call :t "[ b ] - main menu"
    set /p pmp=
    if /i "%c%" == "true" if "%pmp%" == "1" goto Precracked_pmp
    if /i "%pmp%" == "2" goto Auto-crack_pmp
    if /i "%pmp%" == "b" goto clearscreenmainmenu
    call :t "Enter a valid option"
    pause>nul
    goto physics_mod_pro1

:Precracked_pmp
    set speed=20
    set target_width=45
    set target_height=20
    call :Window_animate
:Precracked_pmp
title pre-cracked 
    cls
    set "v91a-fabric-1.19.x=pmp_B8P9jNamgTFEr2bG_47fc73d618527270877762a9aa4751c4_https://media-files9.bunkr.ru/physics-mod-pro-v91-fabric-22w44a-0At1TOXM.7z#_physics-mod-pro-v91-fabric-22w44a.7z"
    set "v89a-fabric-1.19.x=pmp_TDWcy66wgd7EktC9_676a70f4c77985d64c9366fa8b7d6d5e_https://media-files9.bunkr.ru/physics-mod-pro-v89a-fabric-1.19.x-wlhm0XTg.7z_physics-mod-pro-v89a-fabric-1.19.x.7z"
    set  "v89a-forge-1.19.x=pmp_JvqR5UAd4Ss386kP_53efdb29622eb33cc008b9ed7a01b994_https://media-files9.bunkr.ru/physics-mod-pro-v89a-forge-1.19.x-U4ghK99n.7z#_physics-mod-pro-v89a-forge-1.19.x.7z"
    set "v89a-fabric-1.18.2=pmp_U87CRyLWjpvbXtXL_a7e10a4c64c527ee2b18e8e36eb52e9f_https://media-files9.bunkr.ru/physics-mod-pro-v89a-fabric-1.18.2-H6JtfMoK.7z_physics-mod-pro-v89a-fabric-1.18.2.7z"
    set  "v89a-forge-1.18.2=pmp_tKCHTfjf4y64QjKP_fdb9c8683e678867caf376c341201a68_https://media-files9.bunkr.ru/physics-mod-pro-v89a-forge-1.18.2-Q8ahbS9b.7z#_physics-mod-pro-v89a-forge-1.18.2.7z"
    set "v36b-fabric-1.17.1=pmp_qQsjQQ5znM4cfrP8_87c8c490067c66f65f384924382932ee_https://media-files9.bunkr.ru/physics-mod-pro-v36b-fabric-1.17.1-TkZ5VJxf.7z_physics-mod-pro-v36b-fabric-1.17.1.7z"
    set  "v36b-forge-1.17.1=pmp_Hs3G66gFwySZVSpr_7bdab1fc6d15b56c4606bdf1bcf59546_https://media-files9.bunkr.ru/physics-mod-pro-v36b-forge-1.17.1-hLiQTYyR.7z#_physics-mod-pro-v36b-forge-1.17.1.7z"
    set "v36b-fabric-1.16.5=pmp_JSVkPpCpez9rnrWr_342dcf019e80c1465048764066b8068c_https://media-files9.bunkr.ru/physics-mod-pro-v36b-fabric-1.16.5-OnI4sfP6.7z_physics-mod-pro-v36b-fabric-1.16.5.7z"
    set  "v36b-forge-1.16.5=pmp_4XvJHL9zUz3gWa6K_45bad1ce5c7820080c65fb5ffb961e4e_https://media-files9.bunkr.ru/physics-mod-pro-v36b-forge-1.16.5-oCkM3NNO.7z#_physics-mod-pro-v36b-forge-1.16.5.7z"

    call :t "[ 1 ] - 1.19.3  v91   fabric (snapshot)"
    call :t " "
    call :t "[ 2 ] - 1.19.x  v89a  Fabric"
    call :t "[ 3 ] - 1.19.x  v89a  Forge "
    call :t " "
    call :t "[ 4 ] - 1.18.2  v89a  Fabric"
    call :t "[ 5 ] - 1.18.2  v89a  Forge "
    call :t " "
    call :t "[ 6 ] - 1.17.1  v36b  Fabric"
    call :t "[ 7 ] - 1.17.1  v36b  Forge "
    call :t " "
    call :t "[ 8 ] - 1.16.5  v36b  Fabric"
    call :t "[ 9 ] - 1.16.5  v36b  Forge "
    call :t " "
    call :t "[ # ] - Download all (Not Implemented)"
    call :t " "
    call :t "[ b ] - main menu"
    call :t " "

    set /p pmp_p=
    if "%pmp_p%" == "1" set mf=%v91a-fabric-1.19.x%
    if "%pmp_p%" == "2" set mf=%v89a-fabric-1.19.x%
    if "%pmp_p%" == "3" set mf=%v89a-forge-1.19.x%
    if "%pmp_p%" == "4" set mf=%v89a-fabric-1.18.2%
    if "%pmp_p%" == "5" set mf=%v89a-forge-1.18.2%
    if "%pmp_p%" == "6" set mf=%v36b-fabric-1.17.1%
    if "%pmp_p%" == "7" set mf=%v36b-forge-1.17.1%
    if "%pmp_p%" == "8" set mf=%v36b-fabric-1.16.5%
    if "%pmp_p%" == "9" set mf=%v36b-forge-1.16.5%

    if %pmp_p% gtr 0 if %pmp_p% leq 10 goto auto_process
    if /i "%pmp_p%"== "b" goto clearscreenmainmenu
    call :t "Enter a valid option."
    pause>nul
    goto physics_mod_pro1


:Auto-crack_pmp
	set tempcrackerscript=tempscript.vbs
    if exist "%tempcrackerscript%" erase "%tempcrackerscript%"
    if not exist "%cd%\Crack_Folder" mkdir Crack_Folder
    if not exist "%cd%\Crack_Folder\recaf.jar" (
            set target_width=80
            set target_height=5
            call :Window_animate
            wget.exe -q --show-progress --no-hsts --no-config --output-document="recaf.7z" "https://img.guildedcdn.com/ContentMediaGenericFiles/7c8477b5a2044e4946984f9d14fb064e-Full.7z" >nul
            if not exist "recaf.7z" set "error=recaf.7z was not downloaded" && set "tip=This maybe due to a firewall or antivirus blocking the cube.exe" && goto error
            set "gtip=Check to see if you have either 7z installed or if 7za.exe is in the same folder and the Cube.exe if not contact support"
            if "%Sevenzip%" == "" set "error=Archiving program not set" && set "tip=%gtip%" && goto error
            if "%Sevenzip%" == " " set "error=Archiving program not set" && set "tip=%gtip%" && goto error
            %Sevenzip% x -bd -y "recaf.7z" >nul
            del recaf.7z
    ) 
    if exist recaf.jar move recaf.jar "%cd%\Crack_Folder\"
    :pmp_Crack_Type
    set target_width=85
    set target_height=23
    call :Window_animate
    cls
    call :t "Choose a crack method (Auto-Cracker Credit: The Cube)"
    call :t " "
    call :t "[ 1 ] - Crack type 1 (Crack Credit: Rider#9706, BizzyEnjoyer#1336)"
    call :t "        + Good mod compatability"
    call :t "        + Works indefinitely"
    call :t "        - Does not work Offline"
    call :t " "
    call :t "[ 2 ] - Crack type 2 (Crack Credit: edik#5712 - https://discord.gg/XqrtKfhaqC)"
    call :t "        + Good mod compatability"
    call :t "        + Works indefinitely"
    call :t "        + Works Offline"
    call :t " "
    call :t "[ # ] - Crack type 3 (Crack Credit: edik#5712)"
    call :t "        (Not Implemented)"
    call :t " "
    call :t "[ # ] - Uncrack"
    call :t "        - Uncrack any version of physics mod pro to its original uncracked state"
    call :t "        (Not Implemented)"
    call :t " "
    call :t "[ b ] - back"
    set /p pmp_Crack_Type=
    if "%pmp_Crack_Type%" == "1" set Crack_Type=Crack_Type_1 && goto crack_setup
    if "%pmp_Crack_Type%" == "2" set Crack_Type=Crack_Type_2 && goto crack_setup
    ::if "%pmp_Crack_Type%" == "3" set Crack_Type=Crack_Type_3 && goto crack_setup
    if /i "%pmp_Crack_Type%" == "b" goto physics_mod_pro
    call :t "Enter a valid option"
    pause>nul
    goto pmp_Crack_Type
    
    :crack_setup
    set target_width=120
    set target_height=25
    call :Window_animate
    :crack_setup1
    cls
    call :t "Place a any one version of physics mod pro that you want to crack in the folder called [ Crack_Folder ] then press [ 2 ]"
    call :t " "
    call :t "(Example [ physics-mod-pro-v69a-fabric-1.19.x.jar ] )"
    call :t " "
    call :t "(you can find uncracked versions on kemono or via the google drive folder)"
    call :t " "
    call :t "[ 1 ] - Google drive folder link"
    call :t " "
    call :t "[ 2 ] - Continue"
    call :t " "
    call :t "[ b ] - back"
    set /p crack_setup=
    if /i "%crack_setup%" == "1" (
    call :t " "
    echo https://drive.google.com/drive/u/1/folders/1pOXjBIyu-EqA9MHj0Yqm3ZDIncLNZdr_ | clip
    call :t "[ Link Copied to clipboard ]"
    call :t " "
    timeout /t 5 >nul
    goto crack_setup
    )
    if /i "%crack_setup%" == "2" goto check_for_file
    if /i "%crack_setup%" == "b" goto pmp_Crack_Type
    call :t "Enter a valid option"
    pause>nul
    goto crack_setup1
    
    :check_for_file
    set fn=
    set efn=
    set cf=
    cls
	FOR /R "%cd%\Crack_Folder" %%A in (*physics-mod-pro*) do set fn=%%~nxA
	
    set efn=Cracked_%fn%
    set cf=%cd%\Crack_Folder\Cube.txt

    if "%fn:~0,15%" == "physics-mod-pro" (goto physics-mod-pro_exists) else goto physics-mod-pro_does_not_exist
    goto physics-mod-pro_does_not_exist
	
	:physics-mod-pro_does_not_exist
    set target_width=145
    set target_height=6
    call :Window_animate
	call :t "No usable file was detected, Please insert a file into the [ Crack_Folder ] that contains [ physics-mod-pro ] at the begining of the file name"
    call :t " "
    call :t "[ 1 ] - Try again"
    call :t " "
    call :t "[ b ] - back"
    set /p physics-mod-pro_does_not_exist=
    if /i "%physics-mod-pro_does_not_exist%" == "1" goto check_for_file
    if /i "%physics-mod-pro_does_not_exist%" == "b" goto pmp_Crack_Type
    call :t "Enter a valid option"
    pause>nul
    goto check_for_file

	:physics-mod-pro_exists
	:WARNING
	cls
	:warning1
    set speed=500
    set target_width=160
    set target_height=40
    call :Window_animate
	call :t "[ %fn% ] is Detected and is selected to be cracked"
	call :t " "
	call :t "##############################################################################"
    call :t " WARNING: YOU MUST NOT Interact with your system during The Cracking Process. "
	call :t "##############################################################################"
    call :t " "
    call :t "To be specific: After you enter [YES I UNDERSTAND] and press {ENTER} just don't touch your computer at all"
    call :t " "
    call :t "(you will be told when you can interact with your system after the cracking process is finished)"
    call :t " "
    call :t " "
    call :t "[ YES I UNDERSTAND ]  - Proceed with crack"
    call :t " "
    call :t "[ CANCEL ] OR {ENTER} - Back / Cancel"
	set /p UNDERSTAND=
	if "%UNDERSTAND%" == "YES I UNDERSTAND" goto crack_code_beginning
    if "%UNDERSTAND%" == "CANCEL" goto clearscreenmainmenu
	call :t "Please type a valid option such as [YES I UNDERSTAND] or [CANCEL]"
    pause>nul 
	goto WARNING

:crack_code_beginning
    echo Set WShell = CreateObject("WScript.Shell") >> %tempcrackerscript%
    echo Set WshShell = WScript.CreateObject("WScript.Shell") >> %tempcrackerscript%
    echo WScript.Sleep 100 >> %tempcrackerscript%
    echo WShell.Run("cmd.exe") >> %tempcrackerscript%
    echo WScript.Sleep 500 >> %tempcrackerscript%
    echo WshShell.AppActivate "cmd.exe" >> %tempcrackerscript%
    echo WScript.Sleep 100 >> %tempcrackerscript%
    echo WshShell.SendKeys "title Crack_Window" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WScript.Sleep 100 >> %tempcrackerscript%
    echo WshShell.SendKeys "cd %cd%\Crack_Folder" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WScript.Sleep 100 >> %tempcrackerscript%
    echo WshShell.SendKeys "java -jar recaf.jar --cli" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WScript.Sleep 200 >> %tempcrackerscript%
    echo WshShell.SendKeys "loadworkspace %fn%" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WScript.Sleep 200 >> %tempcrackerscript%
    echo WshShell.SendKeys "disassemble net/diebuddies/util/+Http+Request get+9+Ljava/lang/String;+0+Ljava/lang/+String;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WScript.Sleep 4000 >> %tempcrackerscript%
    goto %Crack_Type%
    
:Crack_Type_1
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+l+i+n+e +a 12" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{UP}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+l+i+n+e +a 4" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+l+i+n+e +b 13" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{UP}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+l+i+n+e +b 5" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+j+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DEL}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DEL}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DEL}" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DEL}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+j" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+K 22" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DEL}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+j" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+e+x_+h+a+n+d+l+e+r_1+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{LEFT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{BS}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+q" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+e+x_+s+t+a+r+t_2+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{LEFT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{BS}" >> %tempcrackerscript%
    echo WshShell.SendKeys "line" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+e+x_+h+a+n+d+l+e+r_2+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{LEFT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{BS}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+P" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+e+x_+h+a+n+d+l+e+r_2+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{UP}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+a+s+t+o+r+e v6" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{BS}" >> %tempcrackerscript%
    echo WshShell.SendKeys "line" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{BS}" >> %tempcrackerscript%
    echo WshShell.SendKeys "v6" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+q+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DEL}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+p" >> %tempcrackerscript%
    echo WshShell.SendKeys "{LEFT}" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "^e" >> %tempcrackerscript%
    echo WshShell.SendKeys "{BS}" >> %tempcrackerscript%
    echo WshShell.SendKeys "line" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{LEFT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{BS}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+q" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "{LEFT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DOWN}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{RIGHT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{RIGHT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{RIGHT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{RIGHT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{RIGHT}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{DEL}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+q" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "^w" >> %tempcrackerscript%
    echo WshShell.SendKeys "+a+r+e+t+u+r+n" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{UP}" >> %tempcrackerscript%
    
    echo WshShell.SendKeys "+r+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+l+d+c +21verified+2" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+a+s+t+o+r+e v1" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+a+l+o+a+d v1" >> %tempcrackerscript%

    echo This files was automatically cracked using the "Cube.exe" >> %cf%
    echo. >> %cf%
    echo The Cube: https://discord.gg/8pWC25Xzkj >> %cf%
    echo. >> %cf%
    echo Crack Type Credit: Rider#9706, BizzyEnjoyer#1336 >> %cf%

    goto crack_code_export_end

:Crack_Type_2    
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "^k" >> %tempcrackerscript%
    echo WshShell.SendKeys "{del}" >> %tempcrackerscript%
    echo WshShell.SendKeys "{del}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+d+e+f+i+n+e +p+u+b+l+i+c +s+t+a+t+i+c get+9+ljava/lang/+string; urlToRead+0+ljava/lang/+string;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+t+h+r+o+w+s java/io/+i+o+exception" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+a+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+l+i+n+e +a 11" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+i+c+o+n+s+t_1" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+p+u+t+s+t+a+t+i+c net/diebuddies/physics/settings/+verification+screen.verified +z" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+b+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+l+i+n+e +b 12" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+g+e+t+s+t+a+t+i+c net/diebuddies/config/+config+client.verificationCode +ljava/lang/+string;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+i+n+v+o+k+e+d+y+n+a+m+i+c make+concat+with+constants +9+ljava/lang/String;+0+ljava/lang/String; handle[+h_+i+n+v+o+k+e+s+t+a+t+i+c java/lang/invoke/+string+concat+factory.make+concat+with+constants+9+ljava/lang/invoke/+method+handles$+lookup;+ljava/lang/+string;+ljava/lang/invoke/+method+type;+ljava/lang/String;[+ljava/lang/+object;+0+ljava/lang/invoke/+call+site;] args[+2\u0001verified+2]" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+a+r+e+t+u+r+n" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "+c+;" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%

    echo This files was automatically cracked using the "Cube.exe" >> %cf%
    echo. >> %cf%
    echo The Cube:             https://discord.gg/8pWC25Xzkj >> %cf%
    echo Physics mod bypassed: https://discord.gg/XqrtKfhaqC >> %cf%
    echo. >> %cf%
    echo Crack Type Credit: edik#5712 >> %cf%
    goto crack_code_export_end

    :crack_code_export_end
    echo WshShell.SendKeys "^o" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WshShell.SendKeys "^x" >> %tempcrackerscript%
    echo WScript.Sleep 100  >> %tempcrackerscript%
    echo WshShell.SendKeys "export %efn%" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WScript.Sleep 100 >> %tempcrackerscript%
    echo WshShell.SendKeys "quit" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    echo WScript.Sleep 100 >> %tempcrackerscript%
    echo WshShell.SendKeys "exit %efn%" >> %tempcrackerscript%
    echo WshShell.SendKeys "{ENTER}" >> %tempcrackerscript%
    goto crack_in_process

:crack_in_process
	call :t " "
    call :t "Crack will start in 3"
	timeout /t 1 /nobreak >nul
    call :t "Crack will start in 2"
	timeout /t 1 /nobreak >nul
    call :t "Crack will start in 1"
	timeout /t 1 /nobreak >nul
	call :t " "
	timeout /t 1 /nobreak >nul
	call :t "[ Crack Started ] - Do not touch your computer"
	timeout /t 1 /nobreak >nul
	start /wait %tempcrackerscript%
	timeout /t 5 /nobreak >nul
    taskkill /F /FI "WINDOWTITLE eq Crack_Window" /T>nul
    erase %tempcrackerscript%
    
    %Sevenzip% a -bd -y "%cd%\Crack_Folder\%efn%" "%cf%">nul
    del %cf% >nul
	
    call :t " "
	call :t "[ Crack Finished ] - You can touch your computer"
	call :t " "
	call :t "[Info] - The cracked file should be located in the [ %CD%\Crack_Folder ] with [ Cracked_ ] at the begining of the file name"
    call :t " "
	call :t "Press anything to return to the mainmenu."
    pause>NUL
    goto clearscreenmainmenu

::C:\Users\%Username%\AppData\Roaming\.minecraft\mods

:shaders
    endlocal
    setlocal
    title Shaders
    set speed=500
    set target_width=52
    set target_height=25
    call :Window_animate

    set    "Continuum_Old=shader_TmRuNyQL9TZdRsTW.7z_ZvZ2kC2RKXWTg6g8_35d1ffa46df92bfd9818538824d25a52_https://media-files9.bunkr.ru/TmRuNyQL9TZdRsTW-XRgY7gb5.7z_Continuum_Old"
    set        "Continuum=shader_D35xm7syduM88mp7.7z_n4avHUYckQWR2zEy_8abf3e8c707373f3cddd24fcdb389aff_https://media-files9.bunkr.ru/D35xm7syduM88mp7-VTH2N4hK.7z_Continuum_Alpha_Build_12"
    set "Continuum_RT_Old=shader_KSVyxBpc2RjscYDv.7z_mDgvg9p9WeqsZwDF_5a525959760aa9d02d30c66427666a5c_https://media-files9.bunkr.ru/KSVyxBpc2RjscYDv-i6kJtCxU.7z_Continuum_RT_Old"
    set  "Continuum_RT_15=shader_55Xknx47YCRsJUcC.7z_Y9GbHY9aM2ykgtAQ_8bbbda10d29f662e4f6736d45dafe754_https://media-files9.bunkr.ru/55Xknx47YCRsJUcC-sCQ7Xa4S.7z_Continuum_RT_15"
    set         "ApolloRT=shader_LnYamW0leh9O3E7r.7z_U1u6GJ3apBcy9K5D_6b477a69910f9b47a89959b31cbff4bf_https://media-files9.bunkr.ru/LnYamW0leh9O3E7r-sLImadxd.7z_ApolloRT_2022-11-6_19.12"
    set "ApolloRT_Rewrite=shader_mODJHXsu5c2e8ET3.7z_cJFNn17gP6uKIO8i_b29fdff4a58329a07ab7e28c7cdd7ea0_https://media-files9.bunkr.ru/mODJHXsu5c2e8ET3-Eh3XouD4.7z_ApolloRT_Rewrite_2022-11-3_00.09"
    set            "kappa=shader_GIKyfhN0duQ964WD.7z_C0WKQoOSZnu4rp5d_468d6e8a7542a965b01fccd8ae8f2cce_https://media-files9.bunkr.ru/GIKyfhN0duQ964WD-JzG408qF.7z_Kappa_v5.0_T2"
    set          "KappaPT=shader_R0w91mQxkBrTWSqe.7z_N03eJFrWixCZaUK6_73ab0e62ddd0ac9f30507293869af971_https://media-files9.bunkr.ru/R0w91mQxkBrTWSqe-LkX319fH.7z_KappaPT_P16b_2022-12-2_16.12"
    set          "MollyVX=shader_kOcY58tbUns90EM2.7z_jPd0QFTczV4oxZ7u_e2d2cb88626aa72d8de4f042cacff23c_https://media-files9.bunkr.ru/kOcY58tbUns90EM2-ruIf9zEP.7z_MollyVX-5-6-2022"
    set  "MollyVX_rewrite=shader_dYyOUoWx3VNg7MP1.7z_yldtxJL1V76NCa4e_1de019ee509dfdc9ba072235f9b37853_https://media-files9.bunkr.ru/dYyOUoWx3VNg7MP1-ZhmPixn8.7z_MollyVXRewrite_2022-2-20_17.43"
    set        "Nostalgia=shader_a4HNcsubvRZT2pgF.7z_ZgAOwz4YfbjBdTxs_cc695f8a120860cc85e32779664a33e4_https://media-files9.bunkr.ru/a4HNcsubvRZT2pgF-PClxNgCk.7z_Nostalgia_v4.0a"
    set      "NostalgiaVX=shader_C7sSqeXbvI0y1kJR.7z_C1uVlOAW3ZKgXjBn_72a76003db85695522cb41c7431cf9f0_https://media-files9.bunkr.ru/C7sSqeXbvI0y1kJR-KxqKPo7H.7z_NostalgiaVX_P8d_2022-12-2_16.33"
    set   "Octray_rewrite=shader_ES7FPPBhc3JzBaXE.7z_uBHg7KjXT4AvWDzy_2152e8b6b80adcfb8c6c81228e41d200_https://media-files9.bunkr.ru/ES7FPPBhc3JzBaXE-xl4WfGF9.7z_OctrayRewrite_v0.5.12"
    set       "SoftVoxels=shader_7ddXVauZL5H8nr4W.7z_qfnT7fpcRP7ztgPf_018cc3d91d7b7b02b1509416167a876d_https://media-files9.bunkr.ru/7ddXVauZL5H8nr4W-2WuEO253.7z_SoftVoxels_P4_2022-6-7_14.24"
    set          "UShader=shader_fbL6OG5MrVZ9P2en.7z_LhmVtTSOQ9WZ61w5_f7046d57f0bd93095a831084de341dc9_https://media-files9.bunkr.ru/fbL6OG5MrVZ9P2en-MjHPL9G6.7z_UShader_v2.0_E6_2022-12-2_16.33"
    set          "VXFluff=shader_ftyY7aD9SW8Burhd.7z_rgsXQq5aAEcU6df3_01c8d60734b0a568520d049bf84cdfb3_https://media-files9.bunkr.ru/ftyY7aD9SW8Burhd-eyoFKWLF.7z_VXFluff-8-19-2022-v2"

    call :t "Do [ 2 5 11 ] to download files one after the other"
    call :t " "
    call :t "[ 1 ]   - Continuum Old"
    call :t "[ 2 ]   - Continuum Alpha Build 12"
    call :t "[ 3 ]   - Continuum RT Old"
    call :t "[ 4 ]   - Continuum RT Build 15"
    call :t "[ 5 ]   - ApolloRT"
    call :t "[ 6 ]   - ApolloRT Rewrite"
    call :t "[ 7 ]   - Kappa"
    call :t "[ 8 ]   - KappaPT"
    call :t "[ 9 ]   - MollyVX"
    call :t "[ 10 ]  - MollyVX_rewrite"
    call :t "[ 11 ]  - Nostalgia"
    call :t "[ 12 ]  - NostalgiaVX"
    call :t "[ 13 ]  - SoftVoxels"
    call :t "[ 14 ]  - Octray rewrite"
    call :t "[ 15 ]  - UShader"
    call :t "[ 16 ]  - VXFluff"
    call :t " "
    call :t "[ a ]   - Download All"
    call :t " "
    call :t "[ b ]   - mainmenu"

    set /p "shader_selection="
    ::if %shader_selection% gtr 0 if %shader_selection% leq 16 goto check_quantity    
    if /i "%shader_selection%" == "b" endlocal && goto clearscreenmainmenu
    if /i "%shader_selection%" == "a" set "shader_selection=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16"
    
    set "shader_selection=%shader_selection% stop"
    :another_shader_loop
    for %%s in (%shader_selection%) do (

        set shadergoback=1
        :shadergoback
        set "selected_shader=%%s"
        if "%shadergoback%" leq "0" set /a "shadergoback=%shadergoback%-1" && goto shadergoback
    
        if "%selected_shader%" == "1"  set "mf=%Continuum_Old%"    && call :auto_process
        if "%selected_shader%" == "2"  set "mf=%Continuum%"        && call :auto_process
        if "%selected_shader%" == "3"  set "mf=%Continuum_RT_Old%" && call :auto_process
        if "%selected_shader%" == "4"  set "mf=%Continuum_RT_15%"  && call :auto_process
        if "%selected_shader%" == "5"  set "mf=%ApolloRT%"         && call :auto_process
        if "%selected_shader%" == "6"  set "mf=%ApolloRT_Rewrite%" && call :auto_process
        if "%selected_shader%" == "7"  set "mf=%kappa%"            && call :auto_process
        if "%selected_shader%" == "8"  set "mf=%KappaPT%"          && call :auto_process
        if "%selected_shader%" == "9"  set "mf=%MollyVX%"          && call :auto_process
        if "%selected_shader%" == "10" set "mf=%MollyVX_rewrite%"  && call :auto_process
        if "%selected_shader%" == "11" set "mf=%Nostalgia%"        && call :auto_process
        if "%selected_shader%" == "12" set "mf=%NostalgiaVX%"      && call :auto_process
        if "%selected_shader%" == "13" set "mf=%SoftVoxels%"       && call :auto_process
        if "%selected_shader%" == "14" set "mf=%Octray_rewrite%"   && call :auto_process
        if "%selected_shader%" == "15" set "mf=%UShader%"          && call :auto_process
        if "%selected_shader%" == "16" set "mf=%VXFluff%"          && call :auto_process
    )
    
    if "%selected_shader%" neq "stop" goto :another_shader_loop
    endlocal
    goto shaders

:textures
    endlocal
    setlocal
    title Textures
    set speed=500
    set target_width=52
    set target_height=20
    call :Window_animate
    
    set "Stratum=texture_BgYNrCLumnq4whAb.7z_HZzhb8f3fP4BqntX_016c9fc17081509fefa4627c57766397_https://media-files9.bunkr.ru/BgYNrCLumnq4whAb-iuMkmrmt.7z_Stratum"
    call :t "Do [ 1 # # ] to download files one after the other"
    call :t " "
    call :t "[ 1 ] - Stratum (128x, 256x, 512x, 1028x)"
    call :t "[ # ] - Patrix       (To Add)"
    call :t "[ # ] - Stylized     (No source)"
    call :t "[ # ] - NAPP         (To Add)"
    call :t "[ # ] - Realistic    (No source)"
    call :t "[ # ] - Archaic      (No source)"
    call :t "[ # ] - ModernArch   (No source)"
    call :t "[ # ] - Realismmats  (No source)"
    call :t "[ # ] - realistico 8 (To Add)"
    call :t " "
    call :t "[ a ] - Download All"
    call :t " "
    call :t "[ b ] - main menu"

    set /p texture_selection=
    if /i "%texture_selection%" == "b" endlocal && goto clearscreenmainmenu
    if /i "%texture_selection%" == "a" set "texture_selection=1"

    set "texture_selection=%texture_selection% stop"
    :another_textrue_loop
    for %%t in (%texture_selection%) do (

        set texturegoback=1
        :texturegoback
        set "selected_texture=%%t"
        if "%texturegoback%" leq "0" set /a "texturegoback=%texturegoback%-1" && goto texturegoback
        
        if "%selected_texture%" == "1" set "mf=%Stratum%" && call :auto_process

    )
    
    if "%selected_texture%" neq "stop" goto :another_textrue_loop
    endlocal
    goto textures
    
    call :t "Enter a valid option."
    pause>nul
    call :clearscreen
    goto textures1

:auto_process
    
    if "%mf:~0,6%" == "shader" (
    set "ft=%mf:~0,6%"
    set "fn=%mf:~7,19%"
    set "fp=%mf:~27,16%"
    set "oh=%mf:~44,32%"
    set "fl=%mf:~77,58%"
    set "ofn=%mf:~136,99%"
    )

    if "%mf:~0,7%" == "texture" (
    set "ft=%mf:~0,7%"
    set "fn=%mf:~8,19%"
    set "fp=%mf:~28,16%"
    set "oh=%mf:~45,32%"
    set "fl=%mf:~78,58%"
    set "ofn=%mf:~137,99%"
    )

    if "%mf:~0,3%" == "pmp" (
    set "ft=%mf:~0,3%"
    set "fp=%mf:~4,16%"
    set "fn=%mf:~131,99%"
    set "oh=%mf:~21,32%"
    set "fl=%mf:~54,76%"
    set "ofn=%mf:~131,99%"
    )

    if "%ft%" neq "shader" if "%ft%" neq "texture" if "%ft%" neq "pmp" (
        set "error=A variable error occurred" && goto error
    )


    call :clearscreen
    set speed=20
    set target_width=100
    set target_height=25
    call :Window_animate
    
    :accept_download
    if /i "%accept_download%" == "y" goto do_download
    call :t "Download %ft% [ %ofn% ] ?"
    call :t "[y]es or [n]o or [c]ancel all"
    call :t " "
    call :t "Note - if downloading multiple files pressing [y]es will do [y]es for all"
    set /p accept_download=
    if /i %accept_download%== y goto do_download
    if /i %accept_download%== c goto clearscreenmainmenu
    if /i %accept_download%== n ( exit /b ) else call :t "Enter a valid option." && pause>nul && goto accept_download
    
    :do_download
    call :t "Downloading File : %ofn%"
    call :t " "
    wget.exe -q -c --show-progress --no-hsts --output-document="%fn%" "%fl%"
    move "%fn%" "%dirtdnt%" > nul
    if not exist "%dirtdnt%%fn%" (set "error=File Not Found in %dirtdnt%" && goto error)
    call :t " "
    call :t "Calculating Hash."
    set /a count=1 
    for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile "%dirtdnt%%fn%" MD5') do (
        if !count! equ 1 set "md5=%%a"
        set/a count+=1
    )
    set "md5=%md5: =%"
    call :t " "
    call :t "%fn%" 
    call :t "     Original   File Hash : %oh%"
    call :t "     Calculated File Hash : %md5%"
    if "%md5%" neq "%oh%" goto file_integrity_bad
    call :t "Integrity good"
    call :t " "
    call :t "Extracting file."
    %Sevenzip% x -y -o"%dirtdnt%" "%dirtdnt%%fn%" -p"%fp%" > nul
    call :t " "
    call :t "Deleting archive file"
    if exist "%dirtdnt%%fn%" del "%dirtdnt%%fn%"
    call :t " "
    call :t "your file should be located in (%dirtdnt%)"
    
    if "%timeout%" == "ok" timeout /t 1 && goto skip_timeout
    set timeout=ok
    timeout /t 10
    :skip_timeout
    call :clearscreen
    exit /b

:file_integrity_bad
    call :t " "
    call :t "File integrity bad, Deleting (%orignalfilename%)"
    call :t " "
    del "%fn%"
    pause>nul
    goto clearscreenmainmenu
 
:shader_information
    set target_width=100
    set target_height=20
    call :Window_animate
    title Shaders
    call :t "Continuum_Old     - Source: nobUCKSgiven       - Version: nul"
    call :t "Continuum         - Source: nobUCKSgiven       - Version: 2.1 Alpha Build 12"
    call :t "Continuum_RT_Old  - Source: nobUCKSgiven       - Version: nul"
    call :t "Continuum_RT_15   - Source: nobUCKSgiven       - Version: RT-15"
    call :t "ApolloRT          - Source:                    - Version: 2022-11-6_19.12"
    call :t "ApolloRT Rewrite  - Source: Discord-UMQpecSJFp - Version: 2022-11-3_15.29"
    call :t "Kappa             - Source:                    - Version: v5.0_T2"
    call :t "KappaPT           - Source: Anon Contributor   - Version: P16b_2022-12-2_16.12"
    call :t "Nostalgia         - Source:                    - Version: v4.0a"
    call :t "NostalgiaVX       - Source: Anon Contributor   - Version: P8d_2022-12-2_16.33"
    call :t "MollyVX           - Source:                    - Version: 5-6-2022"
    call :t "MollyVXRewrite    - Source:                    - Version: 2022-2-20_17.43"
    call :t "SoftVoxels        - Source:                    - Version: P4_2022-6-7_14.24"
    call :t "Octray Rewrite    - Source:                    - Version: v0.5.12"
    call :t "Ushader           - Source: Anon Contributor   - Version: v2.0_E6_2022-12-2_16.33"
    call :t "VXFluff           - Source:                    - Version: 8-19-2022-v2"
    call :t " "
    pause>nul
    call :clearscreen
    goto information

:texture_information
    set target_width=100
    set target_height=3
    call :Window_animate
    title Textures
    call :t " "
    call :t "Stratum - Source: Continuum site / nul - Version: v31 - Contents: 128x, 256x, 512x, 1028x"
    pause>nul
    call :clearscreen
    goto information

:physics_mod_pro_information
    set target_width=120
    set target_height=30
    call :Window_animate
    title physics mod pro
    call :t "Physics mod pro feature information"
    call :t "                                             1.20         1.19.x         1.18.2         1.17.1         1.16.5"
    call :t "     Weather Physics                         [ # ]        [ # ]          [ # ]          [   ]          [   ]"
    call :t "     Smoke   Physics                         [ # ]        [ # ]          [ # ]          [   ]          [   ]"
    call :t "     Snow    Physics                         [ # ]        [ # ]          [ # ]          [ # ]          [   ]"
    call :t "     Liquid  Physics BETA                    [ # ]        [ # ]          [ # ]          [ # ]          [ # ]"
    call :t "     Vine    Physics                         [ # ]        [ # ]          [ # ]          [ # ]          [ # ]"
    call :t "     Door/Trapdoor Physics                   [ # ]        [ # ]          [ # ]          [ # ]          [ # ]"
    call :t "     Cape    Physics                         [ # ]        [ # ]          [ # ]          [ # ]          [ # ]"
    call :t "     Banner  Physics                         [ # ]        [ # ]          [ # ]          [ # ]          [ # ]"
    call :t "     Leash   Physics                         [ # ]        [ # ]          [ # ]          [ # ]          [ # ]"
    call :t "     Fishing Line Physics                    [ # ]        [ # ]          [ # ]          [ # ]          [ # ]"
    call :t "     Snowball, Egg and Enderpearl Physics    [ # ]        [ # ]          [ # ]          [ # ]          [ # ]"
    call :t " "
    call :t "Available = [ # ], Unavailable = [   ]"
    call :t " "
    call :t "[ 1.19.x = 1.19.0, 1.19.1, 1.19.2 ] [ 1.19.3 might not be supported ]"
    call :t " "
    call :t "Upcoming Features:"
    call :t "      - Block fracturing based on material (wood, stone, metal, etc)"
    call :t "      - Ocean Physics"
    call :t "      - Minecart Physics"
    call :t "      - Soft Body Physics"
    call :t " "
    call :t "Crackers - Rider, BizzyEnjoyer, Edik"
    call :t "Uncracked source - Kemono"
    call :t " "
    call :t "Press anything to return."
    pause>nul
    call :clearscreen
    goto information

:general_info
    set target_width=130
    set target_height=18
    call :Window_animate
    cls
    title General info
    set speed=100
    call :t "Coder of [Cube.exe]  : The Cube"
    call :t " "
    call :t "Physics mod crackers : Rider#9706, BizzyEnjoyer#1336, edik#5712"
    call :t "Other Credit         : nul"
    call :t " "
    call :t "The Cube             : https://discord.gg/8pWC25Xzkj"
    call :t "Physics mod Bypassed : https://discord.gg/XqrtKfhaqC"
    call :t "piracy :)            : https://discord.gg/Xu48h2gf8q"
    call :t "NoBUCKSgiven         : No link avalable"
    call :t " "
    call :t "Pastebin             : https://pastebin.com/rCn1kt8F [ Password : rgD7L2y3vM ] idk why we have this"
    call :t " "
    call :t "If you have a suggestion, file to upload, or need support you can join the (The Cube) link or the leave a comment on pastebin"
    call :t " "
    call :t "Press anything to return."
    pause>nul
    call :clearscreen
    goto information

:change_log
    set speed=1000
    set target_width=110
    set target_height=80
    call :Window_animate
    cls
    title change log
    set speed=10000
    call :t "Current Verison: %current_version_number%" 
    call :t "Updated on: %updated_on%" 
    call :t " "
    call :t "Updated: [*]"
    call :t "Added:   [+]"
    call :t " "
    call :t "v28 30/12/2022 - added force offline setting"
    call :t "v27 29/12/2022 - Bug fixes, multi download added"
    call :t "v26 21/12/2022 - Changed Cloud storage providers, Continuum was split to old and latest"
    call :t "                 Cube icon was added to the Cube.exe, added a new setting to toggle the screen wipe animation"
    call :t "                 Stratum is now downloaded as one file and not part files
    call :t "v25 19/12/2022 - Added code to check if Connected to the Internet"
    call :t "v24 19/12/2022 - Added google drive link for uncracked versions of physics mod pro"
    call :t "v23 18/12/2022 - Bug fixes, Auto-cracker update"
    call :t "                    + Added Crack variant 2 by Edik"
    call :t "v22 17/12/2022 - Bug fixes, Added Physics mod pro auto cracker, Shader pack Update"
    call :t "                    * ApolloRT_Rewrite"
    call :t "                    + Added Crack variant 1 by Rider"
    call :t "v21 15/12/2022 - Bug fixes, Added download location setting"
    call :t "v20 09/12/2022 - Various Improvments"
    call :t "v19 09/12/2022 - Bug fixes"
    call :t "v18 08/12/2022 - Added another setting, Bug fixes"
    call :t "v17 07/12/2022 - Improved UI, Added settings"
    call :t "v16 06/12/2022 - Added config file and Bug fixes"
    call :t "v15 05/12/2022 - Interface update"
    call :t "v14 03/12/2022 - Shader pack Update"
    call :t "                    * VXFluff"
    call :t "v13 02/12/2022 - Added: ?"
    call :t "v13 02/12/2022 - Changed list layout, Improved Code, Shader pack Update"
    call :t "                    * Ushader"
    call :t "                    + NostalgiaVX"
    call :t "                    + KappaPT"
    call :t "                    + ApolloRT"
    call :t "v12 01/12/2022 - Fixed phsyics mod pro hashes"
    call :t "v11 01/12/2022 - Bug fixes"
    call :t "v10 25/11/2022 - Changed interface layout"
    call :t "v9  23/11/2022 - Added Cracked physics mod versions"
    call :t "                    + 1.19.x (Forge, Fabric) (+ Snapshot)"
    call :t "                    + 1.18.2 (Forge, Fabric)"
    call :t "                    + 1.17.1 (Forge, Fabric)"
    call :t "                    + 1.16.5 (Forge, Fabric)"
    call :t "v8  18/11/2022 - Shader Pack Update"
    call :t "                    + MollyVX"
    call :t "                    + SoftVoxels"
    call :t "                    + Octray rewrite"
    call :t "v7  18/11/2022 - Shader Pack Update"
    call :t "                    + ApolloRT"
    call :t "                    + KappaPT"
    call :t "                    + NostalgiaVX"
    call :t "v6  18/11/2022 - Added More Interface Features"
    call :t "v5  18/11/2022 - Test Update"
    call :t "v4  18/11/2022 - Updated Code"
    call :t "v3  18/11/2022 - Updated Interface"
    call :t "v2  15/11/2022 - Texture/Shader pack Update"
    call :t "                   + Stratum             (Texture)"
    call :t "                   + Continuum           (Shader)"
    call :t "                   + Continuum RT 4 - 12 (Shader)"
    call :t "                   + Continuum RT 15     (Shader)"
    call :t "v1  12/11/2022 - File creation"
    call :t " "
    call :t "Press anything to return."
    pause>nul
    call :clearscreen
    goto mainmenu

:The_User
    set target_width=100
    set target_height=27
    call :Window_animate
    setlocal disableExtensions
    setlocal disabledelayedexpansion
    ping localhost -n 1 >nul
    echo                                               .::^^~~^^:.                                             
    ping localhost -n 1 >nul
    echo                                            .:^^^^^^^^~~!!!!!!^^                                          
    ping localhost -n 1 >nul
    echo                                         .^^^^~^^^^:^^^^~!!!!!!!JJ~                                        
    ping localhost -n 1 >nul
    echo                                      :^^^^~~^^^^^^^^^^^^~~!!!!!!!!!7!.                                      
    ping localhost -n 1 >nul
    echo                                      !Y^^^^^^^^^^^^^^~~~~^^~~~~~!!!!5.                                      
    ping localhost -n 1 >nul
    echo                                      !B?^^~~~~~~~~~^^^^^^^^~^^~~~5P                                       
    ping localhost -n 1 >nul
    echo                                      !BJ~~~~~~~~~~~^^^^^^^^^^^^^^~Y5                                       
    ping localhost -n 1 >nul
    echo                                     .!G?~~~~~~~~~~!~^^^^^^^^^^^^~JJ                                       
    ping localhost -n 1 >nul
    echo                                     ^^!P7~~~~~~~~~~^^^^~~~~~~!7!                                       
    ping localhost -n 1 >nul
    echo                                     ~!Y~~~~~~~~~^^:^^^^^^~!!~~!!:                                       
    ping localhost -n 1 >nul
    echo                                     !7?^^:~~~^^^^::::^^^^^^^^~!^^~!?.                                       
    ping localhost -n 1 >nul
    echo                                      JJ:~^^^^::::^^^^:::^^^^^^^^^^!Y7                                        
    ping localhost -n 1 >nul
    echo                                       YJ~^^^^^^^^:^^^^^^^^:::~~^^!5Y^^                                        
    ping localhost -n 1 >nul
    echo                                        J?^^:::::^^^^^^^^^^^^^^^^^^Y5?.                                        
    ping localhost -n 1 >nul
    echo                                         JJ^^.:::^^^^^^^^^^^^^^:~YJ~                                         
    ping localhost -n 1 >nul
    echo                                        .!YJ^^.::^^::^^^^^^::?J^^                                          
    ping localhost -n 1 >nul
    echo                                        !~!YJ~:::::::::~J~                                           
    ping localhost -n 1 >nul
    echo                                       .?~:~!7~~~^^^^^^:^^^^7!!^^.                                         
    ping localhost -n 1 >nul
    echo                                   .::^^~?~^^:::::^^^^^^^^^^^^^^^^!!!!~^^:.                                     
    ping localhost -n 1 >nul
    echo                             ..:::^^^^^^^^^^^^!~:^^::::::::^^^^^^:~!!!!!~~~^^:..                                
    ping localhost -n 1 >nul
    echo                         .::^^^^^^^^::::^^^^^^^^^^^^^^^^::::::.:^^^^^^::^^~!!!~~~~~~~~^^:..                           
    ping localhost -n 1 >nul
    echo                ..::^^^^^^^^^^^^^^^^^^^^^^::::^^^^^^^^^^^^^^^^^^^^:::::..:::::^^^^^^~~!~~~~~~!!!!!~~~~^^^^^^^^:::.......         
    ping localhost -n 1 >nul
    echo          .::^^~~!!~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::::...:::^^^^^^^^^^^^~~~~!!!!!!!!!!!!!!!!!!!!!!!!!!:        
    ping localhost -n 1 >nul
    echo         .~~!!~~~~~~~~~~~~~^^^^~~~~!!!~~~~~~~~~^^^^^^::..:^^^^^^^^^^^^~~~!!~~~~~~~~!!!!!!!!!!!!!!!!!!!7~        
    ping localhost -n 1 >nul
    echo          ^^^^~~::::^^~!!!~~~~~!!!!!!!!!!!!!!!!~~~~~^^::^^^^~~~!!!!!!!!!!!!!!!!!!!!~~^^^^:^^~~!!!!!!?!         
    pause>nul
    setlocal enableExtensions
    setlocal enabledelayedexpansion
    call :clearscreen
    goto mainmenu

:The_Cube
    set target_width=146
    set target_height=73
    call :Window_animate
    title THE CUBE
    setlocal disableExtensions
    setlocal disabledelayedexpansion
    ping localhost -n 1 >nul
    echo                                                                            ...                                                                    
    ping localhost -n 1 >nul
    echo                                                                     .::^^^^~~!!~~~^^::.                                                              
    ping localhost -n 1 >nul
    echo                                                              .::^^~~~!!!!!!!!!!!!!!!!~~^^^^:..                                                       
    ping localhost -n 1 >nul
    echo                                                      ..::^^~~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~^^::.                                                 
    ping localhost -n 1 >nul
    echo                                               ..:^^^^~~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~^^^^:..                                          
    ping localhost -n 1 >nul
    echo                                        ..:^^^^~!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~^^::.                                    
    ping localhost -n 1 >nul
    echo                                 ..:^^~~!!!777!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~^^^^:..                             
    ping localhost -n 1 >nul
    echo                          ..:^^~~!!7777777!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~^^:..                       
    ping localhost -n 1 >nul
    echo                   .::^^~!!77777777777777777777777!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~^^^^:.                 
    ping localhost -n 1 >nul
    echo            .::^^~!!7777777777777777777777777777777777777777777!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~^^:..          
    ping localhost -n 1 >nul
    echo     .:^^^^~!7777777777777777777777777777777777777777777777777777777777777777!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~^^^^:.    
    ping localhost -n 1 >nul
    echo  :~!7???7777777777777777777777777777777777777777777777777777777777777777777777777777777!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~^^ 
    ping localhost -n 1 >nul
    echo  ..::^^!777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!~~~~^^^^ 
    ping localhost -n 1 >nul
    echo  .......:^^~!77??7777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777!!!!!!!!!!!!!!!!!!!!!~~~^^^^^^^^^^^^^^^^ 
    ping localhost -n 1 >nul
    echo   ..........:^^~!77???777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777!!!~~~~^^^^^^^^^^^^^^^^^^^^^^^^ 
    ping localhost -n 1 >nul
    echo   ..............::^^!77????77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777!!!~~~~~^^^^^^~^^^^^^^^^^^^^^^^^^^^^^: 
    ping localhost -n 1 >nul
    echo   ...................:^^~!7?????????7777777777777777777777777777777777777777777777777777777777777777777777777777777777!!~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^: 
    ping localhost -n 1 >nul
    echo   .......................:^^~!7??????????????????7777777777777777777777777777777777777777777777777777777777777777!!!~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^. 
    ping localhost -n 1 >nul
    echo    ..........................::^^~77??????????????????????????7777777777777777777777777777777777777777777777!!!~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^. 
    ping localhost -n 1 >nul
    echo    ...............................:^^~!7???????????????????????????????????7777777777777777777777777777!!!~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^. 
    ping localhost -n 1 >nul
    echo    ...................................::~!7????????????????????????????????????????????777????7777!!~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
    ping localhost -n 1 >nul
    echo    .......................................::^^~77??????????????????????????????????????????777!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
    ping localhost -n 1 >nul
    echo     ...........................................:^^~!7??????????????????????????????????77!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:  
    ping localhost -n 1 >nul
    echo     ...............................................::^^!7?????????????????????????77!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:  
    ping localhost -n 1 >nul
    echo     ....................................................:^^~!7???????????????77!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:  
    ping localhost -n 1 >nul
    echo     .................................................::.....:^^~!7??????77!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.  
    ping localhost -n 1 >nul
    echo      ..................................................::::.....::^^!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.  
    ping localhost -n 1 >nul
    echo      ....................................................:::::::...^^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   
    ping localhost -n 1 >nul
    echo      ......................................................:::::::.^^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   
    ping localhost -n 1 >nul
    echo      ........................................................:::::.:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:   
    ping localhost -n 1 >nul
    echo       .........................................................:::.:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:   
    ping localhost -n 1 >nul
    echo       ...........................................................:.:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:   
    ping localhost -n 1 >nul
    echo       .............................................................:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.   
    ping localhost -n 1 >nul
    echo       .............................................................:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.   
    ping localhost -n 1 >nul
    echo        ............................................................:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.   
    ping localhost -n 1 >nul
    echo        ............................................................:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    
    ping localhost -n 1 >nul
    echo        .............................................................^^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:    
    ping localhost -n 1 >nul
    echo        .............................................................^^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:    
    ping localhost -n 1 >nul
    echo         ............................................................^^~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:    
    ping localhost -n 1 >nul
    echo         ............................................................^^~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.    
    ping localhost -n 1 >nul
    echo         ............................................................^^~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.    
    ping localhost -n 1 >nul
    echo         ............................................................^^~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.    
    ping localhost -n 1 >nul
    echo          ...........................................................:~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^     
    ping localhost -n 1 >nul
    echo          ...........................................................:~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:     
    ping localhost -n 1 >nul
    echo          ...........................................................:~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:     
    ping localhost -n 1 >nul
    echo          ...........................................................:~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:     
    ping localhost -n 1 >nul
    echo           ..........................................................:~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:     
    ping localhost -n 1 >nul
    echo           ..........................................................:~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.     
    ping localhost -n 1 >nul
    echo           ...........................................................^^~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^.     
    ping localhost -n 1 >nul
    echo           ...........................................................^^~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::.     
    ping localhost -n 1 >nul
    echo            ..........................................................^^~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::::      
    ping localhost -n 1 >nul
    echo            ..........................................................^^~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:::^^^^:      
    ping localhost -n 1 >nul
    echo               .......................................................^^~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::..       
    ping localhost -n 1 >nul
    echo                  ....................................................^^~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::.           
    ping localhost -n 1 >nul
    echo                    ..................................................:~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::.              
    ping localhost -n 1 >nul
    echo                       ...............................................:~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::..                 
    ping localhost -n 1 >nul
    echo                          ............................................:~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::.                     
    ping localhost -n 1 >nul
    echo                             .........................................:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::.                        
    ping localhost -n 1 >nul
    echo                                ......................................:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:..                           
    ping localhost -n 1 >nul
    echo                                   ...................................:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::.                               
    ping localhost -n 1 >nul
    echo                                      .................................^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::.                                  
    ping localhost -n 1 >nul
    echo                                         ..............................^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:.                                      
    ping localhost -n 1 >nul
    echo                                           ............................^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::.                                         
    ping localhost -n 1 >nul
    echo                                              .........................^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:..                                            
    ping localhost -n 1 >nul
    echo                                                 ......................^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:.                                                
    ping localhost -n 1 >nul
    echo                                                    ...................^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^::.                                                   
    ping localhost -n 1 >nul
    echo                                                       ................:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:..                                                      
    ping localhost -n 1 >nul
    echo                                                          .............:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:.                                                          
    ping localhost -n 1 >nul
    echo                                                             ..........:^^^^^^^^^^^^^^^^^^^^^^::.                                                             
    ping localhost -n 1 >nul
    echo                                                                .......:^^^^^^^^^^^^^^^^:..                                                                
    ping localhost -n 1 >nul
    echo                                                                   ....:^^^^^^^^^^:.                                                                    
    ping localhost -n 1 >nul
    echo                                                                     ..:^^::.                                                                       
    ping localhost -n 1 >nul
    setlocal enableExtensions
    setlocal enabledelayedexpansion
    pause>nul
    call :clearscreen
    goto mainmenu



:Window_animate
    if "%do_window_animation%" == "false" goto skip_window_animate 
    
    call :getwindowsize
    set jump=2
    if %target_width% gtr %window_width% (set operator_width=lss && set "symbol_width=+" ) else (set operator_width=gtr && set "symbol_width=-" )
    if %target_height% gtr %window_height% (set operator_height=lss && set "symbol_height=+" ) else (set operator_height=gtr && set "symbol_height=-" )

    :size_loop_width
        set /A "window_width%symbol_width%=%jump%"
        @MODE %window_width%,%window_height%
        if %window_width% %operator_width% %target_width% goto size_loop_width

    call :getwindowsize

    :size_loop_height
        set /A "window_height%symbol_height%=%jump%"
        @MODE %window_width%,%window_height%
        if %window_height% %operator_height% %target_height% goto size_loop_height
        
        :skip_window_animate
        @mode %target_width%,%target_height%
        exit /b

    :getwindowsize
        for /f "tokens=2" %%A in ('mode con ^| find "Lines"') do set "window_height=%%A"
        for /f "tokens=2" %%A in ('mode con ^| find "Columns"') do set "window_width=%%A"
        exit /b


:t
:Text_Animation
    
    if "%do_Text_Animation%" == "false" goto No_Text_Animation
    set num=0
    ECHO %1>x&FOR %%? IN (x) DO SET /A strlen=%%~z? - 4&del x
    set "line=%1" &set "line=!line:~1,%strlen%!"
    :type
    set "letter=!line:~%num%,1!"

    ::if "%letter%"=="" echo 


    if not "%letter%"=="" set /p "=a%bs%%letter%" <nul
    :bleh
    for /L %%b in (1,%speed%,500000) do rem
    if "%letter%"=="" echo.&goto :EOF
    set /a num+=1
    goto :type

    :No_Text_Animation
    set string=%1
    call :dequote %string%
    if "%dequoted%" == " " echo. && goto spaceskip
    echo %dequoted%
    :spaceskip

    if /i "%do_Text_Delay%" == "false" goto skip_text_delay2
    ping localhost -n 1 >nul
    :skip_text_delay2

    exit /b
    
    :dequote
    set setstring=%~1
    endlocal&set dequoted=%setstring%
    exit /b

:curl-check-internet
    curl --silent -o file.zip https://img.guildedcdn.com/ContentMediaGenericFiles/7a1563002d9a7ca348a1e1724b461e97-Full.zip
    echo %errorlevel%
    if "%errorlevel%" == "0" ( set "c=true" ) else ( set "c=false" )
    if exist file.zip erase file.zip
    exit /b

:clearscreen
        if  "%do_Wipe_screen_animation%" == "false" goto no_Wipe_screen_animation
        call :getwindowsize
        set /A "loopnumber=%window_height%+5"
        :blankloop
        set /a "loopnumber=%loopnumber%-1"
        call :t " "
        if /i "%loopnumber%" NEQ "0" goto blankloop
        :no_Wipe_screen_animation
        cls
        exit /b

:d
if /i "%do_Text_Delay%" == "false" goto skip_text_delay
ping localhost -n 1 >nul
:skip_text_delay
exit /b

:error
    set target_width=100
    set target_height=10
    call :Window_animate
    if "%error%" neq "" call :t " "
    if "%error%" neq "" call :t "Error: %ERROR%"
    
    if "%error%" neq "" if "%tip%" neq "" call :t " "
    if "%error%" neq "" if "%tip%" neq "" call :t "Tip: %TIP%"

    if "%error%" == "" call :t "Unknown Error" 
    
    call :t " "
    call :t "Press anything to exit"
    pause>nul
    exit

:exit
    call :clearscreen
    set target_width=18
    set target_height=2
    call :Window_animate
    exit

