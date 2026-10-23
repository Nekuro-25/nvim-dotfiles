<?php

// Config cadangan php-cs-fixer. Neovim hanya memakainya bila proyek TIDAK punya
// .php-cs-fixer.php / .php-cs-fixer.dist.php. Aturan: PSR-12 dengan indentasi TAB.
return (new PhpCsFixer\Config())
	->setRules([
		'@PSR12' => true,
		'indentation_type' => true,
	])
	->setIndent("\t")
	->setLineEnding("\n");
