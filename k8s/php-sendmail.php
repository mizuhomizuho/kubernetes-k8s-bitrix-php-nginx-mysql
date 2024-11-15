<?php

const MAILS_DIR = __DIR__ . '/mails';

$stream = '';
$fp = fopen('php://stdin','r');
while($t = fread($fp,2048)) {
    if($t === chr(0))
        break;
    $stream .= $t;
}
fclose($fp);

$mkName = function ($i=0) use (&$mkName): string {
    $fn = MAILS_DIR . '/' . date('Y') . '/' . date('m') . '/' . date('d');
    if (!file_exists($fn)) {
        mkdir($fn, 0777, true);
    }
    $fn .= '/' . date('H-i-s_') . $i . '.eml';
    if (file_exists($fn))
        return $mkName(++$i);
    return $fn;
};

file_put_contents($mkName(), $stream);

