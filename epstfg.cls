\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{epstfg}[2016/02/03 EPS End-of-degree template]

%%% Options

\DeclareOption{palatino}{%
	\renewcommand{\rmdefault}{ppl}
	\renewcommand{\sfdefault}{lmss}
	\renewcommand{\ttdefault}{lmtt}
	\renewcommand*{\familydefault}{\rmdefault}
	\def\@fontsizeopt{11pt}
	\message{Loading Palatino fonts}
}

\DeclareOption{sansserif}{
	\renewcommand*{\familydefault}{\sfdefault}
	\def\@fontsizeopt{12pt}
	\message{Loading Sans-Serif fonts}
}

\newif\if@twoside
\DeclareOption{oneside}{
	\PassOptionsToClass{oneside}{memoir}
	\@twosidefalse
}

\DeclareOption{twoside}{
	\PassOptionsToClass{twoside}{memoir}
	\@twosidetrue
}

\newif\if@draftbanner
\DeclareOption{draftbanner}{\@draftbannertrue}
\DeclareOption{nodraftbanner}{\@draftbannerfalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

\ExecuteOptions{palatino,twoside,draftbanner}
\ProcessOptions\relax

\PassOptionsToClass{\@fontsizeopt}{memoir}
\LoadClass[a4paper]{memoir}

%% Load packages
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage[left=3cm,right=3cm,top=3cm,bottom=2cm]{geometry}
\RequirePackage{imakeidx} % Correct index creation
\RequirePackage[acronym, toc]{glossaries}
\RequirePackage[spanish,es-noquoting,es-noshorthands,english]{babel}
\RequirePackage{amsthm}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{framed}
\RequirePackage{mdframed}
\RequirePackage[pdfencoding=auto,psdextra]{hyperref}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8x]{inputenc}
\RequirePackage[final]{graphicx}
\RequirePackage{setspace}
\RequirePackage{collect}
\RequirePackage{lastpage}
\RequirePackage{imakeidx}

\makeindex[intoc]
\indexsetup{firstpagestyle = chapter}

\PrerenderUnicode{ÁáÉéÍíÓóÚúÑñ} % Ensure spanish characters are accepted
\selectlanguage{spanish}

\ifdraftdoc\else
	\@draftbannerfalse
\fi

\colorlet{bannercolor}{Bittersweet}

