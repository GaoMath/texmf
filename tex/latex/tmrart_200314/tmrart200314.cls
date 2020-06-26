%%
%% This is file 'tmrart200314.cls', based on article.cls
%% Revision for use with LaTeX2e
%%
%% 14 March 2020
%%     Creation of the LaTeX document class.
%% 26 May 2020
%%     Reduction of the width of the title and of the authors in fancyheads.
%% ----------------------------------------------------------------------------
%%
%% tmrart200314 - A LaTeX class for formatting documents
%%
%% Copyright (C) 2020 by Tom M. Ragonneau <tom.ragonneau at connect.polyu.hk>
%%
%% This work may be distributed and/or modified under the conditions of the
%%    LaTeX Project Public License (LPPL), either version 1.3c of this license
%%    or (at your option) any later version.  The latest version of this
%%    license is in the file:
%%
%% http://www.latex-project.org/lppl.txt
%% ----------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
%%
%% --- Modified 26 May 2020 ---
%%
\ProvidesClass{tmrart200314}[2020/03/14 v1.0.0 LaTeX document class]
%%
%% Packages required by the LaTeX document class
%%
\LoadClass{article}
\RequirePackage{tmrart200314-maths}
\RequirePackage{tmrart200314-code}

%% ----------------------------------------------------------------------------
%% Support and class options
%% ----------------------------------------------------------------------------
\newif\if@review
\@reviewfalse
%%
%% Options of the LaTeX document class: a4paper, a5paper, letterpaper,
%%    legalpaper, landscape, twoside, review
%%
\if@compatibility\else
	\DeclareOption{a4paper}{%
		\setlength\paperheight{297mm}%
	    \setlength\paperwidth{210mm}}
	\DeclareOption{a5paper}{%
		\setlength\paperheight{210mm}%
		\setlength\paperwidth{148mm}}
	\DeclareOption{letterpaper}{%
		\setlength\paperheight{11in}%
		\setlength\paperwidth{8.5in}}
	\DeclareOption{legalpaper}{%
		\setlength\paperheight{14in}%
		\setlength\paperwidth{8.5in}}
	\DeclareOption{landscape}{%
		\setlength\@tempdima{\paperheight}%
		\setlength\paperheight{\paperwidth}%
		\setlength\paperwidth{\@tempdima}}
\fi
\if@compatibility\else
	\DeclareOption{oneside}{\@twosidefalse\@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue\@mparswitchtrue}
\DeclareOption{review}{\@reviewtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{letterpaper,twoside}
\ProcessOptions\relax

%% ----------------------------------------------------------------------------
%% General layout
%% ----------------------------------------------------------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage[margin=1.05in]{geometry}
\RequirePackage{calc}

\RequirePackage[pdftex,dvipsnames]{xcolor}
\colorlet{reviewcolor}{black!50}

%% ----------------------------------------------------------------------------
%% Headers and footers
%% ----------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\RequirePackage{titling}
\RequirePackage{lastpage}
\pagestyle{fancy}
\setlength{\headheight}{20pt}
\fancyhf{}
\fancyhead[LE,RO]{\thepage/\pageref{LastPage}}
\fancyhead[CE]{\begin{minipage}{.8\linewidth}\centering\scshape\MakeLowercase\thetitle\end{minipage}}
\fancyhead[CO]{\begin{minipage}{.8\linewidth}\centering\scshape\MakeLowercase\theauthor\end{minipage}}
\def\footer{\normalfont\itshape\color{reviewcolor}%
	This manuscript is for review purposes only.}
\if@review
	\cfoot{\footer}
\fi
\fancypagestyle{plain}{%
	% Default layout for the page containing \maketitle
    \fancyhf{}%
    \renewcommand{\headrulewidth}{0pt}%
	\if@review%
		\cfoot{\footer}%
	\fi%
}

%% ----------------------------------------------------------------------------
%% Support for 'review' class option to turn on linenumbers via the lineno
%%    package. The \linenumbers command does not play nice with amsmath, so we
%%    have added some patches to fix it
%% ----------------------------------------------------------------------------
\RequirePackage[mathlines]{lineno}
\renewcommand{\linenumberfont}{\normalfont\footnotesize\color{reviewcolor}}
\newcommand*\patchAmsMathEnvironmentForLineno[1]{%
	\expandafter\let\csname old#1\expandafter%
		\endcsname\csname #1\endcsname%
	\expandafter\let\csname oldend#1\expandafter%
		\endcsname\csname end#1\endcsname%
	\renewenvironment{#1}%
		{\linenomath\csname old#1\endcsname}%
		{\csname oldend#1\endcsname\endlinenomath}}
\newcommand*\patchBothAmsMathEnvironmentsForLineno[1]{%
	\patchAmsMathEnvironmentForLineno{#1}%
	\patchAmsMathEnvironmentForLineno{#1*}}
\newcommand*{\socgPatchAmsMathEnvironmentForLineno}[1]{%
	\renewenvironment{#1}%
		{\linenomath\postdisplaypenalty=0\csname old#1\endcsname}%
		{\csname oldend#1\endcsname\endlinenomath}}%
\newcommand*\socgpatchBothAmsMathEnvironmentsForLineno[1]{%
	\socgPatchAmsMathEnvironmentForLineno{#1}%
	\socgPatchAmsMathEnvironmentForLineno{#1*}}
\AtBeginDocument{%
	\patchBothAmsMathEnvironmentsForLineno{align}%
	\socgpatchBothAmsMathEnvironmentsForLineno{align}%
	\patchBothAmsMathEnvironmentsForLineno{equation}%
	\patchBothAmsMathEnvironmentsForLineno{flalign}%
	\socgpatchBothAmsMathEnvironmentsForLineno{flalign}%
	\patchBothAmsMathEnvironmentsForLineno{alignat}%
	\socgpatchBothAmsMathEnvironmentsForLineno{alignat}%
	\patchBothAmsMathEnvironmentsForLineno{gather}%
	\socgpatchBothAmsMathEnvironmentsForLineno{gather}%
	\patchBothAmsMathEnvironmentsForLineno{multline}%
	\socgpatchBothAmsMathEnvironmentsForLineno{multline}}
%
\if@review%
	\linenumbers%
\fi%
\let\oldmaketitle\maketitle
\renewcommand{\maketitle}{%
	\if@review%
		\nolinenumbers%
		\oldmaketitle%
		\linenumbers%
	\else%
		\oldmaketitle%
	\fi%
}

%% ----------------------------------------------------------------------------
%% Other package patches and internal commands
%% ----------------------------------------------------------------------------
% Override the command \href if the package hyperref is not imported
\providecommand{\href}[2]{#2}
\newcommand{\email}[1]{\protect\href{mailto:#1}{\texttt{#1}}}
