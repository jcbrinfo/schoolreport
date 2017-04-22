% Classe pour les rapports de travaux scolaires.
%
% Inspirée de [UqamLab](https://github.com/jcbrinfo/uqamlab) sur plusieurs
% points, mais avec moins de personnalisation de la mise en page.
%
% Conçu pour fonctionner avec XeLaTeX. Peut fonctionner avec d’autres moteurs
% TeX (à vos risques et périls).
%
% Licence
% -------
% © Jean-Christophe Beaupré <jcbrinfo@users.noreply.qithub.com>.
% 
% Il est autorisé d’utiliser, de reproduire, de modifier et/ou de distribuer
% cette œuvre, avec ou sans frais, à condition que la mention de droit d’auteur
% ainsi que le présent avis d’autorisation apparaissent dans toutes les
% reproductions.
%
% Familles de polices de caractères requises
% ------------------------------------------
% * Linux Libertine O
% * Linux Biolinum O (fait partie du projet Linux Libertine)
% * DejaVu Sans Mono
%
% Citations
% ---------
% * Pour suivre le style de citation par défaut de l’UQAM, utilisez `\citep*` et
%   `\citet*` (les variantes sans astérisque ne mentionnant que le premier
%   auteur).
% * Pour les citations paraphrasées, `\citeauthor*`, `\citeyear` et
%   `\citeyearpar` peuvent vous être utiles.
% * Pour les sites web complets (pas uniquement une page), utilisez
%   `\defcitealias`, `\url` et `\citepalias` pour citer avec l’URL.
%   Malheureusement, `natbib` ne permet pas d’extraire l’attribut `URL` de
%   l’entrée BibTeX.
%   Exemple : `\defcitealias{nit}{\url{http://nitlanguage.org}}` dans le
%   préambule et `\citepalias{nit}` dans le texte.
% * Lorque l’auteur est un organisme (exemple : une norme), combinez `\citetext`
%   avec `\citeyear` tout en respectant la règle « 7. Auteur collectif ».
%   Exemple : `\citetext{{E}uropean {A}ssociation for {S}tandardizing {I}nformation and {C}ommunication {S}ystems ({ECMA}), \citeyear{ECMA-262-v6}}` la première fois et `\citetext{{ECMA}, \citeyear{ECMA-262-v6}}` la deuxième fois.
% * Lorqu’il n’y a pas de date, inscrivez `\iflanguage{english}{n.d.}{s. d.}`
%   dans l’attribut `YEAR` de l’entrée BibTeX. Vous devez aussi retravailler
%   l’appel à citation à la main puisque `natbib` n’est pas conçu pour composer
%   avec ce genre de mention (et vous vous retrouvez avec quelque chose comme
%   « ds da »). Exemple : \citetext{\citeauthor{page-web}, s. d.}
%
% Exemple d’entrée BibTeX pour une norme
% --------------------------------------
% Avec BibTeX, il faut parfois beaucoup tricher pour obtenir un rendu similaire
% à celui recommandée.
%
% ```
% @Book{ECMA-262-v6,
% 	Title    = {{ECMAScript} 2015 {L}anguage {S}pecification},
% 	Author   = {{European Association for Standardizing Information and Communication Systems}},
% 	Year     = {2015},
% 
% 	Address  = {\iflanguage{english}{Geneva}{Genève}},
% 	Note     = {ECMA-262 2015},
% 
% 	File     = {:../literature_repository/languages/Ecma-262.pdf:PDF},
% 	Language = {english}
% }
% ```
%
% Paquetages préconfigurés
% ------------------------
% * `babel`
% * `bookmark`
% * `fancyvrb`
% * `float`
% * `fontspec`
% * `geometry`
% * `graphicx`
% * `hyperref`
% * `ifpdf`
% * `ltabulary`
% * `natbib`
% * `pdflscape`
% * `setspace`
% * `textcase`
% * `url`
% * `xcolor`
%
% Note : N’importez pas `cite`. Sinon, vous allez avoir des erreurs dû à des
% conflits avec `natbib` (je crois).
%
% Quelques trucs en vrac configurés par cette classe
% --------------------------------------------------
% * Si l’option `english` est spécifié, la langue par défaut est l’anglais.
%   Sinon, c’est le français canadien.
% * Le style de bibliographie (`apalike-uqam` ou `apalike-uqam-anglais`) est
%   automatiquement sélectionné selon la langue choisie.
% * La page titre est automatiquement insérée
% * Les pages titres doivent être configurées dans le préambule. Pour ce faire,
%   utilisez les fonctions intégrées `\title` et `\author` ainsi que les
%   fonctions `\course`, `\courseName`, `\courseGroup` et `\recipient` de
%   cette classe.
% * Les couleurs de la palette Tango (`tango-*`) sont définis.
% * Les règles d’espacement françaises (spécifiques à la France) pour `;`, `?`
%   et `!` sont désactivées. Pour les régles québecoises, voir la
%   [Banque de dépannage liguistique de l’OQLF](http://bdl.oqlf.gouv.qc.ca/bdl/gabarit_bdl.asp?id=2039)
%
% Quelques trucs en vrac configurés dans le style bibliographique
% ---------------------------------------------------------------
% * Toutes les années non numériques sont mis entre crochets dans la
%   bibliographie.
% * Si un article de conférence possède déjà un DOI, l’attribut `URL` est
%   ignoré. Cela évite de se retrouver avec l’URL de la conférence en plus de
%   l’URL de l’article dans l’entrée bibliographique.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UqamLab}[2017/04/17 v1.1 Classe pour les travaux scolaires]

% ------------------------------------------------------------------------------
% Options et classe de base
% ------------------------------------------------------------------------------

\newcommand{\@ifEnglish}[2]{#2}
\DeclareOption{english}{
	\renewcommand{\@ifEnglish}[2]{#1}
}

\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{report}
}
\ProcessOptions*

\LoadClass[twoside, openright, letterpaper, 12pt]{report}

% ------------------------------------------------------------------------------
% PDF
% ------------------------------------------------------------------------------

\RequirePackage{ifpdf}

% Insère des liens à la table des matières, qui sont invisibles.
\RequirePackage[hidelinks]{hyperref}
% Solution de contournement d’un bug d’`hyperref` avec un `%` dans le texte.
\RequirePackage{bookmark}

% ------------------------------------------------------------------------------
% Case
% ------------------------------------------------------------------------------

\RequirePackage{textcase}
\newcommand{\@UpperRef}[1]{%
	\texorpdfstring{%
		\MakeTextUppercase{#1}%
	}{%
		#1%
	}%
}

% ------------------------------------------------------------------------------
% Polices de caractères
% ------------------------------------------------------------------------------

\RequirePackage{fontspec}
\setmainfont{Linux Libertine O}
\setsansfont{Linux Biolinum O}
\setmonofont[Scale=0.9]{DejaVu Sans Mono}

% ------------------------------------------------------------------------------
% Citations et bibliographies
% ------------------------------------------------------------------------------

\RequirePackage{url}
%\RequirePackage{cite} % Conflit avec `natbib`!
\RequirePackage{natbib}

\@ifEnglish{
	\AtEndDocument{
		\bibliographystyle{apalike-uqam-anglais}
	}
}{
	\AtEndDocument{
		\bibliographystyle{apalike-uqam}
	}
}

% ------------------------------------------------------------------------------
% Langues
% ------------------------------------------------------------------------------

\@ifEnglish{
	\RequirePackage[canadien, english]{babel}
}{
	\RequirePackage[english, canadien]{babel}
}

% Désactiver les régles d’espacement françaises.
\renewcommand{\FBthinspace}{}

% ------------------------------------------------------------------------------
% Palette de couleurs Tango
% ------------------------------------------------------------------------------
\RequirePackage[table]{xcolor}
\definecolor{tango-butter-1}{HTML}{FCE94F}
\definecolor{tango-butter-2}{HTML}{EDD400}
\definecolor{tango-butter-3}{HTML}{C4A000}
\definecolor{tango-orange-1}{HTML}{FCAF3E}
\definecolor{tango-orange-2}{HTML}{F57900}
\definecolor{tango-orange-3}{HTML}{CE5C00}
\definecolor{tango-chocolate-1}{HTML}{E9B96E}
\definecolor{tango-chocolate-2}{HTML}{C17D11}
\definecolor{tango-chocolate-3}{HTML}{8F5902}
\definecolor{tango-chameleon-1}{HTML}{8AE234}
\definecolor{tango-chameleon-2}{HTML}{73D216}
\definecolor{tango-chameleon-3}{HTML}{4E9A06}
\definecolor{tango-sky-blue-1}{HTML}{729FCF}
\definecolor{tango-sky-blue-2}{HTML}{3465A4}
\definecolor{tango-sky-blue-3}{HTML}{204A87}
\definecolor{tango-plum-1}{HTML}{AD7FA8}
\definecolor{tango-plum-2}{HTML}{75507B}
\definecolor{tango-plum-3}{HTML}{5C3566}
\definecolor{tango-scarlet-red-1}{HTML}{EF2929}
\definecolor{tango-scarlet-red-2}{HTML}{CC0000}
\definecolor{tango-scarlet-red-3}{HTML}{A40000}
\definecolor{tango-aluminium-1}{HTML}{EEEEEC}
\definecolor{tango-aluminium-2}{HTML}{D3D7CF}
\definecolor{tango-aluminium-3}{HTML}{BABDB6}
\definecolor{tango-aluminium-4}{HTML}{888A85}
\definecolor{tango-aluminium-5}{HTML}{555753}
\definecolor{tango-aluminium-6}{HTML}{2E3436}

% ------------------------------------------------------------------------------
% Code source
% ------------------------------------------------------------------------------
\RequirePackage{fancyvrb}
\fvset{
	frame=single,
	numbers=left,
	numbersep=3pt,
	tabsize=4
}

% ------------------------------------------------------------------------------
% Images
% ------------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{pdflscape}
\RequirePackage{float}

% ------------------------------------------------------------------------------
% Tableaux
% ------------------------------------------------------------------------------
\RequirePackage{ltabulary}
\colorlet{table-row-odd}{tango-aluminium-1}
\definecolor{table-row-even}{HTML}{FFFFFF}

% ------------------------------------------------------------------------------
% Marges
% ------------------------------------------------------------------------------

\RequirePackage[margin=1.5cm, outer=5.9cm, inner=2.5cm, nohead, includefoot]{geometry}

% ------------------------------------------------------------------------------
% Chapitres et sections
% ------------------------------------------------------------------------------

% Débuter le corps du document
\newcommand{\body}{
	\newpage
	\pagenumbering{arabic}
	\setcounter{page}{1}
	\renewcommand{\@chapapp}{}
}

% ------------------------------------------------------------------------------
% Pages
% ------------------------------------------------------------------------------

% Redefinir `\cleardoublepage` pour que les pages de garde ne soient pas paginées.
\renewcommand{\cleardoublepage}{%
	\clearpage%
	\if@twoside
		\ifodd%
			\c@page%
		\else
			\mbox{}
			\thispagestyle{empty}
			\newpage
			\if@twocolumn%
				\mbox{}%
				\newpage%
			\fi%
		\fi%
	\fi
}

% ------------------------------------------------------------------------------
% Page titre
% ------------------------------------------------------------------------------

% Ligne horizontale.
\newcommand{\titlePageRule}{\rule{\linewidth}{0.5mm}}

% Le sigle du cours.
\newcommand{\@course}{}
\newcommand{\course}[1]{
	\renewcommand{\@course}{#1}
}

% Le nom du cours.
\newcommand{\@courseName}{}
\newcommand{\courseName}[1]{
	\renewcommand{\@courseName}{#1}
}

% Le numéro de groupe.
\newcommand{\@courseGroup}{}
\newcommand{\courseGroup}[1]{
	\renewcommand{\@courseGroup}{#1}
}

% Le destinataire.
\newcommand{\@recipient}{}
\newcommand{\recipient}[1]{
	\renewcommand{\@recipient}{#1}
}

\renewcommand{\maketitle}{
	\begin{titlepage}
	\newgeometry{margin=1.5cm}
	\center

	\textsc{\Large \@course}

	{\Large \@courseName}

	\vfill

	\titlePageRule
	{
		\Huge
		\@title
		\par
	}
	\titlePageRule

	\vfill

	\emph{\iflanguage{english}{By}{Par}}\\
	\begin{tabular}[t]{c} \@author \end{tabular}

	\iflanguage{english}{Group}{Groupe} \@courseGroup
	\vfill

	\emph{\iflanguage{english}{Delivered to}{Remis à}} \\
	\@recipient

	\vfill

	Université du Québec à Montréal

	\@date

	\restoregeometry
	\end{titlepage}
}

\AtBeginDocument{
	\thispagestyle{empty}
	\maketitle
	\newpage
	\thispagestyle{empty}
	\pagenumbering{globbe}
	\mbox{}
	\newpage
	\pagenumbering{roman}
}

\endinput
