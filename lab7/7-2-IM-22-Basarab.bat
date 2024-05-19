@echo off
ML /c /coff "7-2-IM-22-Basarab.asm"
ML /c /coff "7-2-IM-22-Basarab-PUBLIC.asm"
LINK /subsystem:windows "7-2-IM-22-Basarab.obj" "7-2-IM-22-Basarab-PUBLIC.obj"
7-2-IM-22-Basarab.exe