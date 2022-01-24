# latex-minimalcv
The latex-minimalcv project provides the LaTeX class `minimalcv`. The class is designed for typesetting job applications and CVs whos design is inspired by the 
already existing LaTeX-class `moderncv`. 
It is built upon scrreprt, scrlettr and KOMAvar's and requires LuaLaTeX for the compilation. Please note that this project is more a proof-of-concept and it comes
with absolutely no warranty; not even to be suitable for the task it is designed for. Consider it currently as an pre-alpha-release which is not feature complete.

## Setup process
1. Download the repository and - if required - unzip the files.
2. If you are not intending to compile the example file, you can delete `./example-images/` directory
3. Rename the `minimalcv_example.tex` file to your liking and start writing!


## Basic usage
The file `minimalcv.cls` will not be registered with your LaTeX-installation. You always have to copy it into the same folder where the main `.tex` file of your
project is located.

For compilation, `LuaLaTeX` has to be used. Options: If using TeXstudio, rely on the ghost commment or change the compiler settings. In the command line,
use `lualatex FILENAME.tex`.

The file `FILENAME.tex` should be structured as follows:
```latex
% !TeX program = lualatex

\documentclass{minimalcv}

% Load additional usepackages (optional)

% Setting styles
\KOMAoption{fontsize}{11pt} % fontsize by default 11 pt
\usepackage[english]{babel} % set the correct language for features like formating the date etc.

% Setting KOMAvar's for addresses, phone numbers, etc.

\begin{document}
    \begin{coverLetter}
        \subject{SUBJECT}
        \opening{OPENING}
        
        LETTER CONTENT
        
        \closing{CLOSING}
        
        \enclosure{ENCLOSURE} % optional
    \end{coverLetter}
    
    \begin{vitae}
        CV CONTENT
        \cvclosing
    \end{vitae}
\end{document}
```
For content structuring, there are two macros provided: `\cvitem`, `\cventry`. Their functionality is best understood with the example LaTeX file and the 
corresponding pdf output.

## Migration from `moderncv` to `minimalcv`
One of the design premises was to support most of the `moderncv`-features out of the box. Due to the different design approaches, the following changes have to be done:
1. Setting all the information (addresses, phone numbers, etc.) as KOMAvar's instead of the `moderncv`-macros
2. Putting the cover letter content into the `coverLetter`-environment (technically not necessary, but for layout with correct headers/footers required)
3. Putting the CV content into the `vitae` environment (technically not necessary, but for layout with correct headers/footers required)
4. Replacing `\section` with `\cvsection` (technically not necessary, but for layout with sections à la `moderncv` required)

All the other basic fuctionality of `moderncv` (`\cvitem`, `\cventry`) should work out-of-the-box.

## Known issues
- Long compilation time (due to many calls of environments)
- Spacing of fromaddress, subject and date not well defined
- Not all the creature comforts and customizability yet
