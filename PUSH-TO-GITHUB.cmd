@echo off
REM ============================================================
REM  DevShop - push everything to GitHub
REM  Double-click this file. It will ask for your GitHub
REM  username + password (use a Personal Access Token as the
REM  password) the first time, then push all branches + tags.
REM ============================================================
setlocal
cd /d "%~dp0"

echo.
echo === Step 1/3: forgetting the saved GitHub login ===
git config --global credential.helper ""
git config --global --unset-all credential.https://github.com.username 2>nul
echo Done.
echo.

echo === Step 2/3: checking the project builds ===
call npm install --silent
call npm run lint
if errorlevel 1 goto :fail
call npm test
if errorlevel 1 goto :fail
echo Project is healthy.
echo.

echo === Step 3/3: pushing branches, tags and history ===
git push -u origin main
git push origin develop
git push origin feature/order-tracking
git push origin feature/cart-coupons
git push origin --follow-tags
if errorlevel 1 goto :fail

echo.
echo ============================================================
echo  DONE. Open https://github.com/24107135-sudo/DevOpsA1
echo  and check the Actions tab in a couple of minutes.
echo ============================================================
pause
exit /b 0

:fail
echo.
echo FAILED - fix the error above and run this file again.
pause
exit /b 1
