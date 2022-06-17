%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% start of file `minimalcv.cls'.                                    %%
%%                                                                   %%
%% IMPORTANT: REQUIRES LUALATEX FOR COMPILATION                      %%
%% class version: 2022-06-17-alpha                                   %%
%%                                                                   %%
%% Copyright 2022 Daniel Sacré.                                      %%
%%                                                                   %%    
%% A very simple document class for writing job applications and CVs %%
%% Inspired by the 'moderncv' class and its 'casual' theme in 'blue' %%
%%                                                                   %%
%% It should be compatible with documents written for 'moderncv' if  %%
%% \section is replaced with \cvsection.                             %% 
%%                                                                   %%
%% This piece of software comes without any warranty, not even that  %%
%% it is fit for the intended purpose. Since it is an alpha-release, %%
%% Bug reports and suggestions via github are highly welcome.        %%
%%                                                                   %%
%% LICENSE:                                                          %%
%% This work may be distributed and/or modified under the            %%
%% conditions of the LaTeX Project Public License version 1.3c, or   %%
%% (at your option) any later version. The full license text is      %%
%% available at http://www.latex-project.org/lppl/.                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{minimalcv}[minimalcv class for typesetting job applications and CVs]

\LoadClass{scrreprt} % loading scrreprt as a base class; Note: passing options like in normal document preamble does not work
\RequirePackage{scrletter} % loading all the letter niceness as a usepackage, not a class
\LoadLetterOption{KOMAold}% must be loaded by \LoadLetterOption or \LoadLetterOptions
% http://mirrors.ctan.org/macros/latex/contrib/koma-script/doc/scrguien.pdf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Loading the required packages and setting up their options %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Setting up the page. Currently no easy way for end user except here or via \geometry{} in preamble of document
\RequirePackage[scale=0.775,top=1.5cm, bottom=1.675cm, footskip=3em, includeheadfoot]{geometry}

\RequirePackage{fontspec} % required for LuaLaTeX and ability to select random fonts

\setmainfont[%
	Path=./fonts/, %
	BoldFont={texgyreheros-bold.otf}, %
	ItalicFont={texgyreheros-italic.otf} %
]{texgyreheros-regular.otf} % loading alternative font provided with class

\RequirePackage{fontawesome5} % icons

\RequirePackage{etoolbox}

\RequirePackage{csquotes} % quotations
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{lastpage} % currently not used
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{calc,positioning}

\RequirePackage{scrlayer-scrpage}
\KOMAoptions{footwidth=\useplength{firstfootwidth}}
\KOMAoptions{%
	symbolicnames,%
	%	version=last,% not working in cls
	%	DIN, % not working in cls
	pagenumber=off,% remove page number in letter environment
	enlargefirstpage=off,  % more space on first page
	firstfoot=on, % enable footer on first page
	%	nextfoot=on, % not working yet. Still a bug
	fromalign=left, %
	foldmarks=off %
}

% Put usepackages which are known to disturb others at the end of preamble
\AtEndPreamble{%
	\RequirePackage{url} % allowing for working web links
	\urlstyle{same} % changing url font to match the rest of the sf text
	\RequirePackage[hidelinks]{hyperref}
	%
	% hypersetup adopted from Xavier Danaux's moderncv class; license LPPL 1.3c
	\hypersetup{
		breaklinks,
		pdfstartpage  = 1,
		pdfcreator    = {Lua\LaTeX{} with 'simplecv' class},
		bookmarksopen = true,
		bookmarksdepth= 2,% to show sections and subsections
		% author options not working yet
%		pdfauthor     = {},
%		pdftitle      = {\@firstname{}~\@lastname{}\notblank{\@title}{ -- \@title}{}},
%		pdfsubject    = {Resum\'{e} of \@firstname{}~\@lastname{}},
%		pdfkeywords   = {\@firstname{}~\@lastname{}, curriculum vit\ae{}, resum\'{e}}}
	}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Setting up the page footers and headers %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Generating the footer for the cover letter 
\newcommand*{\footboxCoverLetter}{% 
	\hfil
	\begin{minipage}[t]{0.6\linewidth}
		\centering
		\begin{tabular}{c}
			\small\color{gray}\textbf{\usekomavar{fromname}} \\%[0.75mm]
			\small\color{gray} \usekomavar{fromstreet}~\textbullet~\usekomavar{frompostalcode}~\usekomavar{fromcity}~\textbullet~\usekomavar{fromcountry} \\[-0.75mm]
			\small\color{gray}\raisebox{-0.075em}{%
				\faEnvelope %
			}~\,\usekomavar{fromemail}\quad\textbullet~
				\raisebox{-0.625em}{%
					\tikz{\draw (0,0) node[rotate=270] {\faPhone};
				}%
			}\usekomavar{fromphone}
			\Ifkomavarempty{fromurl}{}{%
				\\[-0.75mm]\small\color{gray}\faGlobe~
				\usekomavar[\url]{fromurl} % to get a working url in footer
			}
		\end{tabular}
	\end{minipage}
	\hfil
}

% Generating the footer for the CV pages
\newcommand*{\footboxCVPages}{% 
	\begin{minipage}[t]{0.6\linewidth}
		\centering
		\begin{tabular}{c}
			\small \color{gray}\textbf{\usekomavar{fromname}} \\%[0.5mm]
			\small\color{gray} \usekomavar{fromstreet}~\textbullet~\usekomavar{frompostalcode}~\usekomavar{fromcity}~\textbullet~\usekomavar{fromcountry} \\[-0.75mm]
			\small\color{gray}\raisebox{-0.075em}{\faEnvelope}~\,\usekomavar{fromemail}\quad\textbullet~
			\raisebox{-0.625em}{%
				\tikz{\draw (0,0) node[rotate=270] {\faPhone};}
			}\usekomavar{fromphone} 
			\Ifkomavarempty{fromurl}{}{%
				\\[-0.75mm]\small\color{gray}\faGlobe~	\usekomavar[\url]{fromurl}
			}
		\end{tabular}
	\end{minipage}
}

\setkomavar{firstfoot}{\footboxCoverLetter} % set the first footer to the footer for cover letter

% page layer magic to get footers to appear correctly
\ForEachLayerOfPageStyle*{plain.scrheadings}{%
	\Ifstrstart{#1}{plain.scrheadings.foot}{%
		\ModifyLayer[
		voffset=\useplength{firstfootvpos}
		]{#1}
	}{}
}% shift the footer down
\ModifyLayer[
addvoffset=-1ex
]{plain.scrheadings.foot.above.line}% shift the footsepline up
\addtokomafont{pagefoot}{\normalfont}
\clearpairofpagestyles
\chead*{}
\cfoot*{}

% defining new page style for cover letter
\newpairofpagestyles[scrheadings]{cover}{%
	\cfoot*{\footboxCoverLetter}%
}

% defining new page style for CV and generate CV only header
\newpairofpagestyles[scrheadings]{cv}{%
	\ohead*{%
		\tikz{%
			\node[anchor=north east](name) at ($(current page.north east)+(0,-0.5cm)$){%
				\normalfont\bfseries\LARGE\color{gray}\usekomavar{fromfirstname}~\color{gray!50!black}\usekomavar{fromlastname}
			}; %
			\draw[gray,thick](name.south east)--++(-1*\linewidth,0);
			 % header does funky things if drawing until the edge of the page (current page.north east) or entering a too large value
		}\\
		\color{gray}\usekomavar{curriculumtitle}
	}%
	\cfoot*{\footboxCVPages}%
	\ofoot*{\raggedleft\small\color{gray}Page \thepage\ of \pageref{EndOfCV}}
}

% setting the correct page style
\pagestyle{plain}
\RequirePackage{xpatch}
\xapptocmd\opening{\thispagestyle{plain}}{}{}% <- first pages will have pagestyle plain too

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Defining the new environments %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the cover letter environment based upon the existing letter variant
\newenvironment{coverLetter}{%
	\begin{letter}{\usekomavar{receiver}} %
}{ %
	\end{letter} %
}

\newenvironment{vitae}{%
	\newpage % make sure that page style is applied to CV page and not letter
	\setcounter{page}{1} % set counter so that first page of CV gets page number 1
	\clearpairofpagestyles %
	\pagestyle{cv} % 
}{%
	\label{EndOfCV} % label so that the page numbering in CV shows the last page of CV
	\newpage % make sure to apply the style on the next page, not the last CV page
	\clearpairofpagestyles %
	\pagestyle{cover} %
}

% By default, columns in LaTeX cannot be redefined. Use the following helper macros found at
% https://tex.stackexchange.com/questions/144434/re-newing-a-column-type
\newcommand\undefcolumntype[1]{\expandafter\let\csname NC@find@#1\endcsname\relax}
\newcommand\forcenewcolumntype[1]{\undefcolumntype{#1}\newcolumntype{#1}}

\newcommand{\envMacroArgumentHelper}{} % allows for storing argument values before using them
\newcommand{\envMacroArgumentHelperTwo}{} % at the end of newenvironment definition; otherwise: error

% Define new environment with CV content on the left and image on the right
% BUG: ALIGNMENT CURRENTLY DOES NOT MATCH WITH THE REST OF THE CV CONTENT
% Possible reasons: 
% 1) Image used for testing purposes to small
% 2) Alignment of minipages wrong
\newenvironment{personalimage}[2][0.925\linewidth]{%
	% Store arguments in temporary macro
	\renewcommand{\envMacroArgumentHelper}{#1} 
	\renewcommand{\envMacroArgumentHelperTwo}{#2}
	% Reset the column type such that the left of the first "column" hopefully 
	% aligns with the rest of the columns in the documents; lies here the bug?
	\forcenewcolumntype{A}{>{\hsize=0.2675\linewidth \raggedleft}X}
	\forcenewcolumntype{Z}{>{\raggedright\arraybackslash}p{0.7375\linewidth}}
	\begin{minipage}[b]{0.75\linewidth}
		\vfil
	}{ % minipage for the CV content
		\vfil
	\end{minipage}
	\hfill
	% Minipage for the image with filepath and options loaded from helper macros
	\begin{minipage}[b]{0.25\linewidth}
		\centering
		\includegraphics[width=\envMacroArgumentHelper]{\envMacroArgumentHelperTwo}
	\end{minipage}
	% "reset" the column types back to the old value
	\forcenewcolumntype{A}{>{\hsize=0.2\linewidth \raggedleft}X}
	\forcenewcolumntype{Z}{>{\raggedright\arraybackslash}p{0.8\linewidth}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Defining all the macros %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macro with special capabilities producing similar output like moderncv (for testing purposes)
\newcommand{\cvitemSPECIAL}[2]{
	\begin{tabular}{>{\raggedleft\arraybackslash}p{0.175\textwidth}p{0.825\textwidth}}
		#1 & #2
	\end{tabular}\\[0.0625cm]
}

% Make sure column size is set correctly
\forcenewcolumntype{A}{>{\hsize=0.2\linewidth \raggedleft}X}
\forcenewcolumntype{Z}{>{\raggedright\arraybackslash}p{0.8\linewidth}}

% macro mimicing the \cvitem of moderncv
\newcommand{\cvitem}[2]{
	\begin{tabularx}{\linewidth}{AZ} 
		#1
		&
		\begin{minipage}[t]{\linewidth}
			#2
		\end{minipage}
	\end{tabularx}\\[0.125cm]
}

% macro mimicing the \cventry of moderncv with additional fixed font weight/shape option preset
\newcommand{\gradeHelper}{}
\newcommand{\cventry}[6]{%
	\ifstrequal{#5}{}{ % If no last argument is supplied, 
		\renewcommand{\gradeHelper}{} % do not add a comma
	}{ %
		\renewcommand{\gradeHelper}{, #5} % add a comma and last argument
	} %
	\begin{tabularx}{\linewidth}{AZ} %l
		#1
		&
		\begin{minipage}[t]{\linewidth}
			\textbf{#2}, \textit{#3}, #4\gradeHelper \\[0.1cm]
			\small #6
		\end{minipage}
	\end{tabularx}\\[0.25cm]
}

% Redefining letter closing
\renewcommand{\closing}[2][0.5cm]{
	\phantom{text}\\[#1]
	\noindent #2\\[0.25cm]
	\usekomavar{signature}
}

% Define a closing for the CV similar to the letter closing
\newcommand{\cvclosing}[1][0.5cm]{%
	\phantom{text}\\[#1]
	\noindent
	\usekomavar{fromcity}, \usekomavar{date}\\[0.25cm]
	\usekomavar{signature}
}

% Defining a macro to produce an enclosure label
\newcommand{\enclosure}[2][0.5cm]{
	\phantom{text}\\[#1]
	\small
	\noindent \color{gray} \usekomavar{enclosurename}:\\
	#2
	\normalcolor
	\normalsize
}

% Redefining section
\definecolor{accentcolor}{HTML}{3873b3}
\newcommand{\cvsection}[1]{
	\section*{\raisebox{0.225em}{\tikz{\fill[accentcolor](0,0)rectangle++(0.15\linewidth,5pt);}} \color{accentcolor} #1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% adjusting positions and spacing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setplength{toaddrvpos}{2cm} % Distance fromadress toaddress
\setplength{refvpos}{7cm} % distance reference line to top of page
\RedeclareSectionCommand[beforeskip=-1.5ex plus -1ex minus -.2ex,afterskip=2ex plus -.2ex]{section} % distance before and after sections


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% KOMAvar related stuff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Defining new KOMAvars
\newkomavar{curriculumtitle}
\newkomavar{accentcolor}

\newkomavar{fromfirstname}
\newkomavar{fromlastname}
\newkomavar{fromstreet}
\newkomavar{frompostalcode}
\newkomavar{fromcity}
\newkomavar{fromcountry}

\newkomavar{enclosurename}
\newkomavar{receiver}

% Setting standard KOMAvars to new value
\setkomavar{fromaddress}{\usekomavar{fromstreet}\\\usekomavar{frompostalcode}~\usekomavar{fromcity}\\\usekomavar{fromcountry}}
\setkomavar{fromname}{\usekomavar{fromfirstname}~\usekomavar{fromlastname}}
\setkomavar{firsthead}{%
	\usekomavar{fromfirstname}~\usekomavar{fromlastname}\\
	\usekomavar{fromaddress}%
}


% Set new KOMAvars to initial values
\setkomavar{enclosurename}{Enclosure}
\setkomavar{curriculumtitle}{curriculum vit\ae{}}
\setkomavar{accentcolor}{blue} % currently not yet used

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% end of file `minimalcv.cls' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%