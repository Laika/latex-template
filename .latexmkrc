#!/usr/bin/perl

@default_files  = ('main.tex');
$out_dir        = 'output/';


$lualatex       = 'lualatex %O %S';
$bibtex         = 'pbibtex %O %B';
$makeindex      = 'mendex %O -o %D %S';
$max_repeat     = 10;
$pdf_mode       = 4; # LuaLaTeX

$ENV{TZ} = 'Asia/Tokyo';
$ENV{OPENTYPEFONTS} = '/usr/share/fonts//:';
$ENV{TTFONTS} = '/usr/share/fonts//:';
