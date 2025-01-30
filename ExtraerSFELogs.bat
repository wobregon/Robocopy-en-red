@echo off
:: Script para extraer y copiar archivos específicos con base en la nomenclatura SFE-YYYY-MM-DD.
:: Busca exclusivamente los archivos de 2024 con fecha 13 y 15 de diciembre.

:: Configuración de las rutas
set ORIGEN=\\166.26.6.190\C$\Kinpos\logs
set DESTINO=\\10.5.133.8\cloud\AIA\Temp
set LOGFILE=C:\Temp\ExtraccionLogs.log

:: Crear la carpeta de destino si no existe
if not exist "%DESTINO%" (
    echo [INFO] %date% %time% - Creando carpeta de destino: %DESTINO%
    mkdir "%DESTINO%"
)

:: Crear archivo de log si no existe
if not exist "C:\Temp" mkdir C:\Temp
if exist "%LOGFILE%" del /f /q "%LOGFILE%"
echo [INFO] %date% %time% - Iniciando extracción de logs. > "%LOGFILE%"

echo Iniciando proceso de copia de logs...
echo.

:: Buscar y copiar archivos específicos
for %%F in ("%ORIGEN%\SFE-2024-12-13.log" "%ORIGEN%\SFE-2024-12-15.log") do (
    if exist "%%F" (
        echo Archivo encontrado: %%F
        echo [INFO] %date% %time% - Archivo encontrado: %%F >> "%LOGFILE%"
        
        :: Copiar archivo al destino
        copy "%%F" "%DESTINO%" >nul
        if %errorlevel% equ 0 (
            echo [INFO] %date% %time% - Archivo copiado exitosamente: %%F >> "%LOGFILE%"
        ) else (
            echo [ERROR] %date% %time% - Error al copiar el archivo: %%F >> "%LOGFILE%"
        )
    ) else (
        echo [WARNING] %date% %time% - Archivo no encontrado: %%F >> "%LOGFILE%"
    )
)

:: Finalización
echo Proceso completado.
echo [INFO] %date% %time% - Proceso completado. >> "%LOGFILE%"
echo Los detalles se encuentran en el log: %LOGFILE%.
pause
