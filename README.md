gitMSOfficeDiff
===============

## Git diffs, of a sort, for MS Office documents

The scenario: Your Git repository tracks some MS Office documents that need to stay in their current format. When these files are updated, you want Git to tell you something more useful than `Binary files a/test.xlsx and b/test.xlsx differ.`

The tools here may help, for a few special-case values of 'more useful.'

### xmlzip.sh

(As previously seen in [this gist](https://gist.github.com/infotroph/5535527))

Configures Git to automatically produce text diffs of xlsx, docx and pptx documents. It works by recognizing that these files are encoded as compressed XML, which can be uncompressed and diffed as plain text.

To use it, add this to your ~/.gitconfig:

        [diff "xmlzip"]
                textconv = /usr/local/bin/xmlzip.sh # or wherever you saved it
 
Now add these lines (or only the ones of them you want) to your project's .gitattributes:

        *.xlsx diff=xmlzip
        *.docx diff=xmlzip
        *.pptx diff=xmlzip
 
Known bugs: Complains on empty components (notably including the always-present `[Content_Types].xml`), and actually shows all changes to the XML (so good luck finding meaningful changes to an Excel file under all the display-state garbage).

### gitxlscmp.sh
(As previously seen in [this gist](https://gist.github.com/infotroph/8377075))

Non-XML Excel files (.xls) are in a fully undocumented binary format, so good luck getting anything useful out of diff. If, like me, you've stupidly allowed one into your repository and even more stupidly tried to update it instead of jumping ship to a more friendly format, here's a shortcut to open the current and last-committed versions so you can put them side-by-side and eyeball the differences.

