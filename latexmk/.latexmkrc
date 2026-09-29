use Cwd;
$success_cmd = 'ln -sf %D .';
$aux_dir = $out_dir = ($ENV{XDG_CACHE_HOME} || "$ENV{HOME}/.cache") . "/latex" . getcwd();
