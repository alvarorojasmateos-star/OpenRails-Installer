@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

rem ===== EFECTO SALEWIN (5 SEGUNDOS) =====
goto :efecto_virus

:efecto_virus
cls
mode con: cols=120 lines=30
color 0F

setlocal enabledelayedexpansion
set "chars=!@#$%%^&*()_+-=[]{}|;:',.<>?/~`"
set /a contador=0

:virus_loop
cls
for /l %%i in (1,1,30) do (
    set /a random_pos=!RANDOM! %% 40
    set /a random_char=!RANDOM! %% 40
    set /a random_color=!RANDOM! %% 15 + 1
    
    setlocal enabledelayedexpansion
    for /f %%j in ('echo prompt $H ^| cmd') do set "BS=%%j"
    
    for /l %%k in (1,1,!random_pos!) do (
        set /p "=!chars:~!random_char!,1! " <nul
    )
)

set /a contador+=1
if %contador% lss 5 goto :virus_loop

rem ===== TRANSICION A NEGRO =====
cls
color 00
cls

rem ===== ESPERAR 1 SEGUNDO EN NEGRO =====
timeout /t 1 /nobreak >nul

rem ===== LIMPIAR Y COMENZAR MENU NORMAL =====
color 0F
cls
mode con: cols=80 lines=30

rem ===== VARIABLES GLOBALES =====
set "DESKTOP=%USERPROFILE%\Desktop"
set "BASE_DIR=%DESKTOP%\OpenRails"
set "APP_DIR=%BASE_DIR%\OpenRails_v175.1"
set "ROUTES_DIR=%APP_DIR%\Routes"
set "TEMP_DIR=%TEMP%\OpenRails_Temp"
set "LOG_FILE=%BASE_DIR%\OpenRails_install.log"
set "VERSION=1.0"

rem ===== URLS DE DESCARGAS =====
set "URL_MAIN=https://www.swisstransfer.com/dl/01a112e0-183c-72df-b0ec-b3dfd44e7174"
set "URL_GLOBAL=https://www.swisstransfer.com/dl/01a112e7-4954-724f-adde-7a2e2a0a96fe"
set "URL_CGL_RE=https://www.swisstransfer.com/dl/01a112f1-b12d-7323-a1c8-fd2fa651de27"
set "URL_CGL_NORE=https://www.swisstransfer.com/dl/01a112f2-4f34-7289-b5b5-bf2e701fd84f"
set "URL_CAT=https://www.swisstransfer.com/dl/01a112f3-6be0-70b2-91d3-8c08fe731d70"
set "URL_LARGA=https://www.swisstransfer.com/dl/01a112f3-dda4-7066-9383-724b3e2aa72e"

mkdir "%TEMP_DIR%" 2>nul
mkdir "%BASE_DIR%" 2>nul

goto :menu_principal

rem ===== MENU PRINCIPAL =====
:menu_principal
cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                     MENU PRINCIPAL                             ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  [1] ▶ Instalar Open Rails ^(v175.1^)
echo  [2] ▶ Instalar rutas
echo  [3] ▶ Ver estado de instalacion
echo  [4] ▶ Limpiar archivos temporales
echo  [5] ▶ Salir
echo.
echo  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
set /p "choice=  Selecciona una opcion: "

if "%choice%"=="1" goto :instalar_openrails
if "%choice%"=="2" goto :menu_rutas
if "%choice%"=="3" goto :ver_estado
if "%choice%"=="4" goto :limpiar_temp
if "%choice%"=="5" goto :salir
cls
echo.
echo  ⚠ Opcion invalida. Intenta de nuevo.
echo.
timeout /t 2 >nul
goto :menu_principal

rem ===== INSTALAR OPEN RAILS =====
:instalar_openrails
cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║              INSTALAR OPEN RAILS ^(v175.1^)                     ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  La instalacion se realizara en:
echo  %DESKTOP%\OpenRails
echo.
echo  ¿Aceptas continuar?
echo.
echo  [1] Si, continuar
echo  [2] No, volver atras
echo.
set /p "accept=  Selecciona una opcion: "

