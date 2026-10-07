@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

rem =============================================================
rem   INTRO + EFECTO FAKE VIRUS + MENU OPEN RAILS
rem   CON EFECTO DE ESCRITURA EN TIEMPO REAL
rem =============================================================

rem ===== VARIABLES =====
set "DESKTOP=%USERPROFILE%\Desktop"
set "BASE_DIR=%DESKTOP%\OpenRails"
set "APP_DIR=%BASE_DIR%\OpenRails_v175.1"
set "TEMP_DIR=%TEMP%\OpenRails_Temp"
set "LOG_FILE=%BASE_DIR%\OpenRails_install.log"
set "VERSION=1.0"

set "URL_MAIN=https://www.swisstransfer.com/dl/01a112e0-183c-72df-b0ec-b3dfd44e7174"
set "URL_GLOBAL=https://www.swisstransfer.com/dl/01a112e7-4954-724f-adde-7a2e2a0a96fe"
set "URL_CGL_RE=https://www.swisstransfer.com/dl/01a112f1-b12d-7323-a1c8-fd2fa651de27"
set "URL_CGL_NORE=https://www.swisstransfer.com/dl/01a112f2-4f34-7289-b5b5-bf2e701fd84f"
set "URL_CAT=https://www.swisstransfer.com/dl/01a112f3-6be0-70b2-91d3-8c08fe731d70"
set "URL_LARGA=https://www.swisstransfer.com/dl/01a112f3-dda4-7066-9383-724b3e2aa72e"

mkdir "%TEMP_DIR%" 2>nul
mkdir "%BASE_DIR%" 2>nul

rem ===== INTRO CON EFECTO DE ESCRITURA =====
:inicio_intro
cls
mode con: cols=100 lines=30
color 0F

echo.
echo      ╔══════════════════════════════════════════════════════════════════╗
echo      ║                                                              ║

call :escribir "      ║   Gracias por confiar" 100
call :escribir "      ║   abriendo mi primer instaler" 100
echo      ║                                                              ║
call :escribir "      ║   Ahora vas a ver un intro guay..." 100
call :escribir "      ║   tu solo relax" 100
echo      ║                                                              ║
echo      ╚══════════════════════════════════════════════════════════════════╝
echo.
call :escribir "      Pulsa cualquier tecla para continuar..." 50
pause >nul

rem ===== EFECTO FAKE VIRUS / SALEWIN (5 segundos) =====
:efecto_virus
cls
color 0A
mode con: cols=120 lines=30

call :escribir "  ███████████████████████████████████████████████████████████████████████████████" 5
call :escribir "  █                                                                        █" 5
call :escribir "  █      Sistema detectado" 30
call :escribir "  █      Analizando archivos del sistema..." 30
call :escribir "  █      Conectando con la red local..." 30
call :escribir "  █      Verificando permisos..." 30
call :escribir "  █                                                                        █" 5
call :escribir "  ███████████████████████████████████████████████████████████████████████████████" 5
echo.

for /L %%i in (1,1,5) do (
    cls
    color 0!random!
    echo.
    echo  ██████████████████████████████████████��██████████████████████████████████████████
    echo  █                                                                        █
    for /L %%n in (1,1,18) do (
        set /a "r=!random! %% 10"
        for /L %%k in (1,1,!r!) do set /p "=░" <nul
        echo.
    )
    echo  █                                                                        █
    echo  █████████████████████████████████████████████████████████████████████████████████
    echo.
    call :escribir "  [!!!] seguridad comprometida [!!!]" 20
    call :escribir "  Cargando interfaz principal..." 20
    timeout /t 1 /nobreak >nul
)

cls
color 00
timeout /t 1 /nobreak >nul

rem ===== MENU PRINCIPAL CON EFECTO DE ESCRITURA =====
:menu_principal
cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                     MENU PRINCIPAL                             ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
call :escribir "  [1] ▶ Instalar Open Rails (v175.1)" 20
call :escribir "  [2] ▶ Instalar rutas" 20
call :escribir "  [3] ▶ Ver estado de instalacion" 20
call :escribir "  [4] ▶ Limpiar archivos temporales" 20
call :escribir "  [5] ▶ Salir" 20
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
call :escribir "  ⚠ Opcion invalida. Intenta de nuevo." 50
echo.
timeout /t 2 >nul
goto :menu_principal

