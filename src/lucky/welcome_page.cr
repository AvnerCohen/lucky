class Lucky::WelcomePage
  include Lucky::HTMLPage

  # Accept a context and all other exposed data
  def initialize(@context : HTTP::Server::Context, *args, **named_args)
  end

  macro render_auth_button(sign_in_action)
    {% if sign_in_action.resolve? %}
      a "View your new app", href: {{ sign_in_action }}.path, class: "btn"
    {% end %}
  end

  def render
    html_doctype
    html lang: "en" do
      head do
        utf8_charset
        title "Welcome to Lucky"
        load_lato_font
        normalize_styles
        welcome_page_styles
      end

      body do
        div class: "container" do
          lucky_logo
          lucky_welcome_tagline
          div class: "container__buttons" do
            a "Check out the guides",
              href: "https://luckyframework.org/guides",
              class: "btn btn--blue"
            render_auth_button(SignIns::New)
          end
        end
      end
    end
  end

  def lucky_logo
    raw %(<img src="#{lucky_logo_data_uri}" class="lucky-logo">)
  end

  def lucky_welcome_tagline
    h1 "Today is a great day to build an app", class: "hero-tagline"
  end

  def welcome_page_styles
    style <<-CSS
      body {
        background-color: #002748;
        color: #fff;
        font-family: 'Lato', system-ui, BlinkMacSystemFont, -apple-system, Segoe UI, Roboto, Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif;
        border-top: 3px solid #9EFF66;
      }

      .container {
        margin: 0 auto;
        max-width: 750px;
        margin-top: 150px;
        text-align: center;
      }

      .container__buttons {
        float: left;
        width: 100%;
        margin: 70px 0;
      }

      .container__buttons .btn:first-child {
        margin-right: 20px;
      }

      .lucky-logo {
        width: 100%
      }

      .hero-tagline {
        font-weight: 400;
        text-transform: uppercase;
        font-size: 20px;
        color: #AAB5BF;
        letter-spacing: 3px;
      }

      .btn {
        text-shadow: 0px 1px 1px rgba(0, 0, 0, 0.3);
        box-sizing: border-box;
        display: inline-block;
        border-radius: 500px;
        text-transform: uppercase;
        font-weight: bold;
        height: 50px;
        font-size: 14px;
        color: #fff;
        padding: 15px 30px;
        text-decoration: none;
        letter-spacing: 1px;
        display: inline-block;
        transition: 0.1s ease-in-out all;
        box-shadow: 0 3px 30px 0 rgba(0, 0, 0, 0.2);
        background: #20c17d;
        background-image: linear-gradient(-180deg, #3de69f 0%, #22c37f 100%);
        transform: scale(1);
      }

      .btn:hover {
        transform: scale(1.03);
        box-shadow: 0 12px 30px 0 rgba(0, 0, 0, 0.3);
      }

      .btn--blue {
        box-shadow: none;
        background: #1c92b3;
        background-image: linear-gradient(-180deg, #47c4ff 0%, #2ba4ec 100%)
      }

    CSS
  end

  def load_lato_font
    css_link "https://fonts.googleapis.com/css?family=Lato:400,900"
  end

  def normalize_styles
    style <<-CSS
      /*! normalize.css v7.0.0 | MIT License | github.com/necolas/normalize.css */html{line-height:1.15;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0}article,aside,footer,header,nav,section{display:block}h1{font-size:2em;margin:.67em 0}figcaption,figure,main{display:block}figure{margin:1em 40px}hr{box-sizing:content-box;height:0;overflow:visible}pre{font-family:monospace,monospace;font-size:1em}a{background-color:transparent;-webkit-text-decoration-skip:objects}abbr[title]{border-bottom:none;text-decoration:underline;text-decoration:underline dotted}b,strong{font-weight:inherit}b,strong{font-weight:bolder}code,kbd,samp{font-family:monospace,monospace;font-size:1em}dfn{font-style:italic}mark{background-color:#ff0;color:#000}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}audio,video{display:inline-block}audio:not([controls]){display:none;height:0}img{border-style:none}svg:not(:root){overflow:hidden}button,input,optgroup,select,textarea{font-family:sans-serif;font-size:100%;line-height:1.15;margin:0}button,input{overflow:visible}button,select{text-transform:none}[type=reset],[type=submit],button,html [type=button]{-webkit-appearance:button}[type=button]::-moz-focus-inner,[type=reset]::-moz-focus-inner,[type=submit]::-moz-focus-inner,button::-moz-focus-inner{border-style:none;padding:0}[type=button]:-moz-focusring,[type=reset]:-moz-focusring,[type=submit]:-moz-focusring,button:-moz-focusring{outline:1px dotted ButtonText}fieldset{padding:.35em .75em .625em}legend{box-sizing:border-box;color:inherit;display:table;max-width:100%;padding:0;white-space:normal}progress{display:inline-block;vertical-align:baseline}textarea{overflow:auto}[type=checkbox],[type=radio]{box-sizing:border-box;padding:0}[type=number]::-webkit-inner-spin-button,[type=number]::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}[type=search]::-webkit-search-cancel-button,[type=search]::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}details,menu{display:block}summary{display:list-item}canvas{display:inline-block}template{display:none}[hidden]{display:none}/*# sourceMappingURL=normalize.min.css.map */
    CSS
  end

  def raw(string)
    @view << string
  end

  def lucky_logo_data_uri
    "data:image/png;base64,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wSaPAgIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIIAAwSbPAAIIIIAAAggggAACCCCAgOECBJuGk5IhAggggAACCCCAAAIIIICAW1yuUhgQQAABBBBAAAEEEEAAAQQQMExAxZlqZLMq37AMyQgBBBBAAAEEEEAAAQQQQAABFWe6pUq2IIEAAggggAACCCCAAAIIIICAYQIqzlQjm66lhmVIRggggAACCCCAAAIIIIAAAgioOFMHm4uQQAABBBBAAAEEEEAAAQQQQMA4AdcitUFQ1TzjMiQnBBBAAAEEEEAAAQQQQACBhBdQcaYKNj1zEh4CAAQQQAABBBBAAAEEEEAAAeMEVJzpqs6t86g/1Z+tjcuZnBBAAAEEEEAAAQQQQAABBBJU4C9Z9G4btWZTJZfrxQRFoNkIIIAAAggggAACCCCAAAJGCvwdX24LNj2emUbmTV4IIIAAAggggAACCCCAAAIJKvB3fLkt2Pz5zXniko8TlIJmI4AAAggggAACCCCAAAIIGCGg40odX6q0LdjU33m8k/QfJAQQQAABBBBAAAEEEEAAAQQiEqgRV/5/sPnzm1+rzF6KKENuQgABBBBAAAEEEEAAAQQQSHSBl9Sopo4rq9P/B5v6R2/yFWo6bdm2t/gvAggggAACCCCAAAIIIIAAAiEI6DhSx5M1kqfG9yLrFm2URh0z1GtDdnidHxBAAAEEEEAAAQQQQAABBBCoS8DlulN+eev5mm/vOLKp32k2cLIa3ZxT8yK+RwABBBBAAAEEEEAAAQQQQKBWAR0/6jhyp+Ta6edtP3Y5IkeqitVc26r2tb7PiwgggAACCCCAAAIIIIAAAgiIa6m4UgfIwlc37IxRe7Cpr+p2SHepLJ8rVVWBnW/iZwQQQAABBBBAAAEEEEAAgQQXcLnyxe0dLAve+Lk2iV2n0W6/St/gch2lvvK3v8SfCCCAAAIIIIAAAggggAACCFTHiTperCPQ1EJ1j2xu99MjnBXlrzOldjsIfyKAAAIIIIAAAggggAACiSygps56vIfWF2hqnbpHNrfbVY9wqjm4bBq0XYQ/EUAAAQQQQAABBBBAAIHEFNBxoV6jWc+I5naYhoNNfaVe7Nls0Eg1VHo753Bup+NPBBBAAAEEEEAAAQQQQCBBBPQ5mjoe1HFhLZsB1abwf8cL658sP0TgAAAAAElFTkSuQmCC"
  end
end
