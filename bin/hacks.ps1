# 添加 timestamp 替换变量支持
$coreps = "$(scoop prefix scoop)\lib\core.ps1"

if ((Get-Content $coreps -Tail 1) -eq "setup_proxy") {
    @'

$substituteOrig = $function:substitute
function substitute($entity, [Hashtable] $params, [Bool]$regexEscape = $false) {
    $params['$timestamp'] = Get-Date -UFormat %s
    & $substituteOrig $entity $params $regexEscape
}
'@ |
    Out-File $coreps -Append -Encoding ascii
}

# 设置 hosts 直连获取更新
@(
    "`n"
    "124.161.37.35 resource.u-tools.cn"
) |
Out-File "$env:windir\System32\drivers\etc\hosts" -Append -Encoding ascii

ipconfig /flushdns

# 添加 force update
$SpecialSnowflakes = @(
    "utools"
) -join ","

"::set-env name=SpecialSnowflakes::$SpecialSnowflakes"
