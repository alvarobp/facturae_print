# FacturaePrint

FacturaePrint translates a facturae xml file into an understandable HTML or PDF file.

The facturae format specification is available on [http://www.facturae.es](http://www.facturae.es). There is also an english version available [here](http://www.facturae.es/es-ES/Documentacion/EsquemaFormato/Esquema%20Formato/Versi%C3%B3n%203_2/Esquema_ingles_v3_2.pdf).

### Installation

    gem install facturae_print

### Usage

FacturaePrint uses [erubis](http://www.kuwata-lab.com/erubis) to translate the facturae xml file into an html file. It also can generate a pdf version from the generated html file, using [PDFKit](http://github.com/jdpace/PDFKit). Nothing fancy.

Right. Let's see some examples:

    facturae_print html 022011.xml templates/default.eruby -o test.html

    facturae_print pdf 022011.xml templates/default.eruby -s templates/default.css -o test.pdf

That's it. What else did you expect?