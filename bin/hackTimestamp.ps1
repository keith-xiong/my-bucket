$coreps = "$(scoop prefix scoop)\lib\core.ps1"

if ((Get-Content $coreps -Tail 1) -eq "setup_proxy") {
@'

$substituteOrig = $function:substitute
function substitute($entity, [Hashtable] $params, [Bool]$regexEscape = $false) {
    $params['$timestamp'] = Get-Date | % Subtract ([datetime]"1970.1") | % Ticks
    & $substituteOrig $entity $params $regexEscape
}
'@ |
Out-File $coreps -Append -Encoding ascii
}