rem ===== INSTALAR OPEN RAILS =====
:instalar_openrails
cls
call :dibujar_header
echo.
echo  ╔══════════════════════════��═════════════════════════════════════╗
echo  ║              INSTALAR OPEN RAILS ^(v175.1^)                     ║
echo  ╚════════════════════════════════════════════════════════════════╝
echo.
call :escribir "  La instalacion se realizara en:" 50
call :escribir "  %DESKTOP%\OpenRails" 50
echo.
call :escribir "  ¿Aceptas continuar?" 50
echo.
call :escribir "  [1] Si, continuar" 30
call :escribir "  [2] No, volver atras" 30
echo.
set /p "accept=  Selecciona una opcion: "

if "%accept%"=="2" goto :menu_principal
if not "%accept%"=="1" (
    cls
    call :escribir "  ⚠ Opcion invalida." 50
    timeout /t 2 >nul
    goto :instalar_openrails
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                    DESCARGANDO ARCHIVO                         ║
echo  ╚═══════════════════���════════════════════════════════════════════╝
echo.
call :escribir "  ⏱ Iniciando descarga de Open Rails v175.1..." 50
call :escribir "  📁 Destino: %DESKTOP%\OpenRails.zip" 50
echo.
call :escribir "  ⚠ IMPORTANTE: No mover Open Rails hasta terminar con todas" 50
call :escribir "    las instalaciones desde este instalador." 50
echo.
call :escribir "  ↓ Abriendo descargador en primer plano..." 50
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
    call :escribir "  ✗ No se pudo descargar el archivo de Open Rails." 50
    echo.
    call :escribir "  Verifica tu conexion a internet e intenta de nuevo." 50
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
call :escribir "  ⏱ Esperando 10 segundos antes de extraer..." 50
echo.

for /l %%i in (10,-1,1) do (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                  EXTRAYENDO ARCHIVOS                           ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    call :escribir "  ⏱ Iniciando extraccion en: %%i segundos..." 10
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
    call :escribir "  ✗ No se pudo extraer el archivo correctamente." 50
    echo.
    timeout /t 3 >nul
    goto :menu_principal
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║              DESCARGA Y EXTRACCION COMPLETADA                  ║
echo  ╚════════════════════════════════��═══════════════════════════════╝
echo.
call :escribir "  ✓ Open Rails v175.1 ha sido descargado y extraido correctamente." 20
echo.
call :escribir "  Ahora necesitas instalar los archivos globales (obligatorio)." 50
echo.
call :escribir "  [1] Instalar global (obligatorio)" 30
call :escribir "  [2] Volver al menu" 30
call :escribir "  [3] Cerrar aplicacion" 30
echo.
set /p "after=  Selecciona una opcion: "

if "%after%"=="1" goto :instalar_global
if "%after%"=="2" goto :menu_principal
if "%after%"=="3" goto :salir
cls
call :escribir "  ⚠ Opcion invalida." 50
timeout /t 2 >nul
goto :instalar_openrails

rem ===== INSTALAR GLOBAL =====
:instalar_global
cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                    INSTALANDO ARCHIVOS GLOBALES                ║
echo  ╚═════════════════════════════════════════════════════════════���══╝
echo.
call :escribir "  ⏱ Descargando archivos globales..." 50
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
    call :escribir "  ✗ No se pudo descargar los archivos globales." 50
    echo.
    timeout /t 3 >nul
    goto :menu_principal
)

cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                  EXTRAYENDO ARCHIVOS GLOBALES                  ║
echo  ╚═══════════════════════════���════════════════════════════════════╝
echo.
call :escribir "  ⏱ Extrayendo en: %DESKTOP%\OpenRails" 50
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
    call :escribir "  ✗ Error durante la extraccion." 50
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
call :escribir "  ✓ Archivos globales instalados correctamente." 20
echo.
call :escribir "  ✓ Open Rails esta listo para usar." 20
echo.
call :escribir "  Presiona cualquier tecla para volver al menu..." 50
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
call :escribir "  Selecciona una ruta para instalar:" 50
echo.
call :escribir "  [1] ▶ CGL_RE" 20
call :escribir "  [2] ▶ CGL_NORE" 20
call :escribir "  [3] ▶ CAT" 20
call :escribir "  [4] ▶ LARGA DISTANCIA" 20
echo.
call :escribir "  [5]   Proximamente" 15
call :escribir "  [6]   Proximamente" 15
call :escribir "  [7]   Proximamente" 15
call :escribir "  [8]   Proximamente" 15
call :escribir "  [9]   Proximamente" 15
call :escribir "  [10]  Proximamente" 15
echo.
call :escribir "  [11] ◄ Volver atras" 20
echo.
set /p "route=  Selecciona una ruta: "

if "%route%"=="1" call :instalar_ruta "CGL_RE" "%URL_CGL_RE%"
if "%route%"=="2" call :instalar_ruta "CGL_NORE" "%URL_CGL_NORE%"
if "%route%"=="3" call :instalar_ruta "CAT" "%URL_CAT%"
if "%route%"=="4" call :instalar_ruta "LARGA DISTANCIA" "%URL_LARGA%"
if "%route%"=="11" goto :menu_principal
if "%route%" GEQ "5" if "%route%" LEQ "10" (
    cls
    call :dibujar_header
    echo.
    echo  ╔════════════════════════════════════════════════════════════════╗
    echo  ║                  PROXIMAMENTE DISPONIBLE                       ║
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    call :escribir "  ⏱ Esta ruta estara disponible pronto." 50
    echo.
    timeout /t 2 >nul
    goto :menu_rutas
)

cls
call :escribir "  ⚠ Opcion invalida." 50
timeout /t 2 >nul
goto :menu_rutas

rem ===== INSTALAR RUTA =====
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
    echo  ╚════════════════════════════════════════════════════════════════╝
    echo.
    call :escribir "  ✗ Primero debes instalar Open Rails." 50
    echo.
    call :escribir "  Presiona cualquier tecla para volver..." 50
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
call :escribir "  ⏱ Descargando ruta %route_name%..." 50
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
    call :escribir "  ✗ No se pudo descargar %route_name%." 50
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
call :escribir "  ⏱ Extrayendo en: %DESKTOP%\OpenRails" 50
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
    call :escribir "  ✗ Error durante la extraccion de %route_name%." 50
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
call :escribir "  ✓ %route_name% ha sido instalada exitosamente." 20
echo.
call :escribir "  Presiona cualquier tecla para volver..." 50
pause >nul
endlocal
goto :menu_rutas

rem ===== VER ESTADO =====
:ver_estado
cls
call :dibujar_header
echo.
echo  ╔════════════════════════════════════════════════════════════════╗
echo  ║                  ESTADO DE INSTALACION                         ║
echo  ╚══════════════════════════════��═════════════════════════════════╝
echo.

if exist "%DESKTOP%\OpenRails" (
    call :escribir "  ✓ Open Rails instalado" 20
    call :escribir "    Ubicacion: %DESKTOP%\OpenRails" 20
) else (
    call :escribir "  ✗ Open Rails no instalado" 50
)

echo.
if exist "%DESKTOP%\OpenRails\OpenRails_v175.1" (
    call :escribir "  ✓ Archivos globales instalados" 20
) else (
    call :escribir "  ✗ Archivos globales no instalados" 50
)

echo.
if exist "%DESKTOP%\OpenRails\OpenRails_v175.1\Routes" (
    call :escribir "  ✓ Carpeta de rutas existente" 20
    for /d %%i in ("%DESKTOP%\OpenRails\OpenRails_v175.1\Routes\*") do (
        call :escribir "    - %%~ni" 15
    )
) else (
    call :escribir "  ✗ Sin carpeta de rutas" 50
)

echo.
echo  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
call :escribir "  Presiona cualquier tecla para volver..." 50
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
call :escribir "  ¿Deseas limpiar los archivos temporales?" 50
echo.
call :escribir "  [1] Si" 30
call :escribir "  [2] No" 30
echo.
set /p "clean=  Selecciona: "

if "%clean%"=="2" goto :menu_principal
if not "%clean%"=="1" (
    cls
    call :escribir "  ⚠ Opcion invalida." 50
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

if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%" 2>nul
if exist "%DESKTOP%\OpenRails.zip" del /q "%DESKTOP%\OpenRails.zip" 2>nul
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
call :escribir "  ✓ Archivos temporales eliminados." 20
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
call :escribir "  Gracias por usar Open Rails Installer v%VERSION%" 20
echo.
call :escribir "  Cualquier duda o bug: alvaro6196 en Discord" 20
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
echo  ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║    ██���══██╗██╔══██║██║██║      ╚════██║
echo  ╚██████╔╝██║     ███████╗██║ ╚████║    ██║  ██║██║  ██║██║███████╗███████║
echo   ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
echo.
echo  cualquier sugerencia o bug alvaro6196 en Discord
echo.
exit /b

rem ===== EFECTO DE ESCRITURA =====
:escribir
setlocal EnableDelayedExpansion
set "texto=%~1"
set "velocidad=%~2"
for /L %%i in (0,1,1023) do (
    if "!texto:~%%i,1!"=="" goto :fin_escritura
    <nul set /p "=!texto:~%%i,1!"
    timeout /t 0 /nobreak >nul
)
:fin_escritura
echo.
endlocal
exit /b

rem ===== DESCARGAR ARCHIVO (POWERSHELL EN PRIMER PLANO) =====
:descargar_archivo
setlocal
set "url=%~1"
set "output=%~2"
set "ps_script=%TEMP%\OpenRails_Download.ps1"

(
    echo Add-Type -AssemblyName System.Windows.Forms
    echo try {
    echo     $url = '%url%'
    echo     $output = '%output%'
    echo     $wc = New-Object System.Net.WebClient
    echo     Write-Host 'Descargando desde:' $url -ForegroundColor Cyan
    echo     Write-Host 'Guardando en:' $output -ForegroundColor Yellow
    echo     $wc.DownloadFile($url, $output)
    echo     Write-Host 'Descarga completada.' -ForegroundColor Green
    echo } catch {
    echo     Write-Host 'Error en la descarga:' $_.Exception.Message -ForegroundColor Red
    echo     exit 1
    echo }
) > "%ps_script%"

powershell -NoProfile -ExecutionPolicy Bypass -File "%ps_script%"
set "result=%errorlevel%"
del "%ps_script%"
if "%result%"=="0" (
    endlocal
    exit /b 0
) else (
    endlocal
    exit /b 1
)

rem ===== EXTRAER ARCHIVO (POWERSHELL EN PRIMER PLANO) =====
:extraer_archivo
setlocal
set "zip=%~1"
set "dest=%~2"
set "ps_script=%TEMP%\OpenRails_Extract.ps1"

(
    echo try {
    echo     $zip = '%zip%'
    echo     $dest = '%dest%'
    echo     Write-Host 'Extrayendo:' $zip -ForegroundColor Cyan
    echo     Write-Host 'Destino:' $dest -ForegroundColor Yellow
    echo     Expand-Archive -Path $zip -DestinationPath $dest -Force -ErrorAction Stop
    echo     Write-Host 'Extraccion completada.' -ForegroundColor Green
    echo } catch {
    echo     Write-Host 'Error en la extraccion:' $_.Exception.Message -ForegroundColor Red
    echo     exit 1
    echo }
) > "%ps_script%"

powershell -NoProfile -ExecutionPolicy Bypass -File "%ps_script%"
set "result=%errorlevel%"
del "%ps_script%"
if "%result%"=="0" (
    endlocal
    exit /b 0
) else (
    endlocal
    exit /b 1
)

endlocal
