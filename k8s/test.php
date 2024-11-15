<?php

//php -f /k8s/test.php

function xmktime()
{
    list($usec, $sec) = explode(" ", microtime());
    return ((float)$usec + (float)$sec);
}

$t = xmktime();
$path = '/var/www/app/web/bx_fs_test';
var_dump($path);
mkdir($path);
$res = true;

for($i=0;$i<1000;$i++)
{
    if (!(($f = fopen($path.'/bx_test_file_'.$i,'wb')) && fwrite($f, '<?php #Hello, world! ?>') && fclose($f)))
    {
        $res = false;
        break;
    }
    include($path.'/bx_test_file_'.$i);
}

if ($res)
    for($i=0;$i<1000;$i++)
        if (!unlink($path.'/bx_test_file_'.$i))
        {
            $res = false;
            break;
        }
rmdir($path);
$time = round(xmktime()-$t,2);
var_dump($time);