if "%accept%"=="2" goto :menu_principal
if not "%accept%"=="1" (
    cls
    echo  ⚠ Opcion invalida.
    timeout /t 2 >nul
    goto :instalar_openrails
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                    DESCARGANDO ARCHIVO                         ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ⏱ Iniciando descarga de Open Rails v175.1...
echo  📁 Destino: %DESKTOP%\OpenRails.zip
echo.
echo  ⚠ IMPORTANTE: No mover Open Rails hasta terminar con todas
echo    las instalaciones desde este instalador.
echo.
echo  ↓ Abriendo descargador en primer plano...
echo.
timeout /t 3 >nul

call :descargar_archivo "%URL_MAIN%" "%DESKTOP%\OpenRails.zip"

if errorlevel 1 (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                      ERROR DE DESCARGA                         ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo  ✗ No se pudo descargar el archivo de Open Rails.
    echo.
    echo  Verifica tu conexion a internet e intenta de nuevo.
    echo.
    timeout /t 4 >nul
    goto :menu_principal
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                  EXTRAYENDO ARCHIVOS                           ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ⏱ Esperando 10 segundos antes de extraer...
echo.

for /l %%i in (10,-1,1) do (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                  EXTRAYENDO ARCHIVOS                           ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo  ⏱ Iniciando extraccion en: %%i segundos...
    echo.
    timeout /t 1 >nul
)

call :extraer_archivo "%DESKTOP%\OpenRails.zip" "%DESKTOP%"

if errorlevel 1 (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                      ERROR DE EXTRACCION                       ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo  ✗ No se pudo extraer el archivo correctamente.
    echo.
    timeout /t 3 >nul
    goto :menu_principal
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║              DESCARGA Y EXTRACCION COMPLETADA                  ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ✓ Open Rails v175.1 ha sido descargado y extraido correctamente.
echo.
echo  Ahora necesitas instalar los archivos globales ^(obligatorio^).
echo.
echo  [1] Instalar global ^(obligatorio^)
echo  [2] Volver al menu
echo  [3] Cerrar aplicacion
echo.
set /p "after=  Selecciona una opcion: "

if "%after%"=="1" goto :instalar_global
if "%after%"=="2" goto :menu_principal
if "%after%"=="3" goto :salir
cls
echo  ⚠ Opcion invalida.
timeout /t 2 >nul
goto :instalar_openrails

rem ===== INSTALAR GLOBAL =====
:instalar_global
cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                    INSTALANDO ARCHIVOS GLOBALES                ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ⏱ Descargando archivos globales...
echo.
timeout /t 2 >nul

call :descargar_archivo "%URL_GLOBAL%" "%TEMP_DIR%\global_install.zip"

if errorlevel 1 (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                  ERROR AL DESCARGAR GLOBAL                     ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo  ✗ No se pudo descargar los archivos globales.
    echo.
    timeout /t 3 >nul
    goto :menu_principal
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                  EXTRAYENDO ARCHIVOS GLOBALES                  ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ⏱ Extrayendo en: %DESKTOP%\OpenRails
echo.
timeout /t 2 >nul

call :extraer_archivo "%TEMP_DIR%\global_install.zip" "%DESKTOP%\OpenRails"

if errorlevel 1 (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                ERROR AL EXTRAER ARCHIVOS GLOBALES              ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo  ✗ Error durante la extraccion.
    echo.
    timeout /t 3 >nul
    goto :menu_principal
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║              INSTALACION GLOBAL COMPLETADA                     ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ✓ Archivos globales instalados correctamente.
echo.
echo  ✓ Open Rails esta listo para usar.
echo.
echo  Presiona cualquier tecla para volver al menu...
pause >nul
goto :menu_principal

rem ===== MENU RUTAS =====
:menu_rutas
cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                    INSTALAR RUTAS                              ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  Selecciona una ruta para instalar:
echo.
echo  [1] ▶ CGL_RE
echo  [2] ▶ CGL_NORE
echo  [3] ▶ CAT
echo  [4] ▶ LARGA DISTANCIA
echo.
echo  [5]   Proximamente
echo  [6]   Proximamente
echo  [7]   Proximamente
echo  [8]   Proximamente
echo  [9]   Proximamente
echo  [10]  Proximamente
echo.
echo  [11] ◄ Volver atras
echo.
set /p "route=  Selecciona una ruta: "

if "%route%"=="1" call :instalar_ruta "CGL_RE" "%URL_CGL_RE%"
if "%route%"=="2" call :instalar_ruta "CGL_NORE" "%URL_CGL_NORE%"
if "%route%"=="3" call :instalar_ruta "CAT" "%URL_CAT%"
if "%route%"=="4" call :instalar_ruta "LARGA DISTANCIA" "%URL_LARGA%"
if "%route%"=="11" goto :menu_principal
if %route% geq 5 if %route% leq 10 (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                  PROXIMAMENTE DISPONIBLE                       ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo  ⏱ Esta ruta estara disponible pronto.
    echo.
    timeout /t 2 >nul
    goto :menu_rutas
)

cls
echo  ⚠ Opcion invalida.
timeout /t 2 >nul
goto :menu_rutas

rem ===== INSTALAR RUTA (SUBRUTINA) =====
:instalar_ruta
setlocal
set "route_name=%~1"
set "route_url=%~2"

if not exist "%DESKTOP%\OpenRails" (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║              ERROR: OPEN RAILS NO INSTALADO                    ║
    echo  ╚════════════════════════════���═══════════════════════════════════╝
    echo.
    echo  ✗ Primero debes instalar Open Rails.
    echo.
    echo  Presiona cualquier tecla para volver...
    pause >nul
    endlocal
    goto :menu_rutas
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                  INSTALAR RUTA: %route_name%
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ⏱ Descargando ruta %route_name%...
echo.
timeout /t 2 >nul

call :descargar_archivo "%route_url%" "%TEMP_DIR%\%route_name%.zip"

if errorlevel 1 (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                ERROR AL DESCARGAR LA RUTA                      ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo  ✗ No se pudo descargar %route_name%.
    echo.
    timeout /t 3 >nul
    endlocal
    goto :menu_rutas
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                  EXTRAYENDO RUTA: %route_name%
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ⏱ Extrayendo en: %DESKTOP%\OpenRails
echo.
timeout /t 2 >nul

call :extraer_archivo "%TEMP_DIR%\%route_name%.zip" "%DESKTOP%\OpenRails"

if errorlevel 1 (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                  ERROR AL EXTRAER LA RUTA                      ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo  ✗ Error durante la extraccion de %route_name%.
    echo.
    timeout /t 3 >nul
    endlocal
    goto :menu_rutas
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║              RUTA INSTALADA CORRECTAMENTE                      ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ✓ %route_name% ha sido instalada exitosamente.
echo.
echo  Presiona cualquier tecla para volver...
pause >nul
endlocal
goto :menu_rutas

rem ===== VER ESTADO =====
:ver_estado
cls
call :dibujar_header
echo.
echo  ╔═════════════════════════════════════════════════════��══════════╗
echo  ║                  ESTADO DE INSTALACION                         ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.

if exist "%DESKTOP%\OpenRails" (
    echo  ✓ Open Rails instalado
    echo    Ubicacion: %DESKTOP%\OpenRails
) else (
    echo  ✗ Open Rails no instalado
)

echo.
if exist "%DESKTOP%\OpenRails\OpenRails_v175.1" (
    echo  ✓ Archivos globales instalados
) else (
    echo  ✗ Archivos globales no instalados
)

echo.
if exist "%DESKTOP%\OpenRails\OpenRails_v175.1\Routes" (
    echo  ✓ Carpeta de rutas existente
    for /d %%i in ("%DESKTOP%\OpenRails\OpenRails_v175.1\Routes\*") do (
        echo    - %%~ni
    )
) else (
    echo  ✗ Sin carpeta de rutas
)

echo.
echo  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
echo  Presiona cualquier tecla para volver...
pause >nul
goto :menu_principal

rem ===== LIMPIAR TEMPORALES =====
:limpiar_temp
cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║              LIMPIAR ARCHIVOS TEMPORALES                       ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ¿Deseas limpiar los archivos temporales?
echo.
echo  [1] Si
echo  [2] No
echo.
set /p "clean=  Selecciona: "

if "%clean%"=="2" goto :menu_principal
if not "%clean%"=="1" (
    cls
    echo  ⚠ Opcion invalida.
    timeout /t 2 >nul
    goto :limpiar_temp
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                  LIMPIANDO...                                  ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
timeout /t 1 >nul

if exist "%TEMP_DIR%" (
    rmdir /s /q "%TEMP_DIR%" 2>nul
)

if exist "%DESKTOP%\OpenRails.zip" (
    del /q "%DESKTOP%\OpenRails.zip" 2>nul
)

if exist "%DESKTOP%\*.zip" (
    del /q "%DESKTOP%\CGL_*.zip" 2>nul
    del /q "%DESKTOP%\CAT.zip" 2>nul
    del /q "%DESKTOP%\LARGA*.zip" 2>nul
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                  LIMPIEZA COMPLETADA                           ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  ✓ Archivos temporales eliminados.
echo.
timeout /t 2 >nul
goto :menu_principal

rem ===== SALIR =====
:salir
cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                      HASTA LUEGO                               ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
echo  Gracias por usar Open Rails Installer v%VERSION%
echo.
echo  Cualquier duda o bug: alvaro6196 en Discord
echo.
timeout /t 2 >nul
exit /b

rem ===== FUNCIONES AUXILIARES =====
:dibujar_header
cls
echo.
echo  ██████╗ ██████╗ ███████╗███╗   ██╗    ██████╗  █████╗ ██╗██╗      ███████╗
echo  ██╔═══██╗██╔══██╗██╔════╝████╗  ██║    ██╔══██╗██╔══██╗██║██║      ██╔════╝
echo  ██║   ██║██████╔╝█████╗  ██╔██╗ ██║    ██████╔╝███████║██║██║      ███████╗
echo  ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║    ██╔══██╗██╔══██║██║██║      ╚════██║
echo  ╚██████╔╝██║     ███████╗██║ ╚████║    ██║  ██║██║  ██║██║███████╗███████║
echo   ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
echo.
echo  cualquier sugerencia o bug alvaro6196 en Discord
echo.
exit /b

rem ===== DESCARGAR ARCHIVO (CON POWERSHELL EN PRIMER PLANO) =====
:descargar_archivo
setlocal
set "url=%~1"
set "output=%~2"
set "ps_script=%TEMP%\OpenRails_Download.ps1"

(
    echo Add-Type -AssemblyName System.Windows.Forms
    echo $global:downloadComplete = $false
    echo $global:downloadError = $false
    echo.
    echo try {
    echo     $url = '%url%'
    echo     $output = '%output%'
    echo     $WebClient = New-Object System.Net.WebClient
    echo.
    echo     Write-Host '↓ Descargando desde: ' -NoNewLine
    echo     Write-Host $url -ForegroundColor Cyan
    echo     Write-Host '↓ Guardando en: ' -NoNewLine
    echo     Write-Host $output -ForegroundColor Yellow
    echo     Write-Host ''
    echo.
    echo     $WebClient.DownloadFile($url, $output^)
    echo     $global:downloadComplete = $true
    echo     Write-Host '✓ Descarga completada exitosamente.' -ForegroundColor Green
    echo } catch {
    echo     $global:downloadError = $true
    echo     Write-Host '✗ Error en la descarga: ' -ForegroundColor Red -NoNewLine
    echo     Write-Host $_.Exception.Message -ForegroundColor Red
    echo }
    echo.
    echo Read-Host 'Presiona Enter para continuar'
) > "%ps_script%"

powershell -NoProfile -ExecutionPolicy Bypass -File "%ps_script%"
set "result=%errorlevel%"

if exist "%output%" (
    del "%ps_script%"
    endlocal
    exit /b 0
) else (
    del "%ps_script%"
    endlocal
    exit /b 1
)

rem ===== EXTRAER ARCHIVO (CON POWERSHELL EN PRIMER PLANO) =====
:extraer_archivo
setlocal
set "zip=%~1"
set "dest=%~2"
set "ps_script=%TEMP%\OpenRails_Extract.ps1"

(
    echo Add-Type -AssemblyName System.Windows.Forms
    echo.
    echo try {
    echo     $zip = '%zip%'
    echo     $dest = '%dest%'
    echo.
    echo     Write-Host '↓ Extrayendo: ' -NoNewLine
    echo     Write-Host $zip -ForegroundColor Cyan
    echo     Write-Host '↓ Destino: ' -NoNewLine
    echo     Write-Host $dest -ForegroundColor Yellow
    echo     Write-Host ''
    echo.
    echo     Expand-Archive -Path $zip -DestinationPath $dest -Force -ErrorAction Stop
    echo     Write-Host '✓ Extraccion completada exitosamente.' -ForegroundColor Green
    echo } catch {
    echo     Write-Host '✗ Error en la extraccion: ' -ForegroundColor Red -NoNewLine
    echo     Write-Host $_.Exception.Message -ForegroundColor Red
    echo }
    echo.
    echo Read-Host 'Presiona Enter para continuar'
) > "%ps_script%"

powershell -NoProfile -ExecutionPolicy Bypass -File "%ps_script%"
set "result=%errorlevel%"

del "%ps_script%"

if %result% equ 0 (
    endlocal
    exit /b 0
) else (
    endlocal
    exit /b 1
)

endlocal
