go install -v -ldflags "-X github.com/gruntwork-io/terragrunt/internal/version.Version=v%PKG_VERSION%" .
if errorlevel 1 exit 1

for %%C in (activate deactivate) do (
    if not exist "%PREFIX%\etc\conda\%%C.d" mkdir "%PREFIX%\etc\conda\%%C.d"
    copy /Y "%RECIPE_DIR%\%%C.sh"   "%PREFIX%\etc\conda\%%C.d\%PKG_NAME%_%%C.sh"
    if errorlevel 1 exit 1
    copy /Y "%RECIPE_DIR%\%%C.fish" "%PREFIX%\etc\conda\%%C.d\%PKG_NAME%_%%C.fish"
    if errorlevel 1 exit 1
)