% Glossary and acronyms
\setacronymstyle{long-short}
\makenoidxglossaries
\renewcommand{\acronymname}{Acr\'onimos}
\glsdisablehyper % glossaries hyperlinks don't work correctly.

% Hyperref settings
\hypersetup{
	hyperindex,
    colorlinks,
    allcolors=blue!50!black
}

% Page styling
\pagestyle{ruled}

\def\titlefootstyle{\itshape\footnotesize}
\def\pagenumberstyle{\small}

\makeoddfoot{ruled}
	{\ifdraftdoc\textit{\tiny\@nameuse{draft-spa}}\fi}
	{\titlefootstyle\@nameuse{title-spa}}
	{\pagenumberstyle\thepage}

\makeevenfoot{ruled}
	{\pagenumberstyle\thepage}
	{\titlefootstyle\@nameuse{title-eng}}
	{\ifdraftdoc\textit{\tiny\@nameuse{draft-eng}}\fi}

\makefootrule{ruled}{\textwidth}{0.7pt}{2pt}

\copypagestyle{chapter}{plain}

% Fix styling in chapter pages
\def\@fixchapterstyle{
	\makeoddfoot{chapter}
		{\ifdraftdoc\textit{\tiny\@nameuse{draft-spa}}\fi}
		{\titlefootstyle\@nameuse{title-spa}}
		{\pagenumberstyle\thepage}

	\makefootrule{chapter}{\textwidth}{0.7pt}{2pt}
}

\let\@internal@mainmatter\mainmatter
\def\mainmatter{\@internal@mainmatter\@fixchapterstyle}

\if@twoside
	\let\clearsidepage\cleardoublepage
\else
	\let\clearsidepage\clearpage
\fi

\let\@internal@frontmatter\frontmatter
\def\frontmatter{\@internal@frontmatter\pagenumbering{Roman}}

% Division styling
\headstyles{memman}
\chapterstyle{pedersen}

\renewcommand{\chaptitlefont}{\itshape\HUGE}
\renewcommand{\afterchapskip}{200pt}

\renewcommand*{\printchapternum}{% Align baselines with the chapter title
    \sidebar{\raisebox{-1.2\baselineskip}[0pt][0pt]{\makebox[0pt][l]{%
      \resizebox{!}{\midchapskip}{\chapnumfont\thechapter}}}}}


\setsecheadstyle{\large\scshape}

\setsecnumdepth{subsection}
\setcounter{tocdepth}{3}

% Useful commands
\newcommand{\todo}[1]{
	\textcolor{red}{#1}
	\marginpar{\textcolor{red}{\textit{\hspace{4pt}TODO}}}
}

% Constants
\def\@theuniversity{Universidad Aut\'onoma de Madrid}
\def\@thecenter{Escuela Polit\'ecnica Superior}
\def\@thecenterlogo{img/logo_eps.png}
\def\@theuniversitylogo{img/logo_uam.jpg}

% Language-dependent strings
\newcommand{\deftranslation}[3]{\@namedef{#1-spa}{#2}\@namedef{#1-eng}{#3}}

\@namedef{eng}{english}\@namedef{spa}{spanish}
\newcommand{\selectlang}[1]{\selectlanguage{\@nameuse{#1}}} % Allow setting language from commands

\deftranslation{endofdegree}{Trabajo de Fin de Grado}{Bachelor Work}
\deftranslation{tutor}{Tutor}{Tutor}
\deftranslation{ponent}{Ponente}{Ponent}
\deftranslation{author}{Autor}{Author}
\deftranslation{abstract}{Resumen}{Abstract}
\deftranslation{keywords}{Palabras clave}{Keywords}
\deftranslation{glossary}{Glosario}{Glossary}
\deftranslation{acronyms}{Acr\'onimos}{Acronyms}
\deftranslation{draft}{Borrador}{Draft}

% Attributes
\def\setdegreeDouble{
	\deftranslation{degree}
		{Doble Grado en Ingenier\'ia Inform\'atica y Matem\'aticas}
		{Double Degreee in Computer Engineering and Mathematics}
}

\def\setdegreeCompSci{
	\deftranslation{degree}
		{Grado en Ingenier\'ia Inform\'atica}
		{Degreee in Computer Engineering}
}

% Undefine memoir's title and date so we can redefine them
\let\title\relax
\let\date\relax
\newcommand{\title}[2][spa]{\@namedef{title-#1}{#2}}
\newcommand{\date}[2][spa]{\@namedef{date-#1}{#2}}

\newif\if@tutorpresent
\def\thetutor{}
\newcommand{\tutor}[1]{\def\thetutor{#1}\@tutorpresenttrue}

\newif\if@ponentpresent
\def\theponent{}
\newcommand{\ponent}[1]{\def\thetutor{#1}\@ponentpresenttrue}

\newif\if@grouppresent
\newcommand{\group}[2][spa]{\@namedef{group-#1}{#2}\@grouppresenttrue}

\newif\if@departmentpresent
\newcommand{\department}[2][spa]{\@namedef{department-#1}{#2}\@departmentpresenttrue}

% Title page
\let\maketitle\relax
\newcommand{\maketitle}[1][spa]{
	\if@twoside
		\cleardoublepage
	\else
		\clearpage
	\fi
	\thispagestyle{empty}
	\begin{center}
	\textsc{\LARGE\@theuniversity}
	\vspace{15pt}
	\par{\Large\@thecenter}

	\vspace{30pt}
	\begin{minipage}{\textwidth}
	\centering
	\raisebox{-0.5\height}{\includegraphics[width=4cm]{\@thecenterlogo}}
	\hspace{20pt}
	\raisebox{-0.5\height}{\includegraphics[width=4cm]{\@theuniversitylogo}}
	\end{minipage}

	\vspace{100pt}
	\textbf{\@nameuse{degree-#1}}

	\vspace{15pt}
	\textbf{\MakeUppercase{\Huge\@nameuse{endofdegree-#1}}}

	\vspace{30pt}
	\textsc{\Large\begin{OnehalfSpace}\@nameuse{title-#1}\end{OnehalfSpace}}

	\vfill

	\if@draftbanner
		\begingroup
		\color{bannercolor}
		\noindent\makebox[\linewidth]{\rule{1.1\paperwidth}{2pt}}
		\vspace{-6pt}

		\textit{\Large\@nameuse{draft-#1}}

		\noindent\makebox[\linewidth]{\rule{1.1\paperwidth}{2pt}}

		\vspace{50pt}
		\endgroup
	\fi

	{\large
		\theauthor
		\vspace{5pt}

		\if@tutorpresent\@nameuse{tutor-#1}: \thetutor\\\fi
		\if@ponentpresent\@nameuse{ponent-#1}: \theponent\fi
	}

	\vspace{10pt}
	\@nameuse{date-#1}

	\end{center}
	\newpage
	\setcounter{page}{0}
}

\newcommand{\makeinnertitle}[1][spa]{ % For second (internal) titles
	\if@twoside
		\cleardoublepage
	\else
		\clearpage
	\fi
	\thispagestyle{empty}
	\begin{center}
	\centering
	\vspace{30pt}
	\ifdraftdoc\textit{\Large\@nameuse{draft-#1} - \today}\par\fi
	\textsc{\LARGE\begin{OnehalfSpace}\@nameuse{title-#1}\end{OnehalfSpace}}

	\vspace{150pt}
	{\large
		\@nameuse{author-#1}: \theauthor\\
		\if@tutorpresent\@nameuse{tutor-#1}: \thetutor\\\fi
		\if@ponentpresent\@nameuse{ponent-#1}: \theponent\\\fi
	}

	\vfill
	{\large
		\if@grouppresent\@nameuse{group-#1}\\\fi
		\if@departmentpresent\@nameuse{department-#1}\\\fi
		\@thecenter\\
		\@theuniversity

		\vspace{15pt}
		\@nameuse{date-#1}
	}

	\end{center}
	\newpage
	\setcounter{page}{0}
}

%% Abstract and keywords

\definecollection{abstract-contents-spa}
\definecollection{abstract-contents-eng}
\let\abstract\@undefined
\let\endabstract\@undefined
\newenvironment{abstract}[1][spa]
{
	\@nameuse{collect}{abstract-contents-#1}{}{}{}{}
}
{\@nameuse{endcollect}}

\newif\if@keywordspresent
\newcommand{\keywords}[2][spa]{\@namedef{keywords-contents-#1}{#2}\@keywordspresenttrue}

\newcommand{\makeabstract}[1][spa]{
	\if@twoside
		\cleardoublepage
	\else
		\clearpage
	\fi
	\chapter*{\@nameuse{abstract-#1}}

	\paragraph{\bfseries\@nameuse{abstract-#1}}
	\includecollection{abstract-contents-#1}

	\par\vspace{10pt}
	\if@keywordspresent
		\paragraph{\bfseries\@nameuse{keywords-#1}}
		\@nameuse{keywords-contents-#1}
	\fi
	\newpage
}

