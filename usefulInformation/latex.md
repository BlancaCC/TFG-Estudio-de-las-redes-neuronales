# How to make bibliography in LaTex with Bibtex / Biblatex  

- https://www.overleaf.com/learn/latex/bibliography_management_with_bibtex  
- https://www.latex-tutorial.com/tutorials/bibtex/  



1. Create a `.bib` file.   
 Format: 
 
```
@ENTRY_TYPE {  identifier_that_refer_this_article
    author = "peoples' name" , 
    title = "", 
    journal = "" , 
    volume = "", 
    pages = "",  
    year = "1905", 
    publisher = "", 
    addres = "", 
    url = ""
    

}

some could be ENTRY_TYPE : article, book, misc, techreport, manual, inbook 
```


2. Tell LaTeX where to find the bibliofraphic database.   


# Latex in emacs, auctex     

- First approach:  https://ondahostil.wordpress.com/2015/08/03/lo-que-he-aprendido-emacs-como-editor-de-latex/  

- Official documentation of auctex: https://www.gnu.org/software/auctex/manual/auctex.html#Environments

- Auctex manual: https://www.gnu.org/software/auctex/manual/auctex.pdf
