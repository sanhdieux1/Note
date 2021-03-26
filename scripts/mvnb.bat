echo off
SETLOCAL ENABLEDELAYEDEXPANSION
SET str=%1
SET currentProject=xecm
rem for %%I in (..) do (
rem    SET currentProject=%%~nxI
rem )
for /d %%D in (*) do (
    SET folderName=%%~nxD
    if not "!folderName:-ear=!"=="!folderName!" (
        SET currentProject=!folderName:-ear=!
    )
)
echo project name: !currentProject!

if "%1" == "" (
    echo mvn clean install -DskipTests=true -Dmaven.javadoc.skip=true
    call mvn -f ./ -DskipTests=true -Dmaven.javadoc.skip=true -nsu clean install
    goto:eof
) else (
    GOTO specialModule
)

:specialModule
   (
        SET subject=!currentProject!-%1
        for %%a in (%*) do (
            if not %%a == %1 (SET "subject=!subject!,!currentProject!-%%a")
        )
        echo mvn -DskipTests=true -Dmaven.javadoc.skip=true clean install -pl :!subject!
        call mvn -f ./ -DskipTests=true -Dmaven.javadoc.skip=true -nsu clean install -pl :!subject!
        goto:eof
    )

:specialProfile
 (
    echo mvn clean install -P%1 -DskipTests=true -Dmaven.javadoc.skip=true
    call mvn -f ./ -DskipTests=true -Dmaven.javadoc.skip=true -nsu clean install -P%1
    goto:eof
 )