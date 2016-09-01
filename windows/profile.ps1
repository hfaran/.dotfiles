# Ensure that $profile sources this file by appending:
# `. C:\Users\Hamza\profile.ps1` or wherever this file lives
# to the file which as $profile


###########
# Imports #
###########

$env:PSModulePath = $env:PSModulePath + ";E:\Documents\WindowsPowerShell\modules"

Import-Module PSReadLine
Add-Type -AssemblyName System.Windows.Forms


############################
# Configuration #
############################

# Initialize pshazz (install using scoop)
try { $null = gcm pshazz -ea stop; pshazz init } catch { }

# Set "Menu" (bash style) completion with Tab key rather than Ctrl-Space; https://github.com/lzybkr/PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function Complete

# Persistent History setup; https://software.intel.com/en-us/blogs/2014/06/17/giving-powershell-a-persistent-history-of-commands
$HistoryFilePath = Join-Path ([Environment]::GetFolderPath('UserProfile')) .ps_history
Register-EngineEvent PowerShell.Exiting -Action { Get-History | Export-Clixml $HistoryFilePath } | out-null
If (Test-path $HistoryFilePath) { Import-Clixml $HistoryFilePath | Add-History }
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward


###########
# Aliases #
###########

# git
Function gs {git status $args}
Function gd {git diff $args}
Function clean_this_git_up {git clean -ndfx -e .idea}
Function clean_this_git_up_for_real {git clean -dfx -e .idea}

Function catp {pygmentize -g $args}
New-Item alias:subl -value "C:\Program Files\Sublime Text 3\sublime_text.exe"
Function service ($name, $action) {sudo net $action $name}

# Navigational aliases
Function up {cd ..}
Function .. {cd ..}
Function ... {cd ../..}
Function .... {cd ../../..}
Function ..... {cd ../../../..}
Function ...... {cd ../../../../..}


#####################
# Utility Functions #
#####################

Function read_path {
    return [Environment]::GetEnvironmentVariable("PATH", "User")
}

Function set_path ($path) {
    [Environment]::SetEnvironmentVariable("PATH", $path, "User")
}

Function append_path ($ext) {
    $path = read_path
    set_path ($path + $ext)
}

Function edit_path {
    # Save existing PATH to temp file and open it with sublime for editing
    $temp_file_path = "C:\temp\ " + [guid]::NewGuid().guid
    read_path | Out-File $temp_file_path
    subl $temp_file_path
    # Wait for user to finish editing
    Write-Host "When finished editing, press any key to continue..."
    $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    # Read new PATH from temp file and set
    set_path (Get-Content $temp_file_path)
    # Remove temp file
    Remove-Item $temp_file_path
}

Function set_power_state ($t, $PowerState) {
    <#
    .DESCRIPTION
    Starts a job that sleeps $t seconds before setting machine power state
    Reference:
    * http://stackoverflow.com/questions/20713782/suspend-or-hibernate-from-powershell
    * http://stackoverflow.com/questions/12766174/how-to-execute-a-powershell-function-several-times-in-parallel

    .PARAMETER t
    Number of seconds to sleep before shutdown
    .PARAMETER PowerState
    The PowerState from [System.Windows.Forms.PowerState] to set
    #>
    $sleep_cmd = {
        param($t, $PowerState)
        # ScriptBlock is in a different context so we have to re-import Forms
        Add-Type -AssemblyName System.Windows.Forms
        Start-Sleep $t  # Wait $t seconds before suspending
        [System.Windows.Forms.Application]::SetSuspendState($PowerState, $false, $false)
    }
    Start-Job -ScriptBlock $sleep_cmd -ArgumentList $t, $PowerState
}

Function suspend ($t) {
    $PowerState = [System.Windows.Forms.PowerState]::Suspend;
    set_power_state $t $PowerState
}

Function hibernate ($t) {
    $PowerState = [System.Windows.Forms.PowerState]::Hibernate;
    set_power_state $t $PowerState
}

Function open ($f) {
    Invoke-Item $f
}

Function e {
    exit
}

Function IAmAdmin () {
    # http://superuser.com/a/749259
    return [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
}
