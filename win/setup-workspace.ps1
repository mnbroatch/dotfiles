# === Config ===
$vdDll = "$PSScriptRoot\VirtualDesktopAccessor.dll"
$vdUrl = "https://github.com/Ciantic/VirtualDesktopAccessor/releases/download/2024-12-16-windows11/VirtualDesktopAccessor.dll"
$LOCALHOST_PORT = 8080

# Variable to store the terminal window handle from Desktop 1
$Desktop1TerminalHandle = [IntPtr]::Zero

try {
    # --- Step 1: Ensure DLL is present ---
    if (-not (Test-Path $vdDll)) {
        Write-Host "Downloading VirtualDesktopAccessor.dll..."
        Invoke-WebRequest -Uri $vdUrl -OutFile $vdDll
    } else {
        Write-Host "VirtualDesktopAccessor.dll already present."
    }
    
    # --- Step 2: Load DLL ---
    Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class VirtualDesktopWrapper {
    [DllImport("VirtualDesktopAccessor.dll", CallingConvention = CallingConvention.Cdecl)]
    public static extern int GetDesktopCount();
    [DllImport("VirtualDesktopAccessor.dll", CallingConvention = CallingConvention.Cdecl)]
    public static extern void CreateDesktop();
    [DllImport("VirtualDesktopAccessor.dll", CallingConvention = CallingConvention.Cdecl)]
    public static extern void GoToDesktopNumber(int number);
    [DllImport("VirtualDesktopAccessor.dll", CallingConvention = CallingConvention.Cdecl)]
    public static extern void MoveWindowToDesktopNumber(IntPtr hWnd, int number);
}
"@

    # --- Step 3: Win32 helper ---
    Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
    
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    
    [DllImport("user32.dll")]
    public static extern bool BringWindowToTop(IntPtr hWnd);
}
"@

    # --- Step 4: Ensure 5 desktops exist ---
    $total = [VirtualDesktopWrapper]::GetDesktopCount()
    while ($total -lt 5) {
        [VirtualDesktopWrapper]::CreateDesktop()
        Start-Sleep -Milliseconds 500
        $total = [VirtualDesktopWrapper]::GetDesktopCount()
    }
    Write-Host "Confirmed: $total desktops available."

    # --- Step 5: Helper function for launch and fullscreen ---
function Start-AppOnDesktop {
    param(
        [int]$Desktop,
        [string]$AppName,
        [string]$Executable,
        [object]$Arguments,
        [int]$DelayBeforeFullscreen = 500,
        [bool]$ReturnHandle = $false
    )
    
    Write-Host "Launching $AppName..."
    [VirtualDesktopWrapper]::GoToDesktopNumber($Desktop)
    Start-Sleep -Milliseconds 500
    
    $proc = Start-Process -FilePath $Executable -ArgumentList $Arguments -PassThru
    Start-Sleep -Milliseconds 1500
    
    $hwnd = [Win32]::GetForegroundWindow()
    
    if ($hwnd -ne [IntPtr]::Zero) {
        [VirtualDesktopWrapper]::MoveWindowToDesktopNumber($hwnd, $Desktop)
        [Win32]::SetForegroundWindow($hwnd)
        Start-Sleep -Milliseconds $DelayBeforeFullscreen
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.SendKeys]::SendWait("{F11}")
        Start-Sleep -Milliseconds 300
        Write-Host "  Successfully launched and fullscreened $AppName on Desktop $($Desktop + 1)"
    } else {
        Write-Host "  Warning: Could not get window handle for $AppName" -ForegroundColor Yellow
        $hwnd = [IntPtr]::Zero
    }
    
    if ($ReturnHandle) {
        Write-Host $hwnd -ForegroundColor Yellow

        return $hwnd
    }
}
    # --- Step 6: Launch apps on desktops ---
    
    Write-Host "Launching applications across desktops..."
    
    # Desktop 1: Terminal with startup script
$Desktop1TerminalHandle = (Start-AppOnDesktop -Desktop 0 -AppName "Desktop 1 terminal" -Executable "wt.exe" -Arguments '-p "Desktop1 Dev Terminal"' -DelayBeforeFullscreen 3000 -ReturnHandle $True)[-1]
        Write-Host $Desktop1TerminalHandle -ForegroundColor Blue

    
    # Desktop 2: Browser with localhost
    Start-AppOnDesktop -Desktop 1 -AppName "Desktop 2 browser" -Executable "msedge.exe" -Arguments @("--new-window", "http://localhost:$LOCALHOST_PORT")
    
    # Desktop 3: Browser with Claude.ai
    Start-AppOnDesktop -Desktop 2 -AppName "Desktop 3 browser" -Executable "msedge.exe" -Arguments @("--new-window", "https://claude.ai")
    
    # Desktop 4: Browser with Google
    Start-AppOnDesktop -Desktop 3 -AppName "Desktop 4 browser" -Executable "msedge.exe" -Arguments @("--new-window", "https://google.com")
    
    # Desktop 5: Terminal with split (special case)
    Write-Host "Launching Desktop 5 terminal with split..."
    [VirtualDesktopWrapper]::GoToDesktopNumber(4)
    Start-Sleep -Milliseconds 500
    
    $splitCommand = 'new-tab -p "Desktop5 Left Terminal" ; split-pane -p "Desktop5 Right Terminal"'
    $proc = Start-Process -FilePath "wt.exe" -ArgumentList $splitCommand -PassThru
    Start-Sleep -Milliseconds 1500
    $hwnd = [Win32]::GetForegroundWindow()
    
    if ($hwnd -ne [IntPtr]::Zero) {
        [VirtualDesktopWrapper]::MoveWindowToDesktopNumber($hwnd, 4)
        [Win32]::SetForegroundWindow($hwnd)
        Start-Sleep -Milliseconds 500
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.SendKeys]::SendWait("{F11}")
        Start-Sleep -Milliseconds 300
        Write-Host "  Successfully launched and fullscreened wt.exe on Desktop 5"
    } else {
        Write-Host "  Warning: Could not get window handle for wt.exe" -ForegroundColor Yellow
    }

    Write-Host "`nAll apps launched across 5 desktops!" -ForegroundColor Green
    
    # Return to the first desktop and refocus the terminal
    Write-Host "Returning to Desktop 1 and refocusing terminal..."
    [VirtualDesktopWrapper]::GoToDesktopNumber(0)
    Start-Sleep -Milliseconds 500


    
if ($Desktop1TerminalHandle -ne [IntPtr]::Zero) {
    Write-Host "Refocusing Desktop 1 terminal window..."
    [Win32]::ShowWindow($Desktop1TerminalHandle, 9)  # SW_RESTORE
    Start-Sleep -Milliseconds 200
    [Win32]::BringWindowToTop($Desktop1TerminalHandle)
    Start-Sleep -Milliseconds 200
    [Win32]::SetForegroundWindow($Desktop1TerminalHandle)
    Write-Host "Desktop 1 terminal is now focused!" -ForegroundColor Green
} else {
    Write-Host "Warning: Could not capture Desktop 1 terminal handle for refocusing" -ForegroundColor Yellow
}

    
} catch {
    Write-Host "Fatal error: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    if ($Host.UI.RawUI.WindowTitle -notlike "*Hidden*" -and [Environment]::GetCommandLineArgs() -notcontains "-WindowStyle") {
        Write-Host "`nPress any key to exit..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}