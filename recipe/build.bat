go install -v -buildvcs=false -ldflags "-X github.com/gruntwork-io/terragrunt/internal/version.Version=v%PKG_VERSION%" .
if errorlevel 1 exit 1

:: Chroma's combined MIT/OFL license is not recognized by go-licenses.
go-licenses save . --save_path=library_licenses --ignore=github.com/alecthomas/chroma/v2
if errorlevel 1 exit 1
set "CHROMA_MODULE_DIR="
for /f "delims=" %%D in ('go list -m -f "{{.Dir}}" github.com/alecthomas/chroma/v2') do set "CHROMA_MODULE_DIR=%%D"
if not defined CHROMA_MODULE_DIR exit 1
copy /Y "%CHROMA_MODULE_DIR%\COPYING" "library_licenses\chroma-COPYING"
if errorlevel 1 exit 1
